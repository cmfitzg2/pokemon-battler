package beans;

import java.util.ArrayList;
import java.util.List;

public class Pokemon {

    private String pokemonCode;
    private String name;
    private List<Move> moves;
    private String level;
    private String hp;
    private String attack;
    private String defense;
    private String speed;
    private String special;
    private String type1;
    private String type2;

    public Pokemon(String pokemonCode, String name, String level) {
        this.pokemonCode = pokemonCode;
        this.name = name;
        this.level = level;
        moves = new ArrayList<>();
    }

    public void addMove(String moveName, String moveCode, String type, String pp, String accuracy) {
        moves.add(new Move(moveName, moveCode, type, pp, accuracy));
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("\r\n----------------------\r\n" + pokemonCode + " | " + name + "\r\n");
        for (Move move : moves) {
            string.append(move.getCode()).append(" | ").append(move.getName()).append("\r\n");
        }
        return string.toString();
    }

    public String getPokemonCode() {
        return pokemonCode;
    }

    public String getName() {
        return name;
    }

    public List<Move> getMoves() {
        return moves;
    }

    public String getLevel() {
        return level;
    }

    public String getHp() {
        return hp;
    }

    public void setHp(String hp) {
        this.hp = hp;
    }

    public String getAttack() {
        return attack;
    }

    public void setAttack(String attack) {
        this.attack = attack;
    }

    public String getDefense() {
        return defense;
    }

    public void setDefense(String defense) {
        this.defense = defense;
    }

    public String getSpeed() {
        return speed;
    }

    public void setSpeed(String speed) {
        this.speed = speed;
    }

    public String getSpecial() {
        return special;
    }

    public void setSpecial(String special) {
        this.special = special;
    }

    public String getType1() {
        return type1;
    }

    public void setType1(String type1) {
        this.type1 = type1;
    }

    public String getType2() {
        return type2;
    }

    public void setType2(String type2) {
        this.type2 = type2;
    }
}
