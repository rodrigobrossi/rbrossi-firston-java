<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.io.*,java.util.*,java.net.*,javax.servlet.*"%>

<jsp:useBean id="ace" scope="page"
	class="firston.eval.access.FOAccessBean" />
<jsp:useBean id="cmb" scope="page"
	class="firston.eval.components.FODynamicComboBean" />
<jsp:useBean id="eml" scope="page"
	class="firston.eval.components.FOEmaiBeanl" />
<jsp:useBean id="prm" scope="page"
	class="firston.eval.components.FOParametersBean" />
<jsp:useBean id="pos" scope="page"
	class="firston.eval.components.FOUserPositionBean" />
<jsp:useBean id="trd" scope="page"
	class="firston.eval.components.FOLocalizationBean" />

<%
	//*********************Recupera parâmetros de inicializacao do web.xml***********************
	ServletContext context = pageContext.getServletContext();
	String DRIVER_BD = context.getInitParameter("jdbcDriver");
	String DRIVERNAME = context.getInitParameter("driverName");
	String USERNAME = context.getInitParameter("userName");
	String PASSWORD = context.getInitParameter("password");
	String EMAIL_DE_SUPORTE = context.getInitParameter("emailSuporte");
	//*******************************************************************************************

	request.getSession(true);

	//declaracao de variaveis
	String query = "", webserver = "OK", componentes = "OK", aplicacao = "OK", banco = "OK", statusPag = "";
	ResultSet rs = null;
	int acesso = 0, online = 0;
	java.text.SimpleDateFormat sdf_data = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");
	java.util.Date dte_hoje = new java.util.Date();
	String hoje = sdf_data.format(dte_hoje);
	Vector funcvet = new Vector();

	URL url_endereco = new URL("http", "localhost", 8080, "login.jsp");
	URLConnection urc_enderecoconn = null;

	//teste de banco de dados
	FODBConnectionBean conexao = new FODBConnectionBean();
	conexao.getConection();

	try {

		//conexao.realizaConexao(DRIVERNAME, USERNAME, PASSWORD,DRIVER_BD);
		query = "SELECT PLA_CODIGO FROM PLANO ORDER BY PLA_DATAINICIO DESC";
		rs = conexao.executaConsulta(query, session.getId() + "RS1");
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS1");
		}
	} catch (Exception e) {
		banco = "FORA";
	}

	try {
		urc_enderecoconn = url_endereco.openConnection();
		urc_enderecoconn.connect();
		if (urc_enderecoconn.getContentType() != null) {
			webserver = "OK";
		}
	} catch (Exception e) {
		webserver = "FORA";
	}

	try {
		ServletConfig scf_aplicacao = getServletConfig();
		if (scf_aplicacao.getServletName() != null) {
			aplicacao = "OK";
		}
	} catch (Exception e) {
		aplicacao = "FORA";
	}

	//recarrega a pagina para exibir o status dos servicos
	statusPag = ((request.getParameter("status") == null) ? ""
			: (String) request.getParameter("status"));
	if (statusPag.equals("")) {
		if (banco.equals("OK") && webserver.equals("OK")
				&& componentes.equals("OK") && aplicacao.equals("OK")) {
			response.sendRedirect("monitor.jsp?status=OK");
		} else {
			response.sendRedirect("monitor.jsp?status=FORA");
			out.println("status:" + statusPag);
		}
	}
%>


<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>MONITOR DIDAXIS EM</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<script language="">
function detalhe1(){
	showModalDialog("alert1.jsp","","dialogWidth=600px;dialogHeight=400px");
}

