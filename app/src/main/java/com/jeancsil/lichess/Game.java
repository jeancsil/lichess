package com.jeancsil.lichess;


public class Game {
    private final LichessService lichessService;

    public Game(LichessService lichessService) {
        this.lichessService = lichessService;
    }

    public String importGame(String pgn) {
        return lichessService.importGame(pgn);
    }
}