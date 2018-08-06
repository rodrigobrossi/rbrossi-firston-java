<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	//try{

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

	String tipo = "", cod = "";
	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	String query = "", query2 = "";
	ResultSet rs = null, rs2 = null;
%>



<html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%
	if (tipo.equals("I")) {
%> <%=trd.Traduz("INCLUSAO DE GRUPO DE RESPOSTAS")%> <%
 	} else {
 %> <%=trd.Traduz("ALTERACAO DE GRUPO DE RESPOSTAS")%> <%
 	}
 %>
</title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra(){
  //document.frm.tipo.value = "F";
  frm.action ="inclusaodegruporesposta.jsp";
  frm.submit();
  return false; 
}
function checker(){
  for(i=0;i<frm.contador.value;i++){
    eval("frm.chkper"+i+".disabled=false");
  }

}
function envia(){
  var teste = 0;
  var teste2 = 0;
  for(i=0;i<frm.contador.value;i++){
    if(eval("frm.chkper"+i+".checked") == true){
      teste = teste + 1;
      if(eval("frm.txt_valor"+i+".value") == ""){
        teste2 = teste2 + 1;
      }
    }
  }
  if(teste == 0){
    alert(<%=("\"" + trd.Traduz("FAVOR SELECIONAR UM ITEM") + "\"")%>);
    return false
  }
  else if((teste != 0) && (teste2 > 0)){
    alert(<%=("\""
									+ trd
											.Traduz("FAVOR DIGITAR UM VALOR PARA CADA ITEM SELECIONADO") + "\"")%>);
    return false
  }
  else{
    //document.frm.tipo.value = "I";
    frm.action ="gruporespostagrava.jsp";
    checker();
    frm.submit();
    return false;
  }
}
function cancela(){
  window.open("gruporesposta.jsp","_self");
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
function numero2(campo){
  aux = campo.value;
  tam = aux.length;
  i = 0;
  nova = "";
  while(i != tam){
    aux2 = aux.substring(i,i+1);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      nova = nova;
    }
    else{
      nova = nova + aux2;
    }
    i++;
  }
  campo.value = nova;
}


function numero(campo){
  aux = campo.value;
  tam = aux.length
  aux2 = aux.substring(tam-1,tam);
  if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
     aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
    aux = campo.value;
    aux = aux.length;
    aux = aux - 1;
    pal = campo.value;
    campo.value = pal.substring(0, aux);
  }
}

/*function numero2(campo){
  aux = campo.value;
  tam = aux.length;
  k = 0;
  while(tam>0){
    aux2 = aux.substring(tam-1,tam);
    if(aux2 != "0" && aux2 != "1" && aux2 != "2" && aux2 != "3" && aux2 != "4" &&
       aux2 != "5" && aux2 != "6" && aux2 != "7" && aux2 != "8" && aux2 != "9"){
      k = k+1;
    }
    tam--;
  }
  if(k != 0){
    alert(<%=("\""
									+ trd
											.Traduz("ESTE CAMPO POSSUI CARACTER NAO PERMITIDO") + "\"")%>);
    campo.value = "";
    campo.focus();
  }
}*/

</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
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
				<jsp:param value="op" name="GR" />
			</jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV" />
				<jsp:param value="op" name="GR" />
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
						<td class="trontrk" align="center">
						<%
							if (tipo.equals("I")) {
						%> <%=trd.Traduz("INCLUSAO DE GRUPO DE RESPOSTAS")%> <%
 	} else {
 %> <%=trd.Traduz("ALTERACAO DE GRUPO DE RESPOSTAS")%> <%
 	}
 %>
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
				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>

				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"> <br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center">&nbsp; <%=trd.Traduz("LOCALIZAR POR RESPOSTA")%>:
						<%
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
						&nbsp; &nbsp;
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="50%">
							<tr>
								<%
									if (!valorFiltro.equals(""))
										valorFiltro = " WHERE RES_NOME >= '" + valorFiltro + "' ";
									int cont = 0;

									query = "SELECT RES_CODIGO, RES_NOME FROM RESPOSTA " + valorFiltro
											+ " ORDER BY RES_NOME";
									rs = conexao.executaConsulta(query, session.getId());
									boolean existe = false;
									if (rs.next()) {
										existe = true;
									}
									if (existe) {
								%>
								<td width="4%">&nbsp;</td>
								<td width="90%" class="celtittab"><%=trd.Traduz("RESPOSTAS")%>
								</td>
								<td width="6%" class="celtittab"><%=trd.Traduz("VALOR")%></td>
							</tr>
							<%
								do {
										if (tipo.equals("U")) {
											query2 = "SELECT QGR_VALOR, RES_CODIGO, QGR_GRUPO FROM RESPGRUPO WHERE QGR_GRUPO = "
													+ cod + "AND RES_CODIGO = " + rs.getString(1);
											rs2 = conexao.executaConsulta(query2, session.getId()
													+ "RS_1");
											if (rs2.next()) {
							%>
							<tr class="celnortab">
								<td width="4%"><input checked type="checkbox" disabled
									name="chkper<%=cont%>" value="<%=rs.getString(1)%>"></td>
								<td width="90%">&nbsp;<%=rs.getString(2)%></td>
								<td width="6%"><input type="text" name="txt_valor<%=cont%>"
									value="<%=rs2.getString(1)%>" size="5" maxlength="9"
									onBlur="numero2(this)" onKeyUp="numero(this)"></td>
							</tr>
							<%
								cont++;
											}
										} else {
							%>
							<tr class="celnortab">
								<td width="4%"><input type="checkbox"
									name="chkper<%=cont%>" value="<%=rs.getString(1)%>"></td>
								<td width="90%">&nbsp;<%=rs.getString(2)%></td>
								<td width="6%"><input type="text" name="txt_valor<%=cont%>"
									size="5" maxlength="9" onBlur="numero2(this)"
									onKeyUp="numero(this)"></td>
							</tr>
							<%
								cont++;
										}

									} while (rs.next());
								} else {
							%>
							<tr class="celnortab">
								<td class="celtittab" colspan="100%" align="center"><%=trd.Traduz("NENHUM REGISTRO ENCONTRADO")%>
								...</td>
							</tr>
							<%
								}
							%>
						</table>
						<br>
						&nbsp;</td>
					</tr>
				</table>


				</td>
				<input type="hidden" name="tipo" value="<%=tipo%>">
				<input type="hidden" name="cod" value="<%=cod%>">
				<input type="hidden" name="contador" value="<%=cont%>">

				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>
			</tr>
			<tr align="center">
				<td align="center" colspan="100%">&nbsp;<br>
				<%
					if (existe) {
				%> <input type="button" onClick="return envia();"
					value="        <%=trd.Traduz("OK")%>        " class="botcin"
					name="buttonok"> <%
 	}
 %> &nbsp; <input type="button" onClick="return cancela()"
					value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%> class="botcin"
					name="buttoncancel"></td>
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
				%> <jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
				<%
					} else {
				%> <jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include> <%
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
		conexao.finalizaConexao(session.getId());
	}
	if (rs2 != null) {
		rs2.close();
		conexao.finalizaConexao(session.getId() + "RS_1");
	}

	//}
	//catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>