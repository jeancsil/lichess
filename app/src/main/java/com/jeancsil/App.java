package com.jeancsil;

import com.jeancsil.lichess.LichessService;
import com.jeancsil.lichess.utils.Authentication;
import com.jeancsil.lichess.utils.ClipboardReader;
import com.jeancsil.lichess.validation.PgnValidator;

public class App {
    public static void main(String[] args) {
        importGame();
    }

    private static void importGame() {
        try {
            var lichessService = new LichessService(Authentication.getAuthToken());
            var pgn = new ClipboardReader().getClipboard();

            if (!PgnValidator.isValidPgn(pgn)) {
                System.err.println("Error: Invalid PGN format. Please copy a valid PGN before running the command.");
                System.exit(127);
            }


            String gameId = lichessService.importGame(pgn);
            System.out.println("https://lichess.org/" + gameId);
        } catch (Exception e) {
            System.exit(127);
        }
    }
}