
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
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	String usu_nome = (String) session.getAttribute("fun_nome");
	String usu_login = (String) session.getAttribute("fun_login");
	Integer usu_idi = (Integer) session.getAttribute("fun_idi");
	String idi_codigo = (String) request.getParameter("idi");
	String desc = (String) request.getParameter("desc" + idi_codigo);
%>


<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AlteraCAo de Idioma")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function checa(){
  if(idi.idioma.value==" "){
    alert("Digite um idioma");
    idi.idioma.focus();
    return false;
    }
  else {
    idi.submit();
    return true;
    }

  }
function exclui(){
  frm.submit();
  return false;
  } 
</script>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String ponto = (String) session.getAttribute("barra");
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="FE" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="FE" /></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="../art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="C" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="op" name="C" /></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			bgcolor="c0c0c0" height="8">
			<tr>
				<%
					if (ponto.equals("..")) {
				%>
				<jsp:include page="../menu/menu_cadastro.jsp" flush="true">
				
				<jsp:param	value="op" name="I" />
				</jsp:include>
					} else {
				%>
				<jsp:include page="/menu/menu_cadastro.jsp" flush="true">
				<jsp:param	value="op" name="I" />
				</jsp:include>
				<%
					}
				%>
			</tr>
		</table>


		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%">

				<center>
				<table border="0" cellspacing="1" cellpadding="2" width="80%">
					<tr>
						<td align="center" colspan="5" width="60%">&nbsp;</td>
					</tr>
					<tr>
						<td>
						<div align="center" class="ftverdanacinza"><b><%=trd.Traduz("Cadastro de Idioma")%></b></div>
						</td>
					</tr>
				</table>
				</center>

				</td>
				<td width="20">&nbsp;</td>
			</tr>
			<tr>
				<td width="20" valign="top"></td>
				<FORM action="valida_idioma.jsp" name="frm" method="POST">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="90%">
					<tr class="celnortab">
						<td colspan="3" height="150" align="center">
						<p><%=trd.Traduz("IDIOMA")%>: <br>
						<br>
						<input type="hidden" name="idi_codigo" value="<%=idi_codigo%>">
						<input type="text" name="idioma" value="<%=desc%>">
						<p><input type="hidden" name="update" value="S">
						</td>
					</tr>
					<tr>
						<td align="center" colspan="3">&nbsp;<br>
						<input type="submit" class="botcin"
							value=<%=("\"" + trd.Traduz("Confirmar") + "\"")%>
							onClick="return checa();">&nbsp;<input type="button"
							class="botcin" value=<%=("\"" + trd.Traduz("Cancelar") + "\"")%>
							onClick="JavaScript:history.go(-1);"></td>
					</tr>
				</table>
				<p>&nbsp;
				</center>
				</td>
				</FORM>
				<td width="20" valign="top"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp"
					flush="true"></jsp:include> <%
 	} else {
 %> <jsp:include
					page="/rodape/rodape.jsp" flush="true"></jsp:include> <%
 	}
 %>
				</td>
			</tr>
		</table>
</body>
</html>
