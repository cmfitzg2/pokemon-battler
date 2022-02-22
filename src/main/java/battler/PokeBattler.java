package battler;

import beans.KeyValuePair;
import beans.Pokemon;
import obs.Assets;
import twitch.chatbot.Bot;
import utils.FileWriter;
import utils.GeneralConstants;
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
    private long loyaltyRewardsLastTime;
    private final long loyaltyRewardsTimer = 60000000000L;
    private long nextBattleStartTime = 0;
    private WatchService watchService;
    private Path logPath;
    private Assets assets;
    private List<Pokemon> redTeam;
    private List<Pokemon> blueTeam;
    private boolean postgame;
    private long postgameStartTime;
    private long postgameWindow = 11000;

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
        idleLoop();
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
                        if (!processBattleLog(tempFile)) {
                            break;
                        }
                    }
                }
                if (Bot.betManager.isBetsOpen()) {
                    if (System.currentTimeMillis() >= nextBattleStartTime * 1000) {
                        closeBets();
                    }
                }
                if (System.nanoTime() - loyaltyRewardsLastTime > loyaltyRewardsTimer) {
                    twitchBot.distributeLoyaltyRewards();
                    loyaltyRewardsLastTime = System.nanoTime();
                }
                if (postgame) {
                    if (System.currentTimeMillis() - postgameStartTime >= postgameWindow) {
                        openBets();
                    }
                }
            } catch (InterruptedException | IOException e) {
                e.printStackTrace();
                Bot.betManager.refundAll();
                break;
            }
        }
    }

    private boolean processBattleLog(File tempFile) throws IOException {
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
        System.out.println(nextBattleStartTime);
        if (p1Outcome.equals("WIN") && p2Outcome.equals("LOSE")) {
            //agreement, p1 wins
            System.out.println("Agreement, p1 wins");
            twitchBot.getChatManager().sendPublicMessage("Red wins!", GeneralConstants.twitchChannelName);
            Bot.betManager.payout("red");
            twitchBot.getChatManager().sendPublicMessage("All winner payouts processed.", GeneralConstants.twitchChannelName);
        } else if (p1Outcome.equals("LOSE") && p2Outcome.equals("WIN")) {
            //agreement, p2 wins
            System.out.println("Agreement, p2 wins");
            twitchBot.getChatManager().sendPublicMessage("Blue wins!", GeneralConstants.twitchChannelName);
            Bot.betManager.payout("blue");
            twitchBot.getChatManager().sendPublicMessage("All winner payouts processed.", GeneralConstants.twitchChannelName);
        } else if (p1Outcome.equals("DRAW") && p2Outcome.equals("DRAW")) {
            //agreement, draw
            twitchBot.getChatManager().sendPublicMessage("The battle was a draw!", GeneralConstants.twitchChannelName);
            System.out.println("Agreement, draw");
            Bot.betManager.refundAll();
            twitchBot.getChatManager().sendPublicMessage("All players have had their bets refunded.", GeneralConstants.twitchChannelName);
        } else {
            //disagreement, call it a draw (this can happen with certain bugs in gen 1
            // like selfdestruct that kills both team's last pokemon = lose / lose)
            System.out.println("Disagreement, draw");
            twitchBot.getChatManager().sendPublicMessage("Due to a conflict in the reported results, the battle is a draw!", GeneralConstants.twitchChannelName);
            System.out.println(p1Outcome + ", " + p2Outcome);
            Bot.betManager.refundAll();
            twitchBot.getChatManager().sendPublicMessage("All players have had their bets refunded.", GeneralConstants.twitchChannelName);
        }
        if (tempFile.delete()) {
            //Delete the log so we are informed when the next battle finishes, we're in the postgame summary now
            System.out.println("Deleted battle log");
            postgame = true;
            postgameStartTime = System.currentTimeMillis();
            return true;
        } else {
            System.out.println("Failed to delete battle log");
            //this is bad, guess we'll refund!
            Bot.betManager.refundAll();
            return false;
        }
    }


    private void openBets() {
        postgame = false;
        Bot.betManager.setBetsOpen(true);
        twitchBot.getChatManager().sendPublicMessage("Bets are now open!", GeneralConstants.twitchChannelName);
        StringBuilder vsMessage = new StringBuilder("RED (");
        buildVsMessage(vsMessage, redTeam);
        vsMessage.append(") vs BLUE (");
        buildVsMessage(vsMessage, blueTeam);
        vsMessage.append(")");
        twitchBot.getChatManager().sendPublicMessage(vsMessage.toString(), GeneralConstants.twitchChannelName);

        //The battler has already loaded its team by now, so we will now get the team for the game after
        //This offers a very large cushion of space between when the team is needed and when it's supplied
        getNewTeam();
        //idleLoop();
    }

    private void buildVsMessage(StringBuilder vsMessage, List<Pokemon> team) {
        for (int i = 0; i < team.size(); i++) {
            if (i == team.size() - 1) {
                vsMessage.append("and ");
            }
            String name = team.get(i).getName();
            if (name.equalsIgnoreCase("nidoran1")) {
                name = "Nidoran♂";
            } else if (name.equalsIgnoreCase("nidoran2")) {
                name = "Nidoran♀";
            }
            vsMessage.append(name);
            if (i < team.size() - 1) {
                vsMessage.append(", ");
            }
        }
    }

    private void closeBets() {
        twitchBot.getChatManager().sendPublicMessage("Bets are now closed!", GeneralConstants.twitchChannelName);
        Bot.betManager.setBetsOpen(false);
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