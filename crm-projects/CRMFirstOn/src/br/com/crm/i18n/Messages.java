package br.com.crm.i18n;

import java.util.Locale;
import java.util.ResourceBundle;

public class Messages {
    private static ResourceBundle messages;
    private static Locale currentLocale;

    static {
        setLocale(Locale.getDefault());
    }

    public static void setLocale(Locale locale) {
        currentLocale = locale;
        messages = ResourceBundle.getBundle("br.com.crm.gui.i18N.messages", currentLocale);
    }

    public static String getString(String key) {
        try {
            return messages.getString(key);
        } catch (Exception e) {
            return key;
        }
    }

    public static Locale getCurrentLocale() {
        return currentLocale;
    }
} 