package br.com.crm.log;



/**
 * This class defines the logger to be used by the application in order to do the log 
 * 
 */
public class Logger {
   private static ILogger logger = ( ILogger )LoggerFactory.getFactory(LoggerConstants.LOG4J);
   
   /**
    * Get the logger  
    * @return ILogger
    */
   public static ILogger getLogger() {
      return logger;
   }
}
