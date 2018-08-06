<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="java.sql.*"%>

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String cod = "-1", lista = "";

	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	if (request.getParameter("sel_gp") != null)
		lista = request.getParameter("sel_gp");

	String avaliacao = "", nome = "", comentario = "";
	//Se for alteracao faz a query 
	ResultSet rs = null, rsU = null, rsL = null, rsP = null, rs2 = null;
	String query = "SELECT Q.QUE_CODIGO, Q.QUE_NOME, Q.QUE_COMENTARIO, A.AVA_DESCRICAO FROM QUESTIONARIO Q, AVALIACAO A "
			+ " WHERE Q.QUE_CODIGO = "
			+ cod
			+ " AND Q.AVA_CODIGO = A.AVA_CODIGO";

	rs = conexao.executaConsulta(query, session.getId());
	if (rs.next()) {
		if (rs.getString(2) != null)
			nome = rs.getString(2);
		if (rs.getString(4) != null)
			avaliacao = rs.getString(4);
		if (rs.getString(3) != null)
			comentario = rs.getString(3);
	} else {
%>
 <script language="JavaScript">
    alert(<%=("\""
										+ trd
												.Traduz("DADOS INCOMPLETOS. FAVOR ACIONAR O SUPORTE") + "\"")%>);
    history.go(-1);
  </script>
<%
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());

	}
%>


<html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("INCLUSAO DE QUESTIONARIO")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function cancela(){
  window.open("questionario.jsp","_self");
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

function muda(){
  frm.action = "inclusaodequestionario2.jsp";
  frm.submit();
}

function excluir(){
  var teste = 0;
  for(i=0;i<frm.contador.value;i++){
    if(eval("frm.check"+i+".checked") == true)
      teste = teste + 1;
  }
  if(teste == 0){
    alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO") + "\"")%>);
  }
  else{
    if(confirm(<%=("\""
									+ trd
											.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?") + "\"")%>)){
      frm.tipo.value = "E";
      frm.action = "questionariograva2.jsp";
      frm.submit();
    }
    else{
      return false;
    }
  }
}

function inserir(){
  var teste = 0;
  for(i=1;i<frm.cont2.value;i++){
    if(eval("frm.rad"+i+".checked") == true){
      teste = teste + 1;
    }
  }
  if(teste == 0){
    alert(<%=("\"" + trd.Traduz("NENHUM ITEM SELECIONADO") + "\"")%>);
    return false;
  }
  else if (showModalDialog){
    var wait;
    var sRtn;
    var min = "";
    for(i=1;i<frm.cont2.value;i++){
      if(eval("frm.rad"+i+".checked") == true){
        min =  eval("frm.rad"+i+".value");
      }
    }
    //
    sRtn = showModalDialog("incluiresp.jsp?per_cod="+min+"&cod="+frm.cod.value+"&sel_gp="+frm.sel_gp.value,"","center=yes;status=no;scroll=yes;dialogWidth=600px;dialogHeight=300px");    
    frm.action = "inclusaodequestionario2.jsp";
    frm.submit();
  }
  else{
    alert(<%=trd
									.Traduz("INTERNET EXPLORER 4.0 OU SUPERIOR E NECESSARIO")%>)
  }
}
  
