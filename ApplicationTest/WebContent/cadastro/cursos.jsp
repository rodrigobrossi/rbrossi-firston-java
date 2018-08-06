
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*,java.lang.Math.*,java.util.*"%>


<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FOParametersBean prm = (FOParametersBean) session
			.getAttribute("Param");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	int pag = Integer.parseInt((String) session.getAttribute("pagina"));
	boolean existe = false, mostraCheck = false;
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	ResultSet rs = null, rsgrid = null, rsc = null;

	//VariAveis para as Queryes
	String query = "", query_grid = "", query_c = "", loc = "", ativo = "", inativo = "", radio = "", checkQ = "", periodo = "";
	String opt_filtro = "", campo = "", filtro_q = "", campo2 = "", data_ini = "", data_fim = "";
	String moeda = prm.buscaparam("MOEDA");

	int sel = -1, count = 0;

	Vector vet_comp = new Vector();
	//vet_comp = (Vector)session.getAttribute("vet_compS");
	vet_comp.clear();

	request.getSession(true);
	session.setAttribute("vet_compS", vet_comp);

	//try{

	//Pegar parametros
	if (request.getParameter("text_datainicio") != null)
		data_ini = request.getParameter("text_datainicio");
	if (request.getParameter("text_datafinal") != null)
		data_fim = request.getParameter("text_datafinal");

	if (request.getParameter("select2") != null) {
		opt_filtro = (String) request.getParameter("select2");

		//Select do Combo escolhido
		if (opt_filtro.equals("Competencia")) {
			query = "SELECT CMP_CODIGO, CMP_DESCRICAO FROM COMPETENCIA ORDER BY CMP_DESCRICAO";
			campo2 = "CUR_CODIGO IN (SELECT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = ";
		}

		if (opt_filtro.equals("Entidade")) {
			query = "SELECT EMP_CODIGO, EMP_NOME FROM EMPRESA ORDER BY EMP_NOME";
			campo = "E.EMP_CODIGO = ";
		}

		if (opt_filtro.equals("Titulo")) {
			query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO ORDER BY TIT_NOME";
			campo = "T.TIT_CODIGO = ";
		}
	} else {
		opt_filtro = "Competencia";
		query = "SELECT CMP_CODIGO, CMP_DESCRICAO FROM COMPETENCIA ORDER BY CMP_DESCRICAO";
		campo2 = "CUR_CODIGO IN (SELECT CUR_CODIGO FROM CURSOCOMP WHERE CMP_CODIGO = ";

	}

	if (request.getParameter("radio") == null)
		radio = "";
	else
		radio = request.getParameter("radio");

	if ((radio.equals("todos")) || (radio.equals(""))) {
		checkQ = "";
	} else if (radio.equals("ativo")) {
		checkQ = "AND C.CUR_ATIVO = 'S' ";
	} else {
		checkQ = "AND C.CUR_ATIVO = 'N' ";
	}

	if (!(opt_filtro.equals("Periodo")))
		rs = conexao.executaConsulta(query, session.getId() + "RS_1");

	//Monta a query do Grid
	if (!(request.getParameter("select") == null)) {
		if (!(request.getParameter("select").equals("Todos"))) {
			if (!(campo.equals(""))) {
				sel = Integer.parseInt(request.getParameter("select"));
				filtro_q = campo + request.getParameter("select") + " ";
			} else {
				sel = Integer.parseInt(request.getParameter("select"));
				filtro_q = campo2 + request.getParameter("select")
						+ ") ";
			}
		} else {
			filtro_q = " 0=0 ";
		}
	}

	else {
		filtro_q = " 0=0 ";
	}

	if (!(request.getParameter("textfield") == null)) {
		loc = request.getParameter("textfield").trim();
		if (!(loc == null)) {
			filtro_q = filtro_q + " AND C.CUR_NOME >= '" + loc + "' ";
		} else {
			loc = "";
		}
	}

	else {
		loc = "";
	}

	if ((opt_filtro.equals("Periodo"))
			&& ((!(data_ini.equals(""))) || (!(data_fim.equals(""))))) {

		if (data_ini.equals(""))
			periodo = "C.CUR_DATACADASTRO <= DATEFMT(" + data_fim
					+ ") ";
		else if (data_fim.equals(""))
			periodo = "C.CUR_DATACADASTRO >= DATEFMT(" + data_ini
					+ ") ";
		else
			periodo = "C.CUR_DATACADASTRO BETWEEN DATEFMT(" + data_ini
					+ ") AND DATEFMT(" + data_fim + ") ";

		query_grid = "SELECT C.CUR_CODIGO, C.CUR_NOME, C.CUR_DURACAO, C.CUR_CUSTO, E.EMP_NOME, C.CUR_ATIVO, "
				+ "A.ASS_NOME, T.TIT_NOME "
				+ "FROM CURSO C, EMPRESA E, ASSUNTO A, TITULO T "
				+ "WHERE E.EMP_CODIGO = C.EMP_CODIGO "
				+ "AND C.TIT_CODIGO = T.TIT_CODIGO "
				+ "AND T.ASS_CODIGO = A.ASS_CODIGO "
				+ "AND "
				+ periodo
				+ "AND "
				+ filtro_q
				+ " "
				+ checkQ
				+ " AND CUR_SIMPLES = 'N' ORDER BY C.CUR_NOME";

		query_c = "SELECT COUNT(C.CUR_CODIGO) "
				+ "FROM CURSO C, EMPRESA E, ASSUNTO A, TITULO T "
				+ "WHERE E.EMP_CODIGO = C.EMP_CODIGO "
				+ "AND C.TIT_CODIGO = T.TIT_CODIGO "
				+ "AND T.ASS_CODIGO = A.ASS_CODIGO " + "AND " + periodo
				+ "AND " + filtro_q + " " + checkQ
				+ " AND CUR_SIMPLES = 'N'";

		rsc = conexao
				.executaConsulta(query_c, session.getId() + "RS_2");

		if (rsc.next())
			count = rsc.getInt(1);
	}

	else {
		query_grid = "SELECT C.CUR_CODIGO, C.CUR_NOME, C.CUR_DURACAO, C.CUR_CUSTO, E.EMP_NOME, C.CUR_ATIVO, "
				+ "A.ASS_NOME, T.TIT_NOME "
				+ "FROM CURSO C, EMPRESA E, ASSUNTO A, TITULO T "
				+ "WHERE E.EMP_CODIGO = C.EMP_CODIGO "
				+ "AND C.TIT_CODIGO = T.TIT_CODIGO "
				+ "AND T.ASS_CODIGO = A.ASS_CODIGO "
				+ "AND "
				+ filtro_q
				+ " "
				+ checkQ
				+ " AND CUR_SIMPLES = 'N' ORDER BY C.CUR_NOME";

		query_c = "SELECT COUNT(C.CUR_CODIGO) "
				+ "FROM CURSO C, EMPRESA E, ASSUNTO A, TITULO T "
				+ "WHERE E.EMP_CODIGO = C.EMP_CODIGO "
				+ "AND C.TIT_CODIGO = T.TIT_CODIGO "
				+ "AND T.ASS_CODIGO = A.ASS_CODIGO " + "AND "
				+ filtro_q + " " + checkQ + " AND CUR_SIMPLES = 'N'";

		rsc = conexao
				.executaConsulta(query_c, session.getId() + "RS_2");

		if (rsc.next())
			count = rsc.getInt(1);
	}
	//out.println(query_grid);
	rsgrid = conexao.executaConsulta(query_grid, session.getId()
			+ "RS_4");
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.components.FOParametersBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Cadastro de Cursos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function Filtro()
{
  window.open("../cadastro/cursos.jsp?select2="+frm.select2.value,"_parent");
  return true;
}         

