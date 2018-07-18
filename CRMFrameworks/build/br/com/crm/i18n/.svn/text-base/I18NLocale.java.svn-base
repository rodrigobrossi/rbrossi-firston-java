package br.com.crm.i18n;

import java.util.Locale;


/**
 * Class to set the current locale and language
 * of the application
 */
public class I18NLocale implements I18NApplicationLocale {
   private static I18NLocale I18N_Locale = new I18NLocale();
   private Locale locale;

   /**
    * This class is not intended to be instantiated.
    */
   private I18NLocale() {
   }

   /**
    * @return instance of I18NLocale
    */
   public static I18NLocale getInstance() {
      if (I18N_Locale == null) {
         return new I18NLocale();
      }

      return I18N_Locale;
   }

   /**
    *
    * @param locale
    * @return
    */
   public static I18NLocale getInstance(Locale locale) {
      I18N_Locale.setLocale(locale);

      return I18N_Locale;
   }

   /**
    * Gets the identifier for the current language and region
    * of the application.
    */
   public Locale getCurrentLocale() {
      return locale;
   }

   /**
    * Sets the identifier for the current language and region
    * of the application.
    */
   public void setLocale(Locale currentLocale) {
      locale = currentLocale;
   }
}
