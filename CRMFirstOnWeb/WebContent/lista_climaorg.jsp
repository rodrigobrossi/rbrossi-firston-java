
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><html>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*"%>

<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>

<head>
<title><%=trd.Traduz("Clima Organizacional")%></title>
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
						<td width="20"><img src="art/bit.gif" width="20" height="48"></td>
						<td width="100%" valign="middle"><img border="0"
							src="art/VCP Novo Logo1_Color.jpg"></td>
						<td width="20"><img src="art/bit.gif" width="20" height="15"></td>
						<td align="right" valign="bottom"><!-- #BeginLibraryItem "/Library/headerbar.lbi" -->
						<table width="350" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="hcfont" align="right">&nbsp;</td>
								<td width="20"><img src="art/bit.gif" width="20"
									height="10"></td>
							</tr>
						</table>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td height="8" colspan="6"><img src="art/bit.gif" width="8"
									height="8"></td>
							</tr>
							<tr>
								<td height="20" nowrap>&nbsp;</td>
								<td width="10"><img src="art/bit.gif" width="13"
									height="10"></td>
								<td height="20" nowrap>&nbsp;</td>
								<td width="20"><img src="art/bit.gif" width="20"
									height="10"></td>
							</tr>
						</table>
						<!-- jspEndLibraryItem --></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="snfundo">&nbsp;</td>
			</tr>
		</table>

		<div align="center" valign="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td valign="top"><img src="art/bit.gif" width="20" height="15"></td>
				<td valign="top"><img src="art/bit.gif" width="159" height="1"><br>
				</td>
				<td valign="top"><img src="art/bit.gif" width="20" height="15"></td>
			</tr>
		</table>
		<table border="0" cellspacing="1" cellpadding="2" width="80%">
			<tr>
				<td align="center" colspan="5" width="60%">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="5">
				<div align="center" class="ftverdanacinza"><b><%=trd.Traduz("Lista de Processos")%></b></div>
				</td>
			</tr>

			<%
				ResultSet rs;
				java.util.Date d1 = new java.util.Date();
				SimpleDateFormat s1 = new SimpleDateFormat("dd/MM/yyyy");
				String dataHoje = s1.format(d1);
				String query = "SELECT PRO_CODIGO, PRO_NOME, PRO_INICIO, PRO_FIM, PRO_FIMPRG "
						+ "FROM PROCESSO "
						+ "WHERE PRO_TIPO = 'C' "
						+ "AND DATEFMT("
						+ dataHoje
						+ ") >=PRO_INICIO "
						+ "AND DATEFMT("
						+ dataHoje
						+ ") <=PRO_FIMPRG "
						+ "ORDER BY PRO_NOME";

				rs = conexao.executaConsulta(query);

				if (rs.next()) {
			%>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<tr class="celtittab">
				<td align="center" width="35%"><%=trd.Traduz("Processos")%></td>
				<td width="15%">
				<div align="center"><%=trd.Traduz("Data InIcio")%></div>
				</td>
				<td width="15%">
				<div align="center"><%=trd.Traduz("Data TErmino")%></div>
				</td>
			</tr>
			<%
				SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
					java.util.Date hoje = new java.util.Date();

					do {
						int pro_codigo = rs.getInt(1);
						String pro_nome = new String(rs.getString(2));

						java.util.Date data = rs.getDate(3);
						java.util.Date data2 = rs.getDate(4);
						java.util.Date data3 = rs.getDate(5);

						String hoje_prg_fim = formato.format(hoje);
						String prg_fim = formato.format(data3);
						String pro_fim = formato.format(data2);
						String pro_inicio = formato.format(data);

						//if(((hoje.compareTo(data3) <= 0) || hoje_prg_fim.equals(prg_fim)) && (hoje.compareTo(data) >= 0)) {
			%>
			<tr class="celnortab">
				<td width="35%"><a
					href="responder_questionario_climaorg.jsp?pro_codigo=<%=rs.getString(1)%>"
					class="ctoflnkc"><%=pro_nome%></a></td>
				<td width="15%" align="center"><%=pro_inicio%></td>
				<td width="15%" align="center"><%=pro_fim%></td>
			</tr>
			<%
				//}

					} while (rs.next());

				}

				else {
			%>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="5" align="center" class="ftverdanacinza">Nenhum
				processo encontrado!</td>
			</tr>
			<tr>
				<td colspan="5">&nbsp;</td>
			</tr>
			<%
				}

				conexao.finalizaConexao();
				if (rs != null)
					rs.close();
			%>

		</table>
		<br>
		<br>
		<form action="index.jsp">
		<center><input type="submit" value="  Voltar  "
			class="botcin"></center>
		</form>
		<p>&nbsp;</p>
		</div>
		</td>
	</tr>
	<tr>
		<td align="left" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><img src="art/bit.gif" width="20" height="10"></td>
						<td width="10" nowrap><img src="art/bit.gif" width="10"
							height="10"></td>
						<td nowrap class="difont"><b><%=trd.Traduz("DUvidas")%>?</b>
						<%=trd.Traduz("Entre em contato com")%>: <a
							href="mailto:contato@serinformatica.com.br?subject=D%FAvidas"
							class="dilink">contato@serinformatica.com.br</a></td>
					</tr>
				</table>
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>
</html>
