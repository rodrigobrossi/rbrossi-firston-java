
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*,java.util.*"%>


<%
    FODBConnectionBean conexaoEsperado = new FODBConnectionBean();

    FODBConnectionBean conexaoq = new FODBConnectionBean();

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	conexaoq.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));
	conexaoEsperado.realizaConexao((String) session
			.getAttribute("s_conexao"), (String) session
			.getAttribute("s_usubanco"), (String) session
			.getAttribute("s_senbanco"), (String) session
			.getAttribute("s_driverbanco"));

	//Declaracoes de variaveis e recuperacao de parametros
	String origem = (String) request.getParameter("origem"); //nome da pagina de origem

	String usu_tipo = (String) session.getAttribute("usu_tipo"); //tipo do usuario
	String usu_nome = (String) session.getAttribute("usu_nome"); //nome do usuario
	String usu_login = (String) session.getAttribute("usu_login"); //login do usuario
	Integer usu_fil = (Integer) session.getAttribute("usu_fil"); //
	Integer usu_idi = (Integer) session.getAttribute("usu_idi"); //

	ResultSet rs = null, rsq = null, rsEsperado = null;

	String usu_plano = "", resultadoEsperadoAtual = "", resultadoPrevisao = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano")); //

	String moeda = prm.buscaparam("MOEDA");

	String extra = ""; //Parametro para Solicitacao Extra (OBRIGATORIO)
	if ((request.getParameter("extra") != null))
		extra = request.getParameter("extra");

	String fun_codigo = ""; //Parametro quando funcionario for UNICO!!!
	if ((request.getParameter("fun_codigo") != null))
		fun_codigo = request.getParameter("fun_codigo");

	String ass = "-1";
	if (request.getParameter("selectass") != null)
		ass = request.getParameter("selectass"); //auxiliar combo Assunto

	String tit = "-1";
	if (request.getParameter("selecttit") != null)
		tit = request.getParameter("selecttit"); //auxiliar combo Titulo

	String cur = "-1";
	if (request.getParameter("selectcur") != null)
		cur = request.getParameter("selectcur"); //auxiliar combo Curso

	String query = ""; //variavel auxiliar de construcao de querys

	String curso = "";
	String n = "";
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page
	import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("SolicitaCAo")%> - <%=trd.Traduz("SolicitaCAo Extra")%></title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
<%!public String ReaistoStr(float valor, String moeda) {
		DecimalFormat dcf = new DecimalFormat("0.00");
		dcf.setMaximumFractionDigits(2);
		String strReais = dcf.format(valor);
		return moeda + strReais;
	}%>

<%!public String durhora(float valor) {
		int ho = 0;
		Float h;
		h = new Float(valor);
		;
		ho = h.intValue();
		ho = ho / 60;
		String hora = "";
		hora = hora.valueOf(ho);
		return hora;
	}%>

<%!public String durmin(float valor) {
		int mi = 0;
		Float m;
		m = new Float(valor);
		mi = m.intValue();
		mi = mi % 60;
		String min = "";
		if (mi < 10) {
			min = "0" + min.valueOf(mi);
		} else {
			min = min.valueOf(mi);
		}
		return min;
	}%>
