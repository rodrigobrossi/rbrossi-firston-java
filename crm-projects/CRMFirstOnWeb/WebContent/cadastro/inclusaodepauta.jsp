
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.text.*,java.util.*"%>

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

	//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do assunto
	String tipo = "";
	String cod = "-1";
	String curso = "";

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("codi") == null)) {
		cod = request.getParameter("codi");
	}
	if (!(request.getParameter("cursos") == null)) {
		curso = request.getParameter("cursos");
	}

	//Se for alteracao faz a query 
	ResultSet rs = null;
	String query = "SELECT * FROM PAUTA WHERE PAU_CODIGO = " + cod
			+ " ORDER BY PAU_CODIGO";

	rs = conexao.executaConsulta(query);
	if (rs.next()) {
	}
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("InclusAo de Pauta")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<script language="JavaScript">
function envia(){
  frm.submit();
  return false; 
  }
function cancela(){
  window.open("pautacurso.jsp?cod=<%=curso%>","_self");
  }
</script>

<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','art/onenglish.gif','art/onespanol.gif')">
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
								value="opt" name="CA" /></jsp:include>
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
							String oi = "", oia = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "PA";
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
									oia = "/menu/menu1.jsp?opt=" + "PA";
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
				<td width="100%">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="trcurso"><%=trd.Traduz("CADASTRO")%></td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td width="1" class="trhdiv"><img src="../art/bit.gif"
							width="1" height="1"></td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk"><%=trd.Traduz("InclusAo de Pauta")%></td>
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
				<FORM name="frm" action="pautagrava.jsp" method="POST">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1">&nbsp;<br>
				<center>
				<table border="0" cellspacing="2" cellpadding="2" width="44%">
					<tr>
						<td class="ftverdanacinza" height="30" width="16%"><%=trd.Traduz("DIA")%>:
						</td>
						<td class="ftverdanacinza" height="30" width="84%">
						<%
							if (tipo.equals("I")) {
						%> <input type="text" name="textfield1"
							size="15"> &nbsp; &nbsp; &nbsp; <%
 	} else {

 		String dataf = new String();
 		if (!(rs.getString(4) == null)) {
 			java.util.Date diai = rs.getDate(4);
 			SimpleDateFormat data1 = new SimpleDateFormat("dd/MM/yyyy");
 			dataf = data1.format(diai);
 		}

 		if (!(rs.getString(4) == null)) {
 %> <input type="text" name="textfield1" size="15"
							value="<%=dataf%>"> &nbsp; &nbsp; &nbsp; <%
 	} else {
 %> <input type="text" name="textfield1"
							size="15"> &nbsp; &nbsp; &nbsp; <%
 	}
 	}
 %> <%=trd.Traduz("HORARIO")%>: <%
 	if (tipo.equals("I")) {
 %> <input
							type="text" name="textfield2" size="9"> <%
 	} else {
 %> <input type="text" name="textfield2" size="9"
							value="<%=rs.getString(5)%>"> <%
 	}
 %>
						</td>
					</tr>
					<tr>
						<td class="ftverdanacinza" width="16%"><%=trd.Traduz("DESCRICAO")%>:
						</td>
						<td class="ftverdanacinza" width="84%"><textarea
							name="textfield3" rows="4" cols="33">
						<%
							if (tipo.equals("U")) {
						%><%=rs.getString(3)%>
						<%
							}
						%>
						</textarea></td>
					</tr>
					<tr>
						<td class="ftverdanacinza" width="16%"><%=trd.Traduz("RESPONSAVEL")%>:
						</td>
						<td class="ftverdanacinza" width="84%">
						<%
							if (tipo.equals("I")) {
						%> <input type="text" name="textfield4"
							size="44"> <%
 	} else {
 %> <input type="text" name="textfield4" size="44"
							value="<%=rs.getString(6)%>"> <%
 	}
 %>
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2">&nbsp;<br>
						<input type="button" onClick="return envia();"
							value="        <%=trd.Traduz("OK")%>        " class="botcin"
							name="buttonok"> &nbsp; <input type="button"
							onClick="return cancela()"
							value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%> class="botcin"
							name="buttoncancel"></td>
					</tr>
				</table>
				</center>
				</td>
				<input type="hidden" name="tipo" value="<%=tipo%>">
				<input type="hidden" name="codi" value="<%=cod%>">
				<input type="hidden" name="curso" value="<%=curso%>">
				</FORM>
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
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();
%>