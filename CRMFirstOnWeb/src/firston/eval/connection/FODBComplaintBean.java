/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.connection;

public class FODBComplaintBean {

	public FODBComplaintBean() {
	}

	public String equivalencia(String str_query, String str_bd) {
		String str_queryAlterada = "";
		String str_banco = str_bd.substring(0, 6).toUpperCase();
		if (str_banco.equals("ORACLE"))
			str_queryAlterada = equivalenciaOracle(str_query);
		else
			str_queryAlterada = equivalenciaSQLServer(str_query);
		return str_queryAlterada;
	}

	public String equivalenciaOracle(String str_query) {
		int int_inicio = 0;
		int int_tamanho = 0;
		String str_data = "";
		str_query = str_query.toUpperCase().trim();
		for (str_query = str_query.replaceAll("OUTER", "(+)="); str_query
				.lastIndexOf("DATEFMT") > 0; str_query = str_query.substring(0,
				int_inicio)
				+ "TO_DATE('"
				+ str_data
				+ "', 'DD/MM/YYYY')"
				+ str_query.substring(int_inicio + 19, int_tamanho)) {
			int_inicio = str_query.lastIndexOf("DATEFMT");
			int_tamanho = str_query.length();
			str_data = str_query.substring(int_inicio + 8, int_inicio + 18);
		}

		return str_query;
	}

	public String equivalenciaSQLServer(String str_query) {
		int int_inicio = 0;
		int int_tamanho = 0;
		String str_data = "";
		str_query = str_query.toUpperCase().trim();
		for (str_query = str_query.replaceAll("OUTER", "*="); str_query
				.lastIndexOf("DATEFMT") > 0; str_query = str_query.substring(0,
				int_inicio)
				+ "CONVERT(DATETIME, '"
				+ str_data
				+ "', 103)"
				+ str_query.substring(int_inicio + 19, int_tamanho)) {
			int_inicio = str_query.lastIndexOf("DATEFMT");
			int_tamanho = str_query.length();
			str_data = str_query.substring(int_inicio + 8, int_inicio + 18);
		}

		return str_query;
	}
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/equivalencia/Equivalencia.class
 * Total time: 16 ms Jad reported messages/errors: Exit status: 0 Caught
 * exceptions:
 */