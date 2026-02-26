<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*"%>

<%
	//recupera da sessAo//
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	ResultSet rs = null;

	//Declaracao de variaveis
	String query = "", fun_nomedb = "", fil_nomedb = "", fun_logindb = "", fun_senhadb = "", fun_cod = "";
	int i = 0;
%>
<script language="JavaScript">
function gera() {
    frm_gera.action ="gera_login_sql.jsp";
    frm_gera.submit;
}
</script>


<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>eFeedback - <%=trd.Traduz("Menu Principal")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">

</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<form name="frm_gera">
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
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include> 
						<%
						} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="FE"/></jsp:include> 
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
						<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param value="op" name="F"/></jsp:include> 
						<%
						} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param value="op" name="F"/></jsp:include> 
						<%
						}
						%>

					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="2" cellpadding="0"
			bgcolor="c0c0c0" height="8">
			<tr>
				<%
				if (ponto.equals("..")) {
				%>
				<jsp:include page="../menu/menu_ferramentas.jsp" flush="true" >
					<jsp:param value="op" name="G"/>
				</jsp:include>
				<%
				} else {
				%>
				<jsp:include page="/menu/menu_ferramentas.jsp" flush="true" >
				
				<jsp:param value="op" name="G"/>
				</jsp:include>
				<%
				}
				%>
			</tr>
		</table>
		<br>

		<center>
		<table border="0" cellspacing="1" cellpadding="2" width="80%">
			<tr>
				<td colspan="5">
				<div align="center" class="ftverdanacinza"><b><%=trd.Traduz("Gera Login")%></b></div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr class="celtittab">
				<td align="center" width="5%"></td>
				<td align="center" width="40%"><%=trd.Traduz("NOME")%></td>
				<td align="center" width="35%">
				<div align="center"><%=trd.Traduz("FILIAL")%></div>
				</td>
				<td align="center" width="15%"><%=trd.Traduz("LOGIN")%></td>
			</tr>
			<%
						query = "SELECT FUN.FUN_NOME, FIL.FIL_NOME, FUN.FUN_LOGIN, FUN.FUN_CODIGO "
						+ "FROM FUNCIONARIO FUN, FILIAL FIL "
						+ "WHERE FUN.FIL_CODIGO = FIL.FIL_CODIGO AND FUN_DEMITIDO <> 'S' "
						+ "ORDER BY FUN.FUN_NOME ";
				rs = conexao.executaConsulta(query);

				while (rs.next()) {
					fun_nomedb = "";
					fil_nomedb = "";
					fun_logindb = "";
					fun_cod = "";
					i = i + 1;

					if (rs.getString(1) != null)
						fun_nomedb = rs.getString(1);
					if (rs.getString(2) != null)
						fil_nomedb = rs.getString(2);
					if (rs.getString(3) != null)
						fun_logindb = rs.getString(3);
					if (rs.getString(4) != null)
						fun_cod = rs.getString(4);
			%>
			<tr class="celnortab">
				<td align="left" width="5%"><input type="checkbox"
					name="chk<%=i%>" value="<%=fun_cod%>"></td>
				<td align="left" width="40%"><%=fun_nomedb%></td>
				<td align="center" width="25%"><%=fil_nomedb%></td>
				<td align="center" width="15%"><%=fun_logindb%></td>
			</tr>
			<%
			}
			%>
		</table>
		<BR>
	<tr>
		<td colspan="5">
		<div align="center"><input type="submit" name="Submit"
			value="Gerar" class="botcin" onClick="return gera()"></div>
		</td>
	</tr>
	<tr>
		<td><br>
		<input type="hidden" name="cont" value="<%=i%>"></td>
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

<%
		if (rs != null)
		rs.close();
	conexao.finalizaConexao();
%>
</form>
</body>
</html>
