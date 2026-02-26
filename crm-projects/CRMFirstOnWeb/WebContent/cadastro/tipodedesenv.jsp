<!--
Nome do arquivo: cadastro/tipodedesenv.jsp
Nome da funcionalidade: cadastro de alternativa de desenvolvimento
Função: exibe as alternaticas de desenvolvimento e as funcionalidades, dependendo das permissões e 
        se existem registros

Variáveis necessárias/Requisitos: 
- sessao:usu_tipo("usu_tipo"), usu_nome("usu_nome"), usu_login("usu_login"),
         usu_fil("usu_fil"), usu_idi("usu_idi"), per("vetorPermissoes");
- parametro: filtro("filtro");

Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 14/03/2003 - Desenvolvedor: Anderson Inoue
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

	//***DECLARAÇÃO DE VARIÁVEIS***
	ResultSet rs = null;
	String filtro = "", query = "";
	boolean existe = false, mostraCheck = false, check = false;

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	//Verifica se foi digitado algum filtro
	if (!(request.getParameter("filtro") == null)) {
		filtro = " WHERE DES_DESCRICAO >= '"
				+ request.getParameter("filtro") + "' ";
	}

	query = "SELECT DES_CODIGO, DES_DESCRICAO FROM DESENVOLVIMENTO "
			+ filtro + " ORDER BY DES_DESCRICAO";
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Cadastro de Alternativa de Desenvolvimento")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function filtra(){
  document.frm.tipo.value = "F";
  frm.action ="tipodedesenv.jsp";
  frm.submit();
  return false; 
}
function inclui(){
  document.frm.tipo.value = "I";
  frm.action ="inclusaodetipodedesenv.jsp";
  frm.submit();
  return false; 
}
function altera(){
  document.frm.tipo.value = "U";
  frm.action ="inclusaodetipodedesenv.jsp";
  frm.submit();
  return false; 
}
function exclui(){
  if(confirm(<%=("\""
									+ trd
											.Traduz("Deseja excluir o item selecionado?") + "\"")%>)){
    document.frm.tipo.value = "E";
    frm.action ="tipodesenvgrava.jsp";
    frm.submit();
    return false; 
  }
  else{
    return false;
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
    campo.value = "";
    campo.focus();
  }
}

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
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
						%><jsp:include page="../menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
						</jsp:include>
						<%
							} else {
						%><jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="CA" /></jsp:include>
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
									oia = "../menu/menu1.jsp?opt=" + "TD";
								} else {
									oia = "../menu/menu1.jsp?opt="
											+ request.getParameter("opt");
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "TD";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt");
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
						<td class="trontrk"><%=trd.Traduz("CADASTRO DE ALTERNATIVA DE DESENVOLVIMENTO")%></td>
						<td width="13"><img src="../art/bit.gif" width="13"
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
						<td height="20" class="ctfontc" align="center">&nbsp; <%=trd
									.Traduz("LOCALIZAR POR ALTERNATIVA DE DESENVOLVIMENTO")%>: <%
 	String valorFiltro = (((String) request.getParameter("filtro") == null)
 			? ""
 			: (String) request.getParameter("filtro"));
 %> <input type="text" name="filtro" value="<%=valorFiltro%>"
							onBlur="aspa2(this)" onKeyUp="aspa(this)">&nbsp; &nbsp;
						&nbsp; <input type="button" onClick="return filtra();"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%> class="botcin"
							name="button1"></td>
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
						<td align="center">&nbsp;<br>
						<%
							rs = conexao.executaConsulta(query, session.getId() + "RS1");
							if (rs.next()) {
								existe = true;/*Atribuie valor para existe*/
							}

							if (per.contains("CADASTRO ALTER.DESENV. - MANUTENCAO")) {
								mostraCheck = true;
						%>
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
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
									if (existe) {
								%>
								<td width="10">&nbsp;</td>
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
								<td width="10">&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return altera()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
									</tr>
								</table>
								<%
									}
								%>
								</td>
							</tr>
						</table>
						&nbsp; &nbsp; <%
 	}
 %>
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="4%">&nbsp;</td>
								<%
									if (existe) {
								%>
								<td width="96%" class="celtittab"><%=trd.Traduz("ALTERNATIVA DE DESENVOLVIMENTO")%>
								<%
									} else {
								%>
								
								<td width="96%" class="celtittab" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>...
								<%
																	}
																%>
								</td>
							</tr>
							<%
								check = false;
								if (existe) {
									do {
							%>
							<tr class="celnortab">
								<td width="4%">
								<%
									if (mostraCheck) {
												if (check == false) {
													check = true;
								%><input type="radio" name="cod" checked
									value="<%=rs.getString(1)%>"> <%
 	} else {
 					check = true;
 %><input type="radio" name="cod" value="<%=rs.getString(1)%>">
								<%
									}
											} else {
								%>&nbsp;<%
									}
								%>
								</td>
								<td width="96%"><%=rs.getString(2)%></td>
							</tr>
							<%
								} while (rs.next());
								}
							%>
						</table>
						<br>
						&nbsp;</td>
					</tr>
				</table>
				</td>
				<input type="hidden" name="tipo">

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
				%><jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					} else {
				%><jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
				<%
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
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}
	/*FINALIZAÇÕES*/
%>