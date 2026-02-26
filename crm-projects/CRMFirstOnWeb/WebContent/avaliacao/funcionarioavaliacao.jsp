<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page	import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session.getAttribute("Conexao");
%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");

	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String query = "";
	ResultSet rs;
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("FUNCIONARIOS PARA AVALIACAO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra(){
  //document.frm.tipo.value = "F";
  frm.action ="funcionarioavaliacao.jsp";
  frm.submit();
  return false; 
}
function altera(){
  document.frm.tipo.value = "U";
  frm.action ="inclusaofuncavaliacao.jsp";
  frm.submit();
  return false; 
}
function inclui(){
  document.frm.tipo.value = "I";
  frm.action ="incluifuncaval.jsp";
  frm.submit();
  return false; 
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
				<jsp:param value="op" name="FA" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="FA" />
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
						<td class="trontrk" align="center"><%=trd.Traduz("FUNCIONARIOS PARA AVALIACAO")%></td>
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
						<td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>:
						<%
 	String valorFiltro = (((String) request.getParameter("filtro") == null)
 			? ""
 			: (String) request.getParameter("filtro"));
 %>
						<input type="text" name="filtro" value="<%=valorFiltro%>">&nbsp;
						&nbsp; &nbsp; <input type="button" onClick="return filtra();"
							value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button1">
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
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return inclui();" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
									</tr>
								</table>
								</td>
								<td width="10">&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return altera();" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						&nbsp; &nbsp;
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="60%">
							<tr>
								<td width="4%">&nbsp;</td>
								<td width="36%" class="celtittab"><%=trd.Traduz("FUNCIONARIO")%>
								</td>
								<td width="20%" class="celtittab"><%=trd.Traduz("TIPO")%></td>
							</tr>
							<%
								if (!valorFiltro.equals("")) {
									valorFiltro = "AND F.FUN_NOME >= '" + valorFiltro + "'";
								}
								query = "SELECT DISTINCT F.FUN_CODIGO, F.FUN_NOME, AV.AVA_DESCRICAO "
										+ "FROM FUNCIONARIO F, AVALIADO A, PROCESSO P, QUESTIONARIO Q, AVALIACAO AV "
										+ "WHERE F.FUN_CODIGO = A.FUN_CODIGO "
										+ "AND P.PRO_CODIGO = A.PRO_CODIGO "
										+ "AND Q.QUE_CODIGO = P.QUE_CODIGO "
										+ "AND AV.AVA_CODIGO = Q.AVA_CODIGO "
										+ valorFiltro
										+ " "
										+ "ORDER BY F.FUN_NOME";

								rs = conexao.executaConsulta(query, "1234");
								if (rs.next()) {
									String ok = "", checa = "";
									do {
										checa = "";
										if (!ok.equals("1")) {
											checa = "checked";
											ok = "1";
										}
							%>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod" <%=checa%>
									value="<%=rs.getString(1)%>"></td>
								<td width="39%"><%=rs.getString(2)%></td>
								<td width="19%"><%=rs.getString(3)%></td>
							</tr>
							<%
								} while (rs.next());
								} else {
							%>
							<tr>
								<td>&nbsp;</td>
								<td colspan="2" class="celnortab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
							</tr>
							<%
								}
							%>
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
	//}
	//catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>