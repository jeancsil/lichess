package com.jeancsil.lichess.utils;

import java.util.logging.*;

public class ConsoleLogger {
    private static final Logger LOGGER = Logger.getLogger(ConsoleLogger.class.getName());

    static {
        LOGGER.setLevel(Level.ALL);
        ConsoleHandler handler = new ConsoleHandler();
        handler.setFormatter(new Formatter() {
            @Override
            public String format(LogRecord record) {
                return record.getMessage() + "\n";
            }
        });
        handler.setLevel(Level.ALL);
        LOGGER.addHandler(handler);
        LOGGER.setUseParentHandlers(false);
    }

    public static void info(String message) {
        LOGGER.info(message);
    }

    public static void error(String message) {
        LOGGER.severe(message);
    }

    public static void debug(String message) {
        LOGGER.fine(message);
    }
}