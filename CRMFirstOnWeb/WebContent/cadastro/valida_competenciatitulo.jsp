<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String sel_titulo = (String) request.getParameter("sel_titulo");
	String sel_competencia = (String) request
			.getParameter("sel_competencia");
	String obrigatorio = (String) request.getParameter("radiobutton");
	String update = (((String) request.getParameter("update") == null)
			? "N"
			: (String) request.getParameter("update"));
	String cti_codigo = (((String) request.getParameter("cti_codigo") == null)
			? "N"
			: (String) request.getParameter("cti_codigo"));

	String query = new String();
	if (update.equals("N")) {
		query = "Insert into comp_titulo (cmp_codigo,tit_codigo) values ("
				+ sel_competencia + "," + sel_titulo + ")";
		conexao.executaAlteracao(query);
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script
	language="JavaScript">
    alert(<%=("\""
										+ trd
												.Traduz("InclusAo efetuada com sucesso") + "\"")%>);
    window.open("competencia_titulo.jsp?sel_titulo=Todos&sel_competencia=<%=sel_competencia%>","_self");
  </script>
<%
	} else if (update.equals("S")) {
		query = "Update  comp_titulo SET cmp_codigo=" + sel_competencia
				+ " ,tit_codigo =" + sel_titulo + " "
				+ " where  cti_codigo=" + cti_codigo;
		conexao.executaAlteracao(query);
%>
<script language="JavaScript">
    alert(<%=("\""
										+ trd
												.Traduz("AlteraCAo efetuada com sucesso") + "\"")%>);
    window.open("competencia_titulo.jsp?sel_titulo=Todos&sel_competencia=<%=sel_competencia%>","_self");
  </script>
<%
	}

	conexao.finalizaConexao();
%>