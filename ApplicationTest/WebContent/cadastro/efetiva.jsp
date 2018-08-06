
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.lang.Math.*,java.util.*"%>
<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
	String fun_cod = "";
	String query = "";
	ResultSet rs = null, rsH = null;

	if (request.getParameter("codigo") != null) {
		fun_cod = request.getParameter("codigo");
	}

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	String aplicacao = (String) session.getAttribute("aplicacao");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//Faz conexAo ao Banco de Dados
	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 

	// **************** TRADUCAO ****************
	//trd.setConecta((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));
	//trd.setIdioma(usu_idi.intValue());
	// **************** TRADUCAO ****************
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - <%=trd.Traduz("CADASTRO DE FUNCIONARIOS")%>
- <%=trd.Traduz("EFETIVACAO DE TERCEIRO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function efetiva(){
  frm.action="efetiva_grava.jsp";
  frm.submit();
}
function cancela(){
  window.open("funcionarios.jsp","_self");
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
							<jsp:param value="opt" name="SO" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true">
							<jsp:param value="opt" name="SO" />
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
			<jsp:include page="../menu/menu1.jsp" flush="true">
				<jsp:param value="opt" name="FU" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu1.jsp" flush="true">
				<jsp:param value="opt" name="FU" />
			</jsp:include>
			<%
				}
			%>
		</table>


		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="trontrk"><%=trd.Traduz("EFETIVACAO DE TERCEIRO")%></td>
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
		</table>
		<form name="frm" method="post">
		<center>
		<table border="0" cellspacing="1" cellpadding="2" width="95%">
			<tr>

				<td width="4%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("CHAPA")%></div>
				</td>
				<td width="20%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("NOME")%></div>
				</td>
				<td width="12%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("CARGO")%></div>
				</td>
				<td width="12%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("FILIAL")%></div>
				</td>
				<td width="12%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("DEPARTAMENTO")%></div>
				</td>
				<td width="12%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("TABELA2")%></div>
				</td>
				<td width="12%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("TABELA3")%></div>
				</td>
				<td width="12%" class="celtittab" height="28">
				<div align="center"><%=trd.Traduz("SOLICITANTE")%></div>
				</td>
			</tr>
			<tr class="celnortab">

				<%
					query = "SELECT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, FI.FIL_NOME, F.FUN_CODSOLIC, "
							+ "C.CAR_NOME, D.DEP_NOME, T3.TB3_DESCRICAO, T2.TB2_NOME "
							+ "FROM FUNCIONARIO F, CARGO C, DEPTO D, TABELA3 T3, TABELA2 T2, FILIAL FI "
							+ "WHERE C.CAR_CODIGO = F.CAR_CODIGO AND "
							+ "D.DEP_CODIGO = F.DEP_CODIGO AND "
							+ "F.TB3_CODIGO OUTER T3.TB3_CODIGO AND "
							+ "F.TB2_CODIGO OUTER T2.TB2_CODIGO AND "
							+ "F.FIL_CODIGO OUTER FI.FIL_CODIGO AND "
							+ "F.FUN_CODIGO = " + fun_cod;
					rs = conexao.executaConsulta(query, session.getId());
					if (rs.next()) {
				%>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(6)%></td>
				<td><%=rs.getString(4)%></td>
				<td><%=rs.getString(7)%></td>
				<td><%=((rs.getString(8) == null) ? "" : rs.getString(8))%></td>
				<td><%=((rs.getString(9) == null) ? "" : rs.getString(9))%></td>
				<%
					String queryH = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "
								+ rs.getString(5);
						rsH = conexao.executaConsulta(queryH, session.getId() + "RS_1");
						if (rsH.next()) {
				%>
				<td><%=rsH.getString(1)%></td>
				<%
					} else {
				%>
				<td>&nbsp;</td>
				<%
					}
						if (rsH != null) {
							rsH.close();
							conexao.finalizaConexao(session.getId() + "RS_1");
						}
					}
					if (rs != null) {
						rs.close();
						conexao.finalizaConexao(session.getId());
					}
				%>
			</tr>
		</table>
		<br>
		<br>
		<br>

		<select name="sel_func">
			<%
				query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO WHERE FUN_DEMITIDO <> 'S' AND FUN_TERCEIRO <> 'S' ORDER BY FUN_NOME";
				rs = conexao.executaConsulta(query, session.getId() + "RS_2");
				if (rs.next()) {
					do {
			%>
			<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%
				} while (rs.next());
				}
				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS_2");
				}
			%>
		</select> <input type="hidden" name="codigo" value="<%=fun_cod%>"> <br>
		<br>
		<br>
		<input type="button" value="   EFETIVAR   " class="botcin"
			OnClick="return efetiva();"> <input type="button"
			value="   CANCELAR   " class="botcin" OnClick="return cancela();">
		</center>
		</form>
		</td>
	</tr>
	<tr>
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
