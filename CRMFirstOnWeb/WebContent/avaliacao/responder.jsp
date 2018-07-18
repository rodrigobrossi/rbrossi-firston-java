
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%@page
	import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>


<%
	//try{
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOParametersBean prm = (FOParametersBean) session
			.getAttribute("Param");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_codigo = (Integer) session.getAttribute("usu_codigo");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String query = "", opt_filtro = "", campo = "", filtro_q = "", query_grid = "";
	ResultSet rs = null, rsgrid = null;
	int sel = -1;

	java.util.Date dt_atual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

	String str_dt_atual = formato.format(dt_atual);

	if (request.getParameter("select2") != null) {
		opt_filtro = (String) request.getParameter("select2");

		//Select do Combo escolhido
		if (opt_filtro.equals("Avaliacao")) {
			query = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO ORDER BY AVA_DESCRICAO";
			campo = "A.AVA_CODIGO = ";
		}

		if (opt_filtro.equals("Curso")) {
			query = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO ORDER BY CUR_NOME";
			campo = "C.CUR_CODIGO = ";
		}

		if (opt_filtro.equals("Funcionario")) {
			query = "SELECT FUN_CODIGO, FUN_NOME FROM FUNCIONARIO ORDER BY FUN_NOME";
			campo = "F.FUN_CODIGO = ";
		}
	} else {
		opt_filtro = "Avaliacao";
		query = "SELECT AVA_CODIGO, AVA_DESCRICAO FROM AVALIACAO ORDER BY AVA_DESCRICAO";
		campo = "A.AVA_CODIGO = ";
	}

	//Monta a query do Grid
	if (!(request.getParameter("select") == null)) {
		if (!(opt_filtro.equals("Status"))) {
			if (!(request.getParameter("select").equals("Todos"))) {
				if (!(campo.equals(""))) {
					sel = Integer.parseInt(request
							.getParameter("select"));
					filtro_q = campo + request.getParameter("select")
							+ " ";
				} else {
					sel = Integer.parseInt(request
							.getParameter("select"));
					filtro_q = request.getParameter("select") + ") ";
				}
			} else {
				filtro_q = " 0=0 ";
			}
		} else {
			if (request.getParameter("select").equals("P")) { //AvaliaCAo Pendente
				filtro_q = "(AVD.AVD_STATUS IS NULL OR AVD.AVD_STATUS = 'N') "
						+ "AND P.PRO_FIM > DATEFMT("
						+ str_dt_atual
						+ ")";
			}
			if (request.getParameter("select").equals("V")) { //AvaliaCAo Vencida
				filtro_q = "(AVD.AVD_STATUS IS NULL OR AVD.AVD_STATUS = 'N') "
						+ "AND P.PRO_FIM <= DATEFMT("
						+ str_dt_atual
						+ ")";
			}
			if (request.getParameter("select").equals("R")) { // AvaliaCAo Respondida
				filtro_q = "AVD.AVD_STATUS='S'";
			}
			if ((request.getParameter("select").equals("Todos")))
				filtro_q = " 0=0 ";
		}
	}

	else {
		filtro_q = " 0=0 ";
	}

	query_grid = "SELECT F.FUN_CODIGO, F.FUN_NOME, AVD.PRO_CODIGO, P.PRO_ENVLAUDO, P.PRO_FIM, "
			+ "Q.AVA_CODIGO, A.AVA_DESCRICAO, AVD.AVD_STATUS, Q.QUE_NOME, P.PRO_CODIGO, T.CUR_CODIGO, "
			+ "C.CUR_NOME "
			+ "FROM AVALIADO AVD, PROCESSO P, QUESTIONARIO Q, AVALIACAO A, FUNCIONARIO F, TURMA T, CURSO C "
			+ "WHERE AVD.PRO_CODIGO = P.PRO_CODIGO "
			+ "AND F.FUN_CODIGO = AVD.FUN_CODIGO "
			+ "AND Q.QUE_CODIGO = P.QUE_CODIGO "
			+ "AND A.AVA_CODIGO = Q.AVA_CODIGO "
			+ "AND P.TUR_CODIGO = T.TUR_CODIGO "
			+ "AND T.CUR_CODIGO = C.CUR_CODIGO "
			+ "AND "
			+ filtro_q
			+ " ";
	if (!usu_tipo.equals("F"))
		query_grid = "AND F.FUN_CODIGO = " + usu_codigo.toString();
	query_grid = query_grid
			+ " ORDER BY F.FUN_NOME, C.CUR_NOME, A.AVA_DESCRICAO";
	rsgrid = conexao.executaConsulta(query_grid, session.getId());
	//out.println(query_grid);
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOParametersBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("RESPONDER")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra(){
  //document.frm.tipo.value = "F";
  frm.action ="avaliar.jsp";
  frm.submit();
  return false; 
}
function inclui(){
  alert("EM CONSTRUCAO");
  //document.frm.tipo.value = "I";
  //frm.action ="inclusaodequestionario.jsp";
  //frm.submit();
  //return false; 
}
function altera(){
  //document.frm.tipo.value = "U";
  alert("EM CONSTRUCAO");
  //frm.action ="inclusaodequestionario.jsp";
  //frm.submit();
  //return false; 
}
function exclui()
{
  alert("EM CONSTRUCAO");
  /*
  if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)){
    document.frm.tipo.value = "E";
    frm.action ="questionariograva.jsp";
    frm.submit();
    return false; 
  }
  else{
    return false;
  }*/
}
function Filtro()
{
  window.open("../avaliacao/responder.jsp?select2="+frm.select2.value,"_parent");
  return true;
}   
function envia()
{
  frm.action ="responder.jsp";
  frm.submit();
  return false;
}
</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<FORM name="frm" method="POST">
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
				<jsp:param value="op" name="RE" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="RE" />
			</jsp:include>
			<%
				}
			%>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" align="center"><%=trd.Traduz("RESPONDER")%></td>
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
						<td colspan="2" height="12"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td colspan="2" height="20" class="ctfontc" align="center"><%=trd.Traduz("OPCOES")%>:
						<select name="select2" class="form" onChange="return Filtro();">
							<option value="<%=opt_filtro%>"><%=trd.Traduz(opt_filtro)%></option>
							<%
								if (!(opt_filtro.equals("Avaliacao"))) {
							%>
							<option value="Avaliacao"><%=trd.Traduz("AVALIACAO")%></option>
							<%
								}
								if (!(opt_filtro.equals("Curso"))) {
							%>
							<option value="Curso"><%=trd.Traduz("CURSO")%></option>
							<%
								}
								if (!(opt_filtro.equals("Funcionario"))) {
							%>
							<option value="Funcionario"><%=trd.Traduz("FUNCIONARIO")%></option>
							<%
								}
								if (!(opt_filtro.equals("Status"))) {
							%>
							<option value="Status"><%=trd.Traduz("STATUS")%></option>
							<%
								}
							%>
						</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=trd.Traduz("FILTRO")%>:
						<select name="select">
							<option value="Todos">Todos</option>
							<%
								if (!(opt_filtro.equals("Status"))) {

									rs = conexao.executaConsulta(query, session.getId() + "RS_1");

									if (rs.next()) {
										do {
											if (sel == rs.getInt(1)) {
							%>
							<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
								}
										} while (rs.next());
									}
								} else {
									if (!(request.getParameter("select") == null)) {
										if (request.getParameter("select").equals("P")) {
							%>
							<option selected value="P"><%=trd.Traduz("Pendente")%></option>
							<option value="V"><%=trd.Traduz("Vencida")%></option>
							<option value="R"><%=trd.Traduz("Respondida")%></option>
							<%
								} else if (request.getParameter("select").equals("V")) {
							%>
							<option value="P"><%=trd.Traduz("Pendente")%></option>
							<option selected value="V"><%=trd.Traduz("Vencida")%></option>
							<option value="R"><%=trd.Traduz("Respondida")%></option>
							<%
								} else if (request.getParameter("select").equals("R")) {
							%>
							<option value="P"><%=trd.Traduz("Pendente")%></option>
							<option value="V"><%=trd.Traduz("Vencida")%></option>
							<option selected value="R"><%=trd.Traduz("Respondida")%></option>
							<%
								} else {
							%>
							<option value="P"><%=trd.Traduz("Pendente")%></option>
							<option value="V"><%=trd.Traduz("Vencida")%></option>
							<option value="R"><%=trd.Traduz("Respondida")%></option>
							<%
								}
									} else {
							%>
							<option value="P"><%=trd.Traduz("Pendente")%></option>
							<option value="V"><%=trd.Traduz("Vencida")%></option>
							<option value="R"><%=trd.Traduz("Respondida")%></option>
							<%
								}
								}
							%>
						</select></td>
					</tr>

					<tr>
						<td colspan="2" height="12"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>

					<tr>
						<td colspan="2" align="center"><input type="button"
							onClick="return envia();" value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%>
							class="botcin" name="button"></td>
					</tr>

					<tr>
						<td colspan="3">&nbsp;</td>
					</tr>
				</table>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>

			<tr>
				<td height="51" colspan="100%">
				<div align="center"><img src="../art/bit.gif" width="1"
					height="1">
				<table border="0" cellspacing="3" cellpadding="0" width="50%">
					<tr class="ctfontb">
						<td width="17"><img src="../art/black.gif" width="17"
							height="17"></td>
						<td>= <%=trd.Traduz("PENDENTE")%></td>
						<td width="17"><img src="../art/red.gif" width="17"
							height="17"></td>
						<td>= <%=trd.Traduz("VENCIDA")%></td>
						<td width="17"><img src="../art/green.gif" width="17"
							height="17"></td>
						<td>= <%=trd.Traduz("RESPONDIDA")%></td>
					</tr>
				</table>
				</div>
				</td>
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
						<td align="center">&nbsp;<br>
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="98%">
							<tr class="celtittab">
								<%
									java.util.Date hoje = new java.util.Date();
									String inicio = "", fim = "", cor = "", linka = "";

									if (rsgrid.next()) {
										if (prm.buscaparam("USE_CURSO").equals("S")) {
								%>
								<td width="30%"><%=trd.Traduz("FUNCIONARIO(S)")%></td>
								<td width="15%" align="center"><%=trd.Traduz("CURSO")%></td>
								<%
									} else {
								%>
								<td width="50%" colspan="2"><%=trd.Traduz("FUNCIONARIO(S)")%></td>
								<%
									}
								%>
								<td width="15%" align="center"><%=trd.Traduz("AVALIACAO")%></td>
								<td width="20%" align="center"><%=trd.Traduz("QUESTIONARIO")%></td>
								<td width="10%" align="center"><%=trd.Traduz("DATA ENVIO")%></td>
								<td width="10%" align="center"><%=trd.Traduz("DATA VENCIMENTO")%></td>
							</tr>
							<%
								do {
										java.util.Date data1 = rsgrid.getDate(4);
										java.util.Date data2 = rsgrid.getDate(5);
										inicio = formato.format(data1);
										fim = formato.format(data2);
										linka = "";

										if (rsgrid.getString(8) != null)
											linka = rsgrid.getString(8);

										if (hoje.after(data2))
											cor = "celnortabvv";
										else
											cor = "celnortab";
										if (linka.equals("S"))
											cor = "celnortabv";
							%>
							<tr class="celnortab">

								<%
									if (prm.buscaparam("USE_CURSO").equals("S")) {
								%>
								<td width="30%">
								<%
									if (!linka.equals("S")) {
								%> <a
									href="responder2.jsp?cod=<%=rsgrid.getString(6)%>&fun_cod=<%=rsgrid.getString(1)%>&pro_codigo=<%=rsgrid.getString(10)%> "
									class="lnk"><%=rsgrid.getString(2)%></a> <%
 	} else {
 %> <%=rsgrid.getString(2)%> <%
 	}
 %>
								</td>
								<td width="15%" class="<%=cor%>"><%=rsgrid.getString(12)%></td>
								<%
									} else {
								%>
								<td width="50%" colspan="2"><a
									href="responder1.jsp?cod=<%=rsgrid.getString(1)%>" class="lnk"><%=rsgrid.getString(2)%></a></td>
								<%
									}
								%>
								<td width="15%" class="<%=cor%>"><%=rsgrid.getString(7)%></td>
								<td width="20%" class="<%=cor%>"><%=rsgrid.getString(9)%></td>
								<td width="10%" class="<%=cor%>"><%=inicio%></td>
								<td width="10%" class="<%=cor%>"><%=fim%></td>
							</tr>
							<%
								} while (rsgrid.next());
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
				<input type="hidden" name="tipo"></td>


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
</FORM>
</body>
</html>
<%
	if (rsgrid != null) {
		rsgrid.close();
		conexao.finalizaConexao(session.getId());
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_1");
	}

%>