function envia()
{
  //if(!(document.frm.inativo.checked) && !(document.frm.ativo.checked))
  //{
  //  alert(<%=("\"" + trd.Traduz("Ativo e/ou Inativo?") + "\"")%>);
  //  return false;
  //}
  //else
  //{
    frm.action ="cursos.jsp";
    frm.submit();
    return false;
  //}
}

function inclui()
{
  document.frm.tipo.value = "I";
  frm.action ="inclusaodecurso.jsp";
  frm.submit();
  return false; 
}

function altera()
{
  document.frm.tipo.value = "U";
  frm.action ="inclusaodecurso.jsp";
  frm.submit();
  return false; 
}

function exclui()
{
  if(confirm(<%=("\""
									+ trd
											.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?") + "\"")%>))
  {
    document.frm.tipo.value = "E";
    frm.action ="cursograva.jsp";
    frm.submit();
    return false; 
  }
  else
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
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 == "\"" || aux2 == "\'")
      k = k+1;
    tam--;
  }
  if(k != 0){
    alert(<%=("\""
									+ trd
											.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA") + "\"")%>);
    campo.focus();
    campo.value = "";
  }
}

function FormataData(campo, evento, direcao){
  if (campo.value.length < 10000){
    if (evento != 9 ){//tab
      if(evento != 8 && evento != 46 && evento != 16 && !(evento > 36 && evento < 41)){ //delete, backspace, shift nAo causam evento
        var tam = campo.value.length
        if ((evento >= 48 && evento <= 57) || (evento >= 96 && evento <= 105)) {
          if (tam == 2 || tam == 5){
            campo.value = campo.value + "/";
            }
          } 
        else{
          if (direcao == "up"){
            if (campo.value.length == 0){
              campo.value = ""
              }
            else{
              campo.value = campo.value.substring(0,campo.value.length-1)
              }
            }
          }
        campo.focus()
        }
      } 
    else{
      if (direcao == "down"){
        ChecaData(campo)
        }
      }
    }
  }

