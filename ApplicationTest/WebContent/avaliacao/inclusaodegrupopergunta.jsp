<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="java.sql.*"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session.getAttribute("Conexao");
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

	//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do assunto
	String tipo = "", cod = "-1", grupo = "";

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	//Se for alteracao faz a query 
	ResultSet rs;
	String query = "SELECT GRU_CODIGO, GRU_NOME FROM PERGRUPO "
			+ " WHERE GRU_CODIGO = " + cod;
	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 
	rs = conexao.executaConsulta(query, session.getId());
	if (rs.next()) {
		grupo = rs.getString(2);
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
%>



<html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%
if (tipo.equals("I")) {
%> <%=trd.Traduz("INCLUSAO DE GRUPO DE PERGUNTAS")%> <%
 } else {
 %> <%=trd.Traduz("ALTERACAO DE GRUPO DE PERGUNTAS")%> <%
 }
 %>
</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<script language="JavaScript">
function envia(){
  if(document.frm.gru_nome.value==""){
    alert(<%=("\""+trd.Traduz("DIGITE O NOME DO GRUPO DE PERGUNTAS")+"\"")%>);
    return false;
  }
  else{
    frm.action = "grupoperguntagrava.jsp";
    frm.submit();
    return false; 
  }
}

function cancela(){
  window.open("grupopergunta.jsp","_self");
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
							<jsp:param value="opt" name="CA"/>
						</jsp:include>
						<%
						} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true">
							<jsp:param value="opt" name="CA"/>
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
						<jsp:param value="op" name="AV"/>
						</jsp:include>
						<%
						} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true">
						<jsp:param value="op" name="AV"/>
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
			<jsp:include page="../menu/menu_avaliacao.jsp"	flush="true">
					<jsp:param value="opt" name="AV"/>
					<jsp:param value="op" name="GP"/>
				</jsp:include>
			<%
			} else {
			%>
			<jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
				<jsp:param value="opt" name="AV"/>
					<jsp:param value="op" name="GP"/>
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
						%> <%=trd.Traduz("INCLUSAO DE GRUPO DE PERGUNTAS")%> <%
 } else {
 %> <%=trd.Traduz("ALTERACAO DE GRUPO DE PERGUNTAS")%> <%
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
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="70%">
					<tr class="celnortab">
						<td>
						<p><%=trd.Traduz("GRUPO DE PERGUNTAS")%><br>
						<%
						if (tipo.equals("I")) {
						%> <input type="text" name="gru_nome" maxlength="50" size="70"
							onKeyUp="aspa(this)" onBlur="aspa2(this)"> <%
 } else {
 %> <input type="text" name="gru_nome" maxlength="50" size="70"
							value="<%=grupo%>" onKeyUp="aspa(this)" onBlur="aspa2(this)">
						<%
						}
						%> <input type="hidden" name="tipo" value="<%=tipo%>"> <input
							type="hidden" name="cod" value="<%=cod%>">
						</td>
					</tr>
					<tr>
						<td align="center">&nbsp;<br>
						<input type="button" onClick="return envia();"
							value="        <%=trd.Traduz("OK")%>        " class="botcin"
							name="buttonok"> &nbsp; <input type="button"
							onClick="return cancela()" value=<%=("\""+trd.Traduz("CANCELAR")+"\"")%>
							class="botcin" name="buttoncancel"></td>
					</tr>
				</table>
				<p>&nbsp;
				</center>
				</td>

				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>
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
	//}
	//catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>