
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*"%>


<%
	//try{
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
 	FODBConnectionBean conexaoOP = new FODBConnectionBean();
	conexaoOP.realizaConexao(
			(String) session.getAttribute("s_conexao"),
			(String) session.getAttribute("s_usubanco"),
			(String) session.getAttribute("s_senbanco"),
			(String) session.getAttribute("s_driverbanco"));

	String queryOP = "";
	String opt_filtro = "";

	ResultSet rs = null, rsOP = null;

	if (!(request.getParameter("opcombo") == null)) {
		opt_filtro = (String) request.getParameter("opcombo");

		//Select do Combo escolhido
		if (opt_filtro.equals("C"))
			queryOP = "SELECT CMP_CODIGO, CMP_DESCRICAO FROM COMPETENCIA ORDER BY CMP_DESCRICAO";

		if (opt_filtro.equals("E"))
			queryOP = "SELECT EMP_CODIGO, EMP_NOME FROM EMPRESA ORDER BY EMP_NOME";

		if (opt_filtro.equals("T"))
			queryOP = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO ORDER BY TIT_NOME";
	} else {
		opt_filtro = "T";
		queryOP = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO ORDER BY TIT_NOME";
	}

	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	// **************** TRADUCAO ****************
	//trd.setConecta((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));
	//trd.setIdioma(usu_idi.intValue());
	// **************** Fim TRADUCAO ************ 

	//Verifica se foi digitado algum filtro
	String filtro = "", filtrott = "", filtrot = "";
	String teste = "";
	if (!(request.getParameter("filtro") == null)) {
		filtro = " AND CUR_NOME >= '" + request.getParameter("filtro")
				+ "' ";
	}

	teste = request.getParameter("sel_titulo");
	out.println(teste);
	out.println(opt_filtro);

	//Verifica se foi selecionado algum Assunto
	if ((request.getParameter("sel_titulo") != null)) {
		if (request.getParameter("sel_titulo").equals("-1")) {
		} else {
			if (opt_filtro.equals("C")) {
				filtrot = " AND CMP_CODIGO = "
						+ request.getParameter("sel_titulo") + "";
			} else if (opt_filtro.equals("E")) {
				filtrot = " AND EMP_CODIGO = "
						+ request.getParameter("sel_titulo") + "";
			} else if (opt_filtro.equals("T")) {
				filtrot = " AND TIT_CODIGO = "
						+ request.getParameter("sel_titulo") + "";
			}
		}
	}

	filtrott = filtro + filtrot;

	String query2 = "";
	String query = "SELECT CUR_CODIGO, CUR_NOME, CUR_DURACAO, CUR_CUSTO, CUR_OBJETIVO FROM CURSO WHERE 0=0 "
			+ filtrott + "ORDER BY CUR_NOME";

	rsOP = conexaoOP.executaConsulta(queryOP);

	rs = conexao.executaConsulta(query);
%>


<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Cadastro")%> - <%=trd.Traduz("Cadastro de Cursos")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>

<script language="JavaScript">
function filtra()
{
  //document.frm.tipo.value = "F";
  frm.action ="cursos.jsp";
  frm.submit();
  return false; 
}

function inclui()
{
  //  document.frm.tipo.value = "I";
  frm.action ="inclusaodecurso.jsp";
  frm.submit();
  return false; 
}

function altera()
{
//  document.frm.tipo.value = "U";
  frm.action ="inclusaodecurso.jsp";
  frm.submit();
  return false; 
}

function pauta()
{
//  document.frm.tipo.value = "U";
  frm.action ="pautacurso.jsp";
  frm.submit();
  return false; 
}

function planoc()
{
  //document.frm.tipo.value = "U";
  frm.action ="planocurso.jsp";
  frm.submit();
  return false; 
}

function exclui()
{
  if(confirm("Deseja excluir o item selecionado?"))
  {
//    document.frm.tipo.value = "E";
    frm.action ="cursograva.jsp";
    frm.submit();
    return false; 
  }
  else
    return false;
}

function atualiza()
         {
         window.open("../cadastro/cursos.jsp?opcombo="+frm.sel_opcao.value,"_parent");
    return true;
        }            

</script>

<link rel="stylesheet" href="../default.css" type="text/css">
</head>

