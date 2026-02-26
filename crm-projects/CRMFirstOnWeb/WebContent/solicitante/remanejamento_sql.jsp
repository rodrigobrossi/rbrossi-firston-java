
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
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String aplicacao = (String) session.getAttribute("aplicacao");

	//declaracao de variaveis
	String query = "", solic_destino = "", fun_codigo = "", count_aux = "";
	Integer count = new Integer(Integer.parseInt(request
			.getParameter("cont")));;

	//busca solicitante destino
	if (request.getParameter("cbo_sol") != null)
		solic_destino = request.getParameter("cbo_sol");

	//Atualizacao
	for (int i = 0; i <= count.intValue(); i++) {
		if (request.getParameter("sub_" + i) != null) {
			fun_codigo = request.getParameter("sub_" + i);
			query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = "
					+ solic_destino + " WHERE FUN_CODIGO = "
					+ fun_codigo + " ";
			conexao.executaAlteracao(query);
		}
	}
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script
	language="JavaScript">
  alert(<%=("\""
									+ trd
											.Traduz("Remanejamento efetuado com exito!") + "\"")%>);
  window.open("solicitantes.jsp", "_parent");
</script>
