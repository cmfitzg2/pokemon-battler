package twitch.chatbot;

import twitch.chatbot.beans.Bet;
import twitch.chatbot.beans.User;

import java.util.ArrayList;
import java.util.List;

public class BetManager {

    public List<Bet> activeBets;
    public List<String> validWinners;
    private boolean betsOpen = false;
    private final String teamRed = "red";
    private final String teamBlue = "blue";
    private int betTotalRed;
    private int betTotalBlue;
    private boolean weightedBets = false;

    public BetManager() {
        activeBets = new ArrayList<>();
        validWinners = new ArrayList<>();
        validWinners.add(teamRed);
        validWinners.add(teamBlue);
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
        betTotalRed = 0;
        betTotalBlue = 0;
    }

    public void payout(String winner) {
        for (Bet bet : activeBets) {
            if (bet.getWinner().equalsIgnoreCase(winner)) {
                User user = bet.getUser();
                if (weightedBets) {
                    
                } else {
                    user.setBalance(user.getBalance() + bet.getAmount() * 2);
                }
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
        if (winner.equals(teamRed)) {
            betTotalRed += amount;
        } else if (winner.equals(teamBlue)) {
            betTotalBlue += amount;
        }
    }

    public void updateBet(User user, long amount, String winner) {
        for (Bet bet : activeBets) {
            if (bet.getUser().getName().equalsIgnoreCase(user.getName())) {
                if (bet.getWinner().equals(teamRed)) {
                    betTotalRed -= bet.getAmount();
                } else if (bet.getWinner().equals(teamBlue)) {
                    betTotalBlue -= bet.getAmount();
                }
                if (winner.equals(teamRed)) {
                    betTotalRed += amount;
                } else if (winner.equals(teamBlue)) {
                    betTotalBlue += amount;
                }
                bet.setAmount(amount);
                bet.setWinner(winner);
            }
        }
    }

    public void removeBet(User user) {
        Bet bet = getBetByUser(user);
        if (bet.getWinner().equals(teamRed)) {
            betTotalRed -= bet.getAmount();
        } else if (bet.getWinner().equals(teamBlue)) {
            betTotalBlue -= bet.getAmount();
        }
        activeBets.remove(bet);
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
