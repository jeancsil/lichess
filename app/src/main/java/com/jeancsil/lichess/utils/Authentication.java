package com.jeancsil.lichess.utils;

import java.io.File;
import java.io.IOException;

import com.google.common.base.Charsets;
import com.google.common.io.Files;

public class Authentication {
    private Authentication() {
    }

    public static String getAuthToken() {
        try {
            var lichessToken = new File(".lichess.token");
            var contents = Files.readLines(lichessToken, Charsets.UTF_8);
            if (contents.size() == 0) {
                throw new RuntimeException("Lichess token not found");
            }

            return contents.getFirst();
        } catch (IOException e) {
            throw new RuntimeException("Error authenticating to Lichess");
        }
    }
}
