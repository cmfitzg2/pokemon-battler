package twitch.chatbot.features;

import battler.PokeBattler;
import com.github.philippheuer.events4j.simple.SimpleEventHandler;
import com.github.twitch4j.TwitchClient;
import com.github.twitch4j.chat.events.channel.ChannelMessageEvent;
import twitch.chatbot.Bot;
import twitch.chatbot.beans.Bet;
import twitch.chatbot.beans.User;

import java.util.Optional;

public class ProcessComands {

    private TwitchClient client;

    public ProcessComands(SimpleEventHandler eventHandler) {
        eventHandler.onEvent(ChannelMessageEvent.class, this::onChannelMessage);
        client = PokeBattler.twitchBot.getTwitchClient();
    }

    public void onChannelMessage(ChannelMessageEvent event) {
        String user = event.getUser().getName();
        String message = event.getMessage();
        String channelName = event.getChannel().getName();
        if (message.startsWith("!")) {
            String command = message.substring(1);
            String[] parts = command.split(" ");
            switch (parts[0]) {
                case "register":
                    if (parts.length == 1) {
                        register(user, channelName);
                    } else {
                        sendPublicMessage("@" + user + " This command does not take any arguments", channelName);
                    }
                    break;
                case "balance":
                    if (parts.length == 1) {
                        balance(user, channelName);
                    } else {
                        sendPublicMessage("@" + user + " This command does not take any arguments", channelName);
                    }
                    break;
                case "bet":
                    bet(user, channelName, parts);
                    break;
                case "unbet":
                    if (parts.length == 1) {
                        unbet(user, channelName);
                    } else {
                        sendPublicMessage("@" + user + " This command does not take any arguments", channelName);
                    }
                    break;
                case "bets":
                    if (parts.length == 1) {
                        bets(user, channelName);
                    } else {
                        sendPublicMessage("@" + user + " This command does not take any arguments", channelName);
                    }
                    break;
                case "commands":
                    if (parts.length == 1) {
                        commands(channelName);
                    }
                    break;
                default:
                    break;
            }
        }
        System.out.printf(
                "Channel [%s] - User[%s] - Message [%s]%n",
                event.getChannel().getName(),
                event.getUser().getName(),
                event.getMessage()
        );
    }

    private void register(String user, String channelName) {
        if (Bot.userManager.registerUser(user)) {
            sendPublicMessage("@" + user + " You have registered successfully! Your account has been given an initial balance of "
                    + Bot.userManager.getInitialBalance(), channelName);
        } else {
            sendPublicMessage("@" + user + " You are already registered!", channelName);
        }
    }

    private void balance(String user, String channelName) {
        if (Bot.userManager.getUser(user) != null) {
            sendPublicMessage("@" + user + " Your balance is " + Bot.userManager.getUser(user).getBalance(), channelName);
        } else {
            sendPublicMessage("@" + user + " Please !register before trying to use this command", channelName);
        }
    }

