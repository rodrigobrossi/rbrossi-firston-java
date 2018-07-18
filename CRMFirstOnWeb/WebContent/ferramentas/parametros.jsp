
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*"%>

<%
	//recupera da sessAo//
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs = null;

	int i = 0;
	String query = "", smtp = "", porta = "", remetente = "", copia = "", usuario = "", senha = "", valor = "";
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Ferramentas")%> - <%=trd.Traduz("CADASTRO DE PARAMETROS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">

function valida(){
  if(document.form1.mai_smtp.value == ""){
    alert(<%=("\"" + trd.Traduz("Campo SMTP nAo preenchido") + "\"")%>);
        document.form1.mai_smtp.focus();
        return false;
  }
    
  if(document.form1.mai_port.value == ""){
    document.form1.mai_port.value = 25;
  }
  
  if(document.form1.mai_end.value == ""){
        alert(<%=("\""
									+ trd
											.Traduz("Campo Remetente nAo preenchido") + "\"")%>);
        document.form1.mai_end.focus();
        return false;
  }
 
  if(document.form1.env_cc.checked){
        if(document.form1.mai_cc.value == ""){
            alert(<%=("\"" + trd.Traduz("Campo cc nAo preenchido") + "\"")%>);
            document.form1.mai_cc.focus();
            return false;    
        }
  }
  
  if(document.form1.aut_serv.checked){
        if(document.form1.mai_user.value == ""){
            alert(<%=("\""
									+ trd
											.Traduz("Campo Nome da Conta nAo preenchido") + "\"")%>);
            document.form1.mai_user.focus();
            return false;
        }
      
        if(document.form1.mai_senha.value == ""){
            alert(<%=("\"" + trd.Traduz("Campo Senha nAo preenchido") + "\"")%>);
            document.form1.mai_senha.focus();
            return false;
    }
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

</script>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
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
						%>
						<%
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="FE" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="FE" /></jsp:include>
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
						<jsp:include page="../menu/menu.jsp" flush="true"><jsp:param
								value="op" name="F" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/menu.jsp" flush="true"><jsp:param
								value="op" name="F" /></jsp:include>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
			<tr>
				<%
					if (ponto.equals("..")) {
				%>
				<jsp:include page="../menu/menu_ferramentas.jsp" flush="true">
					<jsp:param value="op" name="P" />
				</jsp:include>
				<%
					} else {
				%>
				<jsp:include page="/menu/menu_ferramentas.jsp" flush="true">
					<jsp:param value="op" name="P" />
				</jsp:include>
				<%
					}
				%>
			</tr>
		</table>

		<center>

		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" width="297" align="center"><%=trd.Traduz("CADASTRO DE PARAMETROS")%></td>
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
		</table>
		</center>


		<form name="form1" method="post" action="parametros_incluir.jsp">
		<table width="40%" border="0" cellspacing="1" cellpadding="1"
			align="center">

			<%
				query = "SELECT PAR_CODIGO, PAR_DESCRICAO, PAR_VALOR "
						+ "FROM PARAM " + "WHERE PAR_VISUALIZA = 'S' "
						+ "ORDER BY PAR_DESCRICAO";

				rs = conexao.executaConsulta(query);

				if (rs.next()) {
					do {
						i++;
						valor = rs.getString(3);
			%>
			<tr class="celnortab">
				<td width="20%">
				<div align="center"></div>
				<div align="right"><%=rs.getString(2)%>:</div>
				<td width="30%"><input type="text" name="tf_<%=i%>"
					value="<%=valor%>" onBlur="aspa2(this)" onKeyUp="aspa(this)">
				<input type="hidden" name="cod_<%=i%>" value="<%=rs.getString(1)%>">
				</td>
			</tr>
			<%
				} while (rs.next());
				}
			%>

			<tr>
				<td width="20%">&nbsp;</td>
				<td width="30%">&nbsp;</td>
			</tr>

			<tr>
				<td width="20%">&nbsp;</td>
				<td width="30%">&nbsp;</td>
			</tr>

			<tr>
				<td colspan="5">
				<center><input type="submit"
					value=<%=("\"" + trd.Traduz("ALTERAR") + "\"")%> class="botcin"
					onClick="return valida()"></center>
				</td>
			</tr>

			<tr>
				<td width="20%">&nbsp;</td>
				<td width="30%">&nbsp;</td>
			</tr>

		</table>
		<input type="hidden" name="count" value="<%=i%>"></form>

		<center>
		<table border="0" cellspacing="1" cellpadding="2" width="90%">

			<%
				smtp = prm.buscaparam("MAI_SMTP");

				porta = prm.buscaparam("MAI_PORT");

				remetente = prm.buscaparam("MAI_END");

				copia = prm.buscaparam("MAI_CC");

				usuario = prm.buscaparam("MAI_USER");

				senha = prm.buscaparam("MAI_SENHA");
			%>
		</table>
		</center>
		<p>&nbsp;</p>
		</td>
	</tr>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%
				if (ponto.equals("..")) {
			%>
			<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
			<%
				} else {
			%>
			<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
			<%
				}
			%>
		</table>
		</td>
	</tr>
</table>

<%
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();
%>

</body>
</html>
