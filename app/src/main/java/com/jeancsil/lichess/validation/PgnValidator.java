package com.jeancsil.lichess.validation;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class PgnValidator {
    private static final Pattern TAG_PATTERN = Pattern.compile("\\[([A-Za-z0-9]+)\\s+\"(.*)\"\\]");
    private static final Pattern MOVE_PATTERN = Pattern.compile("\\d+\\.\\s*([PNBRQK]?[a-h]?[1-8]?x?[a-h][1-8](=[NBRQ])?|O-O(?:-O)?)[+#]?|\\{.*?\\}|\\(.*?\\)|\\$\\d+");
    private static final Pattern RESULT_PATTERN = Pattern.compile("(1-0|0-1|1/2-1/2|\\*)\\s*$");

    public static boolean isValidPgn(String pgn) {
        if (pgn == null || pgn.trim().isEmpty()) {
            return false;
        }

        String[] lines = pgn.split("\n");
        boolean seenMoves = false;
        boolean seenTags = false;
        boolean seenResult = false;
        StringBuilder moveText = new StringBuilder();

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty()) {
                continue;
            }

            if (line.startsWith("[")) {
                if (seenMoves) {
                    return false; // Tags should come before moves
                }
                if (!isValidTag(line)) {
                    return false;
                }
                seenTags = true;
            } else {
                if (!seenTags) {
                    return false; // Must have at least one tag before moves
                }
                moveText.append(line).append(" ");
            }
        }

        var fullMoveText = moveText.toString().trim();
        if (isValidResult(fullMoveText)) {
            seenResult = true;
            fullMoveText = fullMoveText.substring(0, fullMoveText.lastIndexOf(' ')).trim();
        }

        seenMoves = isValidMoveText(fullMoveText);

        return seenTags && seenMoves && seenResult;
    }

    private static boolean isValidTag(String tag) {
        Matcher matcher = TAG_PATTERN.matcher(tag);
        return matcher.matches();
    }

    private static boolean isValidMoveText(String moveText) {
        Matcher matcher = MOVE_PATTERN.matcher(moveText);
        return matcher.find();
    }

    private static boolean isValidResult(String result) {
        Matcher matcher = RESULT_PATTERN.matcher(result);
        return matcher.find();
    }
}
