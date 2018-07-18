/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

import java.sql.ResultSet;
import java.sql.SQLException;

import firston.eval.connection.FODBConnectionBean;

public class FOParametersBean {

	public FOParametersBean() {
		erro = "";
		novo = "";
		conn = (new FODBConnectionBean()).getConection();
		session = "";
	}

	public String buscaparam(String nome) throws SQLException,
			ClassNotFoundException, Exception {
		String valor = "";
		String query = "SELECT PAR_CODIGO, PAR_NOME, PAR_VALOR FROM PARAM WHERE PAR_NOME = '"
				+ nome + "' ORDER BY PAR_NOME";
		ResultSet rs = conn.executaConsulta(query, session + "RS1_PARAM");
		if (rs.next())
			valor = rs.getString(3);
		else
			valor = "";
		rs.close();
		conn.finalizaConexao(session + "RS1_PARAM");
		return valor;
	}

	public void setSession(String session) {
		this.session = session;
	}

	private String erro;
	private String novo;
	private FODBConnectionBean conn;
	private String session;
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/param/param.class Total
 * time: 16 ms Jad reported messages/errors: Exit status: 0 Caught exceptions:
 */