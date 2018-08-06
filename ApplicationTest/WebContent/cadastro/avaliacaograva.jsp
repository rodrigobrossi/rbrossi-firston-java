
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
	//try{
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

	//Pega o tipo de cadastro (inclusão ou alteração) e o codigo do assunto
	String tipo = "", avaliacao = "", cod = "-1";

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("rad") == null)) {
		cod = request.getParameter("rad");
	}
	if (!(request.getParameter("avanome") == null)) {
		avaliacao = request.getParameter("avanome");
	}

	String query = "";
	ResultSet rs = null;

	if (tipo.equals("I")) {
		query = "SELECT AVA_CODIGO FROM AVALIACAO WHERE AVA_DESCRICAO = '"
				+ avaliacao + "'";
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script
	language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL INCLUIR AVALIACAO JA EXISTENTE") + "\"")%>);
      window.open("avaliacoes.jsp","_self");
    </script>
<%
	} else {
			query = "INSERT INTO AVALIACAO (AVA_DESCRICAO) VALUES ('"
					+ avaliacao + "')";
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
      window.open("avaliacoes.jsp","_self");
    </script>
<%
	}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId());
		}
	} else if (tipo.equals("U")) {
		query = "SELECT AVA_CODIGO FROM AVALIACAO WHERE AVA_DESCRICAO = '"
				+ avaliacao + "' AND AVA_CODIGO <> " + cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL INCLUIR AVALIACAO JA EXISTENTE") + "\"")%>);
      window.open("avaliacoes.jsp","_self");
    </script>
<%
	} else {
			query = "UPDATE AVALIACAO SET AVA_DESCRICAO = '"
					+ avaliacao + "' WHERE AVA_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
      window.open("avaliacoes.jsp","_self");
    </script>
<%
	}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId());
		}

	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
	//}catch(Exception e){out.println("Erro: "+e);}
%>
