/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

import java.io.PrintStream;

public class FOLoginValidatorBean {

	public FOLoginValidatorBean() {
		validou = false;
		foi = "";
		arroba = "";
		login = "";
		r = 0;
		e = 0;
		count = 0;
		counts = 0;
	}

	public boolean verificaRemetente(String email1) {
		String email = email1.trim();
		char teste[] = email.toCharArray();
		int tamanho = email.length();
		for (r = 0; r < email.length(); r++) {
			if (teste[r] == '/' || teste[r] == '\264' || teste[r] == '\\'
					|| teste[r] == '#' || teste[r] == '$' || teste[r] == '%'
					|| teste[r] == '\250' || teste[r] == '&' || teste[r] == '*'
					|| teste[r] == '(' || teste[r] == ')' || teste[r] == '\247'
					|| teste[r] == '+' || teste[r] == '=' || teste[r] == ' '
					|| teste[r] == '"' || teste[r] == '~' || teste[r] == '^'
					|| teste[r] == '\272' || teste[r] == ']' || teste[r] == '['
					|| teste[r] == '{' || teste[r] == '}' || teste[r] == '\260'
					|| teste[r] == ';' || teste[r] == ':' || teste[r] == '>'
					|| teste[r] == '<' || teste[r] == ',' || teste[r] == '?') {
				validou = false;
				break;
			}
			if (teste[r] == '@') {
				arroba = String.valueOf(teste[r]);
				if (r != email.length())
					do {
						if (teste[r] == '.') {
							count++;
							if (r++ == email.length()) {
								validou = false;
							} else {
								counts++;
								validou = true;
							}
							break;
						}
						foi = "" + foi + String.valueOf(teste[r]);
						if (teste[r] == '.')
							count++;
						r++;
					} while (r < email.length());
				else
					validou = false;
				break;
			}
			validou = false;
			login = "" + login + String.valueOf(teste[r]);
			System.out.println("teste");
		}

		if (teste[email.length() - 1] == '.')
			validou = false;
		return validou;
	}

	public String retornaArroba() {
		return arroba;
	}

	public String retornaFim() {
		return foi;
	}

	public String retornaLogin() {
		return login;
	}

	public int retornaPontos() {
		return count;
	}

	boolean validou;
	String foi;
	String arroba;
	String login;
	int r;
	int e;
	int count;
	int counts;
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/valida/valida.class Total
 * time: 31 ms Jad reported messages/errors: Exit status: 0 Caught exceptions:
 */