
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.lang.Math.*,java.util.*"%>

<jsp:useBean id="cmb" scope="page" class="firston.eval.components.FODynamicComboBean" />

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	
	FODBConnectionBean conexaoc = new FODBConnectionBean();
	FODBConnectionBean conexaocNP = new FODBConnectionBean();

	conexaoc.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));
	conexaocNP.realizaConexao((String) session
			.getAttribute("s_conexao"), (String) session
			.getAttribute("s_usubanco"), (String) session
			.getAttribute("s_senbanco"), (String) session
			.getAttribute("s_driverbanco"));

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	String aplicacao = (String) session.getAttribute("aplicacao");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Integer usu_codigo = (Integer) session.getAttribute("usu_cod");
	String usu_plano = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));

	int pag = Integer.parseInt((String) session.getAttribute("pagina"));
	ResultSet rs = null, rsgrid = null, rsgridNP = null, rsc = null, rscNP = null;

	Vector vet_desc = new Vector();
	Vector vet_cust = new Vector();
	vet_desc.clear();
	vet_cust.clear();
	session.setAttribute("vet_descS", vet_desc);
	session.setAttribute("vet_custS", vet_cust);

	//try {

	//Limpa INCNPTEMP do usuario
	if (request.getParameter("limpa") == null) {
		String query_limpa = "DELETE FROM INCNPTEMP WHERE INC_USU_CODIGO = "
		+ usu_codigo;
		conexao.executaAlteracao(query_limpa);
		//out.println("LIMPOU!!!");
	}

	String filial = "" + usu_fil;
	String codigo = "" + usu_codigo;
	String ter = "";

	//VariAveis para as Queryes
	String query = "", query_gridP = "", query_gridNP = "", query_cP = "", query_cNP = "", loc = "";
	String opt_filtro = "", campo = "", filtro_q = "";
	int sel = -1;

	String tit = "*";
	String cur = "*";
	boolean contem, bloquear = false;

	//Verifica Bloqueio de Funcionalidades
	query = "SELECT PLA_REGISTROTREINAMENTO FROM PLANO WHERE PLA_CODIGO = "
			+ usu_plano;
	rs = conexao.executaConsulta(query);
	if (rs.next()) {
		if (rs.getString(1) != null) {
			if (rs.getString(1).equals("N"))
		bloquear = true;
		}
	}

	if (request.getParameter("textnome") != null) {
		opt_filtro = (String) request.getParameter("textnome");
	} else {
		opt_filtro = "-1";
	}

	//Pegar parametros
	query = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME "
			+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO ";
	//Select do Filtro escolhido
	if (request.getParameter("selectcur") != null) {
		if (!(request.getParameter("selectcur").equals(""))) {
			query = query + "AND T.CUR_CODIGO = "
			+ request.getParameter("selectcur") + " ";
		} else {
			query = query + "AND T.CUR_CODIGO = C.CUR_CODIGO ";
		}
	} else {
		query = query + "AND T.CUR_CODIGO = C.CUR_CODIGO ";
	}
	rs = conexao.executaConsulta(query);

	String par = "";
	if (usu_tipo.equals("F")) {
		par = "";
	} else {
		if (usu_tipo.equals("P") || usu_tipo.equals("G")) {
			par = " AND F.FIL_CODIGO = " + usu_fil + " ";
		} else {
			if (usu_tipo.equals("S")) {
		par = " AND F.FIL_CODIGO = " + usu_fil
				+ " AND F.FUN_CODSOLIC = " + usu_codigo + " ";
			}
		}
	}

	//Querys do grid de Treinamentos Planejados
	if (request.getParameter("selectcur") != null) {
		if (!(request.getParameter("selectcur").equals(""))) {
			query_gridP = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, F.FUN_TERCEIRO "
			+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND "
			+ "T.CUR_CODIGO = C.CUR_CODIGO AND (T.TUR_CODIGO_REAL IS NULL) "
			+ "AND (T.TUR_CODIGO_PLAN_ANT IS NULL)  AND (T.JUS_CODIGO IS NULL)  "
			+ par + " ";
			//Select do Filtro escolhido
			query_gridP = query_gridP + "AND T.CUR_CODIGO = "
			+ request.getParameter("selectcur") + " ";
			if (!(opt_filtro.equals("-1"))) {
		query_gridP = query_gridP + " AND F.FUN_NOME >= '"
				+ opt_filtro + "%'";
			}
		} else {
			query_gridP = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, F.FUN_TERCEIRO "
			+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND "
			+ "T.CUR_CODIGO = C.CUR_CODIGO AND (T.TUR_CODIGO_REAL IS NULL) "
			+ "AND (T.TUR_CODIGO_PLAN_ANT IS NULL)  AND (T.JUS_CODIGO IS NULL)  "
			+ par + " AND T.CUR_CODIGO = -1 ";
		}
	} else {
		query_gridP = "SELECT T.TEF_CODIGO, F.FUN_CHAPA, F.FUN_NOME, C.CUR_NOME, F.FUN_TERCEIRO "
		+ "FROM TREINAMENTO T, FUNCIONARIO F, CURSO C "
		+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND "
		+ "T.CUR_CODIGO = C.CUR_CODIGO AND (T.TUR_CODIGO_REAL IS NULL) "
		+ "AND (T.TUR_CODIGO_PLAN_ANT IS NULL)  AND (T.JUS_CODIGO IS NULL)  "
		+ par + " AND T.CUR_CODIGO = -1 ";
	}

	//out.println(query_gridP);
	//out.println("Filtro: " + request.getParameter("filtro") + " -- Cur: " + request.getParameter("selectcur"));
	query_cP = "SELECT COUNT(*) "
			+ query_gridP.substring(62, query_gridP.length()) + " "
			+ par + " ";
	/*"FROM TREINAMENTO T, FUNCIONARIO F, CURSO C " + 
	  "WHERE T.FUN_CODIGO = F.FUN_CODIGO AND T.CUR_CODIGO = C.CUR_CODIGO";*/

	//Querys do grid de Treinamentos Nao Planejados
	query_gridNP = "SELECT T.FUN_CODIGO, F.FUN_CHAPA, F.FUN_NOME, F.FUN_TERCEIRO "
			+ "FROM FUNCIONARIO F, INCNPTEMP T "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO "
			+ "AND T.INC_USU_CODIGO = "
			+ usu_codigo
			+ " "
			+ "AND F.FUN_DEMITIDO = 'N' " + "ORDER BY F.FUN_NOME";
	query_cNP = "SELECT COUNT(*) FROM FUNCIONARIO F, INCNPTEMP T "
			+ "WHERE T.FUN_CODIGO = F.FUN_CODIGO "
			+ "AND T.INC_USU_CODIGO = " + usu_codigo + " ";

	//ConecCAo com o Banco pelo Statement para a PaginaCAo com suas variaveis
	String primeiro = "1";
	int ult = 0;
	int tot = 0;
	int irpag = 0;
	int irpagtot = 0;
	int pagatual = 0;
	int pagtotal = 0;
	boolean existe = false, existe2 = false;
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	Connection conn = DriverManager.getConnection((String) session
			.getAttribute("s_conexao"), (String) session
			.getAttribute("s_usubanco"), (String) session
			.getAttribute("s_senbanco"));

	Statement stmt = conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,
			ResultSet.CONCUR_UPDATABLE);

	Statement stmtNP = conn.createStatement(
			ResultSet.TYPE_SCROLL_INSENSITIVE,
			ResultSet.CONCUR_UPDATABLE);

	rsgrid = stmt.executeQuery(query_gridP);
	rsgrid.setFetchSize(pag);
	stmt.setFetchDirection(rs.FETCH_FORWARD);
	rsc = conexaoc.executaConsulta(query_cP);
	if (rsgrid.next()) {
		existe = true;
	}

	rsgridNP = stmtNP.executeQuery(query_gridNP);
	rsgridNP.setFetchSize(pag);
	stmtNP.setFetchDirection(rs.FETCH_FORWARD);
	rscNP = conexaocNP.executaConsulta(query_cNP);
	if (rsgridNP.next()) {
		existe2 = true;
	}

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

	//out.println(query_gridP + " -- " + query_gridNP);

	//Move o Cursor para a PosiCAo
	if (primeiro.equals("1")) {
		rsgrid.absolute(Integer.parseInt(primeiro));
		rsgrid.previous();
		rsgridNP.absolute(Integer.parseInt(primeiro));
		rsgridNP.previous();
	} else {
		rsgrid.absolute(Integer.parseInt(primeiro));
		rsgrid.previous();
		rsgridNP.absolute(Integer.parseInt(primeiro));
		rsgridNP.previous();
	}

	//Calcula a Ultima pagina
	if (rsc.next() && rscNP.next()) {
		if ((rsc.getInt(1)) >= (rscNP.getInt(1))) {
			tot = rsc.getInt(1);
		} else {
			tot = rscNP.getInt(1);
		}
		ult = ((tot / pag) * pag) + 1;
		pagatual = (Integer.parseInt(primeiro) / pag) + 1;
		Math e = null;
		pagtotal = e.round((tot / pag) + 0.5f);
		if ((tot % pag) == 0)
			pagtotal--;//evita erros no numero de paginas
	}

	//Busca e Insere dados no vetor de Treinamentos Planejados
	String n = "";
	Vector funcvet = new Vector();
	if (session.getAttribute("funcs") != null)
		funcvet = (Vector) session.getAttribute("funcs");
	//out.println("Session: " + funcvet.size());

	//insere os elementos no vetor
	for (int k = 1; k <= pag; k++) {
		if ((request.getParameter("chktreiplan" + n.valueOf(k)) != null)) {
			if (!(funcvet.contains(request.getParameter("chktreiplan"
			+ n.valueOf(k)))))
		funcvet.add(request.getParameter("chktreiplan"
				+ n.valueOf(k)));
		}
	}

	//out.println("VecTam: " + funcvet.size());
	session.setAttribute("funcs", funcvet);
	//funcvet.clear();
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Lista de PresenCa")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function FormataCampo1(campo, evento, direcao){
	if (campo.value.length < 1000000){
		if(evento != 9 ){//tab
			if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
				var tam = campo.value.length
				if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)){
					if (tam == 2 || tam == 5){
						campo.value = campo.value + "";
					}
				}
				else{
					if (direcao == "up"){
						if (campo.value.length == 0){
							campo.value = ""
						}
						else{
							campo.value = "";//campo.value.substring(0,campo.value.length-1)
						}
					}
				}
				campo.focus()
			}
		} 
		else{
			if (direcao == "down"){
				var teste = campo.value.substring(0,1);
				if(campo.value<0){
					alert(<%=("\""+trd.Traduz("Este campo nAo aceita valores negativos !")+"\"")%>);
					campo.value="";
					campo.focus();
					return false;
				}
				else if(teste=="+"||teste=="~"||teste=="^"||
					teste=="\""||teste=="'"||teste=="!"||teste=="@"||
					teste=="#"||teste=="$"||teste=="%"||teste=="¨"||
					teste=="&"||teste=="*"||teste=="("||teste==")"||
					teste=="_"||teste=="="||teste=="~"||teste=="`"||
					teste=="´"||teste=="{"||teste=="["||teste=="}"||
					teste=="]"||teste=="<"||
					teste==">"||teste==":"||teste==";"||teste=="/"||
					teste=="?"||teste=="|"||teste=="\\"||teste=="^"){
					alert(<%=("\""+trd.Traduz("Este campo nAo aceita caracteres especiais !")+"\"")%>);
					campo.value="";
					campo.focus();
					return false;
				}
			}
		}
	}
}
function Filtro() {
        document.frm.p.value = "1";
	    document.frm.i.value = "-1";
        frm.action = "01_registrolistadepresenca.jsp";
        frm.submit();
        return false; 
        }
