<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
%>

<%@page import="firston.eval.components.FOLocalizationBean"%><%@page
	import="firston.eval.connection.FODBConnectionBean"%><%@page
	import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Ferramentas")%> - <%=trd.Traduz("Troca Senha")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function troca(){
  if(frm.atual.value == ""){
    alert(<%=("\""
									+ trd
											.Traduz("E NECESSARIO PREENCHER O CAMPO SENHA ATUAL") + "\"")%>);
    frm.atual.focus();
    return false;
  }
  else if(frm.nova.value == ""){
    alert(<%=("\""
									+ trd
											.Traduz("E NECESSARIO PREENCHER O CAMPO NOVA SENHA") + "\"")%>);
    frm.nova.focus();
    return false;
  }
  else if(frm.confirma.value == ""){
    alert(<%=("\""
									+ trd
											.Traduz("E NECESSARIO PREENCHER O CAMPO CONFIRMA SENHA") + "\"")%>);
    frm.confirma.focus();
    return false;
  }
  else if(frm.nova.value != frm.confirma.value){
    alert(<%=("\""
									+ trd
											.Traduz("A CONFIRMACAO DE SENHA E INVALIDA") + "\"")%>);
    frm.confirma.value="";
    frm.confirma.focus();
    return false;
  }
  else{
    frm.action="checa_grava_senha.jsp";
    frm.submit();
    return true;
  }
}

function aspa(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 == "\"" || aux2 == "\'"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

function aspa2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == "\"" || aux2 == "\'")
      k = k+1;
    tam--;
  }
  if(k != 0){
    alert(<%=("\""
									+ trd
											.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA") + "\"")%>);
    campo.focus();
    campo.value = "";
  }
}

</script>
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
						%>
						<%
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
						<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param
								value="op" name="F" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param
								value="op" name="F" /></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
			<tr>
				<%
					if (ponto.equals("..")) {
				%>
				<jsp:include page="../menu/menu_ferramentas.jsp" flush="true">
					<jsp:param value="op" name="T" />
				</jsp:include>
				<%
					} else {
				%>
				<jsp:include page="/menu/menu_ferramentas.jsp" flush="true">
					<jsp:param value="op" name="T" />
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
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td width="100%" align="center">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="13"><img src="../art/bit.gif" width="13"
									height="15"></td>
								<td class="trontrk" width="297" align="center"><%=trd.Traduz("TROCA SENHA")%></td>
								<td width="29"><img src="../art/bit.gif" width="13"
									height="15"></td>
							</tr>
						</table>
						</td>
						<td width="20">&nbsp;</td>
					</tr>
				</table>
				</center>

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
		</table>

		<br>
		<br>
		<br>
		<br>
		<br>
		<form name="frm">
		<center>
		<table border="0" cellspacing="1" cellpadding="1" width="50%"
			bgcolor="FFFFFF">
			<tr>
				<td align="right" class="celnortab"><%=trd.Traduz("SENHA ATUAL")%>:
				</td>
				<td class="celnortab">&nbsp;<input type="password" name="atual"
					size="40" maxlength="200" onBlur="aspa2(this)" onKeyUp="aspa(this)"></td>
			</tr>
			<tr>
				<td align="right" class="celnortab"><%=trd.Traduz("NOVA SENHA")%>:
				</td>
				<td class="celnortab">&nbsp;<input type="password" name="nova"
					size="40" maxlength="200" onBlur="aspa2(this)" onKeyUp="aspa(this)"></td>
			</tr>
			<tr>
				<td align="right" class="celnortab"><%=trd.Traduz("CONFIRMAR SENHA")%>:
				</td>
				<td class="celnortab">&nbsp;<input type="password"
					name="confirma" size="40" maxlength="200" onBlur="aspa2(this)"
					onKeyUp="aspa(this)"></td>
			</tr>
		</table>

		<br>
		<input type="button" class="botcin"
			value=<%=("\"" + trd.Traduz("CONFIRMAR") + "\"")%>
			OnClick="return troca();"> <input type="reset" class="botcin"
			value="    <%=trd.Traduz("LIMPA")%>    "></center>
		</form>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%
				if (ponto.equals("..")) {
			%>
			<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>

</body>
</html>
