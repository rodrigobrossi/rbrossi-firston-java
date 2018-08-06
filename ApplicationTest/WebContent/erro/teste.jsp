<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"
	session="true"%>
<%@page import="java.sql.*"%>

<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>

<%
	ResultSet rs;
	String query = "";

	query = "SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FUN_CODIGO = ";
	rs = conexao.executaConsulta(query);
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>JSP Page</title>
</head>
<body>

<%-- <jsp:useBean id="beanInstanceName" scope="session" class="package.class" /> --%>
<%-- <jsp:getProperty name="beanInstanceName"  property="propertyName" /> --%>

<%
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();
%>
teste
</body>
</html>
