package beans;

import java.util.ArrayList;
import java.util.List;

public class Pokemon {

    private String pokemonCode;
    private String name;
    private List<Move> moves;
    private String level;

    public Pokemon(String pokemonCode, String name, String level) {
        this.pokemonCode = pokemonCode;
        this.name = name;
        this.level = level;
        moves = new ArrayList<>();
    }

    public void addMove(String moveName, String moveCode) {
        moves.add(new Move(moveName, moveCode));
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
}