</script>


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
									oi = "../menu/menu.jsp?op=" + "S";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "S&op=S";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt") + "&op=S";
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "S";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "S&op=S";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt")
											+ "&op=S";
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
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("ALTERACAO DA SOLICITACAO")%></td>
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
				<FORM name="frm" method="POST">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ftverdanacinza" align="center">
						<table cellspacing="2" cellpadding="2" width="80%">
							<tr>

								<!--////ASSUNTO//////////////////////////////////////////////////////////////////-->
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("ASSUNTO")%>:</td>
								<td colspan=3><select name="selectass" class="form"
									onChange="return assunto();">
									<%
										query = "SELECT ASS_CODIGO, ASS_NOME FROM ASSUNTO "
												+ "WHERE ASS_ATIVO = 'S' ORDER BY ASS_NOME";
										rs = conexao.executaConsulta(query);
										if (rs.next()) {
											do {
									%>
									<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
									<%
										} while (rs.next());
										}
									%>
								</select></td>
							</tr>
							<tr>
								<!--////TITUTLO//////////////////////////////////////////////////////////////////-->
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("TITULO")%>:</td>
								<td colspan=3><select name="selecttit" class="form"
									onChange="return titulo();">
									<%
										query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO "
												+ "WHERE TIT_ATIVO = 'S' AND ASS_CODIGO = -1 ORDER BY TIT_NOME";
									%>
									<option value="Selecione" selected><%=trd.Traduz("Selecione")%></option>
									<%
										rs = conexao.executaConsulta(query);
										if (rs.next()) {
											tit = rs.getString(1);
											do {
									%>
									<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
									<%
										} while (rs.next());
										}
									%>
								</select></td>
							</tr>
							<tr>
								<!--////CURSO////////////////////////////////////////////////////////////////////-->
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CURSO")%>:</td>
								<td colspan=3><select name="selectcur" class="form"
									onChange="return curso();">
									<%
										query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO "
												+ "WHERE CUR_ATIVO = 'S' AND TIT_CODIGO = " + tit + " "
												+ " AND CUR_SIMPLES = 'N' ORDER BY CUR_NOME";
									%>
									<option value="Selecione" selected><%=trd.Traduz("Selecione")%></option>
									<%
										rs = conexao.executaConsulta(query);
										if (rs.next()) {
											do {
												cur = rs.getString(1);
									%>
									<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
									<%
										} while (rs.next());
										}
									%>
								</select></td>
							</tr>
							<tr>
								<!--////TURMAS//////////////////////////////////////////////////////////////////-->
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("TURMAS")%>:</td>
								<td colspan=3><select name="selecttur">
									<%
										query = "SELECT  TUR_CODIGO, TUR_DATAINICIO, TUR_DATAFINAL "
												+ "FROM TURMA WHERE TUR_PLANEJADA = 'S' " + " "
												+ "AND (TUR_REGISTRADA = 'N' OR TUR_REGISTRADA = NULL) "
												+ "AND CUR_CODIGO = " + cur + " ORDER BY TUR_DATAINICIO";
										rs = conexao.executaConsulta(query);
										if (rs.next()) {
									%>
									<option value=""><%=trd.Traduz("Selecione")%></option>
									<%
										do {
									%>
									<option value="<%=rs.getInt(1)%>"><%=rs.getDate(2)%>&nbsp;|&nbsp;<%=rs.getDate(3)%></option>
									<%
										} while (rs.next());
										} else {
									%>
									<option value="-1"><%=trd.Traduz("Nenhuma")%></option>
									<%
										}
									%>
								</select></td>
							</tr>
							<tr>
								<td width="16%" class="ftverdanacinza" align="right">&nbsp;</td>
								<td colspan="2">&nbsp;<br>
								<%
									String queryRecuperaResult = "SELECT TEF_RESULTADOESPERADO,QBR_CODIGO FROM TREINAMENTO WHERE FUN_CODIGO="
											+ (String) request.getParameter("fun_cod_fun")
											+ " AND CUR_CODIGO=" + cur;
									//out.println(queryRecuperaResult);
									rsEsperado = conexaoEsperado.executaConsulta(queryRecuperaResult);

									if (rsEsperado.next()) {
										resultadoEsperadoAtual = rsEsperado.getString(1);
										resultadoPrevisao = ((rsEsperado.getString(2) == null) ? "N"
												: rsEsperado.getString(2));
									}
									//out.println("resultado"+resultadoEsperadoAtual);
								%> <!--////RESULTADOS ESCPERADOS////////////////////////////////////////////////////-->
								<span class="ftverdanapreto"> <%=trd.Traduz("RESULTADOS ESPERADOS")%>:</span><br>
								<textarea name="tf_result" rows="8" cols="45"><%=resultadoEsperadoAtual%></textarea>
								</td>
								<td width="30%">
								<table cellpadding="3" width="180" cellspacing="0">
									<tr>
										<td class="celtittabcin"><%=trd.Traduz("COMPETENCIAS BUSCADAS")%>:
										<p>
										<%
											query = "SELECT COMPETENCIA.CMP_CODIGO, COMPETENCIA.CMP_DESCRICAO "
													+ "FROM CURSOCOMP, COMPETENCIA "
													+ "WHERE CURSOCOMP.CMP_CODIGO = COMPETENCIA.CMP_CODIGO AND "
													+ "CURSOCOMP.CUR_CODIGO = " + cur + " "
													+ "ORDER BY COMPETENCIA.CMP_DESCRICAO";
											String comp = "";
											rs = conexao.executaConsulta(query);
											//out.println(query);
											int j = 1;
											if (rs.next()) {
												do {
													comp = rs.getString(1);
										%> <input
											type="checkbox" name="checkbox<%=j%>"
											value="<%=rs.getInt(1)%>" checked> <%=rs.getString(2)%><br>
										<%
											j++;
												} while (rs.next());
											}
										%>
										
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>

								<%
									query = "SELECT CUR_CODIGO, CUR_CUSTO, CUR_CUSTO2, CUR_DURACAO "
											+ "FROM CURSO WHERE CUR_CODIGO = " + cur + " ";
									rs = conexao.executaConsulta(query);
								%>
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CUSTO CURSO")%>:</td>
								<td width="27%" class="cttit">
								<%
									String Dur = "";
									String Cus1 = "", Cus2 = "";
									float Cust = 0;
									//out.println(query);
									if (rs.next()) {
										Dur = rs.getString(4);
										Cus1 = rs.getString(2);
										Cus2 = rs.getString(3);
										Cust = (rs.getFloat(2) + rs.getFloat(3));
								%> <%=ReaistoStr(rs.getFloat(2), moeda)%> <input type="hidden"
									name="cus1" value="<%=Cus1%>"> <input type="hidden"
									name="cus2" value="<%=Cus2%>"> <input type="hidden"
									name="dur" value="<%=Dur%>"> <input type="hidden"
									name="extra" value="<%=extra%>"> <input type="hidden"
									name="fun_codigo" value="<%=fun_codigo%>"></td>
								<%
									query = "SELECT QBR_CODIGO, QBR_NOME FROM QUEBRA "
												+ "WHERE PER_CODIGO IN "
												+ "(SELECT PER_CODIGO FROM PLANO WHERE PLA_CODIGO = "
												+ usu_plano + ") " + "ORDER BY QBR_ORDEM";
										rsq = conexaoq.executaConsulta(query);
								%>
								<!--////PREVISAO/////////////////////////////////////////////////////////////////-->
								<td width="27%" class="ftverdanacinza" align="right"><%=trd.Traduz("PREVISAO")%>:</td>
								<td width="30%"><select name="selectprev">
									<%
										if (resultadoPrevisao.equals("N")) {
									%>
									<option value="Selecione" selected><%=trd.Traduz("Selecione")%></option>
									<%
										} else {
									%>
									<option value="Selecione"><%=trd.Traduz("Selecione")%></option>
									<%
										}
									%>
									<%
										if (rsq.next()) {
												do {
									%>

									<%
										if (resultadoPrevisao.equals(rsq.getString(1))) {
									%>
									<option value="<%=rsq.getString(1)%>" selected><%=rsq.getString(2)%></option>
									<%
										} else {
									%>
									<option value="<%=rsq.getString(1)%>"><%=rsq.getString(2)%></option>
									<%
										}
									%>
									<%
										} while (rsq.next());
											}
									%>

								</select></td>
							</tr>
							<tr>
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CUSTO LOGISTICA")%>:</td>
								<td width="27%" class="cttit"><%=ReaistoStr(rs.getFloat(3), moeda)%>
								</td>
								<td width="27%" class="ftverdanacinza" align="right"><%=trd.Traduz("DURACAO")%>:</td>
								<td width="30%" class="cttit"><%=durhora(rs.getFloat(4))%>:<%=durmin(rs.getFloat(4))%>
								</td>
							</tr>
							<tr>
								<td width="16%" class="ftverdanacinza" align="right"><%=trd.Traduz("CUSTO TOTAL")%>:</td>
								<td width="27%" class="cttit"><%=ReaistoStr((rs.getFloat(2) + rs.getFloat(3)), moeda)%>
								</td>
								<%
									}

									if (origem.equals("result_filtro")) {
								%>
								<td colspan="2" class="ftverdanacinza" align="right"><input
									type="checkbox" name="checkboxcargo" value="checkbox">
								<%=trd.Traduz("SOLICITAR A TODOS DO MESMO CARGO")%> &nbsp;
								&nbsp;&nbsp;</td>
								<%
									}
								%>
							</tr>
							<tr>
								<td colspan="4" class="ftverdanacinza" align="center">&nbsp;<br>
								<input type="button" onClick="return envia();"
									value=<%=("\"" + trd.Traduz("CONFIRMAR") + "\"")%> class="botcin"
									name="button"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="15"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				</td>
				<input type="hidden" name="origem" value="<%=origem%>">
				<input type="hidden" name="func_codigo" value="<%=fun_codigo%>">
				<input type="hidden" name="reloaded" value="ok">
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
<!--<script language="JavaScript1.2" src="HM_Loader.js" type='text/JavaScript'></script>-->
</body>
</html>
<%
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();

	conexaoq.finalizaConexao();
	//conexaoq.finalizaBD();

	conexaoEsperado.finalizaConexao();
	//conexaoEsperado.finalizaBD();
%>