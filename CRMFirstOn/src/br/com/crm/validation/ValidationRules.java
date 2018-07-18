package br.com.crm.validation;

import javax.swing.JTextField;

public abstract class ValidationRules {

	public ValidationRules() {
		super();
	}
	/**
	 * Validate a JTextField
	 * @param component
	 * @return
	 */
	public static String[] validateJTextFiel(JTextField component,int validation) {
		if (component != null ) {

			if (validation==ValidatorConstants.VALIDFOR_TIT) {
				String[] messages = null;
				if (component.getText().length() > 15) {
					messages = new String[1];
					messages[0] = "Elemento possui tamanho maior do que o permitido";
				}
				return messages;
			}// End of First Component
			else if (validation==ValidatorConstants.VALIDFOR_DDD) {
				// TODO Imaplement validation
				return null;
			} else if (validation==ValidatorConstants.VALIDFOR_EMAIL) {
				// TODO Imaplement validation
				return null;
			} else if (validation==ValidatorConstants.VALIDFOR_HTTP) {
				// TODO Imaplement validation
				return null;
			} else if (validation==ValidatorConstants.VALIDFOR_NUMERIC_1) {
				// TODO Imaplement validation
				return null;
			} else if (validation==ValidatorConstants.VALIDFOR_NUMERIC_3) {
				// TODO Imaplement validation
				return null;
			} else if (validation==ValidatorConstants.VALIDFOR_PRICE) {
				// TODO Imaplement validation
				return null;
			} else if (validation==ValidatorConstants.VALIDFOR_TEL) {
				// TODO Imaplement validation
				return null;
			}else{
				return null;
			}
		}else{
			return null;
		}
	}

}
