<!--
Nome do arquivo: cadastro/auxiliares.jsp
Nome da funcionalidade: exibe tabelas
Função: cadastra, altera e exclui cargos não importados
Variáveis necessárias/ Requisitos: 
- sessao: 
- parametro: 
Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 13/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - padronizacao da página;
_________________________________________________________________________________________

-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*,java.util.*"%>

<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//try{

	//***DECLARAÇÃO DE VARIÁVEIS***
	String query = "", filtro_filial = "", filtro_tb2 = "", filtro_filial_usu = "", queryTAB = "", filtro_depto = "", filtro_tb3 = "", cbo_opcao = "", filtro = "";
	ResultSet rs = null;
	int radi = 0;

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
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
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	cbo_opcao = ((request.getParameter("cbo_opcao") == null) ? ""
			: request.getParameter("cbo_opcao"));
	filtro = ((request.getParameter("txt_filtro") == null) ? ""
			: request.getParameter("txt_filtro"));
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOParametersBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - <%=trd.Traduz("CADASTRO DE CONSULTAS")%></title>
<script language="JavaScript" src="scripts.js">
  </script>

<script language="JavaScript">
function envia(){
  if (frm.cbo_opcao.value == "") {
    alert(<%=("\""
									+ trd
											.Traduz("Favor escolher a opcao de filtro!") + "\"")%>);
    return false;
  }
  else {
    frm.action = "auxiliares.jsp";
    frm.submit();
  }
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

function inclui(){
  frm.action = "inclusaodecargo.jsp";
  frm.tipo.value = "I";
  frm.submit();
}

function exclui(){
  if(frm.radi.value == 0){
    alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO") + "\"")%>);
    return false;
  }
  else{
    if(confirm(<%=("\""
									+ trd
											.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO") + "\" ? ")%>)){
      frm.action = "cargograva.jsp";
      frm.tipo.value = "E";
      frm.submit();
    }
    else{
      return false;
    }
  }
}

