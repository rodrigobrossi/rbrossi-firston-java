/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

import java.util.Vector;

public class FOUserPositionBean {

	public FOUserPositionBean() {
	}

	public Vector montaCombo(String combo, String filial, String solic,
			String aplicacao, String unidade, String diretoria, String celula,
			String time) {
		String order = "";
		String query = "";
		String solicitante = "";
		String query_uni = "";
		String query_dir = "";
		String query_cel = "";
		String query_tim = "";
		Vector querys = new Vector();
		combo = combo.toUpperCase();
		if (combo.equals("CARGO")) {
			query = "SELECT DISTINCT C.CAR_CODIGO, C.CAR_NOME FROM CARGO C, LOTACAO L WHERE C.TB5_CODIGO = L.TB5_CODIGO AND L.TB5_CODIGO = "
					+ unidade + " ";
			order = " ORDER BY CAR_NOME";
			if (!solic.equals("null"))
				solicitante = " AND FUN_CODSOLIC = '" + solic + "'";
			if (!filial.equals("null"))
				query_uni = "SELECT DISTINCT TB5_CODIGO, TB5_DESCRICAO FROM TABELA5 WHERE TB5_CODIGO = "
						+ unidade + " " + "ORDER BY TB5_DESCRICAO";
			else
				query_uni = "SELECT DISTINCT TB5_CODIGO, TB5_DESCRICAO FROM TABELA5 ORDER BY TB5_DESCRICAO";
			if (!diretoria.equals("") && !diretoria.equals("-1")) {
				query = query + " AND C.TB6_CODIGO = L.TB6_CODIGO "
						+ "AND L.TB6_CODIGO = " + diretoria + "";
				query_dir = "SELECT DISTINCT T6.TB6_CODIGO, T6.TB6_DESCRICAO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade
						+ " "
						+ "AND L.TB6_CODIGO = "
						+ diretoria
						+ " " + "ORDER BY T6.TB6_DESCRICAO";
				query_cel = "SELECT DISTINCT T7.TB7_CODIGO, T7.TB7_DESCRICAO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade
						+ " "
						+ "AND L.TB6_CODIGO = "
						+ diretoria
						+ ") " + "ORDER BY T7.TB7_DESCRICAO";
				query_tim = "SELECT DISTINCT T8.TB8_CODIGO, T8.TB8_DESCRICAO FROM TABELA8 T8, LOTACAO L WHERE T8.TB8_CODIGO = L.TB8_CODIGO AND L.TB8_CODIGO IN (SELECT T7.TB7_CODIGO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade
						+ ") "
						+ "AND L.TB6_CODIGO = "
						+ diretoria
						+ ") " + "ORDER BY T8.TB8_DESCRICAO";
			} else {
				query_dir = "SELECT DISTINCT T6.TB6_CODIGO, T6.TB6_DESCRICAO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade + " " + "ORDER BY T6.TB6_DESCRICAO";
				query_cel = "SELECT DISTINCT T7.TB7_CODIGO, T7.TB7_DESCRICAO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade + ") " + "ORDER BY T7.TB7_DESCRICAO";
				query_tim = "SELECT DISTINCT T8.TB8_CODIGO, T8.TB8_DESCRICAO FROM TABELA8 T8, LOTACAO L WHERE T8.TB8_CODIGO = L.TB8_CODIGO AND L.TB8_CODIGO IN (SELECT T7.TB7_CODIGO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade + ")) " + "ORDER BY T8.TB8_DESCRICAO";
			}
			if (!celula.equals("") && !celula.equals("-1")) {
				query = query + " AND C.TB7_CODIGO = L.TB7_CODIGO "
						+ "AND L.TB7_CODIGO = " + celula + "";
				query_cel = "SELECT DISTINCT T7.TB7_CODIGO, T7.TB7_DESCRICAO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade
						+ ") "
						+ "AND L.TB7_CODIGO = "
						+ celula
						+ " "
						+ "ORDER BY T7.TB7_DESCRICAO";
				query_tim = "SELECT DISTINCT T8.TB8_CODIGO, T8.TB8_DESCRICAO FROM TABELA8 T8, LOTACAO L WHERE T8.TB8_CODIGO = L.TB8_CODIGO AND L.TB7_CODIGO IN (SELECT T7.TB7_CODIGO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB5_CODIGO = "
						+ unidade
						+ ") "
						+ "AND L.TB7_CODIGO = "
						+ celula
						+ ") " + "ORDER BY T8.TB8_DESCRICAO";
			}
			if (!time.equals("") && !time.equals("-1")) {
				query = query + " AND C.TB8_CODIGO = L.TB8_CODIGO "
						+ "AND L.TB8_CODIGO = " + time + " ";
				query_tim = "SELECT DISTINCT T8.TB8_CODIGO, T8.TB8_DESCRICAO FROM TABELA8 T8, LOTACAO L WHERE T8.TB8_CODIGO = L.TB8_CODIGO AND L.TB7_CODIGO IN (SELECT T7.TB7_CODIGO FROM TABELA7 T7, LOTACAO L WHERE T7.TB7_CODIGO = L.TB7_CODIGO AND L.TB6_CODIGO IN (SELECT T6.TB6_CODIGO FROM TABELA6 T6, LOTACAO L WHERE T6.TB6_CODIGO = L.TB6_CODIGO AND L.TB6_CODIGO = "
						+ unidade
						+ ")) "
						+ "AND T8.TB8_CODIGO = "
						+ time
						+ " "
						+ "ORDER BY T8.TB8_DESCRICAO";
			}
		}
		query = query + order;
		querys.addElement(query);
		querys.addElement(query_uni);
		querys.addElement(query_dir);
		querys.addElement(query_cel);
		querys.addElement(query_tim);
		return querys;
	}
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/posicao/Posicao.class
 * Total time: 15 ms Jad reported messages/errors: Exit status: 0 Caught
 * exceptions:
 */