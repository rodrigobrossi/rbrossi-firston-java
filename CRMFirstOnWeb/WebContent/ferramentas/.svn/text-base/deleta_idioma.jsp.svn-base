
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

	int cod_idi = Integer
			.parseInt((String) request.getParameter("idi"));
	String query = "delete from comp_titulo where cti_codigo="
			+ cod_idi;
	//try {
	conexao.executaAlteracao(query);
	//}
	//catch(Exception e){
	//  out.println(""+e);
	//} 

	conexao.finalizaConexao();
	response.sendRedirect("idioma.jsp");
%>