function ChecaData(THISDATE){
  var erro = 0
  var data = THISDATE.value
  if (data.length != 10) 
    erro=1
  var dia = data.substring(0, 2)// dia
  var barra1 = data.substring(2, 3)// '/'
  var mes = data.substring(3, 5)// mes
  var barra2 = data.substring(5, 6)// '/'
  var ano = data.substring(6, 10)// ano
    
  if (mes < 1 || mes > 12) 
    erro = 1
  if (dia < 1 || dia > 31) 
    erro = 1
  if (ano < 1990) 
    erro = 1
  if (mes == 4 || mes == 6 || mes == 9 || mes == 11){
    if (dia == 31) 
      erro = 1
      }
  if (mes == 2){
    var bis = parseInt(ano/4)
    if (isNaN(bis)){
      erro = 1
      }
    if (dia > 29) 
      erro = 1
    if (dia == 29 && ((ano/4) != parseInt(ano/4))) 
      erro = 1
    }
  if ((erro == 1) && (THISDATE.value != "")) {
    alert(THISDATE.value + ' <%=trd.Traduz("E uma data invAlida!")%>');
    THISDATE.value = "";
    }
  }
function DoCal(elTarget){
  if (showModalDialog){
    var sRtn;
    sRtn = showModalDialog("calendar.htm","","center=yes;status=no;dialogWidth=306px;dialogHeight=220px");
    if (sRtn!="")
      elTarget.value = sRtn;
    } 
  else
    alert(<%=("\""
									+ trd
											.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO") + "\"")%>)
}

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>




<%!public String ReaistoStr(float valor, String moeda) {
		DecimalFormat dcf = new DecimalFormat("0.00");
		dcf.setMaximumFractionDigits(2);
		String strReais = dcf.format(valor);
		return moeda + strReais;
	}%>

<%!public String convHora(float minutos) {
		Float aux = new Float(minutos);
		int hora_aux = aux.intValue();
		String total = "";
		int hora = hora_aux / 60;
		int min = hora_aux % 60;
		if (min < 10)
			total = hora + ":0" + min;
		else
			total = hora + ":" + min;
		return total;
	}%>