    private void bet(String user, String channelName, String[] parts) {
        User registeredUser = Bot.userManager.getUser(user);
        if (registeredUser != null) {
            if (Bot.betManager.isBetsOpen()) {
                if (parts.length != 3) {
                    sendPublicMessage("@" + user + " Incorrect number of arguments for bet. Please use format: \"!bet amount winner\", " +
                            "e.g., \"!bet 100 red\" (no quotes)", channelName);
                } else {
                    try {
                        long amount = Long.parseLong(parts[1]);
                        String winner = parts[2];
                        if (amount < 0) {
                            sendPublicMessage("@" + user + " Bet must be a positive number", channelName);
                        } else {
                            Optional<Bet> matchingObject = Bot.betManager.activeBets.stream().
                                    filter(p -> p.getUser().getName().equalsIgnoreCase(registeredUser.getName())).
                                    findFirst();
                            Bet bet = matchingObject.orElse(null);
                            long balance = registeredUser.getBalance();
                            if (bet != null) {
                                //user already has a live bet
                                long prevBet = bet.getAmount();
                                String prevWinner = bet.getWinner();
                                if (balance + prevBet >= amount) {
                                    if (Bot.betManager.isWinnerValid(winner)) {
                                        registeredUser.setBalance(balance + prevBet - amount);
                                        if (amount == 0) {
                                            Bot.betManager.removeBet(registeredUser);
                                            sendPublicMessage("@" + user + " Your active bet has been removed", channelName);
                                        } else {
                                            Bot.betManager.updateBet(registeredUser, amount, winner);
                                            sendPublicMessage("@" + user + " Bet updated from " +
                                                    prevBet + " on " + prevWinner + " to " +
                                                    amount + " on " + winner, channelName);
                                        }
                                    } else {
                                        sendPublicMessage("@" + user + " Incorrect format for bet. Please use format: \"!bet amount winner\", " +
                                                "e.g., \"!bet 100 red\" (no quotes)", channelName);
                                    }
                                } else {
                                    sendPublicMessage("@" + user + " Insufficient balance to place this bet", channelName);
                                }
                            } else {
                                if (amount == 0) {
                                    sendPublicMessage("@" + user + " Bet must be a positive number", channelName);
                                } else {
                                    if (balance >= amount) {
                                        if (Bot.betManager.isWinnerValid(winner)) {
                                            registeredUser.setBalance(balance - amount);
                                            Bot.betManager.addBet(registeredUser, amount, winner);
                                            sendPublicMessage("@" + user + " Bet of " + amount + " successfully placed on " + winner, channelName);
                                        } else {
                                            sendPublicMessage("@" + user + " Incorrect format for bet. Please use format: \"!bet amount winner\", " +
                                                    "e.g., \"!bet 100 red\" (no quotes)", channelName);
                                        }
                                    } else {
                                        sendPublicMessage("@" + user + " Insufficient balance to place this bet", channelName);
                                    }
                                }
                            }
                        }
                    } catch (NumberFormatException e) {
                        sendPublicMessage("@" + user + " Incorrect format for bet. Please use format: \"!bet amount winner\", " +
                                "e.g., \"!bet 100 red\" (no quotes)", channelName);
                    }
                }
            } else {
                sendPublicMessage("@" + user + " Bets are closed!", channelName);
            }
        } else {
            sendPublicMessage("@" + user + " Please !register before trying to use this command", channelName);
        }
    }

    private void unbet(String user, String channelName) {
        if (Bot.betManager.isBetsOpen()) {
            User registeredUser = Bot.userManager.getUser(user);
            if (registeredUser != null) {
                Optional<Bet> matchingObject = Bot.betManager.activeBets.stream().
                        filter(p -> p.getUser().getName().equalsIgnoreCase(registeredUser.getName())).
                        findFirst();
                Bet bet = matchingObject.orElse(null);
                if (null != bet) {
                    registeredUser.setBalance(registeredUser.getBalance() + bet.getAmount());
                    Bot.betManager.removeBet(registeredUser);
                    sendPublicMessage("@" + user + " Your active bet has been removed", channelName);
                } else {
                    sendPublicMessage("@" + user + " You currently have no bets open", channelName);
                }
            } else {
                sendPublicMessage("@" + user + " Please !register before trying to use this command", channelName);
            }
        } else {
            sendPublicMessage("@" + user + " Bets are closed!", channelName);
        }
    }
    private void commands(String channelName) {
        sendPublicMessage("!register - If you are unregistered, registers you in the system and loads you with an initial balance of " + Bot.userManager.getInitialBalance(), channelName);
        sendPublicMessage("!balance - PMs you your current balance", channelName);
        sendPublicMessage("!bet amount winner - If bets are open, places a bet on the specified winner for the specified amount, e.g., \"!bet 100 red\"", channelName);
        sendPublicMessage("!commands - Sends this message to the channel", channelName);
    }

    private void bets(String user, String channelName) {
        User registeredUser = Bot.userManager.getUser(user);
        if (null != registeredUser) {
            Bet bet = Bot.betManager.getBetByUser(registeredUser);
            if (bet != null) {
                sendPublicMessage("@" + user + " You are currently betting " + bet.getAmount() + " on " + bet.getWinner(), channelName);
            } else {
                sendPublicMessage("@" + user + " You currently have no bets open", channelName);
            }
        } else {
            sendPublicMessage("@" + user + " Please !register before trying to use this command", channelName);
        }
    }

    private void sendPublicMessage(String message, String channelName) {
        client.getChat().sendMessage(channelName, message);
    }
}
