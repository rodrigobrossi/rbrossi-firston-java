<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<jsp:useBean id="imp" scope="page"
	class="firston.eval.components.FOImportBean" />
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%@page import="java.sql.*,java.io.*,java.util.*"%>


<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("PROCESSOS")%> - <%=trd.Traduz("PARAMETROS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<center>
<tr>
	<td width="6%" height="23">&nbsp;</td>
	<td width="33%" class="ftverdanacinza"><%=trd.Traduz("AGUARDE O FIM DA IMPORTACAO..")%></td>
	<td width="49%" height="21"></td>
	<td width="12%" height="23">&nbsp;</td>
</tr>
</center>

<%
	boolean c = true, c1 = true, c2 = true, c3 = true, c4 = true, c5 = true, c6 = true, c7 = true, c8 = true, c9 = true, c10 = true, c11 = true;
	String tabela = "", arquivo = "";
	/*try
	 {*/

	if (request.getParameter("checkbox2") != null) {
		tabela = request.getParameter("checkbox2");
		if (request.getParameter("tf_txt2") != null) {

			arquivo = request.getParameter("tf_txt2");
			c = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox3") != null) {
		tabela = request.getParameter("checkbox3");
		if (request.getParameter("tf_txt3") != null) {
			arquivo = request.getParameter("tf_txt3");
			c1 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox4") != null) {
		tabela = request.getParameter("checkbox4");
		if (request.getParameter("tf_txt4") != null) {
			arquivo = request.getParameter("tf_txt4");
			c2 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox5") != null) {
		tabela = request.getParameter("checkbox5");
		if (request.getParameter("tf_txt5") != null) {
			arquivo = request.getParameter("tf_txt5");
			c3 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox6") != null) {
		tabela = request.getParameter("checkbox6");
		if (request.getParameter("tf_txt6") != null) {
			arquivo = request.getParameter("tf_txt6");
			c4 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox7") != null) {
		tabela = request.getParameter("checkbox7");
		if (request.getParameter("tf_txt7") != null) {
			arquivo = request.getParameter("tf_txt7");
			c5 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox8") != null) {
		tabela = request.getParameter("checkbox8");
		if (request.getParameter("tf_txt8") != null) {
			arquivo = request.getParameter("tf_txt8");
			c6 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox9") != null) {
		tabela = request.getParameter("checkbox9");
		if (request.getParameter("tf_txt9") != null) {
			arquivo = request.getParameter("tf_txt9");
			c7 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox10") != null) {
		tabela = request.getParameter("checkbox10");
		if (request.getParameter("tf_txt10") != null) {
			arquivo = request.getParameter("tf_txt10");
			c8 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox11") != null) {
		tabela = request.getParameter("checkbox11");
		if (request.getParameter("tf_txt11") != null) {
			arquivo = request.getParameter("tf_txt11");
			c9 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox12") != null) {
		tabela = request.getParameter("checkbox12");
		if (request.getParameter("tf_txt12") != null) {
			arquivo = request.getParameter("tf_txt12");
			c10 = imp.importa(tabela, arquivo);
		}
	}

	if (request.getParameter("checkbox") != null) {
		tabela = request.getParameter("checkbox");
		if (request.getParameter("tf_txt") != null) {
			arquivo = request.getParameter("tf_txt");
			c11 = imp.importa(tabela, arquivo);
		}
	}

	if ((c == false) || (c1 == false) || (c2 == false) || (c3 == false)
			|| (c4 == false) || (c5 == false) || (c6 == false)
			|| (c7 == false) || (c8 == false) || (c9 == false)
			|| (c10 == false) || (c11 == false)) {
%>
<script language="JavaScript">
    // alert("Ocorreram erros durante a ImportaCAo, restaure o Backup e contacte o suporte !");
    // window.open("importacao.jsp","_self");
</script>
<%
	}
%>
<script language="JavaScript">
    // alert("ImportaCAo executada com sucesso !");
    //  window.open("importacao.jsp","_self");
</script>
<%
	/*}
	 catch(Exception e)
	 {*/
%>

<%
	//}
%>