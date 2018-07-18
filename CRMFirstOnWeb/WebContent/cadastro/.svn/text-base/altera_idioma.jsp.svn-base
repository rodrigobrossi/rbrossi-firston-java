
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

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String idi_codigo = (String) request.getParameter("idi");
	String desc = (String) request.getParameter("desc" + idi_codigo);
%>

<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - <%=trd.Traduz("ALTERACAO DE IDIOMA")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function checa()
{
    frm.submit();
    return false;
}

function exclui()
{
  frm.submit();
  return false;
} 
</script>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
						<jsp:include page="../menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
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
							String oi = "", oia = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "ID";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt");
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "ID";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt");
								}

							}
						%>
						<jsp:include page="<%=oi%>" flush="true"></jsp:include>
					</tr>
				</table>
				</td>
			</tr>
			<jsp:include page="<%=oia%>" flush="true"></jsp:include>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("ALTERACAO DE IDIOMA")%></td>
						<td width="29"><img src="../art/bit.gif" width="13"
							height="15"></td>
					</tr>
				</table>
				</td>
				<td width="20">&nbsp;</td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" valign="top"></td>
				<FORM action="valida_idioma.jsp" name="frm" method="POST">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="90%">
					<tr class="celnortab">
						<td colspan="3" height="150">
						<p><%=trd.Traduz("IDIOMA")%> <br>
						<br>
						<input type="hidden" name="idi_codigo" value="<%=idi_codigo%>">
						<input type="text" name="idioma" value="<%=desc%>">
						<p><input type="hidden" name="update" value="S">
						</td>
					</tr>
					<tr>
						<td align="center" colspan="3">&nbsp;<br>
						<input type="button" class="botcin"
							value="      <%=trd.Traduz("OK")%>      "
							onClick="return checa();"> <input type="button"
							class="botcin" value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%>
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
		</td>
	</tr>
</table>
</body>
</html>