function detalhe2(){
	showModalDialog("alert2.jsp","","dialogWidth=600px;dialogHeight=400px");
}

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
<body rightmargin="0" bottommargin="0" leftmargin="0" topmargin="0">
<table width="100%" height="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td height="15%" bgcolor="#005B7F"><!--CABECALHO-->
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="5%">
				<div align="right">&nbsp;&nbsp;</div>
				</td>
				<td width="45%"><img src="../art/Logo_Cliente_Banner.gif"
					width="334" height="36"></td>
				<td width="50%" valign="bottom">
				<div align="right">
				<table width="20%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="20" nowrap><a href="../login.jsp" class="hclinkb"><img
							src="../art/ico_home_on.gif" width="15" border="0" height="11">HOME</a></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<!--FIM CABECALHO--></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="100%" class="trontrk">
		<div align="center"><strong><font size="2">MONITOR
		DIDAXIS EM</font></strong></div>
		</td>
	</tr>
	<tr>
		<td><!--CORPO-->
		<table width="70%" border="0" bordercolor="#666666" align="center"
			cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<table width="100%" align="center" cellpadding="0" cellspacing="2">
					<tr>
						<td colspan="3" class="botver">
						<div align="center"><strong><font size="2">SERVIÇOS</font></strong></div>
						</td>
					</tr>
					<tr>
						<td width="51%">
						<div align="center"><font color="#666666" size="2"
							face="Verdana, Arial, Helvetica, sans-serif"><strong>Serviço</strong></font></div>
						</td>
						<td colspan="2">
						<div align="center"><font color="#666666" size="2"
							face="Verdana, Arial, Helvetica, sans-serif"><strong>Status</strong></font></div>
						</td>
					</tr>
					<tr class="celcin">
						<td>1 - Web Server</td>
						<td colspan="2" align="center"><%=webserver%></td>
					</tr>
					<tr class="celcin">
						<td>2 - Componentes</td>
						<td colspan="2" align="center"><%=componentes%></td>
					</tr>
					<tr class="celcin">
						<td>3 - Aplica&ccedil;&atilde;o</td>
						<td colspan="2" align="center"><%=aplicacao%></td>
					</tr>
					<tr class="celcin">
						<td>4 - Banco de Dados</td>
						<td colspan="2" align="center"><%=banco%></td>
					</tr>
					<tr class="celcin">
						<td>5 - Acessos</td>
						<%
							query = "SELECT A.FUN_CODIGO " + "FROM ACESSO A "
									+ "WHERE A.ACE_DATA >= CONVERT(datetime,'" + hoje
									+ "',103) " + "ORDER BY A.ACE_HORA DESC";

							rs = conexao.executaConsulta(query, session.getId() + "RS2");
							if (rs.next()) {
								do {
									if (rs.getString(1) != null
											&& !(funcvet.contains(rs.getString(1)))) {
										funcvet.addElement(rs.getString(1));
									}
								} while (rs.next());
							}

							if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId() + "RS2");
							}

							for (int i = 0; i < funcvet.size(); i++) {
								query = "SELECT A.FUN_CODIGO, F.FUN_NOME ,A.ACE_DATA, A.ACE_HORA, A.ACE_OPERACAO, A.ACE_SESSION, F.FUN_LOGIN "
										+ "FROM FUNCIONARIO F, ACESSO A "
										+ "WHERE A.FUN_CODIGO = "
										+ funcvet.elementAt(i)
										+ " "
										+ "AND A.FUN_CODIGO = F.FUN_CODIGO "
										+ "AND A.ACE_DATA >= CONVERT(datetime,'"
										+ hoje
										+ "',103) " + "ORDER BY A.ACE_HORA DESC";

								rs = conexao.executaConsulta(query, session.getId() + "RS3");
								if (rs.next()) {
									if (rs.getInt(5) == 0) {
										online++;
									}
								}
								if (rs != null) {
									rs.close();
									conexao.finalizaConexao(session.getId() + "RS3");
								}
							}

							query = "SELECT COUNT(A.FUN_CODIGO) " + "FROM ACESSO A "
									+ "WHERE A.ACE_DATA >= CONVERT(datetime,'" + hoje
									+ "',103) " + "AND A.ACE_OPERACAO = 0 ";

							if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId() + "RS3");
							}

							rs = conexao.executaConsulta(query, session.getId() + "RS4");
							if (rs.next()) {
								acesso = rs.getInt(1);
							}

							if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId() + "RS4");
							}
						%>
						<td width="24%" align="center"><!--<a href="#" onClick="return detalhe1();">-->Hoje<!--</a>-->
						= <%=acesso%></td>
						<td width="25%" align="center"><a href="#"
							onClick="return detalhe2();">Online</a> = <%=online%></td>
					</tr>
					<tr class="celcin">
						<td>6 - FirstOn EM</td>
						<td colspan="2" align="center">
						<%
							if (statusPag.equals("OK")) {
								out.println("OK");
							} else {
								out
										.println("<font color=\"red\"><strong><b>FORA</b></strong></font>");
							}
						%>
						</td>
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
				<td colspan="2">
				<table width="100%" align="center" cellpadding="0" cellspacing="2">
					<tr>
						<td colspan="4" class="botver" align="center"><strong><font
							size="2">SERVIDOR</font></strong></td>
					</tr>
					<tr>
						<td width="25%" align="center"><font color="#666666" size="2"
							face="Verdana, Arial, Helvetica, sans-serif"><strong>Versão
						JVM</strong></font></td>
						<td width="25%" align="center"><font color="#666666" size="2"
							face="Verdana, Arial, Helvetica, sans-serif"><strong>Vendor
						JVM</strong></font></td>
						<td width="25%" align="center"><font color="#666666" size="2"
							face="Verdana, Arial, Helvetica, sans-serif"><strong>SO</strong></font></td>
						<td width="25%" align="center"><font color="#666666" size="2"
							face="Verdana, Arial, Helvetica, sans-serif"><strong>Versão
						do SO</strong></font></td>
					</tr>
					<tr>
						<td class="celcin" align="center"><%=System.getProperty("java.runtime.version")%></td>
						<td class="celcin" align="center"><%=System.getProperty("java.vm.vendor")%></td>
						<td class="celcin" align="center"><%=System.getProperty("os.name")%></td>
						<td class="celcin" align="center"><%=System.getProperty("os.version")%></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<!--FIM CORPO--> <%
 	request.getSession(true);
 	session.setAttribute("funcvet", funcvet);
 %>
		</td>
	</tr>
	<!--RODAPE-->
	<tr>
		<td height="40" bgcolor="#F4F4F4">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td></td>
				<td nowrap class="difont"><b>DÚVIDAS?</b> ENTRE EM CONTATO
				COM:&nbsp;<a href="mailto:<%=EMAIL_DE_SUPORTE%>" class="dilink"><%=EMAIL_DE_SUPORTE%></a>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<!--FIM RODAPE-->
</table>
</body>