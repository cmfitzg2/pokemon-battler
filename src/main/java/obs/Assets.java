package obs;

import utils.GeneralConstants;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class Assets {

    private Map<String, BufferedImage> pokemon;
    private BufferedImage sheet;

    public Assets() {
        try {
            sheet = ImageIO.read(Assets.class.getResource("src/main/resources/spritesheet.png"));
            pokemon = new HashMap<>();
            pokemon.put(GeneralConstants.bulbasaur, crop(0, 0));
            pokemon.put(GeneralConstants.ivysaur, crop(1, 0));
            pokemon.put(GeneralConstants.venusaur, crop(2, 0));
            pokemon.put(GeneralConstants.charmander, crop(3, 0));
            pokemon.put(GeneralConstants.charmeleon, crop(4, 0));
            pokemon.put(GeneralConstants.charizard, crop(5, 0));
            pokemon.put(GeneralConstants.squirtle, crop(6, 0));
            pokemon.put(GeneralConstants.wartortle, crop(7, 0));
            pokemon.put(GeneralConstants.blastoise, crop(8, 0));
            pokemon.put(GeneralConstants.caterpie, crop(9, 0));
            pokemon.put(GeneralConstants.metapod, crop(10, 0));
            pokemon.put(GeneralConstants.butterfree, crop(11, 0));

            pokemon.put(GeneralConstants.weedle, crop(0, 1));
            pokemon.put(GeneralConstants.kakuna, crop(1, 1));
            pokemon.put(GeneralConstants.beedrill, crop(2, 1));
            pokemon.put(GeneralConstants.pidgey, crop(3, 1));
            pokemon.put(GeneralConstants.pidgeotto, crop(4, 1));
            pokemon.put(GeneralConstants.pidgeot, crop(5, 1));
            pokemon.put(GeneralConstants.rattata, crop(6, 1));
            pokemon.put(GeneralConstants.raticate, crop(7, 1));
            pokemon.put(GeneralConstants.spearow, crop(8, 1));
            pokemon.put(GeneralConstants.fearow, crop(9, 1));
            pokemon.put(GeneralConstants.ekans, crop(10, 1));
            pokemon.put(GeneralConstants.arbok, crop(11, 1));

            pokemon.put(GeneralConstants.pikachu, crop(0, 2));
            pokemon.put(GeneralConstants.raichu, crop(1, 2));
            pokemon.put(GeneralConstants.sandshrew, crop(2, 2));
            pokemon.put(GeneralConstants.sandslash, crop(3, 2));
            pokemon.put(GeneralConstants.nidoran2, crop(4, 2));
            pokemon.put(GeneralConstants.nidorina, crop(5, 2));
            pokemon.put(GeneralConstants.nidoqueen, crop(6, 2));
            pokemon.put(GeneralConstants.nidoran1, crop(7, 2));
            pokemon.put(GeneralConstants.nidorino, crop(8, 2));
            pokemon.put(GeneralConstants.nidoking, crop(9, 2));
            pokemon.put(GeneralConstants.clefairy, crop(10, 2));
            pokemon.put(GeneralConstants.clefable, crop(11, 2));

            pokemon.put(GeneralConstants.vulpix, crop(0, 3));
            pokemon.put(GeneralConstants.ninetales, crop(1, 3));
            pokemon.put(GeneralConstants.jigglypuff, crop(2, 3));
            pokemon.put(GeneralConstants.wigglytuff, crop(3, 3));
            pokemon.put(GeneralConstants.zubat, crop(4, 3));
            pokemon.put(GeneralConstants.golbat, crop(5, 3));
            pokemon.put(GeneralConstants.oddish, crop(6, 3));
            pokemon.put(GeneralConstants.gloom, crop(7, 3));
            pokemon.put(GeneralConstants.vileplume, crop(8, 3));
            pokemon.put(GeneralConstants.paras, crop(9, 3));
            pokemon.put(GeneralConstants.parasect, crop(10, 3));
            pokemon.put(GeneralConstants.venonat, crop(11, 3));

            pokemon.put(GeneralConstants.venomoth, crop(0, 4));
            pokemon.put(GeneralConstants.diglett, crop(1, 4));
            pokemon.put(GeneralConstants.dugtrio, crop(2, 4));
            pokemon.put(GeneralConstants.meowth, crop(3, 4));
            pokemon.put(GeneralConstants.persian, crop(4, 4));
            pokemon.put(GeneralConstants.psyduck, crop(5, 4));
            pokemon.put(GeneralConstants.golduck, crop(6, 4));
            pokemon.put(GeneralConstants.mankey, crop(7, 4));
            pokemon.put(GeneralConstants.primeape, crop(8, 4));
            pokemon.put(GeneralConstants.growlithe, crop(9, 4));
            pokemon.put(GeneralConstants.arcanine, crop(10, 4));
            pokemon.put(GeneralConstants.poliwag, crop(11, 4));

            pokemon.put(GeneralConstants.poliwhirl, crop(0, 5));
            pokemon.put(GeneralConstants.poliwrath, crop(1, 5));
            pokemon.put(GeneralConstants.abra, crop(2, 5));
            pokemon.put(GeneralConstants.kadabra, crop(3, 5));
            pokemon.put(GeneralConstants.alakazam, crop(4, 5));
            pokemon.put(GeneralConstants.machop, crop(5, 5));
            pokemon.put(GeneralConstants.machoke, crop(6, 5));
            pokemon.put(GeneralConstants.machamp, crop(7, 5));
            pokemon.put(GeneralConstants.bellsprout, crop(8, 5));
            pokemon.put(GeneralConstants.weepinbell, crop(9, 5));
            pokemon.put(GeneralConstants.victreebel, crop(10, 5));
            pokemon.put(GeneralConstants.tentacool, crop(11, 5));

            pokemon.put(GeneralConstants.tentacruel, crop(0, 6));
            pokemon.put(GeneralConstants.geodude, crop(1, 6));
            pokemon.put(GeneralConstants.graveler, crop(2, 6));
            pokemon.put(GeneralConstants.golem, crop(3, 6));
            pokemon.put(GeneralConstants.ponyta, crop(4, 6));
            pokemon.put(GeneralConstants.rapidash, crop(5, 6));
            pokemon.put(GeneralConstants.slowpoke, crop(6, 6));
            pokemon.put(GeneralConstants.slowbro, crop(7, 6));
            pokemon.put(GeneralConstants.magnemite, crop(8, 6));
            pokemon.put(GeneralConstants.magneton, crop(9, 6));
            pokemon.put(GeneralConstants.farfetchd, crop(10, 6));
            pokemon.put(GeneralConstants.doduo, crop(11, 6));

            pokemon.put(GeneralConstants.dodrio, crop(0, 7));
            pokemon.put(GeneralConstants.seel, crop(1, 7));
            pokemon.put(GeneralConstants.dewgong, crop(2, 7));
            pokemon.put(GeneralConstants.grimer, crop(3, 7));
            pokemon.put(GeneralConstants.muk, crop(4, 7));
            pokemon.put(GeneralConstants.shellder, crop(5, 7));
            pokemon.put(GeneralConstants.cloyster, crop(6, 7));
            pokemon.put(GeneralConstants.gastly, crop(7, 7));
            pokemon.put(GeneralConstants.haunter, crop(8, 7));
            pokemon.put(GeneralConstants.gengar, crop(9, 7));
            pokemon.put(GeneralConstants.onix, crop(10, 7));
            pokemon.put(GeneralConstants.drowzee, crop(11, 7));

            pokemon.put(GeneralConstants.hypno, crop(0, 8));
            pokemon.put(GeneralConstants.krabby, crop(1, 8));
            pokemon.put(GeneralConstants.kingler, crop(2, 8));
            pokemon.put(GeneralConstants.voltorb, crop(3, 8));
            pokemon.put(GeneralConstants.electrode, crop(4, 8));
            pokemon.put(GeneralConstants.exeggcute, crop(5, 8));
            pokemon.put(GeneralConstants.exeggutor, crop(6, 8));
            pokemon.put(GeneralConstants.cubone, crop(7, 8));
            pokemon.put(GeneralConstants.marowak, crop(8, 8));
            pokemon.put(GeneralConstants.hitmonlee, crop(9, 8));
            pokemon.put(GeneralConstants.hitmonchan, crop(10, 8));
            pokemon.put(GeneralConstants.lickitung, crop(11, 8));

            pokemon.put(GeneralConstants.koffing, crop(0, 9));
            pokemon.put(GeneralConstants.weezing, crop(1, 9));
            pokemon.put(GeneralConstants.rhyhorn, crop(2, 9));
            pokemon.put(GeneralConstants.rhydon, crop(3, 9));
            pokemon.put(GeneralConstants.chansey, crop(4, 9));
            pokemon.put(GeneralConstants.tangela, crop(5, 9));
            pokemon.put(GeneralConstants.kangaskhan, crop(6, 9));
            pokemon.put(GeneralConstants.horsea, crop(7, 9));
            pokemon.put(GeneralConstants.seadra, crop(8, 9));
            pokemon.put(GeneralConstants.goldeen, crop(9, 9));
            pokemon.put(GeneralConstants.seaking, crop(10, 9));
            pokemon.put(GeneralConstants.staryu, crop(11, 9));

            pokemon.put(GeneralConstants.starmie, crop(0, 10));
            pokemon.put(GeneralConstants.mrmime, crop(1, 10));
            pokemon.put(GeneralConstants.scyther, crop(2, 10));
            pokemon.put(GeneralConstants.jynx, crop(3, 10));
            pokemon.put(GeneralConstants.electabuzz, crop(4, 10));
            pokemon.put(GeneralConstants.magmar, crop(5, 10));
            pokemon.put(GeneralConstants.pinsir, crop(6, 10));
            pokemon.put(GeneralConstants.tauros, crop(7, 10));
            pokemon.put(GeneralConstants.magikarp, crop(8, 10));
            pokemon.put(GeneralConstants.gyarados, crop(9, 10));
            pokemon.put(GeneralConstants.lapras, crop(10, 10));
            pokemon.put(GeneralConstants.ditto, crop(11, 10));

            pokemon.put(GeneralConstants.eevee, crop(0, 11));
            pokemon.put(GeneralConstants.vaporeon, crop(1, 11));
            pokemon.put(GeneralConstants.jolteon, crop(2, 11));
            pokemon.put(GeneralConstants.flareon, crop(3, 11));
            pokemon.put(GeneralConstants.porygon, crop(4, 11));
            pokemon.put(GeneralConstants.omanyte, crop(5, 11));
            pokemon.put(GeneralConstants.omastar, crop(6, 11));
            pokemon.put(GeneralConstants.kabuto, crop(7, 11));
            pokemon.put(GeneralConstants.kabutops, crop(8, 11));
            pokemon.put(GeneralConstants.aerodactyl, crop(9, 11));
            pokemon.put(GeneralConstants.snorlax, crop(10, 11));
            pokemon.put(GeneralConstants.articuno, crop(11, 11));

            pokemon.put(GeneralConstants.zapdos, crop(0, 12));
            pokemon.put(GeneralConstants.moltres, crop(1, 12));
            pokemon.put(GeneralConstants.dratini, crop(2, 12));
            pokemon.put(GeneralConstants.dragonair, crop(3, 12));
            pokemon.put(GeneralConstants.dragonite, crop(4, 12));
            pokemon.put(GeneralConstants.mewtwo, crop(5, 12));
            pokemon.put(GeneralConstants.mew, crop(6, 12));
            pokemon.put(GeneralConstants.raticate, crop(7, 12));
            pokemon.put(GeneralConstants.spearow, crop(8, 12));
            pokemon.put(GeneralConstants.fearow, crop(9, 12));
            pokemon.put(GeneralConstants.ekans, crop(10, 12));
            pokemon.put(GeneralConstants.arbok, crop(11, 12));

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public BufferedImage getImageByCode(String code) {
        return pokemon.get(code);
    }

    private BufferedImage crop(int xIndex, int yIndex) {
        int sideLength = 56;
        return sheet.getSubimage(xIndex * sideLength, yIndex * sideLength, sideLength, sideLength);
    }
}
