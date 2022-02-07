package twitch.chatbot;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;
import com.github.philippheuer.credentialmanager.domain.OAuth2Credential;
import com.github.twitch4j.TwitchClient;
import com.github.twitch4j.TwitchClientBuilder;
import com.github.philippheuer.events4j.simple.SimpleEventHandler;

import twitch.chatbot.features.*;

import java.io.InputStream;

public class Bot {

    private Configuration configuration;
    private TwitchClient twitchClient;
    public static UserManager userManager;
    public static BetManager betManager;

    public Bot() {
        loadConfiguration();
        System.out.println(configuration.toString());
        TwitchClientBuilder clientBuilder = TwitchClientBuilder.builder();
        OAuth2Credential credential = new OAuth2Credential(
                "twitch",
                configuration.getCredentials().get("irc")
        );
        twitchClient = clientBuilder
                .withClientId(configuration.getApi().get("twitch_client_id"))
                .withClientSecret(configuration.getApi().get("twitch_client_secret"))
                .withEnableHelix(true)
                /*
                 * Chat Module
                 * Joins irc and triggers all chat based events (viewer join/leave/sub/bits/gifted subs/...)
                 */
                .withChatAccount(credential)
                .withEnableChat(true)
                /*
                 * GraphQL has a limited support
                 * Don't expect a bunch of features enabling it
                 */
                .withEnableGraphQL(true)
                /*
                 * Kraken is going to be deprecated
                 * see : https://dev.twitch.tv/docs/v5/#which-api-version-can-you-use
                 * It is only here so you can call methods that are not (yet)
                 * implemented in Helix
                 */
                .withEnableKraken(true)
                .build();
        userManager = new UserManager();
        betManager = new BetManager();
    }

    /**
     * Method to register all features
     */
    public void registerFeatures() {
        SimpleEventHandler eventHandler = twitchClient.getEventManager().getEventHandler(SimpleEventHandler.class);

        // Register Event-based features
        ChannelNotificationOnDonation channelNotificationOnDonation = new ChannelNotificationOnDonation(eventHandler);
        ChannelNotificationOnFollow channelNotificationOnFollow = new ChannelNotificationOnFollow(eventHandler);
        ChannelNotificationOnSubscription channelNotificationOnSubscription = new ChannelNotificationOnSubscription(eventHandler);
        ProcessComands processComands = new ProcessComands(eventHandler);
    }

    /**
     * Load the Configuration
     */
    private void loadConfiguration() {
        try {
            ClassLoader classloader = Thread.currentThread().getContextClassLoader();
            InputStream is = classloader.getResourceAsStream("config.yaml");

            ObjectMapper mapper = new ObjectMapper(new YAMLFactory());
            configuration = mapper.readValue(is, Configuration.class);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Unable to load Configuration ... Exiting.");
            System.exit(1);
        }
    }

    public void start() {
        // Connect to all channels
        for (String channel : configuration.getChannels()) {
            twitchClient.getChat().joinChannel(channel);
        }
    }

    public void sendPublicMessage(String message, String channelName) {
        twitchClient.getChat().sendMessage(channelName, message);
    }

    public TwitchClient getTwitchClient() {
        return twitchClient;
    }
}
