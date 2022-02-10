package battler;

import beans.KeyValuePair;
import beans.Pokemon;
import obs.Assets;
import twitch.chatbot.Bot;
import utils.FileWriter;
import utils.JsonParse;
import utils.StatCalculations;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.concurrent.TimeUnit;

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
    private long loyaltyRewardsLastTime;
    private final long loyaltyRewardsTimer = 60000000000L;
    private long nextBattleStartTime = 0;
    private WatchService watchService;
    private Path logPath;
    private Assets assets;
    private List<Pokemon> redTeam;
    private List<Pokemon> blueTeam;

    public PokeBattler() {
        random = new Random();
        JsonParse jsonParse = new JsonParse();
        assets = new Assets();
        redTeam = new ArrayList<>();
        blueTeam = new ArrayList<>();
        try {
            pokemonMasterList = jsonParse.getMapFromJson("src/main/resources/pokemon-codes.json");
            movesMasterList = jsonParse.getMapFromJson("src/main/resources/move-codes.json");
            pokemonStatsList = jsonParse.getArrayListMapFromJson("src/main/resources/pokemon-stats.json");
            pokemonTypesList = jsonParse.getArrayListMapFromJson("src/main/resources/pokemon-types.json");
            pokemonMovePropsList = jsonParse.getArrayListMapFromJson("src/main/resources/move-props.json");
            logPath = Paths.get("src/main/scripts");
            watchService = logPath.getFileSystem().newWatchService();
            logPath.register(watchService, StandardWatchEventKinds.ENTRY_CREATE);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        twitchBot = new Bot();
        twitchBot.registerFeatures();
        twitchBot.start();
        statCalculations = new StatCalculations(random);
        loyaltyRewardsLastTime = System.nanoTime();
        getNewTeam();
    }

    private void idleLoop() {
        WatchKey watchKey;
        while (true) {
            try {
                watchKey = watchService.poll(2000, TimeUnit.MILLISECONDS);
                if (watchKey != null) {
                    watchService = logPath.getFileSystem().newWatchService();
                    logPath.register(watchService, StandardWatchEventKinds.ENTRY_CREATE);
                    File tempFile = new File(logPath + "/battle-log.txt");
                    if (tempFile.exists()) {
                        Path fileName = tempFile.toPath();
                        String contents = Files.readString(fileName);
                        String[] parts = contents.split("\n");
                        String p1Outcome = parts[0].trim();
                        String p2Outcome = parts[1].trim();
                        //Post-game screen in OBS
                        nextBattleStartTime = Long.parseLong(parts[8].trim());
                        FileWriter.outputOutcomeFileForObs(Boolean.parseBoolean(parts[2].trim()), Boolean.parseBoolean(parts[3].trim()),
                                Boolean.parseBoolean(parts[4].trim()), Boolean.parseBoolean(parts[5].trim()),
                                Boolean.parseBoolean(parts[6].trim()), Boolean.parseBoolean(parts[7].trim()),
                                nextBattleStartTime);
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
                            timeBetsOpened = System.currentTimeMillis();
                            getNewTeam();
                        } else {
                            System.out.println("Failed to delete battle log");
                            //this is bad, guess we'll exit!
                            Bot.betManager.refundAll();
                            break;
                        }
                    }
                }
                if (Bot.betManager.isBetsOpen() && System.currentTimeMillis() - timeBetsOpened > nextBattleStartTime * 1000) {
                    Bot.betManager.setBetsOpen(false);
                }
                if (System.nanoTime() - loyaltyRewardsLastTime > loyaltyRewardsTimer) {
                    twitchBot.distributeLoyaltyRewards();
                    loyaltyRewardsLastTime = System.nanoTime();
                }
            } catch (InterruptedException | IOException e) {
                e.printStackTrace();
                Bot.betManager.refundAll();
            }
        }
    }

    private void getNewTeam() {
        redTeam = getRandomizedTeam();
        blueTeam = getRandomizedTeam();
        FileWriter.outputRandomTeamFile(teamSize, redTeam, blueTeam);
        //this is the team for the next run, not the current one
        boolean current = nextBattleStartTime == 0;
        FileWriter.outputTeamImages(assets, current, redTeam.get(0).getPokemonCode(), redTeam.get(1).getPokemonCode(), redTeam.get(2).getPokemonCode(),
                blueTeam.get(0).getPokemonCode(), blueTeam.get(1).getPokemonCode(), blueTeam.get(2).getPokemonCode());
        FileWriter.outputTeamsFileForObs(redTeam.get(0).getName(), redTeam.get(1).getName(), redTeam.get(2).getName(),
                blueTeam.get(0).getName(), blueTeam.get(1).getName(), blueTeam.get(2).getName());
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