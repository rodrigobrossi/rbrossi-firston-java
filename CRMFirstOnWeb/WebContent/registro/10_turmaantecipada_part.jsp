
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>

<%
	//try{

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	FODBConnectionBean conexaoC = new FODBConnectionBean();
	FODBConnectionBean conexaoT = new FODBConnectionBean();

	conexaoC.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));
	conexaoT.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	String aplicacao = (String) session.getAttribute("aplicacao");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	int pag = Integer.parseInt((String) session.getAttribute("pagina"));

	ResultSet rs = null, rsgrid = null, rsc = null;

	String turma = request.getParameter("turma");
	boolean existe = false, mostraCheck = false;
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	//VariAveis para as Queryes
	String query = "", query_grid = "", query_c = "", loc = "", classe = "";
	String opt_filtro = "", campo = "", filtro_q = "";
	int sel = -1;

	opt_filtro = "Cargo";
	query = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO ORDER BY CAR_NOME";
	campo = "CAR_CODIGO = ";

	String par = "";

	if (usu_tipo.equals("F")) {
		par = "";
	} else {
		if (usu_tipo.equals("P") || usu_tipo.equals("G")) {
			par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil + " ";
		} else {
			if (usu_tipo.equals("S")) {
				par = " AND FUNCIONARIO.FIL_CODIGO = " + usu_fil
						+ " AND FUNCIONARIO.FUN_CODSOLIC = " + usu_cod
						+ " ";
			}
		}
	}

	query_grid = "SELECT FUNCIONARIO.FUN_CODIGO, FUNCIONARIO.FUN_CHAPA, FUNCIONARIO.FUN_NOME, "
			+ "CARGO.CAR_NOME, DEPTO.DEP_NOME, TABELA3.TB3_DESCRICAO, TABELA2.TB2_NOME, "
			+ "FILIAL.FIL_NOME, SOLICITANTE.FUN_NOME, FUNCIONARIO.FUN_DEMITIDO, FUNCIONARIO.FUN_TERCEIRO, TREINAMENTO.TEF_PLANEJADO "
			+ "FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL, TREINAMENTO "
			+ "WHERE FUNCIONARIO.FUN_CODSOLIC OUTER SOLICITANTE.FUN_CODIGO AND "
			+ "FUNCIONARIO.FUN_DEMITIDO = 'N' AND "
			+ "CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND "
			+ "DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND "
			+ "FUNCIONARIO.TB3_CODIGO OUTER TABELA3.TB3_CODIGO AND "
			+ "FUNCIONARIO.TB2_CODIGO OUTER TABELA2.TB2_CODIGO AND "
			+ "FUNCIONARIO.FIL_CODIGO OUTER FILIAL.FIL_CODIGO "
			+ par
			+ " AND "
			+ "FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO AND "
			+ "TREINAMENTO.TUR_CODIGO_PLAN_ANT = "
			+ turma
			+ " "
			+ "ORDER BY FUNCIONARIO.FUN_NOME";

	query_c = "SELECT COUNT(*) "
			+ "FROM FUNCIONARIO, FUNCIONARIO SOLICITANTE, CARGO, DEPTO, TABELA3, TABELA2, FILIAL, TREINAMENTO "
			+ "WHERE FUNCIONARIO.FUN_CODSOLIC OUTER SOLICITANTE.FUN_CODIGO AND "
			+ "FUNCIONARIO.FUN_DEMITIDO = 'N' AND "
			+ "CARGO.CAR_CODIGO = FUNCIONARIO.CAR_CODIGO AND "
			+ "DEPTO.DEP_CODIGO = FUNCIONARIO.DEP_CODIGO AND "
			+ "FUNCIONARIO.TB3_CODIGO OUTER TABELA3.TB3_CODIGO AND "
			+ "FUNCIONARIO.TB2_CODIGO OUTER TABELA2.TB2_CODIGO AND "
			+ "FUNCIONARIO.FIL_CODIGO OUTER FILIAL.FIL_CODIGO " + par
			+ " AND "
			+ "FUNCIONARIO.FUN_CODIGO = TREINAMENTO.FUN_CODIGO AND "
			+ "TREINAMENTO.TUR_CODIGO_PLAN_ANT = " + turma + " ";

	//ConexAo com o Banco pelo Statement para a PaginaCAo com suas variaveis
	String primeiro = "1";
	int ult = 0;
	int tot = 0;
	int irpag = 0;
	int irpagtot = 0;
	int pagatual = 0;
	int pagtotal = 0;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	Connection conn = DriverManager.getConnection((String) session
			.getAttribute("s_conexao"), (String) session
			.getAttribute("s_usubanco"), (String) session
			.getAttribute("s_senbanco"));

	Statement stmt = conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,
			ResultSet.CONCUR_UPDATABLE);
	rsgrid = stmt.executeQuery(query_grid);
	rsgrid.setFetchSize(pag);
	stmt.setFetchDirection(rs.FETCH_FORWARD);

	//VariAveis de controle de pAgina
	if (request.getParameter("p") != null) {
		primeiro = (String) request.getParameter("p");
	}

	int valor = Integer.parseInt(primeiro);
	int valorAnt = Integer.parseInt(primeiro) - pag;

	if (request.getParameter("i") != null) {
		if (Integer.parseInt(request.getParameter("i")) > 0) {
			irpag = Integer.parseInt(request.getParameter("i"));
			irpagtot = ((irpag * pag) - pag) + 1;
			primeiro = primeiro.valueOf(irpagtot);
			valor = Integer.parseInt(primeiro);
			valorAnt = Integer.parseInt(primeiro) - pag;
		}
	}

	//Para nAo tentar mover para a linha zero
	if (Integer.parseInt(primeiro) <= 0) {
		primeiro = "1";
	}

	//Move o Cursor para a PosiCAo
	if (primeiro.equals("1")) {
		rsgrid.absolute(Integer.parseInt(primeiro));
		rsgrid.previous();
	} else {
		rsgrid.absolute(Integer.parseInt(primeiro));
		rsgrid.previous();
	}

	//Para contar as linhas da query
	rsc = conexaoC.executaConsulta(query_c);
	//Calcula a Ultima pagina
	if (rsc.next()) {
		tot = rsc.getInt(1);
		ult = ((tot / pag) * pag) + 1;
		pagatual = (Integer.parseInt(primeiro) / pag) + 1;
		Math e = null;
		pagtotal = e.round((tot / pag) + 0.5f);
	}

	//Busca e Insere dados no vetor de funcionArios selecionados
	String n = "";
	Vector funcvet = new Vector();
	if (request.getParameter("apagavet") != null) {
		request.getSession();
		funcvet = (Vector) session.getAttribute("funcs");
		//insere os elementos no vetor
		for (int k = 0; k <= pag; k++) {
			if ((request.getParameter("checkbox" + n.valueOf(k)) != null)) {
				//out.println(request.getParameter("checkbox" + n.valueOf(k)));
				if (!(funcvet.contains(request.getParameter("checkbox"
						+ n.valueOf(k)))))
					funcvet.add(request.getParameter("checkbox"
							+ n.valueOf(k)));
			}
		}
	} else {
		funcvet.clear();
		//out.println("Apagou!");
	}

	//out.println("VecTam: " + funcvet.size());
	session.setAttribute("funcs", funcvet);
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page
	import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("PARTICIPANTES DA TURMA")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript"> 	
