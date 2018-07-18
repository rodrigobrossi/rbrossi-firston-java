
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.net.*,java.util.*"%>

<%
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

	//try{

	//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do assunto
	String tipo = "";
	String cod = "1";
	int teste = 0, cont = 0;
	Vector titulos = new Vector();

	if (!(request.getParameter("tipo") == null))
		tipo = request.getParameter("tipo");

	if (!(request.getParameter("cod") == null))
		cod = request.getParameter("cod");

	//Se for alteracao faz a query 
	ResultSet rs = null, rsa = null;

	String query = "SELECT TIT_CODIGO, TIT_NOME, TIT_ATIVO, TIT_AVALIAEFICACIA, ASS_CODIGO FROM TITULO "
			+ " WHERE TIT_CODIGO = " + cod + " ORDER BY TIT_NOME";

	//Combo de Assunto
	String querya = "SELECT ASS_CODIGO, ASS_NOME FROM ASSUNTO WHERE ASS_ATIVO = 'S' ORDER BY ASS_NOME";
	rsa = conexao.executaConsulta(querya, session.getId() + "RS1");
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%
if (tipo.equals("I")) {
%> <%=trd.Traduz("INCLUSAO DE TITULOS")%> <%
 } else {
 %> <%=trd.Traduz("ALTERACAO DE TITULOS")%> <%
 		//Pega o contador e os checks selecionados e gravam na seção
 		cont = Integer.parseInt((String) request
 		.getParameter("contador"));

 		for (int i = 0; i < cont; i++) {
 			if (!(request.getParameter("cod" + i) == null)) {
 		teste = teste + 1;

 		cod = request.getParameter("cod" + i);
 		titulos.add(cod);
 			}
 		}

 		if (teste == 1) {
 			query = "SELECT TIT_CODIGO, TIT_NOME, TIT_ATIVO, TIT_AVALIAEFICACIA, ASS_CODIGO FROM TITULO "
 			+ " WHERE TIT_CODIGO = "
 			+ cod
 			+ " ORDER BY TIT_NOME";
 		}
 		session.setAttribute("titulos", titulos);

 	}
 %>
</title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function envia(){
  if(document.frm.assnome.value==""){
    alert(<%=("\""+trd.Traduz("Digite o nome do tItulo")+"\"")%>);
    return false;
  }
  else{
    frm.submit();
    return false;
  }
}

function cancela(){
  window.open("titulos.jsp","_self");
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
    alert(<%=("\""+trd.Traduz("NAO E PERMITIDO DIGITAR ASPA SIMPLES OU DUPLA")+"\"")%>);
    campo.value = "";
    campo.focus();
  }
}

</script>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
<form name="frm" action="titulosgrava.jsp" method="POST">
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
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> 
						<%
						} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param value="opt" name="CA"/></jsp:include> 
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
							String oi = "", oia = "", opcao1 = "", opcao2 = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
									opcao1 = "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
									opcao1 = request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "TI";
									opcao2 = "TI";
								} else {
									oia = "../menu/menu1.jsp?opt="
									+ request.getParameter("opt");
									opcao2 = request.getParameter("opt");
								}
							} else {
								if (request.getParameter("op") == null) {
									oi = "/menu/menu.jsp?op=" + "C";
									opcao1 = "C";
								} else {
									oi = "/menu/menu.jsp?op=" + request.getParameter("op");
									opcao1 = request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "/menu/menu1.jsp?opt=" + "TI";
									opcao2 = "TI";
								} else {
									oia = "/menu/menu1.jsp?opt=" + request.getParameter("opt");
									opcao2 = request.getParameter("opt");
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
						<td class="trontrk">
						<%
						if (tipo.equals("I")) {
						%> <%=trd.Traduz("INCLUSAO DE TITULOS")%> <%
 } else {
 %> <%=trd.Traduz("ALTERACAO DE TITULOS")%> <%
 }
 %>
						</td>
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
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="3" width="90%">
					<tr class="celnortab">
						<td colspan="3">
						<p><%=trd.Traduz("NOME DO ASSUNTO")%><br>
						<br>
						<select name="sel_assunto">
							<%
								rs = conexao.executaConsulta(query, session.getId() + "RS2");
								if (rs.next()) {
									if (rsa.next()) {
										do {
									if ((tipo.equals("U"))
											&& (rs.getString(5).equals(rsa.getString(1)))) {
							%>
							<option selected value="<%=rsa.getString(1)%>"><%=rsa.getString(2)%>
							<%
							} else {
							%>
							
							<option value="<%=rsa.getString(1)%>"><%=rsa.getString(2)%>
							<%
										}
										} while (rsa.next());
									}
							%>
							
						</select></p>
						<p><%=trd.Traduz("NOME DO TITULO")%><br>
						<%
						if (tipo.equals("I")) {
						%> <input type="text" name="assnome" maxlength="60" size="70"
							onBlur="aspa2(this)" onKeyUp="aspa(this)"> <%
 			} else {

 			if (teste == 1) {
 %> <input type="text" name="assnome" maxlength="60" size="70"
							value="<%=rs.getString(2)%>" onBlur="aspa2(this)"
							onKeyUp="aspa(this)"> <%
 } else {
 %> <input type="text" disabled name="assnome" maxlength="60" size="70"
							value="<%=rs.getString(2)%>" onBlur="aspa2(this)"
							onKeyUp="aspa(this)"> <%
 }
 %> <%
 }
 %> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; <%
 if (tipo.equals("I")) {
 %> <input type="checkbox" name="ativo"> <%
 			} else {
 			if (rs.getString(3).equals("S")) {
 %> <input type="checkbox" name="ativo" checked> <%
 } else {
 %> <input type="checkbox" name="ativo"> <%
 		}
 		}
 	}
 %> <%=trd.Traduz("ATIVO")%>&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; <input
							type="hidden" name="tipo" value="<%=tipo%>"> <input
							type="hidden" name="cod" value="<%=cod%>"> <input
							type="hidden" name="contador" value="<%=cont%>">
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
					String parametro = "?";
					//try{
					for (Enumeration e = request.getParameterNames(); e
							.hasMoreElements();) {
						String nome = "" + e.nextElement();
						parametro = parametro + nome + "="
						+ (String) request.getParameter(nome) + "&";
					}
					//} catch(Exception e ){out.println("Erro do RodapE "+e);};

					URLEncoder codec = null;
					parametro = codec.encode(parametro);
					request.getSession(true);
					session.setAttribute("par", parametro);
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
</form>
</body>
</html>
<%
		if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}

	if (rsa != null) {
		rsa.close();
		conexao.finalizaConexao(session.getId() + "RS2");
	}

	//}catch (Exception r){out.println(r);}
%>