function ProximaPag(valor) {	
        document.frm.p.value = valor.value;
        document.frm.i.value = "-1";  
	frm.action ="01_registrolistadepresenca.jsp";
        frm.submit();
        return false;
        }            
function AnteriorPag(valor) {	        
        document.frm.p.value = valor.value;
	document.frm.i.value = "-1";  
	frm.action ="01_registrolistadepresenca.jsp";
        frm.submit();
        return false;
        }            
function PrimeiraPag() {
        document.frm.p.value = "1";
	document.frm.i.value = "-1";  
	frm.action ="01_registrolistadepresenca.jsp";
        frm.submit();
        return false;
        }            
function envia() {
	document.frm.p.value = <%=primeiro%>;
        document.frm.i.value = "-1";  
	frm.action ="01_registrolistadepresenca.jsp";
	frm.submit();
	return false;	
	}
function irpag()
{
	if((document.frm.textir.value <= document.frm.pagtotal.value) && (document.frm.textir.value > 0) && (document.frm.textir.value != ""))
	{
	        document.frm.p.value = "1";
	        document.frm.i.value = document.frm.textir.value;
		frm.action ="01_registrolistadepresenca.jsp";
	        frm.submit();
		return false;
	}
	else
	{
		alert(<%=("\""+trd.Traduz("PAGINA INVALIDA")+"\"")%>);
		document.frm.textir.value = "";
		return false;
        }            
}
function irpag2()
{
	if((document.frm.textir2.value <= document.frm.pagtotal.value) && (document.frm.textir2.value > 0) && (document.frm.textir2.value != ""))
	{
		document.frm.p.value = "1";
		document.frm.i.value = document.frm.textir2.value;
		frm.action ="01_registrolistadepresenca.jsp";
		frm.submit();
		return false;
	}
	else
	{
		alert(<%=("\""+trd.Traduz("PAGINA INVALIDA")+"\"")%>);
		document.frm.textir2.value = "";
		return false;
	}
} 
function incluir() {          
	frm.action = "02_registrarlistadepresenca.jsp";
    frm.submit();
    return false;
} 

