package br.com.crm.log;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

public class Logger {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(Logger.class);

    public static org.slf4j.Logger getLogger() {
        return logger;
    }

    public void log(String message) {
        logger.info(message);
    }
} 