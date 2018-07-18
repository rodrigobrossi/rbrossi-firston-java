package br.com.crm.validation;

public final class ValidatiorEval {
	
	private static final ValidatiorEval ev = new ValidatiorEval();
	
	private ValidatiorEval(){}
	
	public static ValidatiorEval getValidator(){
		return ev;
	}
	
	
	public static void valid(){
		
		
		
	}
	
	/**
	 * Return an error message to use on the window 
	 * @return 
	 */
	public static String getValidateMessage(String[] messages, int titleField ) {
		StringBuffer bf = new StringBuffer();
		bf.append("<font face='Verdana' size='2' color=RED><b>Errors found in:"+ getMessage(titleField) + ":</b> </font>");
		for (int i = 0; i < messages.length; i++) {
			bf.append("<br><tt><b>"+(i+1)+".</b> "+messages[i]+"</tt>");	
		}
		return bf.toString();
	}

	private static String getMessage(int titleField) {
		// TODO Auto-generated method stub
		return "[UNDER CREATION]:"+titleField;
	}

}
