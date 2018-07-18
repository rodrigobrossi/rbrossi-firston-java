<!--
Nome do arquivo: erro/layout.jsp
Nome da funcionalidade: página de erro
Função: exibe o erro de acordo com o seu tipo
Variáveis necessárias/ Requisitos: 
- sessao: 
- parametro: 
Regras de negócio (pagina): exibir o conteúdo correto para os diferentes tipos de erro
_________________________________________________________________________________________

Histórico
Data de atualizacao: 19/03/2003 - Desenvolvedor: Anderson Inoue
Atividade: criação
_________________________________________________________________________________________
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*,java.util.*,java.sql.*,java.text.*"%>

<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//***DECLARAÇÃO DE VARIÁVEIS***
	String erro = "";

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	erro = ((request.getParameter("tipo") == null) ? "" : request
			.getParameter("tipo"));
%>

<%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20">&nbsp; height="48"></td>
						<td width="100%" valign="middle"><img
							src="../art/Logo_Cliente_Banner.gif"></td>
						<td width="20"></td>
						<td align="right" valign="bottom"></td>
						<td width="20">&nbsp; height="90"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td bgcolor="#005b7f"><img src="../art/bit.gif" width="12"
					height="1"></td>
			</tr>
		</table>
		<table border="0" cellspacing="0" cellpadding="0" width="100%"
			height="100%" align="center">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" height="25">
				<table border="0" cellspacing="0" cellpadding="0" width="100%"
					height="100%">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
				<td width="20">&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<!--<tr width="100%" height="100%" align="center" valign="top" style="width:100%;height:100%;background-image:url(../art/ser_bkg.jpg);BACKGROUND-REPEAT: no-repeat;position:relative">-->
	<tr width="100%" height="100%" align="center" valign="top">
		<td>
		<table border="0" width="400px">
			<tr>
				<td colspan="100%">
				<hr color="#005b7f">
				</td>
			</tr>
			<tr>
				<td class="trontrk" colspan="100%"><img
					src="../art/ico_alerta.gif">&nbsp;<font color="red"><%=trd.Traduz("AVISO")%>:</font>
				<%
					if (erro.equals("S")) {
						out
								.println(trd
										.Traduz("SUA SESSAO EXPIROU. FAVOR REALIZAR O LOGIN NOVAMENTE"));
					} else {
						out
								.println(trd
										.Traduz("OPERACAO INVALIDA. CLIQUE EM VOLTAR PARA CONTINUAR NA APLICACAO OU EXECUTE NOVAMENTE O LOGIN"));
					}
				%>
				</td>
			</tr>
			<tr>
				<td colspan="100%">
				<hr color="#005b7f">
				</td>
			</tr>
			<!--
        <tr>
          <td colspan="100%"><a href="JavaScript:alert('UNDER CONSTRUCTION')" class="lnk_outlook">
            <img src="../art/ico_newmsg.gif" border="0"><b><%=trd.Traduz("ENVIAR ERRO POR E-MAIL")%></b></a>
          </td>
        </tr>
        <tr><td colspan="100%">&nbsp;</td></tr>
        -->
			<tr>
				<td height="200" align="center" valign="middle" colspan="100%">
				<img src="../art/em_peq.gif"></td>
			</tr>
			<tr>
				<td colspan="100%">
				<hr color="#005b7f">
				</td>
			</tr>
			<tr>
				<td align="center"><a href="../sair.jsp" class="lnk_outlook"><img
					src="../art/ico_ordem.gif" border="0">&nbsp;<b><%=trd.Traduz("LOGIN")%></b></a>
				</td>
				<%
					if (!erro.equals("S")) {
				%>
				<td align="center"><a href="#"
					onClick="JavaScript:history.go(-1);" class="lnk_outlook"><img
					src="../art/ico_ordem.gif" border="0">&nbsp;<b><%=trd.Traduz("VOLTAR")%>
				</b></a></td>
				<%
					}
				%>
			</tr>
			<tr>
				<td colspan="100%">
				<hr color="#005b7f">
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><jsp:include page="../rodape/rodape_errorpage.jsp"
					flush="true"></jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>