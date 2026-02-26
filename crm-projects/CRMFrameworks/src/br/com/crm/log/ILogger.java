package br.com.crm.log;

public interface ILogger {
   /**
    * @param level
    */
   public void setLevel(Object level);

   public void setLogToConsole();
   public void setLogToFile(String filename);
   public void setLogToFile(String filename, String threshold);
   public void setLogToHTMLFile(String htmlFilename);

   /**
    * @param configure
    */
   public void configureLogger(Object configure);

   /**
    * @param message
    */
   public void debug(Object message);

   /**
    * @param message
    */
   public void error(Object message);

   /**
    *
    * @param message
    * @param throwable
    */
   public void error(Object message, Object throwable);

   /**
    * @param message
    */
   public void fatal(Object message);

   /**
    * @param message
    */
   public void info(Object message);

   /**
    * @param priority
    * @param message
    * @param throwable
    */
   public void log(Object priority, Object message, Object throwable);

   /**
    * @param priority
    * @param message
    */
   public void log(Object priority, Object message);

   /**
    * @param throwable
    */
   public void log(Object throwable);

   /**
    * @param message
    */
   public void warn(Object message);
}
