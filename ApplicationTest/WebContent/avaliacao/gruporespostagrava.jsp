<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>



<html>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//Declaracao de variaveis
	ResultSet rs = null;
	String query = "", titulo = "", peso = " ";
	int cod_grupo = 0;

	String tipo = "", cod = "";
	if (request.getParameter("tipo") != null)
		tipo = request.getParameter("tipo");
	if (request.getParameter("cod") != null)
		cod = request.getParameter("cod");

	if (tipo.equals("I")) {

		//Verifica o numero de perguntas
		query = "SELECT COUNT(*) FROM RESPOSTA";
		rs = conexao.executaConsulta(query, session.getId() + "RS_1");
		int cont_resp = 0, valida = 0;
		if (rs.next())
			cont_resp = rs.getInt(1);
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_1");
		}

		//Verifica o proximo codigo do grupo
		query = "SELECT MAX(QGR_GRUPO) FROM RESPGRUPO";
		rs = conexao.executaConsulta(query, session.getId() + "RS_2");
		if (rs.next())
			cod_grupo = rs.getInt(1);
		else
			cod_grupo = 0;
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_2");
		}

		//Insere os valores do novo grupo
		for (int k = 0; k < cont_resp; k++) {
			if (request.getParameter("chkper" + k) != null) {
				peso = request.getParameter("txt_valor" + (k));
				if (peso.equals(""))
					peso = "0";

				query = "INSERT INTO RESPGRUPO (RES_CODIGO, QGR_VALOR, QGR_GRUPO) "
						+ "VALUES ("
						+ request.getParameter("chkper" + k)
						+ ", "
						+ peso + ", " + (cod_grupo + 1) + ")";
				conexao.executaAlteracao(query);
				valida++;
			}
		}
		if (valida > 0) {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
    </script>
<%
	}
	} else if (tipo.equals("U")) {
		query = "DELETE FROM RESPGRUPO WHERE QGR_GRUPO = " + cod;
		conexao.executaAlteracao(query);

		int cont_resp = 0, valida = 0;
		String con = "";

		if (request.getParameter("contador") != null) {
			con = request.getParameter("contador");
			cont_resp = Integer.parseInt(con);
		}

		for (int k = 0; k < cont_resp; k++) {
			if (request.getParameter("chkper" + k) != null) {
				peso = request.getParameter("txt_valor" + (k));

				query = "INSERT INTO RESPGRUPO (RES_CODIGO, QGR_VALOR, QGR_GRUPO) "
						+ "VALUES ("
						+ request.getParameter("chkper" + k)
						+ ", "
						+ peso + ", " + cod + ")";
				conexao.executaAlteracao(query);

				query = "SELECT RES_CODIGO FROM QUEST_RESP WHERE QGR_GRUPO = "
						+ cod;
				rs = conexao.executaConsulta(query, session.getId()
						+ "RS_3");
				if (rs.next()) {
					do {
						query = "UPDATE QUEST_RESP SET QGR_VALOR = "
								+ peso + " " + "WHERE QGR_GRUPO ="
								+ cod + " " + "AND RES_CODIGO = "
								+ request.getParameter("chkper" + k);
						conexao.executaAlteracao(query);
					} while (rs.next());
				}
				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS_3");
				}
				valida++;
			}
		}

		if (valida > 0) {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
    </script>
<%
	}
	}

	else if (tipo.equals("E")) {
		//testa se o grupo de resposta faz parte de um questionario
		query = "SELECT QGR_GRUPO FROM QUEST_RESP WHERE QGR_GRUPO = "
				+ cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("ESTE GRUPO DE RESPOSTAS NAO PODE SER EXCLUIDO POR FAZER PARTE DE UM QUESTIONARIO!") + "\"")%>);
    </script>
<%
	} else {
			query = "DELETE FROM RESPGRUPO WHERE QGR_GRUPO = " + cod;
			conexao.executaAlteracao(query);
			query = "DELETE FROM QUEST_RESP WHERE QGR_GRUPO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("EXCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
    </script>
<%
	}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId());
		}
	}
%>

<script language="JavaScript">
  window.open("gruporesposta.jsp","_self");
</script>
</html>