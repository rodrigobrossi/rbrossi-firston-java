/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import firston.eval.connection.FODBConnectionBean;

public class FOLocalizationBean {

	public FOLocalizationBean(FODBConnectionBean conn) {
		erro = "";
		novo = "";
		this.conn = null;
		vetorNovo = new Vector(60, 10);
		session = "";
		achou = false;
		this.conn = conn;
	}

	public String Traduz(String parametro) {
		parametro = parametro.trim();
		parametro = parametro.toUpperCase();
		for (; contador < vetorTraducao.size(); contador++) {
			vetorOpcoes = (Vector) vetorTraducao.elementAt(contador);
			if (vetorOpcoes.elementAt(0).equals(parametro)) {
				parametro = (String) vetorOpcoes.elementAt(1);
				achou = true;
				break;
			}
			achou = false;
		}

		erro = erro + "quase achou:" + achou;
		if (!achou) {
			erro = "entrou";
			novo = insereTermo(parametro);
			vetorNovo.addElement(new String(novo));
			vetorNovo.addElement(new String(novo));
			vetorTraducao.addElement(new Vector(vetorNovo));
			vetorNovo.clear();
			parametro = novo + "[i]";
		}
		contador = 0;
		return parametro;
	}

	public String insereTermo(String parametro2) {
		parametro2 = parametro2.trim().toUpperCase();
		erro = erro + "passou1";
		try {
			erro = erro + "passou2";
			ResultSet rsTermo = conn.executaConsulta(
					"SELECT TRM_CODIGO FROM LNG_TERMO WHERE TRM_NOME = '"
							+ parametro2.toUpperCase() + "'", session + "RS1");
			if (!rsTermo.next())
				conn
						.executaAlteracao("INSERT INTO LNG_TERMO (TRM_NOME) VALUES('"
								+ parametro2.toUpperCase() + "')");
			ResultSet rs = conn.executaConsulta(
					"SELECT TRM_CODIGO FROM LNG_TERMO WHERE TRM_NOME = '"
							+ parametro2.toUpperCase() + "'", session + "RS2");
			if (rs.next())
				conn
						.executaAlteracao("INSERT INTO LNG_TRADUCAO (IDI_CODIGO,TRM_CODIGO,TRD_TRADUCAO) VALUES("
								+ idioma
								+ ","
								+ rs.getInt(1)
								+ ",'"
								+ parametro2.toUpperCase() + "')");
			rs.close();
			rsTermo.close();
			conn.finalizaConexao(session + "RS1");
			conn.finalizaConexao(session + "RS2");
		} catch (SQLException se) {
			erro = erro + "\n erro2:" + se;
		} catch (Exception e) {
			erro = erro + "\n erro3:" + e;
		}
		erro = erro + "passou3";
		return parametro2;
	}

	public Vector retornaVetor() {
		return vetorTraducao;
	}

	public void carregaBean(Vector vetorTraducao) {
		this.vetorTraducao = vetorTraducao;
	}

	public void setIdioma(int idioma) {
		idioma = idioma;
	}

	public String pegaErro() {
		return erro;
	}

	public void setSession(String session) {
		this.session = session;
	}

	public void limpaVetor() {
		vetorTraducao.clear();
	}

	public Vector montaVetor(int idioma) {
		idioma = idioma;
		Vector v1 = new Vector();
		Vector v2 = new Vector(60, 10);
		try {
			erro = erro + "passou4";
			ResultSet rs1;
			for (rs1 = conn
					.executaConsulta(
							"SELECT L.TRM_NOME,T.TRD_TRADUCAO from LNG_TRADUCAO T, LNG_TERMO L WHERE T.IDI_CODIGO="
									+ idioma + " AND T.TRM_CODIGO=L.TRM_CODIGO",
							session + "RS3"); rs1.next(); v2.clear()) {
				v2.addElement(rs1.getString(1).toUpperCase().trim());
				v2.addElement(rs1.getString(2).toUpperCase().trim());
				v1.addElement(new Vector(v2));
			}

			rs1.close();
			conn.finalizaConexao(session + "RS3");
		} catch (SQLException se) {
			erro = erro + "\n erro5:" + se;
		} catch (Exception e) {
			erro = erro + "\n erro6:" + e;
		}
		carregaBean(v1);
		return v1;
	}

	private static int contador = 0;
	private static int idioma = 1;
	private String erro;
	private String novo;
	private FODBConnectionBean conn;
	private Vector vetorTraducao;
	private Vector vetorOpcoes;
	private Vector vetorNovo;
	private String session;
	private boolean achou;

}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/Traducao/Traducao.class
 * Total time: 15 ms Jad reported messages/errors: Exit status: 0 Caught
 * exceptions:
 */