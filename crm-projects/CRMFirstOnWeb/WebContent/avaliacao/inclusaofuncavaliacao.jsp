<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");

	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	String aplicacao = (String) session.getAttribute("aplicacao");

	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 

	String query = "";
	ResultSet rs;

	String fun_codigo = "";
	if (request.getParameter("cod") != null)
		fun_codigo = request.getParameter("cod");
%>
<script language="JavaScript">
function ok(){
  alert("UNDER CONSTRUCTION");
}

function cancel(){
  history.go(-1);
}
</script>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("ALTERACAO DE FUNCIONARIO NA AVALIACAO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
<FORM name="cad_solic">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<%
							String ponto = (String) session.getAttribute("barra");
							if (ponto.equals("..")) {
						%> <jsp:include
							page="../menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include> <%
 	} else {
 %> <jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include> <%
 	}
 %>
						</td>
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
						<td>
						<%
							if (ponto.equals("..")) {
						%> <jsp:include page="../menu/menu.jsp"
							flush="true">
							<jsp:param value="op" name="AV" />
						</jsp:include> <%
 	} else {
 %> <jsp:include page="/menu/menu.jsp" flush="true">
							<jsp:param value="op" name="AV" />

						</jsp:include> <%
 	}
 %>
						</td>
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
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20">&nbsp;</td>
						<td width="100%">
						<center>
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="13"><img src="../art/bit.gif" width="13"
									height="15"></td>
								<td class="trontrk" align="center"><%=trd.Traduz("ALTERACAO DE FUNCIONARIO NA AVALIACAO")%></td>
								<td width="29"><img src="../art/bit.gif" width="13"
									height="15"></td>
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
					<tr>

						<td width="20" valign="top"></td>
						<td valign="top"><img src="../art/bit.gif" width="159"
							height="1"><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="left">&nbsp;
								<table border="0" cellspacing="1" cellpadding="2" width="80%"
									align="left">
									<tr align="left">
										<td align="left" class="ftverdanacinza" width="50%">
										<%
											query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "
													+ fun_codigo;
											rs = conexao.executaConsulta(query);
											rs.next();
										%> <b><%=trd.Traduz("FUNCIONARIO")%></b>: <%=rs.getString(1)%>&nbsp;&nbsp;&nbsp;&nbsp;
										</td>
									</tr>
								</table>
								</td>
							</tr>

							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td class="ctvdiv" height="1"><img src="../art/bit.gif"
									width="1" height="1"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>

							<table border="0" cellspacing="1" cellpadding="2" width="40%"
								align="center">
								<tr>
									<td width="5%">&nbsp;</td>
									<td class="celtittab"><%=trd.Traduz("AVALIAR")%></td>
								</tr>
								<%
									query = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO";
									rs = conexao.executaConsulta(query);
									if (rs.next()) {
										do {
								%>
								<tr>
									<td width="5%" class="celnortab"><input type="checkbox"
										name="check1" value="<%=rs.getString(1)%>"></td>
									<td class="celnortab"><%=rs.getString(2)%></td>
								</tr>
								<%
									} while (rs.next());
									}
								%>
								<tr>
									<td align="center">&nbsp;</td>
								</tr>
								<tr align="center">
									<td colspan="100%" align="center"><input type="button"
										class="botcin" value="        <%=trd.Traduz("OK")%>        "
										onclick="return ok();"> &nbsp; <input type="button"
										class="botcin" value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%>
										onclick="return cancel();"></td>
								</tr>
							</table>

							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
						</table>
						</td>
					<tr>
						<td align="right" height="30" class="difundo">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<%
									if (ponto.equals("..")) {
								%> <jsp:include
									page="../rodape/rodape.jsp" flush="true"></jsp:include> <%
 	} else {
 %>
								<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
								<%
									}
								%>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</FORM>
</body>
</html>
<%
	//}catch(Exception e){
	//out.println("Erro: "+e);}
%>