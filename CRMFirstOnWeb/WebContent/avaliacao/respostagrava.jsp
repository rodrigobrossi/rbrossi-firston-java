<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do assunto
	String tipo = "", cod = "-1", resnome = "";

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}
	if (!(request.getParameter("res_nome") == null)) {
		resnome = request.getParameter("res_nome");
	}

	String query = "";
	ResultSet rs = null;

	if (tipo.equals("I")) {
		query = "SELECT RES_CODIGO FROM RESPOSTA WHERE RES_NOME = '"
				+ resnome + "'";
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>



<script language="JavaScript">
      alert("IMPOSSIVEL INCLUIR RESPOSTA JA EXISTENTE");
      window.open("resposta.jsp","_self");
    </script>
<%
	} else {
			query = "INSERT INTO RESPOSTA (RES_NOME) VALUES ('"
					+ resnome + "')";
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert("INCLUSAO EFETUADA COM SUCESSO");
      window.open("resposta.jsp","_self");
    </script>
<%
	}

	} else if (tipo.equals("U")) {
		query = "SELECT RES_CODIGO FROM RESPOSTA WHERE RES_NOME = '"
				+ resnome + "' AND RES_CODIGO <> " + cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
      alert("IMPOSSIVEL INCLUIR RESPOSTA JA EXISTENTE");
      window.open("resposta.jsp","_self");
    </script>
<%
	} else {
			query = "UPDATE RESPOSTA SET RES_NOME = '" + resnome
					+ "' WHERE RES_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert("ALTERACAO EFETUADA COM SUCESSO");
      window.open("resposta.jsp","_self");
    </script>
<%
	}
	}

	else if (tipo.equals("E")) {
		//testa se a resposta faz parte de um grupo de respostas
		query = "SELECT RES_CODIGO FROM RESPGRUPO WHERE RES_CODIGO = "
				+ cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
    alert(<%=("\""
											+ trd
													.Traduz("ESSA RESPOSTA NAO PODE SER EXCLUIDA POR FAZER PARTE DE UM GRUPO DE RESPOSTAS!") + "\"")%>);
    window.open("resposta.jsp","_self");
  </script>
<%
	} else {

			query = "DELETE FROM RESPOSTA WHERE RES_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
    alert("EXCLUSAO EFETUADA COM SUCESSO");
    window.open("resposta.jsp","_self");
  </script>
<%
	}
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
%>
