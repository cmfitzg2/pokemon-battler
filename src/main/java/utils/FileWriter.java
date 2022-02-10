package utils;

import beans.Pokemon;
import obs.Assets;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;

public class FileWriter {

    public static void outputRandomTeamFile(int teamSize, List<Pokemon> team1, List<Pokemon> team2) {
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
            Path fileName = Path.of("src/main/scripts/randomize-teams-template.lua");
            String template = Files.readString(fileName);
            contents.append(template);
            BufferedWriter writer = new BufferedWriter(new java.io.FileWriter("src/main/scripts/Randomize-Teams.lua"));
            writer.write(contents.toString());
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void outputTeamImages(Assets assets, boolean current, String red1, String red2,
                                        String red3, String blue1, String blue2, String blue3) {
        String path = "src/main/scripts/obs/battle-images/";
        try {
            if (!current) {
                File f = new File(path + "future/red1.png");
                if (f.exists()) {
                    //move the "future" images to the "current" dir before outputting new future images
                    Files.move(Path.of(path + "future/red1.png"), Path.of(path + "current/red1.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    Files.move(Path.of(path + "future/red2.png"), Path.of(path + "current/red2.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    Files.move(Path.of(path + "future/red3.png"), Path.of(path + "current/red3.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    Files.move(Path.of(path + "future/blue1.png"), Path.of(path + "current/blue1.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    Files.move(Path.of(path + "future/blue2.png"), Path.of(path + "current/blue2.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    Files.move(Path.of(path + "future/blue3.png"), Path.of(path + "current/blue3.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                }
                path += "future/";
            } else {
                path += "current/";
            }
            BufferedImage red1Image = assets.getImageByCode(red1);
            File outputFile = new File(path + "red1.png");
            ImageIO.write(red1Image, "png", outputFile);

            BufferedImage red2Image = assets.getImageByCode(red2);
            outputFile = new File(path + "red2.png");
            ImageIO.write(red2Image, "png", outputFile);

            BufferedImage red3Image = assets.getImageByCode(red3);
            outputFile = new File(path + "red3.png");
            ImageIO.write(red3Image, "png", outputFile);

            BufferedImage blue1Image = assets.getImageByCode(blue1);
            outputFile = new File(path + "blue1.png");
            ImageIO.write(blue1Image, "png", outputFile);

            BufferedImage blue2Image = assets.getImageByCode(blue2);
            outputFile = new File(path + "blue2.png");
            ImageIO.write(blue2Image, "png", outputFile);

            BufferedImage blue3Image = assets.getImageByCode(blue3);
            outputFile = new File(path + "blue3.png");
            ImageIO.write(blue3Image, "png", outputFile);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void outputTeamsFileForObs(String name1, String name2, String name3,
                                             String name4, String name5, String name6) {
        String output = name1 + "\n" + name2 + "\n" + name3 + "\n" + name4 + "\n" + name5 + "\n" + name6 + "\n";
        try {
            BufferedWriter writer = new BufferedWriter(new java.io.FileWriter("src/main/scripts/obs/teams.txt"));
            writer.write(output);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void outputOutcomeFileForObs(boolean red1Alive, boolean red2Alive, boolean red3Alive,
                                               boolean blue1Alive, boolean blue2Alive, boolean blue3Alive, long startTime) {
        String output = red1Alive + "\n" + red2Alive + "\n" + red3Alive + "\n" + blue1Alive + "\n" + blue2Alive + "\n" + blue3Alive + "\n" + startTime + "\n";
        try {
            BufferedWriter writer = new BufferedWriter(new java.io.FileWriter("src/main/scripts/obs/outcome.txt"));
            writer.write(output);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
