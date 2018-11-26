<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.text.*,java.util.*"%>
<jsp:useBean id="trd" scope="page" class="firston.eval.components.FOLocalizationBean" />

<%
	//try{

	//*******************************//
	//   DECLARACAO DAS VARIAVEIS    //
	//*******************************//
	Vector funcvet = new Vector();
	String query = "";
	ResultSet rs;
	java.text.SimpleDateFormat sdf_hora = new java.text.SimpleDateFormat(
			"hh:mm");
	java.text.SimpleDateFormat sdf_data = new java.text.SimpleDateFormat(
			"dd/MM/yyyy");
	java.util.Date dte_hoje = new java.util.Date();
	String hoje = sdf_data.format(dte_hoje);

	//*******************************//
	//   RECUPERA DADOS DA SESSAO    //
	//*******************************//
	request.getSession(true);
	funcvet = (Vector) session.getAttribute("funcvet");

	FODBConnectionBean conexao = new FODBConnectionBean();
	conexao.getConection();
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn</title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();'>
<table border="0" width="100%" cellspacing="1">
	<tr class="trontrk">
		<td height="10%" align="center"><b>FUNCIONÁRIO(S) ONLINE</b></td>
	</tr>
	<tr class="trontrk">
		<td>
		<hr>
		</td>
	</tr>

	<tr>
		<td align="center">
		<table border="1" cellspacing="1">
			<tr class="celtittab">
				<td>&nbsp;NOME DO FUNCIONARIO&nbsp;</td>
				<td>&nbsp;HORA DO ACESSO&nbsp;</td>
				<td>&nbsp;ENDEREÇO IP&nbsp;</td>

			</tr>
			<%
					for (int i = 0; i < funcvet.size(); i++) {
					query = "SELECT A.FUN_CODIGO, F.FUN_NOME ,A.ACE_DATA, A.ACE_HORA, A.ACE_OPERACAO, A.ACE_IP "
					+ "FROM FUNCIONARIO F, ACESSO A "
					+ "WHERE A.FUN_CODIGO = "
					+ funcvet.elementAt(i)
					+ " "
					+ "AND A.FUN_CODIGO = F.FUN_CODIGO "
					+ "AND A.ACE_DATA >= DATEFMT("
					+ hoje
					+ ") "
					+ "ORDER BY A.ACE_HORA DESC";

					rs = conexao.executaConsulta(query, session.getId() + "RS1");
					if (rs.next()) {
						if (rs.getInt(5) == 0) {
			%>
			<tr class="celnortab">
				<td>&nbsp;<%=rs.getString(2)%>&nbsp;</td>
				<td align="center"><%=sdf_hora.format(rs.getTime(4))%></td>
				<td align="center"><%=rs.getString(6)%></td>
			</tr>
			<%
					}
					}

					if (rs != null) {
						rs.close();
						conexao.finalizaConexao(session.getId() + "RS1");
					}

				}
			%>
		</table>
		</td>
	</tr>
	<tr class="trontrk">
		<td>&nbsp;</td>
	</tr>

	<tr class="ftverdanacinza">
		<td align="center" class="ftverdanacinza" height="10%"><input
			type="button" class="botcin" value="     FECHAR     " name="botao"
			onClick="JavaScript:window.close();"></td>
	</tr>
</table>
</body>
</html>

<%
	//} catch(Exception e){
	//out.println("ERRO:"+e);
	//}
%>