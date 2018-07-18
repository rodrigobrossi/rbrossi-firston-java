<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><jsp:useBean
	id="acesso" scope="page" class="firston.eval.access.FOAccessBean" />
<%@page import="java.sql.*"%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	FODBConnectionBean conexaoDeAcesso = (FODBConnectionBean) session
			.getAttribute("Conexao");

	ResultSet rst_tipo = null;
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	String endGetId1 = "" + session.getId();
	String rodape = (((String) request.getParameter("rod") == null)
			? "0"
			: (String) request.getParameter("rod"));
	String str_pontos = "../";

	boolean permissao = acesso.verificaAcesso(conexaoDeAcesso, usu_cod,
			endGetId1, session.getId());

	if (permissao == false) {
		rst_tipo = conexaoDeAcesso.executaConsulta(
				"SELECT use_session from userlogin where fun_codigo="
						+ usu_cod, session.getId() + "ACESSO");

		if (rst_tipo.next()) {
			if (rodape.equals("1")) {
				str_pontos = "";
			}
		}

		if (rst_tipo.getString(1).equals("SESSAOINVALIDA7777")) {
			out.println("desconectado");
%>
<script>                          
	window.open("<%=str_pontos%>sair.jsp?msg='Este usuário foi desconectado!'&op=4","_parent")
</script>
<%
	} else {
%>
window.open("<%=str_pontos%>sair.jsp?msg='Este usuário foi desconectado!'&op=3","_parent")
</script>
<%
	}
	}

	if (rst_tipo != null) {
		rst_tipo.close();
		conexaoDeAcesso.finalizaConexao(session.getId() + "ACESSO");
	}
%>