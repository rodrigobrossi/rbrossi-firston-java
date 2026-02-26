<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%@page import="firston.eval.components.FOLocalizationBean"%><jsp:useBean
	id="imp" scope="page" class="firston.eval.components.FOImportBean" />
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%@page import="java.sql.*,java.io.*,java.util.*"%>

<%
	try {
		String tabela = "";
		boolean c = true;

		if (request.getParameter("checkbox2") != null) {
			tabela = request.getParameter("checkbox2");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox3") != null) {
			tabela = request.getParameter("checkbox3");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox4") != null) {
			tabela = request.getParameter("checkbox4");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox5") != null) {
			tabela = request.getParameter("checkbox5");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox6") != null) {
			tabela = request.getParameter("checkbox6");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox7") != null) {
			tabela = request.getParameter("checkbox7");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox8") != null) {
			tabela = request.getParameter("checkbox8");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox9") != null) {
			tabela = request.getParameter("checkbox9");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox10") != null) {
			tabela = request.getParameter("checkbox10");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox11") != null) {
			tabela = request.getParameter("checkbox11");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox12") != null) {
			tabela = request.getParameter("checkbox12");
			c = imp.restaura(tabela);
		}

		if (request.getParameter("checkbox") != null) {
			tabela = request.getParameter("checkbox");
			c = imp.restaura(tabela);
		}
%>
<script language="JavaScript">
 alert(<%=("\""
										+ trd
												.Traduz("RESTAURACAO EXECUTADA COM SUCESSO") + "\"")%>);
  window.open("importacao.jsp","_self");
</script>
<%
	} catch (Exception e) {
%>
<script language="JavaScript">
   alert(<%=("\""
										+ trd
												.Traduz("OCORRERAM ERROS DURANTE A RESTAURACAO, CONTACTE O SUPORTE") + "\"")%>);
   window.open("importacao.jsp","_self");
  </script>
<%
	}
%>
