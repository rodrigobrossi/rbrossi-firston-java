
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

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

	FODBConnectionBean conexaoF = new FODBConnectionBean();

	conexaoF.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs = null, rsF = null;

	//Declaracao de variaveis
	String query = "", fun_nomedb = "", fil_nomedb = "", fun_logindb = "", fun_senhadb = "", fun_cod = "", filial_filtro = "";
	int i = 0;
%>
<script language="JavaScript">
function gera() {
    var qtde=0;
    for(i=1;i<=frm_gera.cont.value;i++)
      if(eval("frm_gera.chk"+i+".checked")==true)
        qtde++;
    if (qtde == 0) {
      alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO!") + "\"")%>);
      return false;
    } else {
      frm_gera.action ="gera_login_sql.jsp";
      frm_gera.submit();
    }
}
function atualiza() {
    frm_gera.action ="gera_login.jsp";
    frm_gera.submit();
}
</script>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page
	import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Solicitantes")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">

</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
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
						<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param
								value="op" name="SO" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param
								value="op" name="SO" /></jsp:include>
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
				<jsp:include page="../menu/menu_solicitante.jsp" flush="true">
					<jsp:param value="op" name="G" />
				</jsp:include>
				<%
					} else {
				%>
				<jsp:include page="/menu/menu_solicitante.jsp" flush="true">
					<jsp:param value="op" name="G" />
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
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk"><%=trd.Traduz("GERA LOGIN")%></td>
						<td width="13"><img src="../art/bit.gif" width="13"
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
			</tr>

			<center>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<form name="frm_gera">
				<tr>
					<td>&nbsp;></td>
					<td width="40%" class="ctfontc" align="right"><%=trd.Traduz("NOME")%>:
					<%
						String valorFiltro = (((String) request.getParameter("filtro") == null) ? ""
								: (String) request.getParameter("filtro"));
					%> <input type="text" name="filtro" value="<%=valorFiltro%>">
					</td>
					<td>&nbsp;&nbsp;</td>
					<td width="60%" class="ctfontc" align="left"><%=trd.Traduz("FILIAL")%>
					<select name="cbo_filial">
						<option value=""><%=trd.Traduz("TODOS")%></option>
						<%
							query = "SELECT FIL_CODIGO, FIL_NOME FROM FILIAL ORDER BY FIL_NOME";
							rsF = conexaoF.executaConsulta(query);
							while (rsF.next()) {
								if (rsF.getString(1).equals(request.getParameter("cbo_filial"))) {
									filial_filtro = request.getParameter("cbo_filial");
						%>
						<option selected value="<%=rsF.getString(1)%>"><%=rsF.getString(2)%></option>
						<%
							} else {
						%>
						<option value="<%=rsF.getString(1)%>"><%=rsF.getString(2)%></option>
						<%
							}
							}
						%>
					</select></td>
					<td>&nbsp;></td>
				</tr>
				<tr>
					<td><img src="../art/bit.gif"></td>
					<td colspan="3" align="center"><input type="button"
						onClick="return atualiza();"
						value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%> class="botcin"
						name="button1"></td>
				</tr>
				<tr>
					<td><img src="../art/bit.gif"></td>
					<td height="12" colspan="3"><img src="../art/bit.gif"
						width="1" height="1"></td>
				</tr>
				<tr align="center">
					<td><img src="../art/bit.gif"></td>
					<td colspan="3" class="ctvdiv" height="1"><img
						src="../art/bit.gif" width="1" height="1"></td>
				</tr>
				<tr>
					<td colspan="100%" align="center"><br>
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table border="1" cellspacing="0" cellpadding="1"
								bordercolor="#000000">
								<tr>
									<td onMouseOver="this.className='ctonlnk2';"
										onClick="return gera();" width="127" height="22" align=center
										class="botver"><a href="#" class="txbotver"><%=trd.Traduz("GERAR")%></a></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>

			<table border="0" cellspacing="1" cellpadding="2" width="80%">
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
							+ "WHERE FUN.FIL_CODIGO = FIL.FIL_CODIGO AND FUN_DEMITIDO <> 'S' ";
					if (!valorFiltro.equals(""))
						query = query + "AND FUN.FUN_NOME >= '" + valorFiltro + "' ";
					if (!filial_filtro.equals(""))
						query = query + "AND FIL.FIL_CODIGO = " + filial_filtro + " ";
					query = query + "ORDER BY FUN.FUN_NOME ";
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
			<input type="hidden" name="cont" value="<%=i%>"> <br>
			</form>
			</center>
			</td>
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

			conexaoF.finalizaConexao();
			//conexaoF.finalizaBD();
		%>
		
</body>
</html>
