package twitch.chatbot;

import twitch.chatbot.beans.User;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserManager {

    public List<User> registeredUsers;
    private int initialBalance = 100;

    public UserManager() {
        registeredUsers = new ArrayList<>();
    }

    public boolean registerUser(String name) {
        if (!userExists(name)) {
            registeredUsers.add(new User(name, initialBalance));
            System.out.println("Registered user: " + name);
            return true;
        }
        System.out.println("Registration failed due to user already existing: " + name);
        return false;
    }

    public User getUser(String name) {
        Optional<User> matchingObject = registeredUsers.stream().
                filter(p -> p.getName().equalsIgnoreCase(name)).
                findFirst();
        return matchingObject.orElse(null);
    }

    private boolean userExists(String name) {
        return registeredUsers.stream().map(User::getName).anyMatch(name::equals);
    }

    public int getInitialBalance() {
        return initialBalance;
    }
}
