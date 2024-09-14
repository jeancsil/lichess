package com.jeancsil;

import com.jeancsil.lichess.LichessService;
import com.jeancsil.lichess.utils.Authentication;
import com.jeancsil.lichess.utils.ClipboardReader;
import com.jeancsil.lichess.validation.PgnValidator;

public class App {
    public static void main(String[] args) {
        try {
            var pgn = new ClipboardReader().getClipboard();
            
            if (!PgnValidator.isValidPgn(pgn)) {
                System.err.println("Error: Invalid PGN format. Please copy a valid PGN before running the command.");
                System.exit(127);
            }

            String token = Authentication.getAuthToken();
            new LichessService(token).importGame(pgn);
        } catch (Exception e) {
            System.exit(127);
        }
    }
}