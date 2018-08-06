<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
%>

<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("AVALIAR")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra(){
  //document.frm.tipo.value = "F";
  frm.action ="avaliar.jsp";
  frm.submit();
  return false; 
}
function inclui(){
  alert("EM CONSTRUCAO");
  //document.frm.tipo.value = "I";
  //frm.action ="inclusaodequestionario.jsp";
  //frm.submit();
  //return false; 
}
function altera(){
  //document.frm.tipo.value = "U";
  alert("EM CONSTRUCAO");
  //frm.action ="inclusaodequestionario.jsp";
  //frm.submit();
  //return false; 
}
function exclui()
{
  alert("EM CONSTRUCAO");
  /*
  if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)){
    document.frm.tipo.value = "E";
    frm.action ="questionariograva.jsp";
    frm.submit();
    return false; 
  }
  else{
    return false;
  }*/
}
</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
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
							<jsp:param value="opt" name="SO" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="SO" />
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
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/menu.jsp" flush="true">
							<jsp:param value="op" name="AV" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true">
							<jsp:param value="op" name="AV" />
						</jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<%
				if (ponto.equals("..")) {
			%>
			<jsp:include page="../menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="MQ" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="MQ" />
			</jsp:include>
			<%
				}
			%>
		</table>
		<FORM name="frm">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" align="center"><%=trd.Traduz("AVALIAR")%></td>
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
						<td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("AVALIACAO")%>:
						<select name="sel_aval">
							<option value="0">SELECIONE</option>
							<option value="1">EFICACIA</option>
							<option value="2">REACAO</option>
							<option value="3">APRENDIZADO</option>
						</select> &nbsp; &nbsp; &nbsp; <input type="button"
							onClick="return filtra();" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%>
							class="botcin" name="button1"></td>
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
						<td align="center" class="ctfontc"><font size="1"> <br>
						** - VENCIDO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * - RESPONDIDO </font></td>
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
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';" onClick=""
											width="127" height="22" align=center class="botver"><a
											href="#" class="txbotver"><%=trd.Traduz("RESPONDER")%></a></td>
									</tr>
								</table>
								</td>
								<td width="10">&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';" onClick=""
											width="127" height="22" align=center class="botver"><a
											href="#" class="txbotver"><%=trd.Traduz("ENVIAR")%></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						&nbsp; &nbsp;
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="4%">&nbsp;</td>
								<td width="52%" class="celtittab">FUNCIONARIO</td>
								<td width="20%" class="celtittab">DATA ENVIO</td>
								<td width="20%" class="celtittab">DATA VENCIMENTO</td>
								<td width="4%" class="celtittab">RESPONDIDA</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod" checked
									value="0"></td>
								<td width="52%">* JOAO ROSANGELA</td>
								<td width="20%">10/10/2002</td>
								<td width="20%">10/10/2002</td>
								<td width="4%">S</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod" value="1"></td>
								<td width="52%">* SILVIO DA SILVA</td>
								<td width="20%">10/10/2002</td>
								<td width="20%">10/10/2002</td>
								<td width="4%">S</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod" value="2"></td>
								<td width="52%">JOAO UBALDO RIBEIRO</td>
								<td width="20%">10/10/2002</td>
								<td width="20%">10/10/2002</td>
								<td width="4%">N</td>
							</tr>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod" value="3"></td>
								<td width="52%">** JANIO QUADROS</td>
								<td width="20%">10/10/2002</td>
								<td width="20%">10/10/2002</td>
								<td width="4%">S</td>
							</tr>
						</table>
						<br>
						&nbsp;</td>
					</tr>
				</table>
				</td>
				<input type="hidden" name="tipo">

				<td width="20" valign="top"></td>
			</tr>
		</table>
		</FORM>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					} else {
				%> <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
				<%
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
