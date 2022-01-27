import beans.Pokemon;
import beans.KeyValuePair;
import com.google.gson.Gson;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class PokeBattler {

    private final int teamSize = 3;
    private Random random;

    public PokeBattler() {
        random = new Random();
        outputLuaFile(getRandomizedTeam(), getRandomizedTeam());
    }

    private List<Pokemon> getRandomizedTeam() {
        List <Pokemon> team = new ArrayList<>();
        try {
            Map<String, String> pokemonMasterList = getMapFromJson("src/main/resources/pokemon-codes.json");
            Map<String, String> movesMasterList = getMapFromJson("src/main/resources/move-codes.json");
            for (int i = 0; i < teamSize; i++) {
                KeyValuePair pokemonEntry = getRandomEntry(pokemonMasterList);
                String pokemonCode = pokemonEntry.getKey();
                String pokemonName = pokemonEntry.getValue();
                Pokemon pokemon = new Pokemon(pokemonCode, pokemonName, "50");
                pokemonMasterList.remove(pokemonCode);
                for (int j = 0; j < 4; j++) {
                    KeyValuePair moveEntry = getRandomEntry(movesMasterList);
                    String moveCode = moveEntry.getKey();
                    String moveName = moveEntry.getValue();
                    pokemon.addMove(moveName, moveCode);
                    movesMasterList.remove(moveCode);
                }
                team.add(pokemon);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return team;
    }

    @SuppressWarnings("unchecked")
    private Map<String, String> getMapFromJson(String json) throws IOException {
        Gson gson = new Gson();
        Reader reader = Files.newBufferedReader(Paths.get(json));
        Map<String, String> map = (Map<String, String>) gson.fromJson(reader, Map.class);
        reader.close();
        return map;
    }

    private KeyValuePair getRandomEntry(Map<String, String> map) {
        Set<String> keySet = map.keySet();
        List<String> keyList = new ArrayList<>(keySet);
        String key = keyList.get(random.nextInt(keyList.size()));
        String value = map.get(key);
        return new KeyValuePair(key, value);
    }

    private void outputLuaFile(List<Pokemon> team1, List<Pokemon> team2) {
        StringBuilder contents = new StringBuilder();
        contents.append("local teams =\r\n{\r\n");
        for (int j = 0; j < 2; j++) {
            contents.append("\tteam").append(j + 1).append(" =\r\n\t{\r\n");
            for (int i = 0; i < team1.size(); i++) {
                Pokemon pokemon = j == 0 ? team1.get(i) : team2.get(i);
                contents.append("\t\tpokemon").append(i + 1).append(" =\r\n\t\t{\r\n")
                        .append("\t\t\tpokemonName = \"").append(pokemon.getName()).append("\",\r\n" +
                        "\t\t\tpokemonCode = \"").append(pokemon.getPokemonCode()).append("\",\r\n" +
                        "\t\t\tpokemonLevel = \"").append(pokemon.getLevel()).append("\",\r\n" +
                        "\t\t\tmove1Code = \"").append(pokemon.getMoves().get(0).getCode()).append("\",\r\n" +
                        "\t\t\tmove2Code = \"").append(pokemon.getMoves().get(1).getCode()).append("\",\r\n" +
                        "\t\t\tmove3Code = \"").append(pokemon.getMoves().get(2).getCode()).append("\",\r\n" +
                        "\t\t\tmove4Code = \"").append(pokemon.getMoves().get(3).getCode()).append("\"\r\n" +
                        "\t\t}");
                if (i < teamSize - 1) {
                    contents.append(",");
                }
                contents.append("\r\n");
            }

            contents.append("\t}");
            if (j == 0) {
                contents.append(",");
            }
            contents.append("\r\n");
        }
        contents.append("}\r\nreturn teams");
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter("TeamTable.lua"));
            writer.write(contents.toString());
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}