
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//VariAveis para as Queryes
	String query = "", solic_cod = "";
	ResultSet rs = null;
	int i = 0;

	//Recupera valores
	if (request.getParameter("chk_solic") != null)
		solic_cod = request.getParameter("chk_solic");

	query = "SELECT F.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CAR_NOME, D.DEP_NOME, T1.TB1_NOME, T2.TB2_NOME, FI.FIL_NOME "
			+ "FROM FUNCIONARIO F, CARGO C, DEPTO D, TABELA1 T1, TABELA2 T2, FILIAL FI "
			+ "WHERE C.CAR_CODIGO = F.CAR_CODIGO AND D.DEP_CODIGO = F.DEP_CODIGO "
			+ "AND T1.TB1_CODIGO OUTER F.TB1_CODIGO AND T2.TB2_CODIGO OUTER F.TB2_CODIGO "
			+ "AND FI.FIL_CODIGO = F.FIL_CODIGO AND F.FUN_CODSOLIC IS NULL "
			+ "ORDER BY F.FUN_NOME ";
	//out.println("query = " + query);

	//try {
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Subordinados")%>
- <%=trd.Traduz("Solicitantes")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
  function cancelar() {
    window.open("solicitantes.jsp?filtro=<%=solic_cod%>", "_parent");
    return true;
  }

  function incluir() {
    frm_sub.tipo_op.value = "ISUB";
    frm_sub.chk_solic.value = <%=solic_cod%>;
    frm_sub.action = "inclusaodesolicitante_sql.jsp";
    frm_sub.submit();
  }
</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../art/onenglish.gif','../art/onespanol.gif')">
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
								value="opt" name="SO" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="SO" /></jsp:include>
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
									oia = "../menu/menu1.jsp?opt=" + "SO";
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
									oia = "/menu/menu1.jsp?opt=" + "SO";
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
				<td width="100%">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="trcurso"><%=trd.Traduz("TITULO")%></td>
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
				<FORM name="frm_sub">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>:
						<input type="text" name="txt_loc_nome"></td>
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
						<td>&nbsp;<br>
						<center>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="incluir();" width="127" height="22" align=center
											class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
									</tr>
								</table>
								</td>
								<td>&nbsp;&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="cancelar();" width="127" height="22" align=center
											class="botver"><a href="#" class="txbotver"><%=trd.Traduz("CANCELAR")%></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</center>
						<br>
						<table border="0" cellspacing="1" cellpadding="2" width="100%">
							<tr>
								<td width="4%" height="28">&nbsp;</td>
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
								<div align="center"><%=trd.Traduz("DEPARTAMENTO")%></div>
								</td>
								<td width="12%" class="celtittab" height="28">
								<div align="center"><%=trd.Traduz("TABELA1")%></div>
								</td>
								<td width="12%" class="celtittab" height="28">
								<div align="center"><%=trd.Traduz("TABELA2")%></div>
								</td>
								<td width="12%" class="celtittab" height="28">
								<div align="center"><%=trd.Traduz("FILIAL")%></div>
								</td>
							</tr>

							<%
								rs = conexao.executaConsulta(query);
								if (rs.next()) {
									do {
										i++;
							%>
							<tr class="celnortab">
								<td width="4%"><input type="checkbox" name="chk_sub_<%=i%>"
									value="<%=rs.getInt(1)%>"></td>
								<td width="4%">
								<div align="center"><%=rs.getString(2)%></div>
								</td>
								<td width="20%"><%=rs.getString(3)%></td>
								<td width="12%"><%=rs.getString(4)%></td>
								<%
									if (rs.getString(5) != null) {
								%>
								<td width="12%"><%=rs.getString(5)%></td>
								<%
									} else {
								%>
								<td width="12%"></td>
								<%
									}
											if (rs.getString(6) != null) {
								%>
								<td width="12%"><%=rs.getString(6)%></td>
								<%
									} else {
								%>
								<td width="12%"></td>
								<%
									}
											if (rs.getString(7) != null) {
								%>
								<td width="12%"><%=rs.getString(7)%></td>
								<%
									} else {
								%>
								<td width="12%"></td>
								<%
									}
											if (rs.getString(8) != null) {
								%>
								<td width="12%"><%=rs.getString(8)%></td>
								<%
									} else {
								%>
								<td width="12%"></td>
								<%
									}
								%>
							</tr>
							<%
								} while (rs.next());
								}
							%>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<input type="hidden" name="tipo_op">
				<input type="hidden" name="chk_solic">
				</FORM>
				<td width="20" valign="top"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
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
<%
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();
	//} catch (Exception e) {  out.println(e);}
%>