<%!public String convHora(float minutos) {
		Float ft = new Float(minutos);
		int min = ft.intValue();

		String total = "";
		float result;
		int inteiro = 0, decimal = 0;

		result = min / 60;

		Float ft2 = new Float(result);
		inteiro = ft2.intValue();

		decimal = min % 60;

		total = inteiro + ":" + decimal;

		return total;
	}%>


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
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="CA" /></jsp:include>
						<%
							} else {
						%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
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
									oia = "../menu/menu1.jsp?opt=" + "CU";
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
									oia = "/menu/menu1.jsp?opt=" + "CU";
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
						<td class="trontrk" width="229"><%=trd.Traduz("CADASTRO DE CURSOS")%></td>
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
				<FORM name="frm" method="post">
				<td valign="top"><img src="../art/bit.gif" width="159"
					height="1"><br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>
					<tr>
						<td height="20" class="ctfontc" align="center">&nbsp;<%=trd.Traduz("CURSO")%>:
						<input type="text" name="filtro"> &nbsp;&nbsp; <%=trd.Traduz("TITULO")%>:
						<select name="sel_titulo">
							<%
								if (rsOP.next()) {
							%>
							<option value="-1">Todos</option>
							<%
								do {

										if (teste.equals(rsOP.getString(1))) {
							%>
							<option selected value=<%=rsOP.getInt(1)%>><%=rsOP.getString(2)%></option>
							<%
								} else {
							%>
							<option value=<%=rsOP.getInt(1)%>><%=rsOP.getString(2)%></option>
							<%
								}

									} while (rsOP.next());
								}
							%>
						</select> &nbsp; <%=trd.Traduz("OPCOES")%>: <select name="sel_opcao"
							OnChange="return atualiza();">
							<%
								if (opt_filtro.equals("-1")) {
							%>
							<option selected value="-1">Todos</option>
							<option value="C">CompetEncia</option>
							<option value="E">Entidade</option>
							<option value="T">TItulo</option>
							<%
								} else if (opt_filtro.equals("C")) {
							%>
							<option value="-1">Todos</option>
							%>
							<option selected value="C">CompetEncia</option>
							<option value="E">Entidade</option>
							<option value="T">TItulo</option>
							<%
								} else if (opt_filtro.equals("E")) {
							%>
							<option selected value="E">Entidade</option>
							<option value="-1">Todos</option>
							<option value="C">CompetEncia</option>
							<option value="T">TItulo</option>
							<%
								} else if (opt_filtro.equals("T")) {
							%>
							<option selected value="T">TItulo</option>
							<option value="-1">Todos</option>
							<option value="C">CompetEncia</option>
							<option value="E">Entidade</option>
							<%
								} else {
							%>
							<option selected value="-1">Todos</option>
							<option value="C">CompetEncia</option>
							<option value="E">Entidade</option>
							<option value="T">TItulo</option>
							<%
								}
							%>
						</select> &nbsp;</td>
					</tr>

					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>


					<tr>
						<td align="center" class="ctfontc"><input checked
							type="checkbox" name="ativo"><%=trd.Traduz("Ativo")%> <input
							type="checkbox" name="inativo"><%=trd.Traduz("Inativo")%>
						</td>
					</tr>

					<tr>
						<td height="12"><img src="../art/bit.gif" width="1"
							height="1"></td>
					</tr>

					<tr>
						<td align="center"><input type="button"
							onClick="return filtra();"
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
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="133">
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
									if (rs.next()) {
								%>
								<td width="12">&nbsp;</td>
								<td width="131">
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onClick="return exclui()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("EXCLUIR")%></a></td>
									</tr>
								</table>
								</td>
								<td width="12">&nbsp;</td>
								<td width="133">
								<table border="1" cellspacing="0" cellpadding="1"
									bordercolor="#000000">
									<tr>
										<td onMouseOver="this.className='ctonlnk2';"
											onMouseOver="this.className='ctonlnk2';"
											onClick="return altera()" width="127" height="22"
											align=center class="botver"><a href="#" class="txbotver"><%=trd.Traduz("ALTERAR")%></a></td>
									</tr>
								</table>
								<td width="12">&nbsp;</td>

								<!--<td width="133"> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick="return pauta()" width="127" height="22" align=center class="botver"><a href="#" onClick="return pauta()" class="txbotver"><%=trd.Traduz("PAUTA")%></a></td>
                            </tr>
                          </table>
                        </td>
                        
                        <td width="12">&nbsp;</td>
      <td width="133"> 
                          <table border="1" cellspacing="0" cellpadding="1" bordercolor="#000000">
                            <tr> 
                              <td onMouseOver="this.className='ctonlnk2';" onClick="return planoc()" width="127" height="22" align=center class="botver"><a href="#" onClick="return planoc()" class="txbotver"><%=trd.Traduz("PLANO DE CURSO")%></a></td>
                            </tr>
                          </table>
                        </td>
        -->
							</tr>
						</table>
						</form>
						<p>
						<table border="0" cellspacing="1" cellpadding="2" width="80%">
							<tr>
								<td width="4%">&nbsp;</td>
								<td width="34%" class="celtittab"><%=trd.Traduz("NOME COMERCIAL")%></td>
								<td width="14%" class="celtittab"><%=trd.Traduz("DURACAO")%></td>
								<td width="14%" class="celtittab"><%=trd.Traduz("CUSTO")%></td>
								<td width="34%" class="celtittab"><%=trd.Traduz("OBJETIVO")%></td>
							</tr>
							<%
								boolean check = false;
									do {
							%>
							<tr class="celnortab">
								<td width="4%">
								<%
									if (check == false) {
												check = true;
								%> <input type="radio" name="cod" checked
									value="<%=rs.getString(1)%>"> <%
 	} else {
 				check = true;
 %> <input type="radio" name="cod"
									value="<%=rs.getString(1)%>"> <%
 	}
 %>
								</td>
								<td width="34%"><%=rs.getString(2)%></td>
								<td width="14%"><%=convHora(rs.getFloat(3))%></td>
								<td width="14%"><%=rs.getString(4)%></td>
								<td width="34%">
								<%
									if (rs.getString(5) != null) {
								%> <%=rs.getString(5)%> <%
 	} else {
 %> &nbsp; <%
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
				</td>
				<input type="hidden" name="tipo">
				<input type="hidden" name="ass_codigo">
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
	conexaoOP.finalizaConexao();

	//conexaoOP.finalizaBD();
	//}catch(Exception e){}
%>