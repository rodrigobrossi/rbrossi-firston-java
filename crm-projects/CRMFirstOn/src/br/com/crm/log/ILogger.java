package br.com.crm.log;

public interface ILogger {
    void configureLogger(Class<?> clazz);
    void setLogToHTMLFile(String fileName);
    void error(String message, Throwable throwable);
    // Add other methods as needed
} 