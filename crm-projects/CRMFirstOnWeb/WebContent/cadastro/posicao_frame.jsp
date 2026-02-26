<!--
Nome do arquivo: cadastro/posicao_frame.jsp
Nome da funcionalidade: cadastro Pre - Requisitos 
Função: exibe os cargos e titulos para montar a grade de requisitos
Variáveis necessárias/ Requisitos: 

- sessao:usu_tipo("usu_tipo"), usu_nome("usu_nome"), usu_login("usu_login"),
         usu_fil("usu_fil"), usu_idi("usu_idi"), per("vetorPermissoes");

- parametro: filtro("filtro"), mensagem("msgPro"); 

Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 22/05/2003 - Desenvolvedor: Leonardo Furlan
Atividade:
          - padronizacao da página;
_________________________________________________________________________________________
-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*,java.util.*"%>
<jsp:useBean id="pos" scope="page" class="firston.eval.components.FOUserPositionBean" />

<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	try {

		//***DECLARAÇÃO DE VARIÁVEIS***
		ResultSet rs = null;
		ResultSet rs1 = null;
		String query = "", query1 = "", msg = "", filtro = "", valorFiltro = "";
		int cont_car = 0;
		boolean existe = false, mostraCheck = false, check = false;

		//***RECUPERCAO DE PARAMETROS***//
		/*valores de sessao*/
		request.getSession();
		FOLocalizationBean trd = (FOLocalizationBean) session
		.getAttribute("Traducao");
		FODBConnectionBean conexao = (FODBConnectionBean) session
		.getAttribute("Conexao");
		firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
		.getAttribute("Param");
		String usu_tipo = (String) session.getAttribute("usu_tipo");
		String usu_nome = (String) session.getAttribute("usu_nome");
		String usu_login = (String) session.getAttribute("usu_login");
		Integer usu_fil = (Integer) session.getAttribute("usu_fil");
		Integer usu_idi = (Integer) session.getAttribute("usu_idi");
		Integer usu_cod = (Integer) session.getAttribute("usu_cod");
		Vector per = (Vector) session.getAttribute("vetorPermissoes");
		String aplicacao = (String) session.getAttribute("aplicacao");

		Vector queries = new Vector();
		String filial = "" + usu_fil;
		String codigo = "" + usu_cod;

		//conexao1.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

		/*Recupera tipo da mensagem*/
		msg = (((String) request.getParameter("msgPro") == null) ? ""
		: (String) request.getParameter("msgPro"));
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("CADASTRO")%> - <%=trd.Traduz("INCLUSAO DE PRE-REQUISITOS")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<SCRIPT language=JavaScript>

function Unidade()
{
  window.open("posicao_frame.jsp?cbo_tabela5="+frm.cbo_tabela5.value,target="parte_superior", "_parent"); 
  return true;
}    
function Diretoria()
{
  window.open("posicao_frame.jsp?cbo_tabela5="+frm.cbo_tabela5.value+"&cbo_tabela6="+frm.cbo_tabela6.value,target="parte_superior", "_parent"); 
  return true;
   
}    
function Celula()
{
  window.open("posicao_frame.jsp?cbo_tabela5="+frm.cbo_tabela5.value+"&cbo_tabela6="+frm.cbo_tabela6.value+"&cbo_tabela7="+frm.cbo_tabela7.value,target="parte_superior", "_parent"); 
  return true;
}    
function Time()
{
  window.open("posicao_frame.jsp?cbo_tabela5="+frm.cbo_tabela5.value+"&cbo_tabela6="+frm.cbo_tabela6.value+"&cbo_tabela7="+frm.cbo_tabela7.value+"&cbo_tabela8="+frm.cbo_tabela8.value,target="parte_superior", "_parent"); 
  return true;
}    

function monta()
{ 
  var param = "";
  var tem = false;

  for(i=1;i<=frm.contador.value;i++)
  {
    if(eval("frm.checkbox"+i+".checked")==true)
    {
	  tem = true;
	  param = param + "checkbox"+i+"="+ eval("frm.checkbox"+i+".value") + "&";
    }
  }

  if (tem)
  {
   window.open("titulos_frame.jsp?" + param + "contapos=" + frm.contador.value,target="parte_inferior", "_parent"); 	  
  }
  else
  {
   alert(<%=("\""+trd.Traduz("NENHUMA POSICAO SELECIONADA")+"\"")%>);   
   return false;
  }
  
}
</SCRIPT>

<body onunload='return fecha();' leftMargin=0 topMargin=0
	marginheight="0" marginwidth="0">
<FORM name="frm" method="post">
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TR>
		<TD vAlign=top>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR>
				<TD class=hcfundo height=59>
				<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TR>
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
					</TR>
				</TABLE>
				</TD>
			</TR>
			<TR>
				<td class="mnfundo"><img src="../art/bit.gif" width="12"
					height="5"></td>
			</TR>
			<TR>
				<TD class=mnfundo height=25>
				<TABLE cellSpacing=0 cellPadding=0 border=0>
					<TR>

						<%
								String oi = "", oia = "";
								if (ponto.equals("..")) {
									if (request.getParameter("op") == null) {
								oi = "../menu/menu.jsp?op=" + "C";
									} else {
								oi = "../menu/menu.jsp?op="
										+ request.getParameter("op");
									}
									if (request.getParameter("opt") == null) {
								oia = "../menu/menu1.jsp?opt=" + "PR";
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
								oia = "/menu/menu1.jsp?opt=" + "PR";
									} else {
								oia = "/menu/menu1.jsp?opt="
										+ request.getParameter("opt");
									}

								}
						%>
						<jsp:include page="<%=oi%>" flush="true"></jsp:include>
					</tr>
				</table>
				</td>
			</tr>
			<jsp:include page="<%=oia%>" flush="true"></jsp:include>

		</TABLE>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR>
				<TD width=20>&nbsp;</TD>
				<TD align=middle width="100%">
				<TABLE cellSpacing=0 cellPadding=0 border=0>
					<TR>
						<TD width=13><IMG src="../art/bit.gif" width="13" height="15"></TD>
						<TD class=trontrk width="274"><%=trd.Traduz("INCLUSAO DE PRE-REQUISITOS")%></TD>
						<TD width=25><IMG src="../art/bit.gif" width="13" height="15"></TD>
					</TR>
				</TABLE>
				</TD>
				<TD width=20>&nbsp;</TD>
			</TR>
			<TR>
				<TD width=20 height=1><IMG height=1 src="../art/bit.gif"
					width=1></TD>
				<TD class=ctvdiv vAlign=top><IMG height=1 src="../art/bit.gif"
					width=1></TD>
				<TD width=20><IMG height=1 src="../art/bit.gif" width=1></TD>
			</TR>
			<TR>
				<TD vAlign=top width=20><IMG height=15 src="../art/bit.gif"
					width=20></TD>

				
				<%
						String tabela5 = "", tabela6 = "", tabela7 = "", tabela8 = "", opt_filtro = "";
						opt_filtro = "Cargo";//essa tela nao tem esse filtro, por isso cargo sera fixo
						if (request.getParameter("cbo_tabela5") != null)
							tabela5 = request.getParameter("cbo_tabela5");
						else
							tabela5 = "" + usu_fil;
						if (request.getParameter("cbo_tabela6") != null)
							tabela6 = request.getParameter("cbo_tabela6");
						if (request.getParameter("cbo_tabela7") != null)
							tabela7 = request.getParameter("cbo_tabela7");
						if (request.getParameter("cbo_tabela8") != null)
							tabela8 = request.getParameter("cbo_tabela8");

						if (usu_tipo.equals("F"))
							queries = pos.montaCombo(opt_filtro, "null", "null",
							aplicacao, tabela5, tabela6, tabela7, tabela8);

						if (usu_tipo.equals("P"))
							queries = pos.montaCombo(opt_filtro, filial, "null",
							aplicacao, tabela5, tabela6, tabela7, tabela8);

						if (usu_tipo.equals("G"))
							queries = pos.montaCombo(opt_filtro, filial, "null",
							aplicacao, tabela5, tabela6, tabela7, tabela8);

						if (usu_tipo.equals("S"))
							queries = pos.montaCombo(opt_filtro, filial, codigo,
							aplicacao, tabela5, tabela6, tabela7, tabela8);
				%>
				
				<TD vAlign=top><IMG height=1 src="../art/bit.gif" width=159><BR>
				<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TR>
						<TD height=13><IMG height=1 src="../art/bit.gif" width=1></TD>
					</TR>
					<TR>
						<TD class=ctfontc><%=trd.Traduz("TABELA5")%>:</TD>
						<TD><SELECT onchange="return Unidade();" name=cbo_tabela5>
							<OPTION value=-1><%=trd.Traduz("Todos")%></OPTION>
							<%
							if (usu_tipo.equals("F")) {
							%>
							<option value="-1"><%=trd.Traduz("Todos")%></option>
							<%
									}

									rs = conexao.executaConsulta((String) queries.elementAt(1),
									session.getId() + "RS_1");

									if (rs.next()) {
										do {
									if ((rs.getInt(1)) == (usu_fil.intValue())
											&& (request.getParameter("cbo_tabela5") == null)) {
							%>
							<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
										} else {
										if (request.getParameter("cbo_tabela5") != null
										&& (rs.getString(1).equals(request
												.getParameter("cbo_tabela5")))) {
							%>
							<option value="<%=rs.getInt(1)%>" selected><%=rs.getString(2)%></option>
							<%
							} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
									}
									}
										} while (rs.next());
										if (rs != null) {
									rs.close();
									conexao.finalizaConexao(session.getId() + "RS_1");
										}
							%>
						</select> <%
 }
 %>
						</TD>
						<TD class=ctfontc><%=trd.Traduz("TABELA6")%>:</TD>
						<TD><SELECT onchange="return Diretoria();" name=cbo_tabela6>
							<OPTION value=-1 selected><%=trd.Traduz("Todos")%></OPTION>
							<%
									rs = conexao.executaConsulta((String) queries.elementAt(2),
									session.getId() + "RS_2");
									if (rs.next()) {
										do {
									if (tabela6.equals(rs.getString(1))) {
							%>
							<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
							} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
										}
										} while (rs.next());
							%>
						</select> <%
 		if (rs != null) {
 		rs.close();
 		conexao.finalizaConexao(session.getId() + "RS_2");
 			}
 		}
 %>
						</TD>
					</TR>

					<TR>
						<TD class=ctfontc><%=trd.Traduz("TABELA7")%>:</TD>
						<TD><SELECT onchange="return Celula();" name=cbo_tabela7>
							<OPTION value=-1 selected><%=trd.Traduz("Todos")%></OPTION>
							<%
									rs = conexao.executaConsulta((String) queries.elementAt(3),
									session.getId() + "RS_3");
									if (rs.next()) {
										do {
									if (tabela7.equals(rs.getString(1))) {
							%>
							<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
							} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
										}
										} while (rs.next());
							%>
						</select> <%
 		if (rs != null) {
 		rs.close();
 		conexao.finalizaConexao(session.getId() + "RS_3");
 			}
 		}
 %>
						</TD>

						<TD class=ctfontc><%=trd.Traduz("TABELA8")%>:</TD>
						<TD><SELECT onchange="return Time();" name=cbo_tabela8>
							<OPTION value=-1 selected><%=trd.Traduz("Todos")%></OPTION>
							<%
									rs = conexao.executaConsulta((String) queries.elementAt(4),
									session.getId() + "RS_4");
									if (rs.next()) {
										do {
									if (tabela8.equals(rs.getString(1))) {
							%>
							<option selected value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
							} else {
							%>
							<option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
							<%
										}
										} while (rs.next());
							%>
						</select> <%
 		if (rs != null) {
 		rs.close();
 		conexao.finalizaConexao(session.getId() + "RS_4");
 			}
 		}
 %>
						</TD>
					</TR>

					<TR>
						<TD colSpan=4></TD>
					</TR>
				</TABLE>
				<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>

					<TR>
						<TD height=12><IMG height=1 src="../art/bit.gif" width=1></TD>
					</TR>
					<TR>
						<TD class=ctvdiv height=1><IMG height=1 src="../art/bit.gif"
							width=1></TD>
					</TR>

					<TR>
						<TD align=middle>&nbsp;<BR>
						<table cellspacing=0 cellpadding=0 border=0>
							<tr>
								<td>
								<table bordercolor=#000000 cellspacing=0 cellpadding=1 border=1>
									<tr>
										<td class=botver onMouseOver="this.className='ctonlnk2';"
											onClick="return monta();" align=middle width=127 height=22><a
											class=txbotver href="#"><%=trd.Traduz("INCLUIR")%></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>


						<TABLE cellSpacing=1 cellPadding=0 width="80%" border=0>
							<TR>
								<TD width="6%">&nbsp;</TD>
								<TD class=celtittab width="94%"><%=trd.Traduz("CARGO")%></TD>
							</TR>


							<%
										if (prm.buscaparam("LOTACAO").equals("S")) {
										query1 = (String) queries.elementAt(0);
									} else {
										query1 = "SELECT CAR_CODIGO, CAR_NOME FROM CARGO ORDER BY CAR_NOME";
									}

									cont_car = 0;
									rs1 = conexao.executaConsulta(query1, session.getId() + "RS_5");
									while (rs1.next()) {
										cont_car++;
							%>

							<TR class=celnortab>
								<TD width="4%"><INPUT type="checkbox"
									name="checkbox<%=cont_car%>" value="<%=rs1.getInt(1)%>">
								</TD>
								<TD width="96%"><%=rs1.getString(2)%></TD>
							</TR>

							<%
							}
							%>

						</TABLE>
						</TD>
					</TR>
				</TABLE>
				</TD>
				<TD vAlign=top width=20><IMG height=15 src="../art/bit.gif"
					width=20></TD>
			</TR>
		</TABLE>
		<INPUT type="hidden" value="<%=cont_car%>" name="contador">
		
		</TD>
	</TR>
	<TR>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD class=difundo align=right height=30>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR>
				<TD>
				<%
				if (ponto.equals("..")) {
				%> <jsp:include page="../rodape/rodape.jsp"
					flush="true"></jsp:include> <%
 } else {
 %> <jsp:include
					page="/rodape/rodape.jsp" flush="true"></jsp:include> <%
 }
 %>
				</TD>
			</TR>
		</TABLE>
		</TD>
	</TR>
</TABLE>
<body onunload='return fecha();'>
</FORM>
</HTML>
<%
			if (rs1 != null) {
			rs1.close();
			conexao.finalizaConexao(session.getId() + "RS_5");
		}
	} catch (Exception e) {
		out.println(e);
	}
%>