function ProximaPag(valor)
        {	
        document.frm.p.value = valor.value;
        document.frm.i.value = "-1";  
        frm.action ="10_turmaantecipada_part.jsp";
        frm.submit();
	    return false;
        }            
function AnteriorPag(valor)
        {	        
        document.frm.p.value = valor.value;
		document.frm.i.value = "-1";  
		frm.action ="10_turmaantecipada_part.jsp";
        frm.submit();
	    return false;
        }            
function PrimeiraPag()
        {
        document.frm.p.value = "1";
		document.frm.i.value = "-1";  
		frm.action ="10_turmaantecipada_part.jsp";
        frm.submit();
	    return false;
        }            
function envia()
	{
	document.frm.p.value = "1";
        document.frm.i.value = "-1";  
	frm.action ="10_turmaantecipada_part.jsp";
	frm.submit();
	return false;	
	}
function irpag()
{
	if(document.frm.textir.value == "")
	{
		alert(<%=("\"" + trd.Traduz("Digite o nUmero da pAgina") + "\"")%>);
		frm.textir.focus();
	}
	else if((document.frm.textir.value > <%=pagtotal%>) || (document.frm.textir.value < 1))
	{
		alert("NUmero da pAgina invAlido");
		frm.textir.focus();
	}
	else
	{
		document.frm.p.value = "1";
		document.frm.i.value = document.frm.textir.value;
		frm.action = "10_turmaantecipada_part.jsp";
		frm.submit();
		return false;
	}
}            
function irpag2()
{
	if(document.frm.textir2.value == "")
	{
		alert(<%=("\"" + trd.Traduz("Digite o nUmero da pAgina") + "\"")%>);
		frm.textir2.focus();
	}
	else if((document.frm.textir2.value > <%=pagtotal%>) || (document.frm.textir2.value < 1))
	{
		alert("NUmero da pAgina invAlido");
		frm.textir2.focus();
	}
	else
	{
		document.frm.p.value = "1";
		document.frm.i.value = document.frm.textir2.value;
		frm.action = "10_turmaantecipada_part.jsp";
		frm.submit();
		return false;
	}
} 

