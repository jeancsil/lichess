package com.jeancsil.lichess.utils;

public class Authentication {
    private Authentication() {
    }

    public static String getAuthToken() {
        String lichessToken = System.getenv("LICHESS_TOKEN");
        if (lichessToken == null || lichessToken.isEmpty()) {
            ConsoleLogger.error("LICHESS_TOKEN environment variable is not set");
            throw new RuntimeException("LICHESS_TOKEN environment variable is not set");
        }
        return lichessToken;
    }
}
