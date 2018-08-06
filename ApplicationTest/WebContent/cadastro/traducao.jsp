
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	ResultSet rs2 = null;

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String cod_car = (((String) request.getParameter("sel_competencia") == null) ? "Todos"
			: (String) request.getParameter("sel_competencia"));
	String cod_tit = (((String) request.getParameter("sel_titulo") == null) ? "Todos"
			: (String) request.getParameter("sel_titulo"));
%>



<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("TraduCAo")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>



<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','../solicitacao/art/onenglish.gif','../solicitacao/art/onespanol.gif')">
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
								value="opt" name="CA" /></jsp:include>
					</tr>
					<%
						} else {
					%>
					<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
							value="opt" name="CA" /></jsp:include>
					</tr>
					<%
						}
					%>
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
									oia = "../menu/menu1.jsp?opt=" + "TR";
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
									oia = "/menu/menu1.jsp?opt=" + "TR";
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
						<td class="trcurso" width="60"><%=trd.Traduz("CADASTRO")%></td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td width="1" class="trhdiv"><img src="../art/bit.gif"
							width="1" height="1"></td>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk" width="297"><%=trd.Traduz("CADASTRO DE TRADUCAO")%></td>
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


				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="13"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="left">
						<%
							String op = (((String) request.getParameter("op") == null) ? "E"
									: (String) request.getParameter("op"));
							String termo = (((String) request.getParameter("termo") == null) ? ""
									: (String) request.getParameter("termo"));
							String tradu = (((String) request.getParameter("tradu") == null) ? ""
									: (String) request.getParameter("tradu"));
							String codigo_traducao = (((String) request.getParameter("codt") == null) ? "1"
									: (String) request.getParameter("codt"));
							String ident = (((String) request.getParameter("id") == null) ? ""
									: (String) request.getParameter("id"));
							String desc = (((String) request.getParameter("desc" + ident) == null) ? "DescriCAo"
									: (String) request.getParameter("desc" + ident));
							String trad = (((String) request.getParameter("trad" + ident) == null) ? "TraduCAo"
									: (String) request.getParameter("trad" + ident));

							if (op.equals("I")) {
						%>
						<FORM name="altera" action="altera_traducao.jsp" method="POST">
						<td valign="top"><img src="../art/bit.gif" width="159"
							height="1">&nbsp;<br>
						<center>
						<table border="0" cellspacing="2" cellpadding="3" width="90%">
							<tr class="celnortab">
								<td colspan="3" height="150" align="center">
								<p><%=trd.Traduz("NOME DO TERMO")%>: <%
									out.println("<b>" + desc + "</b>");
								%>
								
								<p><%=trd.Traduz("TRADUCAO DO TERMO")%>: <input
									type="hidden" name="cod" value="<%=ident%>"> <input
									type="text" name="traduz" value="<%=trad%>">&nbsp;&nbsp;
								
								</td>
							</TR>
							<TR>
								<td align="center">&nbsp;<br>
								<input type="submit" class="botcin"
									value="      <%=trd.Traduz("OK")%>      "> <input
									type="button" class="botcin"
									value=<%=("\"" + trd.Traduz("CANCELAR") + "\"")%>
									onClick="JavaScript:history.go(-1);"></td>
							</tr>
						</table>
						<p>&nbsp;
						</center>
						</FORM>


						<%
							} else if (op.equals("E")) {
						%>
						<center>
						<form name="filtrar"
							action="traducao.jsp?codt?=<%=codigo_traducao%>" method="POST">
						<%=trd.Traduz("NOME DO TERMO")%>: <input type="text" name="termo"
							value="">&nbsp;&nbsp; <%=trd.Traduz("TRADUCAO DO TERMO")%>:
						<input type="text" name="tradu" value="">&nbsp;&nbsp; <input
							type="submit" class="botcin"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%>></FORM>
						</center>
						<%
							}
						%>
						</td>
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
						<%
							if (op.equals("E")) {
						%>

						<td align="center">&nbsp;<br>
						<!--OpCOes -->
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return altera();" width="127" height="22"
											align=center class="botver"><a href="#"
											onClick="return altera();" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
									</tr>
								</table>
								</td>
								<td width="10">&nbsp;</td>
								<!--<td> 
                      <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                              <tr> 
                                <td onMouseOver="this.className='ctonlnk2';" onClick="return altera();" width="127" height="22" align=center class="botver"><a href="#" onClick="return altera();" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
                              </tr>
          </table>
        </td>
        <td width="10">&nbsp;</td>
        <td> 
          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
            <tr> 
              <td onMouseOver="this.className='ctonlnk2';" onClick="return altera();" width="127" height="22" align=center class="botver"><a href="#" onClick="return altera();" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
            </tr>
          </table>
        </td>-->
							</tr>
						</table>
						<!--Fim das opCOes em botOes -->


						<form name="frm" action="traducao.jsp?op=I" method="POST">
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="4%">&nbsp;</td>
								<td width="38%" class="celtittab"><%=trd.Traduz("NOME DO TERMO")%></td>
								<td width="20%" class="celtittab"><%=trd.Traduz("NOME DO IDIOMA")%></td>
								<td width="38%" class="celtittab"><%=trd.Traduz("TRADUCAO DO TERMO")%></td>

							</tr>

							<%
								String query2 = " SELECT t.trd_codigo, r.trm_nome, t.trd_traducao, i.idi_nome"
											+ " FROM LNG_TRADUCAO t, lng_termo r, lng_idioma i"
											+ " WHERE t.idi_codigo = "
											+ codigo_traducao
											+ " AND t.idi_codigo = i.idi_codigo AND "
											+ " t.trm_codigo = r.trm_codigo  AND r.trm_nome >=('"
											+ termo
											+ "')  AND t.trd_traducao  >=('"
											+ tradu
											+ "')  order by r.trm_nome ";
									//try {
									rs2 = conexao.executaConsulta(query2);
									boolean check = false;
									if (rs2.next()) {
										//try{
										rs2 = conexao.executaConsulta(query2);
										while (rs2.next()) {
							%>
							<tr class="celnortab">
								<td width="4%">
								<%
									if (check == false) {
								%><input type="radio" name="id"
									value="<%=rs2.getInt(1)%>" checked>
								<%
									check = true;
												} else {
								%><input type="radio" name="id"
									value="<%=rs2.getInt(1)%>">
								<%
									}
								%>
								</td>
								<td width="38%"><%=rs2.getString(2)%></td>
								<td width="20%"><%=rs2.getString(4)%></td>
								<td width="38%"><%=rs2.getString(3)%></td>
							<tr>
								<input type="hidden" name="desc<%=rs2.getInt(1)%>"
									value="<%=rs2.getString(2)%>">
								<input type="hidden" name="trad<%=rs2.getInt(1)%>"
									value="<%=rs2.getString(3)%>">
								<%
									}
											//}catch(Exception e){out.println(""+e);} 
										} else {
								%>
							
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="idi" disabled>
								</td>
								<td width="48%"><%=trd.Traduz("NAOENC_IDI")%></td>
								<td width="48%"><%=trd.Traduz("NAOENC_IDI")%></td>
							<tr>
								<%
									}
										//}catch(SQLException sql){out.println(""+sql);}
								%>
							
						</table>
						</form>
						<br>
						&nbsp;</td>
						<%
							}
						%>
					</tr>
				</table>
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
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
							if (ponto.equals("..")) {
						%>
						<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include></td>
						<%
							} else {
						%>
						<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include></td>
						<%
							}
						%>
					</tr>
				</table>
				</td>
			</tr>
		</table>
</body>
<!--FunCOes declaradas  para resolver aCOes importantes deste formulArio-->
<script language="JavaScript">
function altera(){
    frm.submit();
    return false;
  }
</script>
<!--Fim da declaraCAo das funCOes principais -->

<%
	if (rs2 != null)
		rs2.close();
	conexao.finalizaConexao();
%>
</html>
