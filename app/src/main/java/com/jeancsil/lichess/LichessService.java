package com.jeancsil.lichess;

import chariot.Client;

// import java.util.concurrent.CompletableFuture;

public class LichessService {
    private final Client client;

    public LichessService(String authToken) {
        this.client = Client.auth(authToken);
    }

    public String importGame(String pgn) {
        return client.games().importGame(pgn).mapOne(t -> t.id()).get();
    }
}