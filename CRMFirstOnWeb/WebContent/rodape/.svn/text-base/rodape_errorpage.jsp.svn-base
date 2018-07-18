<!--
Nome do arquivo: rodape/rodape_errorpage.jsp
Nome da funcionalidade: rodape
Função: inclui o rodape da página de erro
Variáveis necessárias/ Requisitos: 
- sessao:usu_tipo("usu_tipo"), fun_idi("usu_idi"), usu_cod("usu_cod"), apl("aplicacao"); 
- parametro: 
Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 19/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - criação;
_________________________________________________________________________________________
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page	import="java.sql.*,java.util.*,java.sql.*,java.text.*"%>


<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//***DECLARAÇÃO DE VARIÁVEIS***

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
	request.getSession();
	FOLocalizationBean trd2 = (FOLocalizationBean) session.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session.getAttribute("Conexao");
	conexao.getConection();

	String apl = (String) session.getAttribute("aplicacao");
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer fun_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
%>




<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<body>
<script language="JavaScript">
function sobre(){
  window.open('../sobre.jsp','popup','scrollbars=yes,width=384,height=400,left=200,top=100');
}
</script>
<script language="JavaScript1.2" src="js/HM_Loader.js"	type='text/JavaScript'></script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table border="1" cellspacing="0" cellpadding="0">
			<tr>
				<td></td>
				<td width="10" nowrap><img src="../art/bit.gif" width="10"
					height="10"></td>
				<%
				if (apl.equals("EM")) {
				%><td nowrap><a href="#" onclick="return sobre()"
					class="dilink"><%=trd2.Traduz("Sobre o")%> FirstOn EM</a></td>
				<%
				} else if (apl.equals("CM")) {
				%><td nowrap><a href="#" onclick="return sobre()"
					class="dilink"><%=trd2.Traduz("Sobre o")%> FirstOn CM</a></td>
				<%
				} else {
				%><td nowrap><a href="#" onclick="return sobre()"
					class="dilink"><%=trd2.Traduz("Sobre o")%> eFeedback</a></td>
				<%
					}
					String EMAIL_DE_SUPORTE = ((((String) session
							.getAttribute("email_suporte")) == null) ? ""
							: (String) session.getAttribute("email_suporte"));
					if (!EMAIL_DE_SUPORTE.equals("")) {
				%>
				<td width="10" nowrap><img src="../art/bit.gif" width="10"
					height="10"></td>
				<td width="1" class="dihdiv"><img src="../art/bit.gif"
					width="1" height="10"></td>
				<td width="10" nowrap><img src="../art/bit.gif" width="10"
					height="10"></td>
				<td nowrap class="difont"><b><%=trd2.Traduz("DUvidas")%>?</b> <%=trd2.Traduz("Entre em contato com")%>:&nbsp;<a
					href="mailto:<%=EMAIL_DE_SUPORTE%>" class="dilink"><%=EMAIL_DE_SUPORTE%></a>
				<%
				}
				%>
				</td>
			</tr>
		</table>
		</td>
		<td align="right" width="15"></td>
		<td align="right" width="20">&nbsp;
			height="10"></td>
	</tr>
</table>
</html>

