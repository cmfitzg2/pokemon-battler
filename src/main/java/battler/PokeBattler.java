package battler;

import beans.KeyValuePair;
import beans.Pokemon;
import twitch.chatbot.Bot;
import utils.FileWriter;
import utils.JsonParse;
import utils.StatCalculations;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

@SuppressWarnings("rawtypes")
public class PokeBattler {

    private final int teamSize = 3;
    public static final String pokemonLevel = "0x32";
    private final Random random;
    private StatCalculations statCalculations;
    public static Bot twitchBot;
    public static Map<String, String> pokemonMasterList;
    public static Map<String, String> movesMasterList;
    public static Map<String, ArrayList> pokemonStatsList;
    public static Map<String, ArrayList> pokemonTypesList;
    public static Map<String, ArrayList> pokemonMovePropsList;
    private long timeBetsOpened;
    private long betsOpenWindow = 60000000000L;

    public PokeBattler() {
        random = new Random();
        JsonParse jsonParse = new JsonParse();
        try {
            pokemonMasterList = jsonParse.getMapFromJson("src/main/resources/pokemon-codes.json");
            movesMasterList = jsonParse.getMapFromJson("src/main/resources/move-codes.json");
            pokemonStatsList = jsonParse.getArrayListMapFromJson("src/main/resources/pokemon-stats.json");
            pokemonTypesList = jsonParse.getArrayListMapFromJson("src/main/resources/pokemon-types.json");
            pokemonMovePropsList = jsonParse.getArrayListMapFromJson("src/main/resources/move-props.json");
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        twitchBot = new Bot();
        twitchBot.registerFeatures();
        twitchBot.start();
        statCalculations = new StatCalculations(random);
        getNewTeam();
        idleLoop();
    }

    private void idleLoop() {
        while (true) {
            try {
                Thread.sleep(2000);
                //Poll for new battle outcome
                File tempFile = new File("src/main/scripts/battle-log.txt");
                if (tempFile.exists()) {
                    Path fileName = tempFile.toPath();
                    String contents = Files.readString(fileName);
                    String[] parts = contents.split("\n");
                    String p1Outcome = parts[0].trim();
                    String p2Outcome = parts[1].trim();
                    if (p1Outcome.equals("WIN") && p2Outcome.equals("LOSE")) {
                        //agreement, p1 wins
                        System.out.println("Agreement, p1 wins");
                        Bot.betManager.payout("red");
                    } else if (p1Outcome.equals("LOSE") && p2Outcome.equals("WIN")) {
                        //agreement, p2 wins
                        System.out.println("Agreement, p2 wins");
                        Bot.betManager.payout("blue");
                    } else if (p1Outcome.equals("DRAW") && p2Outcome.equals("DRAW")) {
                        //agreement, draw
                        System.out.println("Agreement, draw");
                        Bot.betManager.refundAll();
                    } else {
                        //disagreement, call it a draw (this can happen with certain bugs in gen 1
                        // like selfdestruct that kills both team's last pokemon = lose / lose)
                        System.out.println("Disagreement, draw");
                        Bot.betManager.refundAll();
                    }
                    if (tempFile.delete()) {
                        System.out.println("Deleted battle log");
                        //Delete the log so we are informed when the next battle finishes, the new battle starts around now
                        //The battler has already loaded its team by now, so we will now get the team for the game after
                        //This offers a very large cushion of space between when the team is needed and when it's supplied
                        Bot.betManager.setBetsOpen(true);
                        timeBetsOpened = System.nanoTime();
                        getNewTeam();
                    } else {
                        System.out.println("Failed to delete battle log");
                        //this is bad, guess we'll exit!
                        Bot.betManager.refundAll();
                        break;
                    }
                }
                if (Bot.betManager.isBetsOpen() && System.nanoTime() - timeBetsOpened > betsOpenWindow) {
                    Bot.betManager.setBetsOpen(false);
                }
            } catch (InterruptedException | IOException e) {
                e.printStackTrace();
                Bot.betManager.refundAll();
            }
        }
    }

    private void getNewTeam() {
        FileWriter.outputLuaFile(teamSize, getRandomizedTeam(), getRandomizedTeam());
        idleLoop();
    }

    @SuppressWarnings("unchecked")
    private List<Pokemon> getRandomizedTeam() {
        List <Pokemon> team = new ArrayList<>();
        try {
            Map<String, String> pokemonListCopy = new HashMap<>(pokemonMasterList);
            Map<String, String> moveListCopy = new HashMap<>(movesMasterList);
            for (int i = 0; i < teamSize; i++) {
                KeyValuePair pokemonEntry = getRandomEntry(pokemonListCopy);
                String pokemonCode = pokemonEntry.getKey();
                String pokemonName = pokemonEntry.getValue();
                Pokemon pokemon = new Pokemon(pokemonCode, pokemonName, pokemonLevel);
                pokemon.setHp(statCalculations.getHpStat(pokemonName));
                pokemon.setAttack(statCalculations.getAttackStat(pokemonName));
                pokemon.setDefense(statCalculations.getDefenseStat(pokemonName));
                pokemon.setSpeed(statCalculations.getSpeedStat(pokemonName));
                pokemon.setSpecial(statCalculations.getSpecialStat(pokemonName));
                ArrayList<String> types = pokemonTypesList.get(pokemonName);
                pokemon.setType1(types.get(0));
                pokemon.setType2(types.get(1));
                pokemonListCopy.remove(pokemonCode);
                for (int j = 0; j < 4; j++) {
                    KeyValuePair moveEntry = getRandomEntry(moveListCopy);
                    String moveCode = moveEntry.getKey();
                    String moveName = moveEntry.getValue();
                    ArrayList<String> moveProps = pokemonMovePropsList.get(moveName);
                    String moveType = moveProps.get(0);
                    String movePp = Integer.toHexString(Integer.parseInt(moveProps.get(1)));
                    String moveAccuracy = moveProps.get(2);
                    pokemon.addMove(moveName, moveCode, moveType, movePp, moveAccuracy);
                    moveListCopy.remove(moveCode);
                }
                team.add(pokemon);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return team;
    }

    private KeyValuePair getRandomEntry(Map<String, String> map) {
        Set<String> keySet = map.keySet();
        List<String> keyList = new ArrayList<>(keySet);
        String key = keyList.get(random.nextInt(keyList.size()));
        String value = map.get(key);
        return new KeyValuePair(key, value);
    }

}