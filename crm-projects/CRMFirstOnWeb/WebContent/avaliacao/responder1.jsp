
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page
	import="java.sql.*,java.lang.Math.*,java.util.*,java.text.*"%>

<%
	//try{
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

	String query = "";
	ResultSet rs = null;

	String cod = "";
	if (request.getParameter("cod") != null)
		cod = request.getParameter("cod");
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.components.FOParametersBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("AVALIACAO")%> - <%=trd.Traduz("RESPONDER")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra(){
  //document.frm.tipo.value = "F";
  frm.action ="avaliar.jsp";
  frm.submit();
  return false; 
}
function inclui(){
  alert("EM CONSTRUCAO");
  //document.frm.tipo.value = "I";
  //frm.action ="inclusaodequestionario.jsp";
  //frm.submit();
  //return false; 
}
function altera(){
  //document.frm.tipo.value = "U";
  alert("EM CONSTRUCAO");
  //frm.action ="inclusaodequestionario.jsp";
  //frm.submit();
  //return false; 
}
function exclui(){
  alert("EM CONSTRUCAO");
  /*
  if(confirm(<%=("\""+trd.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?")+"\"")%>)){
    document.frm.tipo.value = "E";
    frm.action ="questionariograva.jsp";
    frm.submit();
    return false; 
  }
  else{
    return false;
  }*/
}
</script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<form name="frm">
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
			<tr>
				<td>
				<%
					if (ponto.equals("..")) {
				%> <jsp:include page="../menu/menu_avaliacao.jsp" flush="true">
					<jsp:param value="opt" name="AV" />
					<jsp:param value="op" name="RE" />
				</jsp:include> <%
 	} else {
 %> <jsp:include page="/menu/menu_avaliacao.jsp" flush="true">
					<jsp:param value="opt" name="AV" />
					<jsp:param value="op" name="RE" />

				</jsp:include> <%
 	}
 %>
				</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="20">&nbsp;</td>
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" align="center"><%=trd.Traduz("RESPONDER")%></td>
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
				<td height="51" colspan="100%">
				<div align="center"><img src="../art/bit.gif" width="1"
					height="1">
				<table border="0" cellspacing="3" cellpadding="0" width="50%">
					<tr class="ctfontb">
						<td width="17"><img src="../art/black.gif" width="17"
							height="17"></td>
						<td>= <%=trd.Traduz("PENDENTE")%></td>
						<td width="17"><img src="../art/red.gif" width="17"
							height="17"></td>
						<td>= <%=trd.Traduz("VENCIDA")%></td>
						<td width="17"><img src="../art/green.gif" width="17"
							height="17"></td>
						<td>= <%=trd.Traduz("RESPONDIDA")%></td>
					</tr>
				</table>
				</div>
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
				<td width="20" valign="top"><img src="../art/bit.gif"
					width="20" height="15"></td>

				<td valign="top">&nbsp;<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12">&nbsp;</td>
					</tr>
					<tr>
						<td align="center">&nbsp;<br>
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr class="celtittab">
								<td width="20%"><%=trd.Traduz("QUESTIONARIO")%></td>
								<td width="20%"><%=trd.Traduz("DATA DE ENVIO")%></td>
								<td width="20%"><%=trd.Traduz("DATA DE VENCIMENTO")%></td>
								<%
									if (prm.buscaparam("USE_CURSO").equals("S")) {
								%>
								<td width="20%"><%=trd.Traduz("AVALIADO")%></td>
								<td width="20%"><%=trd.Traduz("CURSO")%></td>
								<%
									} else {
								%>
								<td width="40%"><%=trd.Traduz("AVALIADO")%></td>
								<%
									}
								%>
							</tr>
							<%
								//query = "SELECT Q.QUE_CODIGO, Q.QUE_NOME, P.PRO_INICIO, P.PRO_FIM, F.FUN_NOME AS AVALIADO, C.CUR_NOME "+
								//      "FROM 

								//****PENDENCIA EF_EM - MARCELO MARQUES****

								String query_EM = "SELECT AVD.PRO_CODIGO, P.PRO_INICIO, P.PRO_FIM, Q.AVA_CODIGO, A.AVA_DESCRICAO, AVD.AVD_STATUS "
										+ "FROM AVALIADO AVD, PROCESSO P, QUESTIONARIO Q, AVALIACAO A "
										+ "WHERE FUN_CODIGO = "
										+ cod
										+ " "
										+ "AND AVD.PRO_CODIGO = P.PRO_CODIGO "
										+ "AND Q.QUE_CODIGO = P.QUE_CODIGO "
										+ "AND A.AVA_CODIGO = Q.AVA_CODIGO ";

								//query_EF = " SELECT Q.QUE_CODIGO, Q.QUE_NOME, P.PRO_CODIGO, A.AVR_CODIGO, P.PRO_FIM ,f.fun_nome as avaliador,a.avr_tipo,a.avd_codigo, v.fun_codigo, q.que_comentario "+
								//          " FROM QUESTIONARIO Q, PROCESSO P, AVALIADOR A, funcionario F, avaliado V "+
								//          " WHERE (A.AVR_STATUS IS NULL OR A.AVR_STATUS <> 'S') "+
								//          " AND A.PRO_CODIGO = P.PRO_CODIGO "+
								//          " AND P.QUE_CODIGO = Q.QUE_CODIGO "+
								//          " AND A.FUN_CODIGO = "+fun_codigo+" and F.fun_codigo = a.fun_codigo"+
								//          " and a.avd_codigo = v.avd_codigo";

								rs = conexao.executaConsulta(query_EM);

								SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
								java.util.Date hoje = new java.util.Date();
								String inicio = "", fim = "", cor = "", linka = "";
								if (rs.next()) {
									do {
										java.util.Date data1 = rs.getDate(2);
										java.util.Date data2 = rs.getDate(3);
										inicio = formato.format(data1);
										fim = formato.format(data2);

										if (rs.getString(6) != null)
											linka = rs.getString(6);
										if (hoje.after(data2))
											cor = "celnortabvv";
										else
											cor = "celnortab";
										if (linka.equals("S"))
											cor = "celnortabv";
							%>
							<tr class="<%=cor%>">
								<td width="30%"><%=inicio%></td>
								<td width="30%"><%=fim%></td>
								<td width="40%"><font color="#666666"> <%
 	if (!linka.equals("S")) {
 %> <a href="responder2.jsp?cod=<%=rs.getString(4)%>&fun_cod=<%=cod%>"
									class="lnk"> <%=rs.getString(5)%> </a> <%
 	} else {
 %> <%=rs.getString(5)%> <%
 	}
 %>
								</td>
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
				<input type="hidden" name="tipo"></td>
				<td width="20" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td align="right" height="30" class="difundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<%
							if (ponto.equals("..")) {
						%> <jsp:include page="../rodape/rodape.jsp" flush=" true" /> <%
 	} else {
 %> <jsp:include page="/rodape/rodape.jsp" flush="true" /> <%
 	}
 %>
						</td>
					</tr>
				</table>
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
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();
	//}
	//catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>
