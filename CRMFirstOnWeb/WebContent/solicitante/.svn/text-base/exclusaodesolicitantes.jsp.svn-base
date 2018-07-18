
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String query = "", cod_solic = "", tipo_usu = "";
	String solic = (String) request.getParameter("solic");
	String type = (String) request.getParameter("tipo");
	if (solic != null)
		cod_solic = solic;
	if (type != null)
		tipo_usu = type;

	//Exclui vinculo de subordinado
	query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = NULL WHERE FUN_CODSOLIC = "
			+ cod_solic + " ";
	conexao.executaAlteracao(query);

	//Atualiza o tipo do usuario
	query = "UPDATE FUNCIONARIO SET FUN_TIPOUSUARIO = NULL, FUN_LOGIN = NULL, "
			+ "FUN_SENHA = NULL "
			+ "WHERE FUN_CODIGO = "
			+ cod_solic
			+ " ";
	conexao.executaAlteracao(query);
	//Exclui o funcionario da lista de usuarios
	query = "DELETE FROM FUNC_USUARIO " + "WHERE FUN_CODIGO = "
			+ cod_solic + " AND TIP_TIPO = '" + tipo_usu.trim() + "' ";
	conexao.executaAlteracao(query);
	//Exclui o funcionario da FocoFilial
	query = "DELETE FROM FOCOFILIAL " + "WHERE FUN_CODIGO = "
			+ cod_solic + " ";
	conexao.executaAlteracao(query);

	conexao.finalizaConexao();
%>


<%@page import="firston.eval.connection.FODBConnectionBean"%><script
	language="JavaScript">
    window.open("solicitantes.jsp", "_parent");
</script>
