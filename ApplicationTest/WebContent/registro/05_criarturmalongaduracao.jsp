
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>


<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	FODBConnectionBean conexaoquebra = new FODBConnectionBean();

	conexaoquebra.realizaConexao((String) session
			.getAttribute("s_conexao"), (String) session
			.getAttribute("s_usubanco"), (String) session
			.getAttribute("s_senbanco"), (String) session
			.getAttribute("s_driverbanco"));

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_plano = (Integer) session.getAttribute("usu_plano");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs = null, rs_quebra = null;

	String query = "";

	Vector vet_desc = new Vector();
	Vector vet_cust = new Vector();
	vet_desc.clear();
	vet_cust.clear();
	request.getSession(true);
	session.setAttribute("vet_descS", vet_desc);
	session.setAttribute("vet_custS", vet_cust);

	int dur_hora = 0, dur_min = 0, duracao = 0, mes = 0, nivel = 0, tef_codigo = 0, trein = 0;

	float custo = 0, reembolso = 0;

	String historico = "";

	if (request.getParameter("tef_codigo") != null)
		tef_codigo = Integer.parseInt(request
				.getParameter("tef_codigo"));

	if (request.getParameter("textdurh") != null) {
		dur_hora = Integer.parseInt(request.getParameter("textdurh"));
		if (request.getParameter("textdurm") != null)
			dur_min = Integer
					.parseInt(request.getParameter("textdurm"));
		if (request.getParameter("textfield2") != null)
			custo = Float
					.parseFloat(request.getParameter("textfield2"));
		if (request.getParameter("textfield3") != null)
			reembolso = Float.parseFloat(request
					.getParameter("textfield3"));
		if (request.getParameter("textfield") != null)
			historico = request.getParameter("textfield");
		if (request.getParameter("selectprev") != null)
			mes = Integer.parseInt(request.getParameter("selectprev"));
		if (request.getParameter("selectniv") != null)
			nivel = Integer.parseInt(request.getParameter("selectniv"));

		duracao = (dur_hora * 60) + dur_min;

		query = "INSERT INTO LANCAMENTO "
				+ "(NID_CODIGO, IDI_CODIGO, LAN_MES, TEF_CODIGO, LAN_CUSTO, LAN_REEMBOLSO, LAN_HISTORICO, "
				+ "LAN_DURACAO) VALUES (" + nivel + ", " + usu_idi
				+ ", " + mes + ", " + tef_codigo + ", " + custo + ", "
				+ "" + reembolso + ", '" + historico + "', " + duracao
				+ ")";

		conexao.executaAlteracao(query);
	}

	String cur = "";
	if (!(request.getParameter("selectcur1") == null)) {
		cur = request.getParameter("selectcur1");
	} else {
		cur = "-1";
	}
%>
<script language="JavaScript">
function filtra(){
	frm.action ="05_criarturmalongaduracao.jsp";
	frm.submit();
	return false;	
	}
function exclui(){
	frm.action ="07_criacaodeturmadelongaduracao_deleta.jsp";
	frm.submit();
	return false;	
	}
