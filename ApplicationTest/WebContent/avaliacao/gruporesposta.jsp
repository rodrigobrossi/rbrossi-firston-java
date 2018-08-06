<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>

<%
	//try{
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

	String query = "";
	ResultSet rs;

	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("GRUPO DE RESPOSTAS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra(){
  //document.frm.tipo.value = "F";
  frm.action ="gruporesposta.jsp";
  frm.submit();
  return false; 
}
function inclui(){
  document.frm.tipo.value = "I";
  frm.action ="inclusaodegruporesposta.jsp";
  frm.submit();
  return false; 
}
function altera(){
  document.frm.tipo.value = "U";
  frm.action ="inclusaodegruporesposta.jsp";
  frm.submit();
  return false; 
}
function exclui()
{
  if(confirm(<%=("\""
									+ trd
											.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?") + "\"")%>)){
    document.frm.tipo.value = "E";
    frm.action ="gruporespostagrava.jsp";
    frm.submit();
    return false; 
  }
  else{
    return false;
  }
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
				<jsp:param value="op" name="GR" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="GR" />
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
						<td class="trontrk" align="center"><%=trd.Traduz("INSERIR GRUPO DE RESPOSTAS")%></td>
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
				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>

				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<%
						query = "SELECT RG.QGR_GRUPO, R.RES_NOME, RG.QGR_VALOR FROM RESPGRUPO RG, RESPOSTA R "
								+ "WHERE RG.RES_CODIGO = R.RES_CODIGO "
								+ "ORDER BY QGR_GRUPO";
						rs = conexao.executaConsulta(query, session.getId());
						boolean existe = false;
						if (rs.next()) {
							existe = true;
						}
					%>
					<tr>
						<td align="center">&nbsp;<br>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return inclui()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
									</tr>
								</table>
								</td>
								<%
									if (existe) {
								%>
								<td width="10">&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return exclui()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
									</tr>
								</table>
								</td>
								<td width="10">&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return altera()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
									</tr>
								</table>
								</td>
								<%
									}
								%>
							</tr>
						</table>
						&nbsp; &nbsp;
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="70%">
							<tr>
								<%
									String nome = "", n_grupo = "", valor = "";
									if (existe) {
								%>
								<td width="4%">&nbsp;</td>
								<td width="96%" class="celtittab"><%=trd.Traduz("GRUPO DE RESPOSTAS")%>
								</td>
							</tr>
							<%
								n_grupo = rs.getString(1);
									String ok = "";
									int m = 0;
									do {
										ok = "";
										if (m == 0)
											ok = "checked";
										if (n_grupo.equals(rs.getString(1)))
											nome = nome + rs.getString(2) + "(" + rs.getString(3)
													+ ")" + "; ";
										else {
							%>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod" <%=ok%>
									value="<%=n_grupo%>"></td>
								<td width="96%">&nbsp;<%=nome%></td>
							</tr>
							<%
								nome = rs.getString(2) + "(" + rs.getString(3) + ")"
													+ "; ";
											n_grupo = rs.getString(1);
											m = m + 1;
										}
									} while (rs.next());
							%>
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="cod"
									value="<%=n_grupo%>"></td>
								<td width="96%">&nbsp;<%=nome%></td>
							</tr>
							<%
								} else {
							%>
							<td colspan="100%" align="center" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
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

				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>
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
<%
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}

	//}
	//catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>