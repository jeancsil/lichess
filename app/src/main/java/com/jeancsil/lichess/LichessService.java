package com.jeancsil.lichess;

import com.jeancsil.lichess.utils.ConsoleLogger;

import chariot.Client;

public class LichessService {
    private final Client client;

    public LichessService(String authToken) {
        this.client = Client.auth(authToken);
    }

    public String importGame(String pgn) {
        var gameId = client.games().importGame(pgn).mapOne(t -> t.id()).get();
        ConsoleLogger.info("Game imported successfully: https://lichess.org/" + gameId);
        return gameId;
    }
}