function incluirNP() {          
	if ((frm.cbonome.value == "") && (frm.txtchapa.value == "")) {
		alert(<%=("\""+trd.Traduz("Favor preencher Nome ou Chapa!")+"\"")%>);
		return true;
	}
	if ((frm.cbonome.value != "") && (frm.txtchapa.value != "")) {
		alert(<%=("\""+trd.Traduz("Favor preencher Nome ou Chapa!")+"\"")%>);
		return true;
	}
	frm.action = "01_registrolistadepresenca_grava_np.jsp";
	frm.submit();
	return false;
} 

function aspa(campo){
	aux = campo.value;
	tam = aux.length
	aux2 = aux.substring(tam-1,tam);
	if(aux2 == "\"" || aux2 == "\'"){
		aux = campo.value;
		aux = aux.length;
		aux = aux - 1;
		pal = campo.value;
		campo.value = pal.substring(0, aux);
	}
}

function aspa2(campo){
	aux = campo.value;
	tam = aux.length;
	i = 0;
	nova = "";
	while(i != tam){
		aux2 = aux.substring(i,i+1);
		if(aux2 == "\"" || aux2 == "\'")
			nova = nova;
		else
			nova = nova + aux2;
		i++;
		
	}
	campo.value = nova;
}

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<FORM name="frm">
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
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
						<%
						} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="RG"/></jsp:include> 
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
									oia = "../menu/menu1.jsp?opt=" + "RL";
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
									oia = "/menu/menu1.jsp?opt=" + "RL";
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
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("Lista de PresenCa")%></td>
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
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center">&nbsp;<%=trd.Traduz("LOCALIZAR POR FUNCIONARIO")%>:
						<%
						if (opt_filtro.equals("-1")) {
						%> <input type="text"
							name="textnome" onKeyUp="aspa(this)" onBlur="aspa2(this)">
						<%
						} else {
						%> <input type="text" name="textnome"
							onKeyUp="aspa(this)" onBlur="aspa2(this)" value="<%=opt_filtro%>">
						<%
						}
						%> &nbsp; &nbsp; <%=trd.Traduz("CURSO")%>: <select
							name="selectcur" class="form">
							<option value="" selected><%=trd.Traduz("Selecione")%></option>
							<%
								String queryt = "";
								queryt = "SELECT CUR_CODIGO, CUR_NOME FROM CURSO "
										+ "WHERE CUR_ATIVO = 'S' " + "ORDER BY CUR_NOME";
								rs = conexao.executaConsulta(queryt);
								if (rs.next()) {
									cur = (request.getParameter("selectcur") == null) ? ""
									: request.getParameter("selectcur");
									do {
										if (cur.equals(rs.getString(1))) {
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
							%>
						</select> &nbsp; &nbsp; <input type="button" onClick="return Filtro();"
							value=<%=("\""+trd.Traduz("FILTRAR")+"\"")%> class="botcin" name="button">
						</td>
					</tr>

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
						<td class="ctfontc" valign="middle" colspan="9"><font
							size="1">* - <%=trd.Traduz("TERCEIRO")%></font></td>
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
					<tr>
						<td>
						<%
						if (bloquear == false) {
						%>
						<center>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											OnClick="return incluir();" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("REGISTRAR")%></a></td>
									</tr>
								</table>
								</td>
								<td width="10">&nbsp;</td>
							</tr>
						</table>
						</center>
						<%
						}//if(bloquear == false)
						%> <br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td width="48%">
								<table border="0" cellspacing="1" cellpadding="2" width="100%">
									<tr class="celtittabcin">
										<td colspan="100%" align="center"><%=trd.Traduz("Treinamentos Planejados")%></td>
									</tr>
									<tr class="celtittab">
										<%
										if (existe) {
										%>
										<td width="7%" align="center">&nbsp;</td>
										<td width="25%"><%=trd.Traduz("CHAPA")%></td>
										<td width="31%"><%=trd.Traduz("NOME")%></td>
										<td width="37%"><%=trd.Traduz("CURSO")%></td>
										<%
										} else {
										%>
										<td colspan="100%" class="celtittab" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
										<%
										}
										%>
									</tr>
									<%
										//Faz o loop no nº de vezes da paginaCAo
										int x;
										for (int i = 1; i <= pag; i++) {
											valor = valor + 1;
											if (rsgrid.next()) {
									%>
									<tr class="celnortab">
										<td width="7%" align="center">
										<%
												if (bloquear == false) {
												if (!funcvet.contains(rsgrid.getString(1))) {
										%>
										<input type="checkbox" name="chktreiplan<%=i%>"
											value="<%=rsgrid.getString(1)%>"> <%
 } else {
 %>
										<input type="checkbox" name="chktreiplan<%=i%>"
											value="<%=rsgrid.getString(1)%>" checked> <%
 		funcvet.remove(rsgrid.getString(1));
 		}
 			}//if(bloquear == false)

 			else
 %> &nbsp;</td>
										<td width="25%"><%=((rsgrid.getString(2) == null) ? "" : rsgrid
										.getString(2))%></td>
										<%
													ter = "";
													if (rsgrid.getString(5).equals("S"))
												ter = "*";
										%>
										<td width="31%"><%=ter%> <%=((rsgrid.getString(3) == null) ? "" : rsgrid
									.getString(3))%></td>
										<td width="37%"><%=((rsgrid.getString(4) == null) ? "" : rsgrid
									.getString(4))%></td>
									</tr>
									<%
										}
										}
									%>
								</table>
								</td>
								<td width="4%">&nbsp;</td>
								<td width="48%">
								<table border="0" cellspacing="1" cellpadding="2" width="100%">
									<tr class="celtittabcin">
										<td colspan="2" align="center"><%=trd.Traduz("TREINAMENTOS NAO PLANEJADOS")%></td>
									</tr>
									<tr class="celtittabcin">
										<td colspan="2"><%=trd.Traduz("NOME")%>:&nbsp; <select
											name="cbonome">
											<option value="" selected></option>
											<%
													if (usu_tipo.equals("F"))
													query = cmb
													.montaCombo("Funcionario", "null", "null", aplicacao);
												if (usu_tipo.equals("P") || usu_tipo.equals("G"))
													query = cmb
													.montaCombo("Funcionario", filial, "null", aplicacao);
												if (usu_tipo.equals("S"))
													query = cmb
													.montaCombo("Funcionario", filial, codigo, aplicacao);
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
									<tr class="celtittabcin">
										<td colspan="2"><%=trd.Traduz("CHAPA")%>: <input
											type="text" name="txtchapa" size="15" onKeyUp="aspa(this)"
											onBlur="aspa2(this)"> <%
 if (bloquear == false) {
 %> <input
											type="button" onClick="return incluirNP();"
											value=<%=("\""+trd.Traduz("INCLUIR")+"\"")%> class="botcin"
											name="button"> <%
 }
 %>
										</td>
									</tr>
									<tr class="celtittab">
										<%
										if (existe2) {
										%>
										<td width="30%"><%=trd.Traduz("CHAPA")%></td>
										<td width="70%"><%=trd.Traduz("NOME")%></td>
										<%
										} else {
										%>
										<td colspan="100%" align="center"><%=trd.Traduz("NENHUM REGISTRO INSERIDO")%>...</td>
										<%
										}
										%>
									</tr>
									<%
											for (int i = 1; i <= (pag); i++) {
											if (rsgridNP.next()) {
									%>
									<tr class="celnortab">
										<td width="30%"><%=((rsgridNP.getString(2) == null) ? "" : rsgridNP
									.getString(2))%></td>
										<td width="70%"><%=((rsgridNP.getString(3) == null) ? "" : rsgridNP
									.getString(3))%></td>
									</tr>
									<%
										}
										}
									%>
								</table>
								</td>
							</tr>
						</table>
					<tr>
						<td height="30" colspan="3">
						<table width="100%" border="0" cellspacing="0" cellpadding="5">
							<tr>
								<td align="left" class="ctfontc" width="16%"><%=trd.Traduz("PAGINA")%>
								<b><%=pagatual%></b> <%=trd.Traduz("DE")%> <b><%=pagtotal%></b></td>
								<td align="right" class="ctfontc" width="16%"><%=trd.Traduz("Total de")%>
								<b><%=tot%></b> <%=trd.Traduz("PESSOAS")%></td>
								<input type="hidden" name="pagtotal" value="<%=pagtotal%>">
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
								<input type="hidden" name="limpa" value="N">
								<td class="ctfontc" width="17%"><a href="#"
									onClick="PrimeiraPag();" class="ctoflnkb"><%=trd.Traduz("Primeira PAgina")%></a></td>
								<%
								if (pagatual > 1) {
								%>
								<td class="ctfontc" width="17%"><a href="#"
									value="<%=valorAnt%>" onClick="return AnteriorPag(this);"
									class="ctoflnkb"><%=trd.Traduz("PAgina Anterior")%></a></td>
								<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%>
								<input type="text" name="textir2" size="3"
									onKeyDown="FormataCampo1(this, window.event.keyCode,'down')"
									onKeyUp="FormataCampo1(this, window.event.keyCode,'up')">
								<input type="button" name="ir2" class="botcin"
									value="  <%=trd.Traduz("IR")%>  " onClick="return irpag2();">
								</a></td>
								<%
								} else {
								%>
								<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAgina Anterior")%></a></td>
								<td class="ctfontc" width="17%"><a><%=trd.Traduz("PAGINA")%>
								<input type="text" name="textir" size="3"
									onKeyDown="FormataCampo1(this, window.event.keyCode,'down')"
									onKeyUp="FormataCampo1(this, window.event.keyCode,'up')">
								<input type="button" name="ir" class="botcin"
									value="  <%=trd.Traduz("IR")%>  " onClick="return irpag();">
								</a></td>
								<%
									}
									if (pagatual < pagtotal) {
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
									name="valor" value="<%=((pagtotal*pag)-(pag-1))%>"
									onClick="return ProximaPag(this);" class="ctoflnkb"><%=trd.Traduz("Ultima PAgina")%></a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				<td width="20" valign="top"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr bgcolor="#FFFFFF">
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<%
				if (ponto.equals("..")) {
				%> <jsp:include
					page="../rodape/rodape.jsp" flush="true"></jsp:include> <%
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
</FORM>

</html>

<%
		if (rs != null)
		rs.close();
	if (conn != null)
		conn.close();

	conexao.finalizaConexao();

	conexaoc.finalizaConexao();
	//conexaoc.finalizaBD();

	conexaocNP.finalizaConexao();
	//conexaocNP.finalizaBD();

	//} catch (Exception e) {
	//  out.println(e);
	//}
%>