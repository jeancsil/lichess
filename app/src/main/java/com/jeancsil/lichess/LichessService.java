package com.jeancsil.lichess;

import chariot.Client;

public class LichessService {
    private final Client client;

    public LichessService(String authToken) {
        this.client = Client.auth(authToken);
    }

    public String importGame(String pgn) {
        var gameId = client.games().importGame(pgn).mapOne(t -> t.id()).get();
        System.out.println("https://lichess.org/" + gameId);
        return gameId;
    }
}