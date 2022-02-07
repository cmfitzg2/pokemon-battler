package twitch.chatbot;

import twitch.chatbot.beans.Bet;
import twitch.chatbot.beans.User;

import java.util.ArrayList;
import java.util.List;

public class BetManager {

    public List<Bet> activeBets;
    public List<String> validWinners;
    private boolean betsOpen = true;

    public BetManager() {
        activeBets = new ArrayList<>();
        validWinners = new ArrayList<>();
        validWinners.add("red");
        validWinners.add("blue");
    }

    public List<Bet> getActiveBets() {
        return activeBets;
    }

    public Bet getBetByUser(User user) {
        for (Bet activeBet : activeBets) {
            if (activeBet.getUser().getName().equalsIgnoreCase(user.getName())) {
                return activeBet;
            }
        }
        return null;
    }

    public void resetBets() {
        activeBets = new ArrayList<>();
    }

    public void payout(String winner) {
        for (Bet bet : activeBets) {
            if (bet.getWinner().equalsIgnoreCase(winner)) {
                User user = bet.getUser();
                user.setBalance(user.getBalance() + bet.getAmount() * 2);
            }
        }
        resetBets();
    }

    public boolean isBetsOpen() {
        return betsOpen;
    }

    public void setBetsOpen(boolean betsOpen) {
        this.betsOpen = betsOpen;
    }

    public void addBet(User user, long amount, String winner) {
        activeBets.add(new Bet(user, amount, winner));
    }

    public void updateBet(User user, long amount, String winner) {
        for (Bet bet : activeBets) {
            if (bet.getUser().getName().equalsIgnoreCase(user.getName())) {
                bet.setAmount(amount);
                bet.setWinner(winner);
            }
        }
    }

    public void removeBet(User user) {
        activeBets.remove(getBetByUser(user));
    }

    public boolean isWinnerValid(String winner) {
        for (String validWinner : validWinners) {
            if (winner.equalsIgnoreCase(validWinner)) {
                return true;
            }
        }
        return false;
    }

    public void refundAll() {
        for (Bet bet : activeBets) {
            bet.getUser().setBalance(bet.getUser().getBalance() + bet.getAmount());
        }
        resetBets();
    }

    public void refundUser(User user) {
        for (Bet bet : activeBets) {
            if (bet.getUser().getName().equalsIgnoreCase(user.getName())) {
                bet.getUser().setBalance(bet.getUser().getBalance() + bet.getAmount());
                activeBets.remove(bet);
                return;
            }
        }
    }
}
