
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	/*
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	 */
%>

<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Cadastro de Tipos de Desenvolvimento")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<FORM name="frm">
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
								value="opt" name="CA" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="CA" /></jsp:include>
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
						<jsp:include page="../menu/menu.jsp" flush="true"></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true"></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="trcurso" width="60">Cadastro</td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td width="1" class="trhdiv"><img src="../art/bit.gif"
							width="1" height="1"></td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" width="297">Cadastro de Tipos de
						Desenvolvimento</td>
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

				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center">&nbsp; NOME DO
						TIPO DE DESENVOLVIMENTO: <input type="text" name="textfield">
						&nbsp; &nbsp; &nbsp; <img src="../art/bot_filtrar.gif" border=0>
						</td>
					</tr>
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td class="ctvdiv" height="1"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td align="center">&nbsp;<br>
						<a href="inclusaodetipodedesenv.jsp"><img
							src="../art/bot1_incluir.gif" border="0" width="127" height="22"></a>
						&nbsp; <a href="#"><img src="../art/bot1_excluir.gif"
							border="0" width="127" height="22"></a> &nbsp; <a
							href="inclusaodetipodedesenv.jsp"><img
							src="../art/bot1_alterar.gif" border="0" width="127" height="22"></a>
						&nbsp; &nbsp;
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="4%">&nbsp;</td>
								<td width="96%" class="celtittab">Nome do Tipo de
								Desenvolvimento</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="checkbox" name="checkbox"
									value="checkbox"></td>
								<td width="96%">Treinamento</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="checkbox" name="checkbox"
									value="checkbox"></td>
								<td width="96%">Leitura</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="checkbox" name="checkbox"
									value="checkbox"></td>
								<td width="96%">Cases</td>
							</tr>
						</table>
						<br>
						&nbsp;</td>
					</tr>
				</table>
				</td>

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
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td></td>
						<td nowrap><b><a href="../login.jsp" class="dilink">Sair</a></b></td>
						<td width="10" nowrap><img src="../art/bit.gif" width="10"
							height="10"></td>
						<td width="1" class="dihdiv"><img src="../art/bit.gif"
							width="1" height="10"></td>
						<td width="10" nowrap><img src="../art/bit.gif" width="10"
							height="10"></td>
						<td nowrap><a
							href="JavaScript:MM_openBrWindow('../about.htm','popup','scrollbars=yes,width=384,height=400,left=200,top=100')"
							class="dilink">Sobre o FirstOn</a></td>
						<td width="10" nowrap><img src="../art/bit.gif" width="10"
							height="10"></td>
						<td width="1" class="dihdiv"><img src="../art/bit.gif"
							width="1" height="10"></td>
						<td width="10" nowrap><img src="../art/bit.gif" width="10"
							height="10"></td>
						<td nowrap class="difont"><b>D&uacute;vidas?</b> Entre em
						contato com: <a
							href="mailto:didaxis@serinformatica.com.br?subject=D%FAvidas"
							class="dilink">didaxis@serinformatica.com.br</a></td>
					</tr>
				</table>
				</td>
				<td align="right" width="29"><a href="#"
					onMouseOver="HM_f_PopUp('elMenu3',event)"
					onMouseOut=
    HM_f_PopDown('elMenu3');
><img
					src="../art/idioma.gif" width="29" height="20" border="0"></a></td>
				<td align="right" width="20"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</FORM>
</body>
</html>
