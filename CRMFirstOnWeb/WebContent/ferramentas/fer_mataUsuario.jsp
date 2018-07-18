<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<jsp:useBean id="acesso" scope="page"
	class="firston.eval.access.FOAccessBean" />
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	String str_op = (((String) request.getParameter("cod") == null) ? ""
			: (String) request.getParameter("cod"));
	Integer codigo = new Integer(Integer.parseInt(str_op));
	//try{
	acesso.mataUsuario(conexao, codigo);
	//}catch(Exception e){}
	response.sendRedirect("fer_administrar_log.jsp");
%>