</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<form name="frm" method="POST">
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
							<jsp:param value="opt" name="CA" />
						</jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA" />
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
				<jsp:param value="op" name="MQ" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="MQ" />
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
						<td class="trontrk" align="center"><%=trd.Traduz("INCLUSAO DE QUESTIONARIO")%>
						</td>
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
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td>
				<table border="0" cellspacing="1" cellpadding="2" width="100%"
					align="left">
					<tr align="left" class="ftverdanacinza">
						<td><b><%=trd.Traduz("AVALIACAO")%></b>:</td>
						<td><%=avaliacao%></td>
					</tr>
					<tr>
						<td colspan="100%">&nbsp;</td>
					</tr>
					<tr align="left" class="ftverdanacinza">
						<td align="left" width="10%"><b><%=trd.Traduz("QUESTIONARIO")%></b>:
						</td>
						<td><%=nome%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<tr>
						<td colspan="100%">&nbsp;</td>
					</tr>
					<tr align="left" class="ftverdanacinza">
						<td align="left" width="10%" valign="top"><b><%=trd.Traduz("COMENTARIO")%></b>:
						</td>
						<td><%=((comentario.equals("")) ? trd.Traduz("SEM COMENTARIOS")
							+ "..." : comentario)%></td>
					<tr>
				</table>
				</td>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
			</tr>
			<tr>
				<td width="20" height="1"><img src="../art/bit.gif" width="1"
					height="1"></td>
				<td valign="top" class="ctvdiv"><img src="../art/bit.gif"
					width="1" height="1"></td>
				<td width="20"><img src="../art/bit.gif" width="1" height="1"></td>
			</tr>
			<tr>
				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>

				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="70%">
					<tr class="ftverdanacinza">
						<td align="center">
						<p><b><%=trd.Traduz("GRUPO DE PERGUNTAS")%></b> <select
							name="sel_gp" onChange="return muda();">
							<option value=""><%=trd.Traduz("ESCOLHA")%></option>
							<%
								String queryU = "SELECT GRU_CODIGO, GRU_NOME FROM PERGRUPO ORDER BY GRU_NOME";
								rsU = conexao.executaConsulta(queryU, session.getId() + "RS_2");
								if (rsU.next()) {
									do {
										if (lista.equals(rsU.getString(1))) {
							%>
							<option selected value="<%=rsU.getInt(1)%>"><%=rsU.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rsU.getInt(1)%>"><%=rsU.getString(2)%></option>
							<%
								}
									} while (rsU.next());
								}
								if (rsU != null) {
									rsU.close();
									conexao.finalizaConexao(session.getId());
								}
							%>
						</select>
						</td>
					</tr>

				</table>

				</center>
				</td>
				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>
			</tr>
			<tr>
				<td align="center" colspan="100%">
				<table border="0" width="67%" cellspacing="1">
					<tr>
						<td width="5%">&nbsp;</td>
						<%
							int cont_rad = 1;
							if (!lista.equals("")) {
								String queryL = "SELECT P.PER_CODIGO, P.PER_TIPO, P.PER_NOME, G.GRU_NOME FROM PERGUNTA P, PERGRUPO G "
										+ "WHERE P.GRU_CODIGO = G.GRU_CODIGO "
										+ "AND P.GRU_CODIGO = " + lista;
								//out.println(queryL);
								rsL = conexao.executaConsulta(queryL, session.getId() + "RS_L");

								if (rsL.next()) {
						%>
						<td class="celtittab" width="90%"><%=trd.Traduz("LISTA DE PERGUNTAS")%>
						(<%=rsL.getString(4)%>)</td>
						<td class="celtittab" width="5%"><%=trd.Traduz("TIPO")%></td>
					</tr>
					<%
						do {
					%>
					<tr class="celnortab">
						<td width="5%"><input type="radio" id="rad<%=cont_rad%>"
							name="rad" value="<%=rsL.getInt(1)%>"></td>
						<td width="90%"><%=rsL.getString(3)%></td>
						<td width="5%"><%=rsL.getString(2)%> <%
 	cont_rad++;
 			} while (rsL.next());
 		}
 	} else {
 %>
						
						<td class="celtittab" colspan="2"><%=trd.Traduz("LISTA DE PERGUNTAS")%>
						(...) <%
													}
													if (rsL != null) {
														rsL.close();
														conexao.finalizaConexao(session.getId() + "RS_L");
													}
												%>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="center" colspan="100%"><input type="button"
							value=<%=("\"" + trd.Traduz("INSERIR") + "\"")%> class="botcin"
							onClick="return inserir();"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
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
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="center" colspan="100%">
				<table border="0" width="67%" cellspacing="1">
					<tr>
						<td>&nbsp;</td>
						<td class="celtittab"><%=trd.Traduz("PERGUNTAS INCLUSAS")%></td>
					</tr>
					<%
						int index = 0;
						String queryP = "SELECT P.PER_CODIGO, P.PER_NOME, QP.PER_TIPO, QP.QPG_PESO, QP.GRU_CODIGO "
								+ "FROM PERGUNTA P, QUESTIONARIO Q, QUEST_PERGUNTA QP "
								+ "WHERE QP.PER_CODIGO = P.PER_CODIGO "
								+ "AND Q.QUE_CODIGO = QP.QUE_CODIGO "
								+ "AND Q.QUE_CODIGO = " + cod;

						rsP = conexao.executaConsulta(queryP, session.getId() + "RS_P");
						if (rsP.next()) {
							do {
					%>
					<tr class="celnortab">
						<td width="5%" valign="top"><input type="checkbox"
							name="check<%=index%>" value="<%=rsP.getInt(1)%>"></td>
						<td><b><%=rsP.getString(2)%></b><br>
						<ul type="disk">
							<%
								String query2 = "SELECT R.RES_NOME "
												+ "FROM QUESTIONARIO Q, QUEST_RESP QR, RESPOSTA R "
												+ "WHERE Q.QUE_CODIGO = QR.QUE_CODIGO "
												+ "AND PER_TIPO = 'ME' "
												+ "AND QR.RES_CODIGO = R.RES_CODIGO "
												+ "AND Q.QUE_CODIGO = '" + cod + "' "
												+ "AND QR.PER_CODIGO = " + rsP.getString(1);

										rs2 = conexao.executaConsulta(query2, session.getId()
												+ "RS_2");

										if (rs2.next()) {
											do {
							%>
							<li><%=rs2.getString(1)%></li>
							<%
								} while (rs2.next());
											if (rs2 != null) {
												rs2.close();
												conexao.finalizaConexao(session.getId() + "RS_2");
											}
							%><p>
						</td>
					</tr>
					<%
						}
								index++;
							} while (rsP.next());
						}

						if (rsP != null) {
							rsP.close();
							conexao.finalizaConexao(session.getId() + "RS_P");
						}
					%>
					<tr>
						<td align="center" colspan="100%">&nbsp;<br>
						<input type="button"
							onClick="JavaScript:window.open('questionario.jsp','_self');"
							value="        <%=trd.Traduz("OK")%>        " class="botcin">&nbsp;
						<input type="button" onClick="return excluir();"
							value=<%=("\"" + trd.Traduz("EXCLUIR") + "\"")%> class="botcin">&nbsp;
						<!--<input type="button" onClick="return cancela();"  value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%> class="botcin">-->
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="cod" value="<%=cod%>"> <input
			type="hidden" name="cont2" value="<%=cont_rad%>"> <input
			type="hidden" name="contador" value="<%=index%>"> <input
			type="hidden" name="tipo"></td>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					} else {
				%> <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					}
				%>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%