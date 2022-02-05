package utils;

import beans.Pokemon;

import java.io.BufferedWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class FileWriter {

    public static void outputLuaFile(int teamSize, List<Pokemon> team1, List<Pokemon> team2) {
        StringBuilder contents = new StringBuilder();
        contents.append("local teams =\r\n{\r\n");
        for (int j = 0; j < 2; j++) {
            contents.append("\tteam").append(j + 1).append(" =\r\n\t{\r\n");
            for (int i = 0; i < team1.size(); i++) {
                Pokemon pokemon = j == 0 ? team1.get(i) : team2.get(i);
                contents.append("\t\tpokemon").append(i + 1).append(" =\r\n\t\t{\r\n")
                        .append("\t\t\tpokemonName = \"").append(pokemon.getName().toUpperCase()).append("\",\r\n" +
                        "\t\t\tpokemonCode = ").append(pokemon.getPokemonCode()).append(",\r\n" +
                        "\t\t\tpokemonLevel = ").append(pokemon.getLevel()).append(",\r\n" +
                        "\t\t\tpokemonType1 = 0x").append(pokemon.getType1()).append(",\r\n" +
                        "\t\t\tpokemonType2 = 0x").append(pokemon.getType2()).append(",\r\n" +
                        "\t\t\tpokemonHp1 = 0x").append(pokemon.getHp().length() > 2 ? "0" + pokemon.getHp().charAt(0) : "00").append(",\r\n" +
                        "\t\t\tpokemonHp2 = 0x").append(pokemon.getHp().substring(pokemon.getHp().length() - 2)).append(",\r\n" +
                        "\t\t\tpokemonAttack1 = 0x").append(pokemon.getAttack().length() > 2 ? "0" + pokemon.getAttack().charAt(0) : "00").append(",\r\n" +
                        "\t\t\tpokemonAttack2 = 0x").append(pokemon.getAttack().substring(pokemon.getAttack().length() - 2)).append(",\r\n" +
                        "\t\t\tpokemonDefense1 = 0x").append(pokemon.getDefense().length() > 2 ? "0" + pokemon.getDefense().charAt(0) : "00").append(",\r\n" +
                        "\t\t\tpokemonDefense2 = 0x").append(pokemon.getDefense().substring(pokemon.getDefense().length() - 2)).append(",\r\n" +
                        "\t\t\tpokemonSpeed1 = 0x").append(pokemon.getSpeed().length() > 2 ? "0" + pokemon.getSpeed().charAt(0) : "00").append(",\r\n" +
                        "\t\t\tpokemonSpeed2 = 0x").append(pokemon.getSpeed().substring(pokemon.getSpeed().length() - 2)).append(",\r\n" +
                        "\t\t\tpokemonSpecial1 = 0x").append(pokemon.getSpecial().length() > 2 ? "0" + pokemon.getSpecial().charAt(0) : "00").append(",\r\n" +
                        "\t\t\tpokemonSpecial2 = 0x").append(pokemon.getSpecial().substring(pokemon.getSpecial().length() - 2)).append(",\r\n" +
                        "\t\t\tmove1Code = ").append(pokemon.getMoves().get(0).getCode()).append(",\r\n" +
                        "\t\t\tmove1Pp = 0x").append(pokemon.getMoves().get(0).getPp()).append(",\r\n" +
                        "\t\t\tmove2Code = ").append(pokemon.getMoves().get(1).getCode()).append(",\r\n" +
                        "\t\t\tmove2Pp = 0x").append(pokemon.getMoves().get(1).getPp()).append(",\r\n" +
                        "\t\t\tmove3Code = ").append(pokemon.getMoves().get(2).getCode()).append(",\r\n" +
                        "\t\t\tmove3Pp = 0x").append(pokemon.getMoves().get(2).getPp()).append(",\r\n" +
                        "\t\t\tmove4Code = ").append(pokemon.getMoves().get(3).getCode()).append(",\r\n" +
                        "\t\t\tmove4Pp = 0x").append(pokemon.getMoves().get(3).getPp()).append("\r\n" +
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
        contents.append("}\r\n\r\n");
        try {
            Path fileName = Path.of("src/main/scripts/main-template.lua");
            String template = Files.readString(fileName);
            contents.append(template);
            BufferedWriter writer = new BufferedWriter(new java.io.FileWriter("src/main/scripts/Randomize-Teams.lua"));
            writer.write(contents.toString());
            System.out.println(contents.toString());
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
