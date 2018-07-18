package br.com.crm.log;

public abstract class LoggerFactory {
    
    private static ILogger logger = Log4JLogger.getInstance();
    
    /**
     * Get logger choosed for application
     * @param log logger used in application
     * @return instance of object log appropriate
     */
    public static final ILogger getFactory(int log){
        switch(log) {
        	case LoggerConstants.LOG4J:
        	    return logger;
        }
        
        String errMsg = Integer.toString(log);
        throw new IllegalArgumentException(errMsg);
    }
}
