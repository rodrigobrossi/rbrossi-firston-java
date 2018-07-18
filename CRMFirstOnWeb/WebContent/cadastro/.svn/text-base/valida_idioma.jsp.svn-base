
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	String descidi = (String) request.getParameter("idioma");
	String idi_codigo = (String) request.getParameter("idi_codigo");
	String update = (((String) request.getParameter("update") == null) ? "N"
			: (String) request.getParameter("update"));

	String query = new String();

	if (update.equals("N")) {
		query = "Insert into lng_idioma (idi_nome) values ('" + descidi
				+ "')";
	} else if (update.equals("S")) {
		query = "Update  lng_idioma SET idi_nome='" + descidi + "' "
				+ " where  idi_codigo=" + idi_codigo;
	}
	//try{
	conexao.executaAlteracao(query);
	//}catch(Exception e){out.println("Erro SQL"+e);} 

	response.sendRedirect("idioma.jsp");
%>