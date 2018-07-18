
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>

<%
	//try{
%>

<script language="JavaScript">
function fecha()
{
  document.write();
  window.close();
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<body onunload='return fecha();' OnUnload="window.returnValue = 1;">
<center><br>
<br>
<font color="#336699" face="Verdana">Cadastrando...</font></center>

<%
	String login = "", senha = "";

	//*********************Checagem de Login***********************
	if (request.getParameter("login") != null)
		login = (request.getParameter("login")).toUpperCase();
	if (request.getParameter("senha") != null)
		senha = (request.getParameter("senha")).toUpperCase();

	String cadaSenha = " UPDATE FUNCIONARIO SET  FUN_SENHA='" + senha
			+ "'" + " WHERE FUN_LOGIN = '" + login + "'";

	conexao.executaAlteracao(cadaSenha);
	//conexao.finalizaConexao();  

	//out.println("cadasenha = " + cadaSenha);
%>

<script>
window.close();
</script>
</body>
</html>
<%
	//} catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>

