
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	
	FODBConnectionBean conexao1  = new FODBConnectionBean();
	FODBConnectionBean conexao2 = new FODBConnectionBean();

	conexao1.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));
	conexao2.realizaConexao((String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String cod_car = (((String) request.getParameter("sel_competencia") == null) ? "Todos"
			: (String) request.getParameter("sel_competencia"));
	String cod_tit = (((String) request.getParameter("sel_titulo") == null) ? "Todos"
			: (String) request.getParameter("sel_titulo"));
	boolean existe = false, mostraCheck = false;
	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	ResultSet rs = null, rs1 = null, rs2 = null;
%>



<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("CompetEncias por TItulo")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<script language="JavaScript">
function exclui()
{
  if(confirm(<%=("\""
									+ trd
											.Traduz("DESEJA EXCLUIR O ITEM SELECIONADO?") + "\"")%>))
  {
    frm.action="deleta_comptitulo.jsp?competencia=<%=cod_car%>&titulo=<%=cod_tit%>";
    frm.submit();
    return false;
  }
  else
    return false;
}
function inclui(){
  window.open("inclusaodecompetenciatitulo.jsp","_parent");
  return false;
  }

function filtra(){
  filtro.submit();
  return true; 
  }
  
function altera()
{
  
  frm.action="altera_competenciatitulo.jsp?competencia=<%=cod_car%>&titulo=<%=cod_tit%>";
  frm.submit();
  return false;
}
  
</script>

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
							String oi = "", oia = "";
							if (ponto.equals("..")) {
								if (request.getParameter("op") == null) {
									oi = "../menu/menu.jsp?op=" + "C";
								} else {
									oi = "../menu/menu.jsp?op=" + request.getParameter("op");
								}
								if (request.getParameter("opt") == null) {
									oia = "../menu/menu1.jsp?opt=" + "CT";
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
									oia = "/menu/menu1.jsp?opt=" + "CT";
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
				<td width="100%" align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="13"><img src="../art/bit.gif" width="13"
							height="15"></td>
						<td class="trontrk"><%=trd.Traduz("CADASTRO DE COMPETENCIAS POR TITULO")%></td>
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
				<FORM name="filtro" action="competencia_titulo.jsp">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="13"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center"><%=trd.Traduz("COMPETENCIA")%>:
						<select name="sel_competencia">
							<option>Todos <%
								String query = "SELECT cmp_codigo, cmp_descricao FROM competencia ORDER BY CMP_DESCRICAO";
								rs = conexao.executaConsulta(query);
								while (rs.next()) {
									if (rs.getString(1).equals(
											request.getParameter("sel_competencia"))) {
							%>
							
							<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%>
							<%
								} else {
							%>
							
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%> <%
 	}
 	}
 %>
							
						</select> &nbsp; &nbsp; &nbsp; <%=trd.Traduz("TITULO")%>: <select
							name="sel_titulo">
							<option>Todos <%
								String query1 = "SELECT tit_codigo, tit_nome FROM titulo ORDER BY tit_nome";
								rs1 = conexao1.executaConsulta(query1);
								while (rs1.next()) {
									if (rs1.getString(1).equals(request.getParameter("sel_titulo"))) {
							%>
							
							<option value="<%=rs1.getInt(1)%>" selected><%=rs1.getString(2)%>
							<%
								} else {
							%>
							
							<option value="<%=rs1.getInt(1)%>"><%=rs1.getString(2)%>
							<%
								}
								}
							%>
							
						</select> <input type="button" class="botcin"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%>
							onClick="return filtra();"></td>
					</tr>
					</FORM>
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
						<!--OpCOes --> <%
 	rs = conexao.executaConsulta(query);
 	if (rs.next()) {
 		existe = true;/*Atribuie valor para existe*/
 	}

 	if (per.contains("CADASTRO COMP.TITULO - MANUTENCAO")) {
 		mostraCheck = true;
 %>

						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return inclui();" width="127" height="22"
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
											onClick="return exclui();" width="127" height="22"
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
											onClick="return altera();" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
									</tr>
								</table>
								</td>
								<%
									}
								%>
							</tr>
						</table>
						<!--Fim das opCOes em botOes --> <%
 	}
 %>


						<form name="frm" method="POST">
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="4%">&nbsp;</td>
								<td width="48%" class="celtittab"><%=trd.Traduz("COMPETENCIA")%></td>
								<td width="48%" class="celtittab"><%=trd.Traduz("TITULO")%></td>
							</tr>


							<%
								String query2 = "";

								if (cod_car.equals("Todos") && cod_tit.equals("Todos")) {
									query2 = " SELECT p.cti_codigo, c.cmp_descricao, t.tit_nome,c.cmp_codigo,t.tit_codigo"
											+ " FROM comp_titulo p, competencia c, titulo t "
											+ " WHERE p.cmp_codigo = c.cmp_codigo AND p.tit_codigo = t.tit_codigo ORDER BY C.CMP_DESCRICAO ";
								} else if ((cod_car.equals("Todos") && !cod_tit.equals("Todos"))) {
									query2 = " SELECT p.cti_codigo, c.cmp_descricao, t.tit_nome,c.cmp_codigo,t.tit_codigo"
											+ " FROM comp_titulo p, competencia c, titulo t "
											+ " WHERE t.tit_codigo= "
											+ cod_tit
											+ " AND p.cmp_codigo = c.cmp_codigo AND p.tit_codigo = t.tit_codigo ORDER BY C.CMP_DESCRICAO ";
								} else if ((!cod_car.equals("Todos") && cod_tit.equals("Todos"))) {
									query2 = " SELECT p.cti_codigo, c.cmp_descricao, t.tit_nome,c.cmp_codigo,t.tit_codigo"
											+ " FROM comp_titulo p, competencia c, titulo t "
											+ " WHERE c.cmp_codigo="
											+ cod_car
											+ " AND p.cmp_codigo = c.cmp_codigo AND p.tit_codigo = t.tit_codigo ORDER BY C.CMP_DESCRICAO";
								} else if ((!cod_car.equals("Todos") && !cod_tit.equals("Todos"))) {
									query2 = " SELECT p.cti_codigo, c.cmp_descricao, t.tit_nome,c.cmp_codigo,t.tit_codigo"
											+ " FROM comp_titulo p, competencia c, titulo t "
											+ " WHERE t.tit_codigo="
											+ cod_tit
											+ " AND c.cmp_codigo="
											+ cod_car
											+ " AND p.cmp_codigo = c.cmp_codigo AND p.tit_codigo = t.tit_codigo ORDER BY C.CMP_DESCRICAO ";
								}

								//try {
								rs2 = conexao2.executaConsulta(query2);
								boolean check = false;
								if (existe) {
									if (rs2.next()) {
										rs2 = conexao2.executaConsulta(query2);
										while (rs2.next()) {
							%>
							<tr class="celnortab">
								<td width="4%">
								<%
									if (mostraCheck) {
								%> <%
 	if (check == false) {
 %> <input type="radio"
									name="pre" value="<%=rs2.getInt(1)%>" checked> <%
 	check = true;
 					} else {
 %> <input type="radio" name="pre"
									value="<%=rs2.getInt(1)%>"> <%
 	}
 %> <%
 	} else {
 %> &nbsp; <%
 	}
 %> <input
									type="hidden" name="titulo<%=rs2.getInt(1)%>"
									value="<%=rs2.getInt(5)%>"> <input type="hidden"
									name="competencia<%=rs2.getInt(1)%>" value="<%=rs2.getInt(4)%>">
								</td>
								<td width="48%"><%=rs2.getString(2)%></td>
								<td width="48%"><%=rs2.getString(3)%></td>
							<tr>
								<%
									}
										} else {
								%>
							
							<tr class="celnortab">
								<td width="4%"><input type="radio" name="pre" disabled>
								</td>
								<td width="48%"><%=trd.Traduz("NAO encontrado")%></td>
								<td width="48%"><%=trd.Traduz("NAO encontrado")%></td>
							<tr>
								<%
									}
									}
									//}catch(SQLException sql){out.println(""+sql);}
								%>
							
						</table>

						<br>
						&nbsp;
						</td>
					</tr>
				</table>
				</td>

				<td width="20" valign="top"></td>
			</tr>
		</table>
		</form>
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

<%
	if (rs != null)
		rs.close();
	conexao.finalizaConexao();

	conexao1.finalizaConexao();
	conexao2.finalizaConexao();
%>

</body>
</html>
