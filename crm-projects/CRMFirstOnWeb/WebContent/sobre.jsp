<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>


<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn EM</title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('imagens/ico_home_on.gif','imagens/ico_mensagens_on.gif','imagens/ico_batepapo_on.gif','imagens/ico_anotacoes_on.gif','imagens/ico_listadecursos_on.gif','imagens/ico_glossario_on.gif','imagens/ico_ajuda_on.gif','solicitacao/imagens/onenglish.gif','solicitacao/imagens/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10%" colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="3">
		<div align="center" class="ftverdanacinza"><b><%=trd.Traduz("Sobre o")%>
		FirstOn EM</b></div>
		</td>
	</tr>
	<tr>
		<td colspan="3">&nbsp;</td>
	</tr>
	<tr>
		<td width="10%">&nbsp;</td>
		<td width="80%">
		<div align="left" class="ftverdanacinza">
		<p>&nbsp; &nbsp; &nbsp; O <b>DIDAXIS EM</b> Sistema de
		Gest&atilde;o de Educa&ccedil;&atilde;o Coporativa - atende &agrave;
		demanda de colabora&ccedil;&atilde;o e decis&otilde;es que envolvem um
		Plano Anual de Desenvolvimento din&acirc;mico.</p>
		<p>&nbsp; &nbsp; &nbsp; T&atilde;o cr&iacute;tico quando a
		flexibilidade aliada ao rigor em controles, &eacute; a facilidade e
		adequa&ccedil;&atilde;o aos usu&aacute;rios. A SER atua em parceria,
		aliando sua viv&ecirc;ncia em gest&atilde;o de desenvolvimento, na
		plena utiliza&ccedil;&atilde;o via web ou licen&ccedil;as modulares do
		<b>DIDAXIS EM</b>.</p>
		<p>&nbsp; &nbsp; &nbsp; Desde o primeiro passo, a
		solu&ccedil;&atilde;o colabora na compreens&atilde;o de sua
		necessidade, para as lideran&ccedil;as (planejamento) ou para alta
		ger&ecirc;ncia (administra&ccedil;&atilde;o), em sequ&ecirc;ncia e
		intelig&ecirc;ncia necess&aacute;rias em momentos cr&iacute;ticos de
		qualidade, balan&ccedil;os e tangibiliza&ccedil;&atilde;o dos
		servi&ccedil;os.</p>
		</div>
		</td>
		<td width="10%">&nbsp;</td>
	</tr>
</table>

</body>
</html>
