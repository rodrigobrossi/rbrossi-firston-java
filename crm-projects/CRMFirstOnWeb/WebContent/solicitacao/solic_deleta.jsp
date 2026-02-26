
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	//Limpa cache
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
	//Recupera parametros
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String query = "";

	String codigo = "";
	if (request.getParameter("tef_codigo") != null)
		codigo = request.getParameter("tef_codigo");

	String fun_codigo = "";
	if (request.getParameter("fun_codigo") != null)
		fun_codigo = request.getParameter("fun_codigo");

	String origem = "";
	if (request.getParameter("origem") != null)
		origem = request.getParameter("origem");

	if (origem.equals("prerequisitos")) {
		for (int k = 0; k <= 50; k++) {
			//out.println("check"+k);
			if (request.getParameter("checkbox" + k) != null) {
				codigo = request.getParameter("checkbox" + k);
			}
		}
	}

	if (origem.equals("result_solics")) {
		for (int k = 0; k <= 50; k++) {
			if (request.getParameter("checkbox" + k) != null) {
				codigo = request.getParameter("checkbox" + k);
			}
		}
	}

	query = "DELETE FROM TREINCOMP WHERE TEF_CODIGO = " + codigo;
	conexao.executaAlteracao(query);

	query = "DELETE FROM TREINAMENTO WHERE TEF_CODIGO = " + codigo;
	conexao.executaAlteracao(query);

	response.sendRedirect(origem + ".jsp?fun_codigo=" + fun_codigo);
%>