package br.com.crm.i18n;

import java.util.MissingResourceException;
import java.util.ResourceBundle;

public class Messages {
	private static final String BUNDLE_NAME = "br.com.crm.gui.i18N.messages"; //$NON-NLS-1$

	private static final ResourceBundle RESOURCE_BUNDLE = ResourceBundle
			.getBundle(BUNDLE_NAME);

	private Messages() {
	}

	public static String getString(String key) {

		try {
			System.out.println("[i18N][Loading]"+key);
			String result = RESOURCE_BUNDLE.getString(key);
			System.out.println("[i18N][Loading]"+result);
			return result;
		} catch (MissingResourceException e) {
			return '!' + key + '!';
		}
	}
}
