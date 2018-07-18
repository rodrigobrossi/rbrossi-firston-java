
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	request.getSession();
	FODBConnectionBean conn = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	String cod = (String) request.getParameter("cod");
	String traduz = (String) request.getParameter("traduz");
	out.println("" + cod + " " + traduz);
	String query = "";
	query = "update  lng_traducao SET trd_traducao='" + traduz + "' "
			+ " where  trd_codigo=" + cod;
	conn.executaAlteracao(query);
	conn.finalizaConexao();
	response.sendRedirect("traducao.jsp");
%>