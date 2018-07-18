
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%!public String trataAspas(String conteudo) {

		char troca[] = conteudo.toCharArray();
		int contador = 0;
		while (contador < conteudo.length()) {
			String alfa = "" + troca[contador];
			if (alfa.equals("'")) {
				troca[contador] = '\"';
			} else if (alfa.equals("/")) {
				troca[contador] = '/';
			}
			contador = contador + 1;
		}

		String retorna = "";
		return retorna.copyValueOf(troca);
	}%>


<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String login = ((String) session.getAttribute("usu_login"))
			.toUpperCase();

	String atual = (request.getParameter("atual")).toUpperCase();
	String senha = (request.getParameter("nova")).toUpperCase();
%>



<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body onunload='return fecha();' OnUnload="window.returnValue = 1;">

<%
	//*********************Checagem de Login***********************

	String query = "", cadaSenha = "";
	ResultSet rs = null;

	query = "SELECT FUN_CODIGO " + "FROM FUNCIONARIO "
			+ "WHERE FUN_LOGIN = '" + trataAspas(login) + "' "
			+ "AND FUN_SENHA = '" + trataAspas(atual) + "'";

	rs = conexao.executaConsulta(query, session.getId() + "RS1");

	if (rs.next()) {
		cadaSenha = " UPDATE FUNCIONARIO SET  FUN_SENHA='"
				+ trataAspas(senha) + "'" + " WHERE FUN_LOGIN = '"
				+ trataAspas(login) + "'";
		conexao.executaAlteracao(cadaSenha);
%>
<script language="JavaScript">
  alert(<%=("\""
										+ trd
												.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
  window.open("trocasenha.jsp","_self");
  </script>
<%
	} else {
%>
<script language="JavaScript">
  alert(<%=("\"" + trd.Traduz("SENHA ATUAL INVALIDA") + "\"")%>);
  window.open("trocasenha.jsp","_self");
  </script>
<%
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}
%>

</body>
</html>

