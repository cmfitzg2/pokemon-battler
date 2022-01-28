package utils;

import java.util.Random;
import battler.PokeBattler;

public class StatCalculations {

    private Random random;
    private int hpIndex = 0;
    private int attackIndex = 1;
    private int defenseIndex = 2;
    private int speedIndex = 3;
    private int specialIndex = 4;


    public StatCalculations(Random random) {
        this.random = random;
    }

    public String getHpStat(String pokemonName) {
        int stat = calculateHpStat(getBaseHp(pokemonName), Integer.parseInt(PokeBattler.pokemonLevel.substring(2), 16));
        return Integer.toHexString(stat);
    }

    public String getAttackStat(String pokemonName) {
        int stat = calculateStat(getBaseAttack(pokemonName), Integer.parseInt(PokeBattler.pokemonLevel.substring(2), 16));
        return Integer.toHexString(stat);
    }

    public String getDefenseStat(String pokemonName) {
        int stat = calculateStat(getBaseDefense(pokemonName), Integer.parseInt(PokeBattler.pokemonLevel.substring(2), 16));
        return Integer.toHexString(stat);
    }

    public String getSpeedStat(String pokemonName) {
        int stat = calculateStat(getBaseSpeed(pokemonName), Integer.parseInt(PokeBattler.pokemonLevel.substring(2), 16));
        return Integer.toHexString(stat);
    }

    public String getSpecialStat(String pokemonName) {
        int stat = calculateStat(getBaseSpecial(pokemonName), Integer.parseInt(PokeBattler.pokemonLevel.substring(2), 16));
        return Integer.toHexString(stat);
    }

    private int getBaseHp(String pokemonName) {
        return ((Double) PokeBattler.pokemonStatsList.get(pokemonName).get(hpIndex)).intValue();
    }

    private int getBaseAttack(String pokemonName) {
        return ((Double) PokeBattler.pokemonStatsList.get(pokemonName).get(attackIndex)).intValue();
    }

    private int getBaseDefense(String pokemonName) {
        return ((Double) PokeBattler.pokemonStatsList.get(pokemonName).get(defenseIndex)).intValue();
    }

    private int getBaseSpeed(String pokemonName) {
        return ((Double) PokeBattler.pokemonStatsList.get(pokemonName).get(speedIndex)).intValue();
    }

    private int getBaseSpecial(String pokemonName) {
        return ((Double) PokeBattler.pokemonStatsList.get(pokemonName).get(specialIndex)).intValue();
    }

    private int getRandomIv() {
        return random.nextInt(16);
    }

    private int getRandomEv() {
        return random.nextInt(65536);
    }

    public int calculateStat(int base, int level) {
        int iv = getRandomIv();
        int ev = getRandomEv();
        double numerator = ((base + iv) * 2 + Math.floor(Math.sqrt(ev) / 4f)) * level;

        return (int) Math.floor(numerator / 100f) + 5;
    }

    public int calculateHpStat(int base, int level) {
        int iv = getRandomIv();
        int ev = getRandomEv();
        double numerator = ((base + iv) * 2 + Math.floor(Math.sqrt(ev) / 4f)) * level;

        return (int) Math.floor(numerator / 100f) + level + 10;
    }
}