function inclui(){
    document.frm.tipo.value = "I";
	frm.action ="07_criacaodeturmadelongaduracao.jsp";
	frm.submit();
	return false;	
}
function altera(){
    document.frm.tipo.value = "A";
	frm.action ="07_criacaodeturmadelongaduracao.jsp";
	frm.submit();
	return false;	
}
function registra(){
    document.frm.tipo.value = "A";
	frm.action ="10_turmaantecipada_reg.jsp";
	frm.submit();
	return false;	
}
</script>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page
	import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Criar Turma Longa DuraCAo")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
								value="opt" name="RG" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="RG" /></jsp:include>
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
									oi = "../menu/menu.jsp?op=" + "R";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "CTL";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt");
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "R";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "CTL";
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
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" align="center"><%=trd.Traduz("Criar Turma Longa DuraCAo")%></td>
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
				<FORM name="frm">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="2"><img src="../art/bit.gif" width="1" height="1"></td>
					</tr>
					<tr>
						<td height="56" class="ctfontc" align="center"><%=trd.Traduz("CURSO")%>:
						<select name="selectcur1">
							<option value="Selecione" selected><%=trd.Traduz("Todos")%></option>
							<%
								query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO "
										+ "WHERE CUR_ATIVO = 'S' AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME";
								rs = conexao.executaConsulta(query);
								if (rs.next()) {
									do {
										if (rs.getString(1).equals(cur)) {
							%>
							<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
							<%
								}
									} while (rs.next());
								}
							%>
						</select> &nbsp; &nbsp; <input type="button" onClick="return filtra();"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%> class="botcin"
							name="button"></td>
					</tr>
					<tr>
						<td class="ctvdiv" height="1"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td height="51">
						<div align="center"><img src="../art/bit.gif" width="1"
							height="1">

						<table border="0" cellspacing="3" cellpadding="0">
							<tr class="ctfontb">
								<td width="17"><img src="../art/black.gif" width="17"
									height="17"></td>
								<td width="160">= <%=trd.Traduz("TURMA PENDENTE")%></td>
								<td width="14"><img src="../art/green.gif" width="17"
									height="17"></td>
								<td width="160">=<%=trd.Traduz("TURMA REGISTRADA")%></td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<tr>
						<td class="ctvdiv" height="1"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td>&nbsp;<br>
						<center>
						<center>
						<table>
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return inclui()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("CRIAR TURMA")%></a></td>
									</tr>
								</table>
								</td>
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
								<td></td>
							</tr>
						</table>
						</center>
						</center>
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="48%">
								<table border="0" cellspacing="1" cellpadding="2" width="100%">
									<tr class="celtittab">
										<td width="3%" align="center">&nbsp;</td>
										<td width="20%"><%=trd.Traduz("CURSO")%></td>
										<td width="25%"><%=trd.Traduz("FUNCIONARIO")%></td>
									</tr>
									<%
										if (!(cur.equals("Selecione"))) {
											query = "SELECT TREINAMENTO.TEF_CODIGO, CURSO.CUR_NOME, FUNCIONARIO.FUN_NOME, TREINAMENTO.TUR_CODIGO_REAL FROM TREINAMENTO, CURSO, "
													+ " FUNCIONARIO WHERE TREINAMENTO.CUR_CODIGO = CURSO.CUR_CODIGO AND "
													+ " FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO AND "
													+ " TREINAMENTO.TTR_CODIGO = 3 "
													+ " AND TREINAMENTO.CUR_CODIGO = "
													+ cur
													+ " ORDER BY curso.CUR_NOME";
										} else {
											query = "SELECT TREINAMENTO.TEF_CODIGO, CURSO.CUR_NOME, FUNCIONARIO.FUN_NOME, TUR_CODIGO_REAL FROM TREINAMENTO, CURSO, "
													+ " FUNCIONARIO WHERE TREINAMENTO.CUR_CODIGO = CURSO.CUR_CODIGO AND "
													+ " FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO AND "
													+ " TREINAMENTO.TTR_CODIGO = 3 "
													+ " ORDER BY curso.CUR_NOME";
										}
										//out.println(query);
										int i;
										boolean check = false;
										i = 1;
										rs = conexao.executaConsulta(query);
										if (rs.next()) {
											do {
												i++;
									%>

									<%
										if (rs.getString(4) == null) {
									%>
									<tr class="celnortab">
										<%
											} else {
										%>
									
									<tr class="celnortabv">
										<%
											}

													trein = rs.getInt(1);

													query = "SELECT Q.QBR_CODIGO "
															+ "FROM QUEBRA Q, PLANO P "
															+ "WHERE Q.QBR_CODIGO NOT IN "
															+ "(SELECT LAN_MES FROM LANCAMENTO WHERE TEF_CODIGO = "
															+ trein + ") " + "AND P.PLA_CODIGO = " + usu_plano
															+ " " + "AND P.PER_CODIGO = Q.PER_CODIGO ";

													rs_quebra = conexaoquebra.executaConsulta(query);

													if (rs_quebra.next()) {
										%>
										<td width="3%" align="center">
										<%
											if (check == false) {
															check = true;
										%> <input type="radio" name="checkbox"
											checked value="<%=rs.getString(1)%>"> <%
 	} else {
 %> <input
											type="radio" name="checkbox" value="<%=rs.getString(1)%>">
										<%
											}
										%>
										</td>
										<td width="39%"><a class="lnk"
											href="09_criarlancamento.jsp?turma=<%=rs.getString(1)%>">
										<%=rs.getString(2)%> </a></td>
										<td width="12%"><%=rs.getString(3)%></td>
										<%
											} else {
										%>
										<td width="3%" align="center">&nbsp;</td>
										<td width="39%" class="celnortabv"><%=rs.getString(2)%></td>
										<td width="12%" class="celnortabv"><%=rs.getString(3)%></td>
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
						<br>
						&nbsp;</td>
					</tr>
				</table>
				</td>
				<input type="hidden" name="tipo">
				</FORM>
				<td width="20" valign="top"></td>
			</tr>
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

<%
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();

	conexaoquebra.finalizaConexao();
	//conexaoquebra.finalizaBD();
%>

</body>
</html>
