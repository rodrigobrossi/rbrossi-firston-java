<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*"%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>


<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<form name="frm">
<%
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//Declaracao de variaveis
	ResultSet rs = null;
	String query = "";
	int cont_resp = Integer.parseInt(request.getParameter("cont"));
	boolean contem = false;

	//Limpa as senhas 
	for (int k = 0; k < cont_resp; k++) {
		//out.println("Cont" + k);
		if (request.getParameter("chk" + k) != null) {
			query = "UPDATE FUNCIONARIO SET FUN_SENHA = '' "
					+ "WHERE FUN_CODIGO = "
					+ request.getParameter("chk" + k) + " ";
			//out.println(query);
			contem = true;
			conexao.executaAlteracao(query);
		}
	}

	if (!contem) {
%> <script language="JavaScript">
      alert(<%=("\""
										+ trd
												.Traduz("Favor escolher um funcionario!") + "\"")%>);
    </script> <%
 	}
 	if (rs != null) {
 		rs.close();
 	}
 	conexao.finalizaConexao();
 %> <script language="JavaScript">
  window.open("limpa_senha.jsp","_self");
</script>
</html>