<body onunload='fecha()' leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0"
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
							String oi = "", oia = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "CU&op=C";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt") + "&op=C";
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "CU&op=C";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt")
											+ "&op=C";
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
						<td class="trontrk" align="center"><%=trd.Traduz("CADASTRO DE CURSOS")%></td>
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
						<td colspan="2" height="12"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td colspan="2" height="20" class="ctfontc" align="center"><%=trd.Traduz("LOCALIZAR POR CURSO")%>:
						<input type="text" name="textfield" value="<%=loc%>"
							onBlur="aspa2(this)" onKeyUp="aspa(this)"> &nbsp; <%
 	if ((radio.equals("")) || (radio.equals("todos"))) {
 %> <input value="ativo" type="radio" name="radio"><%=trd.Traduz("Ativo")%>
						<input value="inativo" type="radio" name="radio"><%=trd.Traduz("Inativo")%>
						<input checked value="todos" type="radio" name="radio"><%=trd.Traduz("Todos")%>
						<%
							} else if (radio.equals("ativo")) {
						%> <input checked value="ativo" type="radio" name="radio"><%=trd.Traduz("Ativo")%>
						<input value="inativo" type="radio" name="radio"><%=trd.Traduz("Inativo")%>
						<input value="todos" type="radio" name="radio"><%=trd.Traduz("Todos")%>
						<%
							} else {
						%> <input value="ativo" type="radio" name="radio"><%=trd.Traduz("Ativo")%>
						<input checked value="inativo" type="radio" name="radio"><%=trd.Traduz("Inativo")%>
						<input value="todos" type="radio" name="radio"><%=trd.Traduz("Todos")%>
						<%
							}
						%> &nbsp;
						<p><%=trd.Traduz("OPCOES")%>: <select name="select2"
							class="form" onChange="return Filtro();">
							<option value="<%=opt_filtro%>"><%=trd.Traduz(opt_filtro)%></option>
							<%
								if (!(opt_filtro.equals("Competencia"))) {
							%>
							<option value="Competencia"><%=trd.Traduz("COMPETENCIA")%></option>
							<%
								}

								if (!(opt_filtro.equals("Entidade"))) {
							%>
							<option value="Entidade"><%=trd.Traduz("ENTIDADE")%></option>
							<%
								}

								if (!(opt_filtro.equals("Periodo"))) {
							%>
							<option value="Periodo"><%=trd.Traduz("PERIODO")%></option>
							<%
								}

								if (!(opt_filtro.equals("Titulo"))) {
							%>
							<option value="Titulo"><%=trd.Traduz("TITULO")%></option>
							<%
								}
							%>
						</select> <%
 	if (!(opt_filtro.equals("Periodo"))) {
 %>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=trd.Traduz("FILTRO")%>:
						<select name="select">
							<option value="Todos">Todos</option>
							<%
								if (rs != null) {
										rs.close();
										conexao.finalizaConexao(session.getId() + "RS_1");
									}

									rs = conexao.executaConsulta(query, session.getId() + "RS_5");
									if (rs.next()) {
										existe = true;/*Atribuie valor para existe*/
									}
									if (existe) {
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
							%>
						</select>
						</td>
					</tr>
					<%
						} else {
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<!--//////////////////////// DATA INICIAL //////////////////////////////-->
					<%=trd.Traduz("DATA INICIAL")%>:
					<input type="text" name="text_datainicio" size="10" maxlength="10"
						onChange="ChecaData(this)"
						onKeyDown="FormataData(this, window.event.keyCode,'down')"
						onKeyUp="FormataData(this, window.event.keyCode,'up')"
						value="<%=data_ini%>">
					&nbsp;
					<img onclick="DoCal(text_datainicio)" style="cursor: hand"
						src="../art/icon_cal.gif" title="CalendArio" WIDTH="17"
						HEIGHT="16">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%=trd.Traduz("DATA FINAL")%>:
					<input type="text" name="text_datafinal" size="10" maxlength="10"
						onChange="ChecaData(this)"
						onKeyDown="FormataData(this, window.event.keyCode,'down')"
						onKeyUp="FormataData(this, window.event.keyCode,'up')"
						value="<%=data_fim%>">
					&nbsp;
					<img onclick="DoCal(text_datafinal)" style="cursor: hand"
						src="../art/icon_cal.gif" title="CalendArio" WIDTH="17"
						HEIGHT="16">
					<%
						}
					%>

					<tr>
						<td colspan="2" height="12"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>

					<tr>
						<td colspan="2" align="center"><input type="button"
							onClick="return envia();"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%> class="botcin"
							name="button"></td>
					</tr>
					<tr>
						<td height="12" colspan="2"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td colspan="2" class="ctvdiv" height="1"><img
							src="../art/bit.gif" width="1" height="1"></td>
					</tr>
					<tr>
						<td colspan="3" align="center">
						<table border="0" cellspacing="3" cellpadding="0">
							<tr class="ctfontb">
								<td width="10"><img src="../art/black.gif" width="17"
									height="17"></td>
								<td width="100">= <%=trd.Traduz("ATIVO")%></td>
								<td width="10"><img src="../art/red.gif" width="17"
									height="17"></td>
								<td width="100">= <%=trd.Traduz("INATIVO")%></td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td colspan="2" class="ctvdiv" height="1"><img
							src="../art/bit.gif" width="1" height="1"></td>
					</tr>


					<tr>
						<td colspan="2" align="center">&nbsp;<br>
						<%
							boolean existe_grid = false;
							if (per.contains("CADASTRO CURSO - MANUTENCAO")) {
								mostraCheck = true;
						%>
						<table>
							<tr>
								<%
									if (rsgrid.next()) {
											existe_grid = true;
										}
								%>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return inclui()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
									</tr>
								</table>
								</td>
								<%
									if (existe_grid) {
								%>
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
								<%
									}
								%>
							</tr>
						</table>
						<%
							}
						%>
						</td>

					</tr>

					<tr>
						<td colspan="2" align="center"><br>
						<table border="0" cellspacing="1" cellpadding="2" width="95%">
							<tr>
								<%
									if (existe_grid) {
								%>
								<td width="4%">&nbsp;</td>
								<td width="30%" class="celtittab"><%=trd.Traduz("CURSO")%></td>
								<td width="15%" class="celtittab"><%=trd.Traduz("ASSUNTO")%></td>
								<td width="15%" class="celtittab"><%=trd.Traduz("TITULO")%></td>
								<td width="15%" class="celtittab"><%=trd.Traduz("ENTIDADE")%></td>
								<td align="center" width="10%" class="celtittab"><%=trd.Traduz("CUSTO")%></td>
								<td align="center" width="10%" class="celtittab"><%=trd.Traduz("DURACAO")%></td>
								<%
									} else {
								%>
								<td colspan="7" align="center" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...</td>
								<%
									}
								%>
							</tr>

							<%
								boolean check = false;

								if (existe_grid) {
									do {
							%>
							<tr class="celnortab">
								<td width="4%">
								<%
									if (mostraCheck) {
								%> <%
 	if (check == false) {
 					check = true;
 %> <input type="radio" name="cod" checked
									value="<%=rsgrid.getString(1)%>"> <%
 	} else {
 					check = true;
 %> <input type="radio" name="cod"
									value="<%=rsgrid.getString(1)%>"> <%
 	}
 			} else {
 %>&nbsp;<%
 	}
 %>
								</td>
								<%
									String cor = rsgrid.getString(6);

											if (cor.equals("S")) {
												cor = "black";
											} else
												cor = "red";
								%>

								<td width="30%"><font color="<%=cor%>"><%=rsgrid.getString(2)%></font></td>
								<td width="15%"><font color="<%=cor%>"><%=rsgrid.getString(7)%></font></td>
								<td width="15%"><font color="<%=cor%>"><%=rsgrid.getString(8)%></font></td>
								<td width="15%"><font color="<%=cor%>"><%=rsgrid.getString(5)%></font></td>
								<td width="10%" align="right"><font color="<%=cor%>"><%=ReaistoStr(rsgrid.getFloat(4), moeda)%></font></td>
								<td width="10%" align="right"><font color="<%=cor%>"><%=convHora(rsgrid.getFloat(3))%></font></td>

							</tr>
							<%
								} while (rsgrid.next());
								}
							%>
						</table>

						</td>
					</tr>
				</table>
				</td>
				<input type="hidden" name="contador" value="<%=pag%>">
				<input type="hidden" name="origem" value="result_filtro">
				<input type="hidden" name="tipo">

				</FORM>
				<td width="20" valign="top"></td>
			</tr>
			<tr>
				<td height="30" colspan="3">
				<table width="95%" border="0" cellspacing="0" cellpadding="5">
					<tr>
						<td align="right" class="ctfontc" width="16%"><%=trd.Traduz("TOTAL DE ")%>
						<b><%=count%></b> <%=trd.Traduz(" CURSOS")%></td>
					</tr>
				</table>
				</td>
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
</body>
</html>
<%
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_5");
	}

	if (rsgrid != null) {
		rsgrid.close();
		conexao.finalizaConexao(session.getId() + "RS_4");
	}
	if (rsc != null) {
		conexao.finalizaConexao(session.getId() + "RS_2");
	}

	//}catch(Exception e){out.println("Erro: "+e);}
%>

