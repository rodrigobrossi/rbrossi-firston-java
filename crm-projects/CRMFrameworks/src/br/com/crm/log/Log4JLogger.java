package br.com.crm.log;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.ConsoleAppender;
import org.apache.log4j.HTMLLayout;
import org.apache.log4j.Layout;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.Priority;
import org.apache.log4j.RollingFileAppender;
import org.apache.log4j.WriterAppender;


public final class Log4JLogger extends LoggerFactory implements ILogger {
   private static Log4JLogger log4JLogger;
   private static final Map levelsMap;

   static {
      levelsMap = new HashMap();
      levelsMap.put(LoggerConstants.DEBUG, Level.DEBUG);
      levelsMap.put(LoggerConstants.INFO, Level.INFO);
      levelsMap.put(LoggerConstants.WARNING, Level.WARN);
      levelsMap.put(LoggerConstants.ERROR, Level.ERROR);
      levelsMap.put(LoggerConstants.FATAL, Level.FATAL);
      levelsMap.put(LoggerConstants.LOG_ON, Level.ALL);
      levelsMap.put(LoggerConstants.LOG_OFF, Level.OFF);
   }

   private Logger logger;
   private String pattern          = "[%d{yy-MM-dd HH:mm:ss,SSS z}] [%t] (%-5p) %c: %m%n";
   private String logFilename      = null;
   private int logViewConf         = LoggerConstants.LOG_CONSOLE;
   private WriterAppender appender;
   private boolean logViewSeted;
   private Level levelCurrent      = Level.DEBUG;

   private int maxBackupIndex   = 3;
   private String maxSizeOfFile = "5MB";

   /**
    * Creates a new Log4JLogger object.
    */
   private Log4JLogger() {
   }

   /**
    * DOCUMENT ME
    *
    * @return DOCUMENT ME!
    */
   public static Log4JLogger getInstance() {
      if (log4JLogger == null) {
         log4JLogger = new Log4JLogger();
      }
      return log4JLogger;
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#setLevel(java.lang.Object)
    */
   public void setLevel(Object level) {
      logger.setLevel(( Level )levelsMap.get(level));
      levelCurrent = logger.getLevel();
   }

   public void setLogToConsole() {
       logViewConf = LoggerConstants.LOG_CONSOLE;
   }

   public void setLogToFile(String filename) {
       logViewConf = LoggerConstants.LOG_FILE;
       logFilename = filename;
   }

   public void setLogToFile(String filename, String threshold) {
       logViewConf = LoggerConstants.LOG_FILE;
       logFilename = filename;
       if(threshold.equals(LoggerConstants.DEBUG)) {
           levelCurrent = Level.DEBUG;
       } else if(threshold.equals(LoggerConstants.INFO)) {
           levelCurrent = Level.INFO;
       } else if(threshold.equals(LoggerConstants.WARNING)) {
           levelCurrent = Level.WARN;
       } else if(threshold.equals(LoggerConstants.ERROR)) {
           levelCurrent = Level.ERROR;
       } else if(threshold.equals(LoggerConstants.FATAL)) {
           levelCurrent = Level.FATAL;
       }
   }


   public void setLogToHTMLFile(String htmlFilename) {
       logViewConf = LoggerConstants.LOG_HTML;
       logFilename = htmlFilename;
   }


   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#configureLogger(java.lang.Object)
    */
   public void configureLogger(Object classType) {
      logger = Logger.getLogger(( Class )classType);
      configureLogView(logViewConf);
      logger.setLevel(levelCurrent);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#info(java.lang.Object)
    */
   public void debug(Object message) {
      logger.debug(message);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#error(java.lang.Object)
    */
   public void error(Object message) {
      logger.error(message);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#error(java.lang.Object, java.lang.Object)
    */
   public void error(Object message, Object throwable) {
      logger.error(message, ( Throwable )throwable);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#fatal(java.lang.Object)
    */
   public void fatal(Object message) {
      logger.fatal(message);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#info(java.lang.Object)
    */
   public void info(Object message) {
      logger.info(message);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#log(java.lang.Object, java.lang.Object, java.lang.Object)
    */
   public void log(Object priority, Object message, Object throwable) {
      logger.log(( Priority )levelsMap.get(priority), message, ( Throwable )throwable);
   }

   /** (non-Javadoc)
    * @see com.mot.log.ILogger#log(java.lang.Object)
    */
   public void log(Object throwable) {
      logger.log(( Priority )levelsMap.get(LoggerConstants.ERROR), "",
                 ( Throwable )throwable);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#log(java.lang.Object, java.lang.Object)
    */
   public void log(Object priority, Object message) {
      logger.log(( Priority )levelsMap.get(priority), message);
   }

   /** (non-Javadoc)
    * @see br.com.motorola.uict.log.ILogger#warn(java.lang.Object)
    */
   public void warn(Object message) {
      logger.warn(message);
   }

   /**
    * DOCUMENT ME
    */
   private void setAppenderConsole() {
      Layout layout = new PatternLayout(pattern);
      appender = new ConsoleAppender(layout);
   }

   /**
    * DOCUMENT ME
    */
   private void setAppenderFile() {
       Layout layout = new PatternLayout(pattern);
       try {
           RollingFileAppender tempFileAppender = new RollingFileAppender(layout, logFilename);
           tempFileAppender.setMaxBackupIndex(maxBackupIndex);
           tempFileAppender.setMaxFileSize(maxSizeOfFile);
           appender = tempFileAppender;
       } catch(IOException e) {
       }
   }

   /**
    * DOCUMENT ME
    */
   private void setAppenderHTML() {
      try {
         Layout layout           = new HTMLLayout();
         FileOutputStream output = new FileOutputStream("UICT_LOG.html");
         appender                = new WriterAppender(layout, output);
      } catch (IOException e) {
      }
   }

   /**
    * DOCUMENT ME
    *
    * @param logView DOCUMENT ME!
    */
   private void configureLogView(int logView) {
      if (!logViewSeted) {
         logger.removeAllAppenders();

         switch (logView) {
            case LoggerConstants.LOG_CONSOLE:
               setAppenderConsole();

               break;

            case LoggerConstants.LOG_FILE:
               setAppenderFile();

               break;

            case LoggerConstants.LOG_HTML:
               setAppenderHTML();

               break;

            default:

               String errMsg = Integer.toString(logView);
               throw new IllegalArgumentException(errMsg);
         }

         logger.addAppender(appender);
         logViewSeted = true;
      } else {
         logger.addAppender(appender);
      }
   }
}
