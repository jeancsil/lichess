package com.jeancsil;

import com.jeancsil.lichess.LichessService;
import com.jeancsil.lichess.utils.Authentication;
import com.jeancsil.lichess.validation.PgnValidator;
import com.jeancsil.lichess.utils.ConsoleLogger;

public class App {
    public static void main(String[] args) {
        ConsoleLogger.debug("Application started");
        
        String pgn = System.getenv("PGN");
        ConsoleLogger.info("Received PGN: " + (pgn != null ? pgn : "null"));
        
        if (pgn == null || pgn.isEmpty()) {
            ConsoleLogger.error("PGN environment variable is not set or is empty");
            System.exit(1);
        }

        if (!PgnValidator.isValidPgn(pgn)) {
            ConsoleLogger.error("Invalid PGN format.");
            System.exit(1);
        }

        try {
            String token = Authentication.getAuthToken();
            new LichessService(token).importGame(pgn);
        } catch (Exception e) {
            ConsoleLogger.error("An error occurred: " + e.getMessage());
            e.printStackTrace();
            System.exit(1);
        }
    }
}