function altera(){
  if(frm.radi.value == 0){
    alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO") + "\"")%>);
    return false;
  }
  else{
    frm.action = "inclusaodecargo.jsp";
    frm.tipo.value = "U";
    frm.submit();
  }
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
						%><jsp:include page="../menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="SO" />
						</jsp:include>
						<%
							} else {
						%><jsp:include page="/menu/banner.jsp" flush="true">
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
									oia = "../menu/menu1.jsp?opt=" + "AX"; //out.println("nulo = " + oia);
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt"); //out.println("cheio = " + oia);
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "AX"; //out.println("nulo = " + oia);
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt"); //out.println("cheio = " + oia);
								}
							}
						%><jsp:include page="<%=oi%>" flush="true"></jsp:include>
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
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("AUXILIARES")%>:
						<%=cbo_opcao%></td>
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
				<FORM name="frm" method="GET">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("CONSULTAR POR")%>:
						<input type="text" name="txt_filtro" value="<%=filtro%>"
							onBlur="aspa2(this)" onKeyUp="aspa(this)"> &nbsp; <%=trd.Traduz("OPCOES")%>:
						<select name="cbo_opcao" class="form">
							<option value="" selected><%=trd.Traduz("SELECIONE")%></option>
							<%
								//if (prm.buscaparam("USE_CARGO").equals("S")){
								if (cbo_opcao.equals("CARGO")) {
							%><option value="CARGO" selected><%=trd.Traduz("CARGO")%></option>
							<%
								} else {
							%><option value="CARGO"><%=trd.Traduz("CARGO")%></option>
							<%
								}//}
								if (prm.buscaparam("USE_DEPARTAMENTO").equals("S")) {
									if (cbo_opcao.equals("DEPARTAMENTO")) {
							%><option value="DEPARTAMENTO" selected><%=trd.Traduz("DEPARTAMENTO")%></option>
							<%
								} else {
							%><option value="DEPARTAMENTO"><%=trd.Traduz("DEPARTAMENTO")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_FILIAL").equals("S")) {
									if (cbo_opcao.equals("FILIAL")) {
							%><option value="FILIAL" selected><%=trd.Traduz("FILIAL")%></option>
							<%
								} else {
							%><option value="FILIAL"><%=trd.Traduz("FILIAL")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB1").equals("S")) {
									if (cbo_opcao.equals("TABELA1")) {
							%><option value="TABELA1" selected><%=trd.Traduz("TABELA1")%></option>
							<%
								} else {
							%><option value="TABELA1"><%=trd.Traduz("TABELA1")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB2").equals("S")) {
									if (cbo_opcao.equals("TABELA2")) {
							%><option value="TABELA2" selected><%=trd.Traduz("TABELA2")%></option>
							<%
								} else {
							%><option value="TABELA2"><%=trd.Traduz("TABELA2")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB3").equals("S")) {
									if (cbo_opcao.equals("TABELA3")) {
							%><option value="TABELA3" selected><%=trd.Traduz("TABELA3")%></option>
							<%
								} else {
							%><option value="TABELA3"><%=trd.Traduz("TABELA3")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB4").equals("S")) {
									if (cbo_opcao.equals("TABELA4")) {
							%><option value="TABELA4" selected><%=trd.Traduz("TABELA4")%></option>
							<%
								} else {
							%><option value="TABELA4"><%=trd.Traduz("TABELA4")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB5").equals("S")) {
									if (cbo_opcao.equals("TABELA5")) {
							%><option value="TABELA5" selected><%=trd.Traduz("TABELA5")%></option>
							<%
								} else {
							%><option value="TABELA5"><%=trd.Traduz("TABELA5")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB6").equals("S")) {
									if (cbo_opcao.equals("TABELA6")) {
							%><option value="TABELA6" selected><%=trd.Traduz("TABELA6")%></option>
							<%
								} else {
							%><option value="TABELA6"><%=trd.Traduz("TABELA6")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB7").equals("S")) {
									if (cbo_opcao.equals("TABELA7")) {
							%><option value="TABELA7" selected><%=trd.Traduz("TABELA7")%></option>
							<%
								} else {
							%><option value="TABELA7"><%=trd.Traduz("TABELA7")%></option>
							<%
								}
								}
								if (prm.buscaparam("USE_TB8").equals("S")) {
									if (cbo_opcao.equals("TABELA8")) {
							%><option value="TABELA8" selected><%=trd.Traduz("TABELA8")%></option>
							<%
								} else {
							%><option value="TABELA8"><%=trd.Traduz("TABELA8")%></option>
							<%
								}
								}
							%>
						</select> &nbsp; &nbsp; <input type="button" onClick="return envia();"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%> class="botcin"
							name="button"></td>
					</tr>
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td class="ctvdiv" height="1"><img src="../art/bit.gif"
							width="1" height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc">&nbsp;</td>
					</tr>

					<%
						if (!usu_tipo.equals("F")) {
							filtro_filial = (" AND C.TB5_CODIGO = " + usu_fil + " ");
							filtro_depto = (" WHERE DEP_CODIGO IN (SELECT TB6_CODIGO FROM LOTACAO WHERE TB5_CODIGO = "
									+ usu_fil + ") ");
							filtro_tb2 = (" WHERE TB2_CODIGO IN (SELECT TB7_CODIGO FROM LOTACAO WHERE TB5_CODIGO = "
									+ usu_fil + ") ");
							filtro_tb3 = (" WHERE TB3_CODIGO IN (SELECT TB8_CODIGO FROM LOTACAO WHERE TB5_CODIGO = "
									+ usu_fil + ") ");
							filtro_filial_usu = (" WHERE FIL_CODIGO IN (SELECT FIL_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO = "
									+ usu_cod + ") ");
						}
						if (!cbo_opcao.equals("")) {
							//***CARGO***
							if (cbo_opcao.equals("CARGO")) {
								if (!filtro.equals("")) {
									if (prm.buscaparam("LOTACAO").equals("S")) {
										queryTAB = "SELECT C.CAR_CODIGO, C.CAR_NOME, T5.TB5_DESCRICAO, T6.TB6_DESCRICAO, T7.TB7_DESCRICAO, T8.TB8_DESCRICAO, C.CAR_CODCLI "
												+ "FROM CARGO C, TABELA5 T5, TABELA6 T6, TABELA7 T7, TABELA8 T8 "
												+ "WHERE C.CAR_NOME >= '"
												+ filtro
												+ filtro_filial
												+ "' "
												+ "AND T5.TB5_CODIGO = C.TB5_CODIGO "
												+ "AND T6.TB6_CODIGO = C.TB6_CODIGO "
												+ "AND C.TB7_CODIGO OUTER T7.TB7_CODIGO "
												+ "AND C.TB8_CODIGO OUTER T8.TB8_CODIGO "
												+ "ORDER BY C.CAR_NOME";
									} else {
										queryTAB = "SELECT CAR_NOME FROM CARGO C WHERE C.CAR_NOME >= '"
												+ filtro
												+ filtro_filial
												+ "' ORDER BY C.CAR_NOME ";
									}
								} else {
									if (prm.buscaparam("LOTACAO").equals("S")) {
										queryTAB = "SELECT C.CAR_CODIGO, C.CAR_NOME, T5.TB5_DESCRICAO, T6.TB6_DESCRICAO, T7.TB7_DESCRICAO, T8.TB8_DESCRICAO, C.CAR_CODCLI "
												+ "FROM CARGO C, TABELA5 T5, TABELA6 T6, TABELA7 T7, TABELA8 T8 "
												+ "WHERE T5.TB5_CODIGO = C.TB5_CODIGO "
												+ filtro_filial
												+ "AND T6.TB6_CODIGO = C.TB6_CODIGO "
												+ "AND C.TB7_CODIGO OUTER T7.TB7_CODIGO "
												+ "AND C.TB8_CODIGO OUTER T8.TB8_CODIGO "
												+ "ORDER BY C.CAR_NOME";
									} else {
										queryTAB = "SELECT C.CAR_NOME FROM CARGO C ORDER BY C.CAR_NOME ";
									}
								}
							}
							//***DEPARTAMENTO***
							else if (cbo_opcao.equals("DEPARTAMENTO")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT DEP_NOME FROM DEPTO WHERE DEP_NOME >= '"
											+ filtro
											+ filtro_depto
											+ "' ORDER BY DEP_NOME ";
								} else {
									queryTAB = "SELECT DEP_NOME FROM DEPTO " + filtro_depto
											+ " ORDER BY DEP_NOME";
								}
							}
							//***FILIAL***
							else if (cbo_opcao.equals("FILIAL")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT FIL_NOME FROM FILIAL WHERE FIL_NOME >= '"
											+ filtro + "' ORDER BY FIL_NOME ";
								} else {
									queryTAB = "SELECT FIL_NOME FROM FILIAL "
											+ filtro_filial_usu + " ORDER BY FIL_NOME";
								}
							}
							//***TABELA1***
							else if (cbo_opcao.equals("TABELA1")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB1_NOME FROM TABELA1 WHERE TB1_NOME >= '"
											+ filtro + "' ORDER BY TB1_NOME ";
								} else {
									queryTAB = "SELECT TB1_NOME FROM TABELA1 ORDER BY TB1_NOME";
								}
							}
							//***TABELA2***
							else if (cbo_opcao.equals("TABELA2")) {
								if (!filtro.equals("")) {
									if (prm.buscaparam("LOTACAO").equals("S")) {
										queryTAB = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_NOME >= '"
												+ filtro
												+ filtro_tb2
												+ "' ORDER BY TB2_NOME ";
									} else {
										queryTAB = "SELECT TB2_NOME FROM TABELA2 WHERE TB2_NOME >= '"
												+ filtro + "' ORDER BY TB2_NOME ";
									}
								} else {
									queryTAB = "SELECT TB2_NOME FROM TABELA2 " + filtro_tb2
											+ " ORDER BY TB2_NOME ";
								}
							}
							//***TABELA3***
							else if (cbo_opcao.equals("TABELA3")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB3_DESCRICAO FROM TABELA3 WHERE TB3_DESCRICAO >= '"
											+ filtro + "' ORDER BY TB3_DESCRICAO ";
								} else {
									queryTAB = "SELECT TB3_DESCRICAO FROM TABELA3 "
											+ filtro_tb3 + " ORDER BY TB3_DESCRICAO ";
								}
							}
							//***TABELA4***
							else if (cbo_opcao.equals("TABELA4")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB4_DESCRICAO FROM TABELA4 WHERE TB4_DESCRICAO >= '"
											+ filtro + "' ORDER BY TB4_DESCRICAO ";
								} else {
									queryTAB = "SELECT TB4_DESCRICAO FROM TABELA4 ORDER BY TB4_DESCRICAO ";
								}
							}
							//***TABELA5***
							else if (cbo_opcao.equals("TABELA5")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB5_DESCRICAO FROM TABELA5 WHERE TB5_DESCRICAO >= '"
											+ filtro + "' ORDER BY TB5_DESCRICAO ";
								} else {
									queryTAB = "SELECT TB5_DESCRICAO FROM TABELA5 ORDER BY TB5_DESCRICAO";
								}
							}
							//***TABELA6***
							else if (cbo_opcao.equals("TABELA6")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB6_DESCRICAO FROM TABELA6 WHERE TB6_DESCRICAO >= '"
											+ filtro + "' ORDER BY TB6_DESCRICAO ";
								} else {
									queryTAB = "SELECT TB6_DESCRICAO FROM TABELA6  ORDER BY TB6_DESCRICAO";
								}
							}
							//***TABELA7***
							else if (cbo_opcao.equals("TABELA7")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB7_DESCRICAO FROM TABELA7 WHERE TB7_DESCRICAO >= '"
											+ filtro + "' ORDER BY TB7_DESCRICAO ";
								} else {
									queryTAB = "SELECT TB7_DESCRICAO FROM TABELA7 ORDER BY TB7_DESCRICAO";
								}
							}
							//***TABELA8***
							else if (cbo_opcao.equals("TABELA8")) {
								if (!filtro.equals("")) {
									queryTAB = "SELECT TB8_DESCRICAO FROM TABELA8 WHERE TB8_DESCRICAO >= '"
											+ filtro + "' ORDER BY TB8_DESCRICAO ";
								} else {
									queryTAB = "SELECT TB8_DESCRICAO FROM TABELA8 ORDER BY TB8_DESCRICAO ";
								}
							}
							//out.println(queryTAB);
							rs = conexao.executaConsulta(queryTAB, session.getId());
							boolean existe = false;
							if (rs.next()) {
								existe = true;
							}

							if (cbo_opcao.equals("CARGO")
									&& per.contains("CADASTRO CONSULTA - CONSULTA")
									&& per.contains("CADASTRO CONSULTA - MANUTENCAO")) {
					%>
					<tr>
						<td align="center">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td colspan="2" align="center">
								<table>
									<tr>
										<td align="center">
										<table border="1" cellspacing="0" cellpadding="1"
											bordercolor="#000000">
											<tr>
												<td onMouseOver="this.className='ctonlnk2';"
													onClick="return inclui()" width="127" height="22"
													align=center class="botver"><a href="#"
													class="txbotver"><%=trd.Traduz("INCLUIR")%></a></td>
											</tr>
										</table>
										</td>
										<%
											if (existe) {
										%>
										<td>
										<table border="1" cellspacing="0" cellpadding="1"
											bordercolor="#000000">
											<tr>
												<td onMouseOver="this.className='ctonlnk2';"
													onClick="return exclui()" width="127" height="22"
													align=center class="botver"><a href="#"
													class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
											</tr>
										</table>
										</td>
										<td>
										<table border="1" cellspacing="0" cellpadding="1"
											bordercolor="#000000">
											<tr>
												<td onMouseOver="this.className='ctonlnk2';"
													onClick="return altera()" width="127" height="22"
													align=center class="botver"><a href="#"
													class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
											</tr>
										</table>
										</td>
										<%
											}
										%>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						</td>
					</tr>
					<tr>
						<td align="center">
						<%
							}
								boolean lota = true;
								if (existe) {
									if (cbo_opcao.equals("CARGO")
											&& prm.buscaparam("LOTACAO").equals("S")) {
										lota = true;
						%>
						<table border="0" cellspacing="1" cellpadding="2" width="98%">
							<tr class="celtittab" align="center">
								<td width="3%">&nbsp;</td>
								<td><%=trd.Traduz(cbo_opcao)%></td>
								<td><%=trd.Traduz("TABELA5")%></td>
								<td><%=trd.Traduz("TABELA6")%></td>
								<td><%=trd.Traduz("TABELA7")%></td>
								<td><%=trd.Traduz("TABELA8")%></td>
								<%
									} else {
												lota = false;
								%>
							
							<tr>
								<td align="center">
								<table border="0" cellspacing="1" cellpadding="2" width="60%">
									<tr class="celtittab" align="center">
										<td><%=trd.Traduz(cbo_opcao)%></td>
										<%
											}
										%>
									</tr>
									<%
										boolean primeiro = true;
												String checa = "";
												do {
									%><tr class="celnortab">
										<%
											if (cbo_opcao.equals("CARGO") && lota == true) {
															if (rs.getString(7) == null) {
																radi = radi + 1;
																if (primeiro == true) {
																	primeiro = false;
																	checa = "checked";
																} else {
																	checa = "";
																}
										%>
										<td width="3%"><input type="radio" <%=checa%> name="cod"
											value="<%=rs.getString(1)%>"></td>
										<%
											} else {
										%><td width="3%">&nbsp;</td>
										<%
											}
										%>
										<td><%=rs.getString(2)%></td>
										<td><%=((rs.getString(3) == null) ? "" : rs
											.getString(3))%></td>
										<td><%=((rs.getString(4) == null) ? "" : rs
											.getString(4))%></td>
										<td><%=((rs.getString(5) == null) ? "" : rs
											.getString(5))%></td>
										<td><%=((rs.getString(6) == null) ? "" : rs
											.getString(6))%></td>
										<%
											} else {
										%><td><%=((rs.getString(1) == null) ? "" : rs
											.getString(1))%></td>
										<%
											}
										%>
									</tr>
									<%
										} while (rs.next());
											} else {
									%>
									<center>
									<table border="0" cellspacing="1" cellpadding="2" width="60%">
										<tr>
											<td width="96%" align="center" class="celtittab"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...
											</td>
										</tr>
										</center>
										<%
											}
											}
										%>
										<input type="hidden" name="tipo">
										<input type="hidden" name="radi" value="<%=radi%>">
									</table>
									</td>
									</FORM>
									<td width="20" valign="top"></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
								if (rs != null) {
							%>
						</table>
						<%
							}
						%>
						
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
								%> <jsp:include
									page="../rodape/rodape.jsp" flush="true"></jsp:include> <%
 	} else {
 %>
								<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
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
<%
	if (rs != null) {
		rs.close();
	}
	conexao.finalizaConexao(session.getId());
	Vector limpa = new Vector();
	session.setAttribute("funcs", limpa);

	//}catch (Exception e){out.println(e);}
%>