function incpart()
        {          
	document.frm.extra.value = "S";
	frm.action = "10_turmaantecipada_part_inc.jsp";
        frm.submit();
	return false;
        } 
function incpartpla()
        {          
	document.frm.extra.value = "S";
	frm.action = "10_turmaantecipada_part_incpla.jsp";
        frm.submit();
	return false;
        } 
function excpart()
        {          
	document.frm.extra.value = "S";
	frm.action = "10_turmaantecipada_part_del.jsp";
        frm.submit();
	return false;
        } 		
</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

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
									oia = "../menu/menu1.jsp?opt=CTA";
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
									oia = "/menu/menu1.jsp?opt=CTA";
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
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("PARTICIPANTES DA TURMA")%></td>
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
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<td>&nbsp;<br>
					<center>
					<%
						rs = conexao.executaConsulta(query);
						if (rs.next()) {
							/*Atribui valor para existe*/
							existe = true;
						}
						if (per.contains("REGISTRO - PARTICIPANTES TURMA ANT - MANUTENCAO")) {
							mostraCheck = true;
					%>
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<table border="1" cellspacing="0" cellpadding="1"
								bordercolor="#000000">
								<tr>
									<td onMouseOver="this.className='ctonlnk2';"
										OnClick="incpartpla()" width="190" height="22" align=center
										class="botver"><a href="#" onClick="return incpartpla();"
										class="txbotver"><%=trd.Traduz("INCLUIR PLANEJADOS")%></a></td>
								</tr>
							</table>
							</td>
							<td width="10">&nbsp;</td>
							<td>
							<table border="1" cellspacing="0" cellpadding="1"
								bordercolor="#000000">
								<tr>
									<td onMouseOver="this.className='ctonlnk2';"
										onClick="incpart();" width="190" height="22" align=center
										class="botver"><a href="#" onClick="return incpart();"
										class="txbotver"><%=trd.Traduz("INCLUIR NAO PLANEJADOS")%></a></td>
								</tr>
							</table>
							</td>
							<td width="10">&nbsp;</td>
							<td>
							<%
								if (existe) {
							%>
							<table border="1" cellspacing="0" cellpadding="1"
								bordercolor="#000000">
								<tr>
									<td onMouseOver="this.className='ctonlnk2';"
										OnClick="excpart()" width="190" height="22" align=center
										class="botver"><a href="#" onClick="return excpart();"
										class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
								</tr>
							</table>
							<%
								}
							%>
							</td>
						</tr>
					</table>
					<%
						}
					%>
					</center>

					<table border="0" cellspacing="1" cellpadding="0" width="100%">

						<tr align="center">
							<td class="ctfontc" colspan="9">&nbsp;</td>
						</tr>
						<tr>
							<td height="1" class="ctvdiv" colspan="9"><img
								src="../art/bit.gif" width="1" height="1"></td>
						</tr>
						<tr>
							<td height="12" colspan="9"><img src="../art/bit.gif"
								width="1" height="1"></td>
						</tr>
						<tr align="center">
							<td class="ctfontc" valign="middle" colspan="100%">* - <%=trd.Traduz("TERCEIRO")%>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="../art/black.gif" width="17"
								height="17"> = <%=trd.Traduz("PLANEJADOS")%>
							&nbsp;&nbsp;&nbsp;&nbsp;<img src="../art/red.gif" width="17"
								height="17"> = <%=trd.Traduz("NAO PLANEJADOS")%></td>
						</tr>
						<tr>
							<td height="12" colspan="9"><img src="../art/bit.gif"
								width="1" height="1"></td>
						</tr>
						<tr>
							<td height="1" class="ctvdiv" colspan="9"><img
								src="../art/bit.gif" width="1" height="1"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<%
							ResultSet rsTurma = null;
							String queryTurma = "SELECT C.CUR_NOME, T.TUR_DATAINICIO, T.TUR_DATAFINAL, T.TUR_VAGAS "
									+ "FROM TURMA T, CURSO C "
									+ "WHERE T.CUR_CODIGO = C.CUR_CODIGO AND T.TUR_CODIGO = "
									+ turma;
							rsTurma = conexaoT.executaConsulta(queryTurma);
							if (rsTurma.next()) {
								String dataf = "", datai = "";
								SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
								java.util.Date data1 = rsTurma.getDate(2);
								java.util.Date data2 = rsTurma.getDate(3);
								datai = formato.format(data1);
								dataf = formato.format(data2);
						%>
						<tr>
							<td colspan="100%" align="left" class="ftverdanacinza"><font
								size="1"><a href="06_criarturmaantecipada.jsp"
								class="lnk"> <%=trd.Traduz("Curso")%>: <%=rsTurma.getString(1)%>
							&nbsp; <%=trd.Traduz("Data inicial")%>:&nbsp;<%=datai%>
							&nbsp;-&nbsp; <%=trd.Traduz("Data final")%>:&nbsp;<%=dataf%>
							&nbsp;-&nbsp; <%=trd.Traduz("Vagas")%>:&nbsp;<%=rsTurma.getString(4)%>
							</a></font></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td width="4%" height="28">&nbsp;</td>
							<td width="4%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("CHAPA")%></div>
							</td>
							<td width="20%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("NOME")%></div>
							</td>
							<td width="12%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("CARGO")%></div>
							</td>
							<td width="12%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("FILIAL")%></div>
							</td>
							<td width="12%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("DEPARTAMENTO")%></div>
							</td>
							<%
								if (prm.buscaparam("USE_TB2").equals("S")) {
							%>
							<td width="12%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("TABELA2")%></div>
							</td>
							<%
								}
							%>
							<%
								if (prm.buscaparam("USE_TB3").equals("S")) {
							%>
							<td width="12%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("TABELA3")%></div>
							</td>
							<%
								}
							%>
							<td width="12%" class="celtittab" height="28">
							<div align="center"><%=trd.Traduz("SOLICITANTE")%></div>
							</td>
						</tr>
						<%
							//Faz o loop no nº de vezes da paginaCAo
							//out.println(query_grid);
							//if(existe){
							for (int i = 1; i <= pag; i++) {
								if (rsgrid.next()) {
									valor = valor + 1;
									if (rsgrid.getString(12) != null)
										if (rsgrid.getString(12).equals("S"))
											classe = "celnortab";//planejados
										else
											classe = "celnortabvv";//nao planejados
									else
										classe = "celnortab";//planejados
						%>
						<tr class="<%=classe%>">
							<td width="4%">
							<%
								if (mostraCheck) {
							%> <%
 	if (!funcvet.contains(rsgrid.getString(1))) {
 %>
							<input type="checkbox" name="checkbox<%=i%>"
								value="<%=rsgrid.getInt(1)%>"> <%
 	} else {
 %>
							<input type="checkbox" name="checkbox<%=i%>"
								value="<%=rsgrid.getInt(1)%>" checked> <%
 	funcvet.remove(rsgrid.getString(1));
 				}
 			} else {
 %>&nbsp;<%
 	}
 %>
							</td>
							<td width="4%">
							<div align="center"><%=rsgrid.getString(2)%></div>
							</td>
							<%
								if (rsgrid.getString(11).equals("S")) {
							%>
							<td width="20%">*<%=((rsgrid.getString(3) == null) ? "" : rsgrid
										.getString(3))%></td>
							<%
								} else {
							%>
							<td width="20%"><%=((rsgrid.getString(3) == null) ? "" : rsgrid
										.getString(3))%></td>
							<%
								}
							%>
							<td width="12%"><%=((rsgrid.getString(4) == null) ? "" : rsgrid
									.getString(4))%></td>
							<td width="12%"><%=((rsgrid.getString(8) == null) ? "" : rsgrid
									.getString(8))%></td>
							<td width="12%"><%=((rsgrid.getString(5) == null) ? "" : rsgrid
									.getString(5))%></td>
							<%
								if (prm.buscaparam("USE_TB2").equals("S")) {
							%>
							<td width="12%"><%=((rsgrid.getString(7) == null) ? "" : rsgrid
										.getString(7))%></td>
							<%
								}
							%>
							<%
								if (prm.buscaparam("USE_TB3").equals("S")) {
							%>
							<td width="12%"><%=((rsgrid.getString(6) == null) ? "" : rsgrid
										.getString(6))%></td>
							<%
								}
							%>
							<td width="12%"><%=((rsgrid.getString(9) == null) ? "" : rsgrid
									.getString(9))%></td>
						</tr>
						<%
							}
							}
							// }
						%>
					</table>

					</td>
					</tr>
					<tr>
						<td height="30" colspan="3">
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr>
								<td align="left" class="ctfontc" width="16%"><%=trd.Traduz("PAGINA")%>
								<b><%=pagatual%></b> <%=trd.Traduz("DE")%> <b><%=pagtotal%></b></td>
								<td align="right" class="ctfontc" width="16%"><%=trd.Traduz("Total de")%>
								<b><%=tot%></b> <%=trd.Traduz("PESSOAS")%></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td class="cthdivb" colspan="3" height="1"><img
							src="../art/bit.gif" width="1" height="1"></td>
					</tr>
					<tr>
						<td height="30" colspan="3" class="ctfundo">
						<table width="100%" border="0" cellspacing="0" cellpadding="9">
							<tr>
								<input type="hidden" name="p">
								<input type="hidden" name="i">
								<input type="hidden" name="extra">
								<input type="hidden" name="turma" value="<%=turma%>">

								<td class="ctfontc" width="17%"><a href="#"
									onClick="return PrimeiraPag();" class="ctoflnkb"><%=trd.Traduz("Primeira PAgina")%></a>
								</td>
								<%
									if (!primeiro.equals("1")) {
								%>
								<td class="ctfontc" width="17%"><a href="#"
									value="<%=valorAnt%>" onClick="return AnteriorPag(this);"
									class="ctoflnkb"><%=trd.Traduz("PAgina Anterior")%></a></td>
								<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%>
								<input type="text" name="textir2" size="3"> <input
									type="button" name="ir2" class="botcin"
									value="  <%=trd.Traduz("IR")%>  " onClick="return irpag2();">
								</a></td>
								<%
									} else {
								%>
								<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAgina Anterior")%></a></td>
								<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%>
								<input type="text" name="textir" size="3"> <input
									type="button" name="ir" class="botcin"
									value="  <%=trd.Traduz("IR")%>  " onClick="return irpag();">
								</a></td>
								<%
									}
									if (valor <= tot) {
								%>
								<td align="right" class="ctfontc" width="17%"><a href="#"
									value="<%=valor%>" onClick="return ProximaPag(this);"
									class="ctoflnkb"><%=trd.Traduz("PrOxima PAgina")%></a></td>
								<%
									} else {
								%>
								<td align="right" class="ctfontc" width="17%"><a><%=trd.Traduz("PrOxima PAgina")%></a></td>
								<%
									}
								%>
								<td align="right" class="ctfontc" width="16%"><a href="#"
									name="valor" value="<%=ult%>"
									onClick="return ProximaPag(this);" class="ctoflnkb"><%=trd.Traduz("Ultima PAgina")%></a></td>
							</tr>
						</table>
						</td>
					</tr>

				</table>
				</td>
				<input type="hidden" name="contador" value="<%=pag%>">
				<input type="hidden" name="origem" value="result_filtro">
				<input type="hidden" name="apagavet" value="N">
				<input type="hidden" name="turma" value="<%=turma%>">
				</FORM>
				<td width="20" valign="top"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
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
	if (conn != null)
		conn.close();

	conexao.finalizaConexao();

	conexaoC.finalizaConexao();
	//conexaoC.finalizaBD();

	conexaoT.finalizaConexao();
	//conexaoT.finalizaBD();

	//} catch (Exception e) {
	//  out.println(e);
	//}
%>