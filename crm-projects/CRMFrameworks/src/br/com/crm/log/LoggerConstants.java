package br.com.crm.log;

public class LoggerConstants {
   /**
    * Status type severity indicating this status represents an debug.
    */
   public static final String DEBUG = "DEBUG";

   /**
    * Status type severity indicating this status is informational only.
    */
   public static final String INFO = "INFO";

   /**
    * Status type severity indicating this status represents a warning.
    */
   public static final String WARNING = "WARN";

   /**
    * Status type severity indicating this status represents an error.
    */
   public static final String ERROR = "ERROR";

   /**
    * Status type severity indicating this status represents an fatal error.
    */
   public static final String FATAL = "FATAL";

   /**
    * Status type severity indicating turn on all logging.
    */
   public static final String LOG_ON = "ALL";

   /**
    * Status type severity indicating to turn off logging.
    */
   public static final String LOG_OFF = "OFF";

   /**
    * References for logger org.apache.log4j
    */
   public static final int LOG4J = 0;

   /**
    * References for logger showed in the console
    */
   public static final int LOG_CONSOLE = 1;

   /**
    * References for logger showed in a file
    */
   public static final int LOG_FILE = 2;

   /**
    * References for logger showed in a html file
    */
   public static final int LOG_HTML = 3;
}
