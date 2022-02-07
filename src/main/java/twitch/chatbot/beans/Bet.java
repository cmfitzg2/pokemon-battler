package twitch.chatbot.beans;

public class Bet {

    private User user;
    private long amount;
    private String winner;

    public Bet(User user, long amount, String winner) {
        this.user = user;
        this.amount = amount;
        this.winner = winner;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public long getAmount() {
        return amount;
    }

    public void setAmount(long amount) {
        this.amount = amount;
    }

    public String getWinner() {
        return winner;
    }

    public void setWinner(String winner) {
        this.winner = winner;
    }
}
