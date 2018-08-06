<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*,java.text.*"%>
<jsp:useBean id="acesso" scope="page" class="firston.eval.access.FOAccessBean" />
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	/* Main Page begins */
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	conexao = conexao.getConection();

	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	//Variaveis de controle do usuArio 
	//String endAddr 		= ""+request.getRemoteAddr();
	//String endUser 		= ""+request.getRemoteUser();
	String endHost = "" + request.getRemoteAddr();
	//String endScheme 	= ""+request.getScheme();
	//String endProto  	= ""+request.getProtocol();
	//String endPort   	= ""+request.getServerPort();
	//String endReader 	= ""+request.getReader();
	//String endEncoading 	= ""+response.getCharacterEncoding();
	//String endServerName 	= ""+request.getServerName();
	//String endServletPath 	= ""+request.getServletPath();
	//String endPathInfo 	= ""+request.getPathInfo();
	//String endSession 	= ""+request.getSession();
	String endGetId = "" + session.getId();
	//String endGeTimeAcess 	= ""+session.getLastAccessedTime();
	//String endGeMaxInterval = ""+session.getMaxInactiveInterval();

	java.util.Date dat_DataAtual = new java.util.Date();

	//out.println("conexao = "+conexao+" - dat_DataAtual = " + dat_DataAtual + " - usu_cod = " + usu_cod + " - endHost = " + endHost + " - endGetId = " + endGetId + " - teste = " + teste);  

	try {
		acesso.validaAcesso(conexao, dat_DataAtual, usu_cod, endHost,
				endGetId, session.getId());
	} catch (Exception ex) {
	}
	acesso = null;
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Menu Principal")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('art/ico_home_on.gif','art/ico_mensagens_on.gif','art/ico_batepapo_on.gif','art/ico_anotacoes_on.gif','art/ico_listadecursos_on.gif','art/ico_glossario_on.gif','art/ico_ajuda_on.gif','solicitacao/art/onenglish.gif','solicitacao/art/onespanol.gif')">
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
						<jsp:include page="menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="R" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="R" />
						</jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							String op = "";
							if (request.getParameter("op") == null) {
								op = "A";
							} else {
								op = request.getParameter("op");
							}
							String opt = "";
							if (request.getParameter("opt") == null) {
								opt = "";
							} else {
								opt = request.getParameter("opt");
							}
							if (ponto.equals("..")) {
						%>
						<jsp:include page="menu/menu.jsp?main=S&op=<%=op%>" flush="true"></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="menu/menu.jsp?main=S&op=<%=op%>" flush="true"></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
			<%
				if (!(opt.equals(""))) {
					if (ponto.equals("..")) {
			%>
			<jsp:include page="menu/menu1.jsp?main=S&opt=<%=opt%>" flush="true"></jsp:include>
			<%
				} else {
			%>
			<jsp:include page="menu/menu1.jsp?main=S&opt=<%=opt%>" flush="true"></jsp:include>
			<%
				}
			%>
			<%
				}
			%>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20"><img src="art/bit.gif" width="20" height="30"></td>
				<td width="100%" height="25">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="trontrk">&nbsp;</td>
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
			<!--        <tr> 
          <td valign="top"><img src="art/bit.gif" width="20" height="15"></td>
          <td valign="top"> <img src="art/bit.gif" width="159" height="1"><br>
          </td>
          <td valign="top"><img src="art/bit.gif" width="20" height="15"></td>
        </tr>-->


		</table>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="rodape/rodape_raiz.jsp" flush="true"></jsp:include>
				<%
					} else {
				%> <jsp:include page="rodape/rodape_raiz.jsp" flush="true"></jsp:include>
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