/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

public class FODynamicComboBean {

	public FODynamicComboBean() {
	}

	public String montaCombo(String combo, String filial, String solic,
			String aplicacao) {
		String order = "";
		String query = "";
		String solicitante = "";
		String combo_solicitante = "";
		combo = combo.toUpperCase();
		if (combo.equals("FUNCIONARIO")) {
			query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_DEMITIDO = 'N'";
			order = " ORDER BY FUN_NOME";
		}
		if (combo.equals("CARGO")) {
			query = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO";
			order = " ORDER BY CAR_NOME";
		}
		if (combo.equals("DEPARTAMENTO")) {
			query = "SELECT DEP_CODIGO, DEP_NOME FROM DEPTO";
			order = " ORDER BY DEP_NOME";
		}
		if (combo.equals("FILIAL")) {
			query = "SELECT FIL_CODIGO, FIL_NOME FROM FILIAL";
			order = " ORDER BY FIL_NOME";
		}
		if (combo.equals("TABELA1")) {
			query = "SELECT TB1_CODIGO, TB1_NOME FROM TABELA1";
			order = " ORDER BY TB1_NOME";
		}
		if (combo.equals("TABELA2")) {
			query = "SELECT TB2_CODIGO, TB2_NOME FROM TABELA2";
			order = " ORDER BY TB2_NOME";
		}
		if (combo.equals("TABELA3")) {
			query = "SELECT TB3_CODIGO, TB3_DESCRICAO FROM TABELA3";
			order = " ORDER BY TB3_DESCRICAO";
		}
		if (combo.equals("TABELA4")) {
			query = "SELECT TB4_CODIGO, TB4_DESCRICAO FROM TABELA4";
			order = " ORDER BY TB4_DESCRICAO";
		}
		if (combo.equals("TABELA5")) {
			query = "SELECT TB5_CODIGO, TB5_DESCRICAO FROM TABELA5";
			order = " ORDER BY TB5_DESCRICAO";
		}
		if (combo.equals("TABELA6")) {
			query = "SELECT TB6_CODIGO, TB6_DESCRICAO FROM TABELA6";
			order = " ORDER BY TB6_DESCRICAO";
		}
		if (combo.equals("TABELA7")) {
			query = "SELECT TB7_CODIGO, TB7_DESCRICAO FROM TABELA7";
			order = " ORDER BY TB7_DESCRICAO";
		}
		if (combo.equals("TABELA8")) {
			query = "SELECT TB8_CODIGO, TB8_DESCRICAO FROM TABELA8";
			order = " ORDER BY TB8_DESCRICAO";
		}
		if (combo.equals("SOLICITANTE")) {
			query = "SELECT FS.FUN_CODIGO, F.FUN_NOME, F.FUN_CODSOLIC FROM FUNC_USUARIO FS, TIPOUSUARIO T, FUNCIONARIO F, APLICACAO A WHERE FS.TIP_TIPO = T.TIP_TIPO AND T.APL_CODIGO = A.APL_CODIGO AND A.APL_SIGLA =  '"
					+ aplicacao
					+ "' "
					+ "AND FS.FUN_CODIGO = F.FUN_CODIGO "
					+ "AND F.FUN_DEMITIDO = 'N'";
			order = " ORDER BY F.FUN_NOME";
		}
		if (!filial.equals("null")) {
			if (!solic.equals("null")) {
				solicitante = " AND FUN_CODSOLIC = '" + solic + "'";
				combo_solicitante = " AND (F.FUN_CODIGO = " + solic
						+ " OR  FUN_CODSOLIC = " + solic + ")";
			}
			if (combo.equals("FUNCIONARIO"))
				query = query
						+ " AND FUN_CODIGO IN "
						+ "(SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("CARGO"))
				query = query
						+ " WHERE CAR_CODIGO IN "
						+ "(SELECT CAR_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("DEPARTAMENTO"))
				query = query
						+ " WHERE DEP_CODIGO IN "
						+ "(SELECT DEP_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("FILIAL"))
				query = query
						+ " WHERE FIL_CODIGO IN "
						+ "(SELECT FIL_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("TABELA1"))
				query = query
						+ " WHERE TB1_CODIGO IN "
						+ "(SELECT TB1_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("TABELA2"))
				query = query
						+ " WHERE TB2_CODIGO IN "
						+ "(SELECT TB2_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("TABELA3"))
				query = query
						+ " WHERE TB3_CODIGO IN "
						+ "(SELECT TB3_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("TABELA4"))
				query = query
						+ " WHERE TB4_CODIGO IN "
						+ "(SELECT TB4_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("TABELA5"))
				query = query
						+ " WHERE TB5_CODIGO IN "
						+ "(SELECT TB5_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = '"
						+ filial + "' " + solicitante + ")";
			if (combo.equals("TABELA6"))
				query = query
						+ " WHERE TB6_CODIGO IN "
						+ "(SELECT TB6_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = "
						+ filial + " " + solicitante + ")";
			if (combo.equals("TABELA7"))
				query = query
						+ " WHERE TB7_CODIGO IN "
						+ "(SELECT TB7_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = "
						+ filial + " " + solicitante + ")";
			if (combo.equals("TABELA8"))
				query = query
						+ " WHERE TB8_CODIGO IN "
						+ "(SELECT TB8_CODIGO FROM FUNCIONARIO WHERE FIL_CODIGO = "
						+ filial + " " + solicitante + ")";
			if (combo.equals("SOLICITANTE"))
				query = "SELECT FS.FUN_CODIGO, F.FUN_NOME, F.FUN_CODSOLIC FROM FUNC_USUARIO FS, TIPOUSUARIO T, FUNCIONARIO F, APLICACAO A WHERE FS.TIP_TIPO = T.TIP_TIPO AND (T.TIP_TIPO = 'S' OR T.TIP_TIPO = 'P') AND T.APL_CODIGO = A.APL_CODIGO AND A.APL_SIGLA =  '"
						+ aplicacao
						+ "' "
						+ "AND FS.FUN_CODIGO = F.FUN_CODIGO "
						+ "AND F.FUN_DEMITIDO = 'N'" + combo_solicitante;
		}
		query = query + order;
		return query;
	}
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/combo/Combo.class Total
 * time: 94 ms Jad reported messages/errors: Exit status: 0 Caught exceptions:
 */