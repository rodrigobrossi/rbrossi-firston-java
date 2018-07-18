<!-- saved from url=(0056)http://192.168.0.104:8080/FirstOnEM/cadastro/titulos.jsp -->
<!--
Nome do arquivo: cadastro/titulos.jsp
Nome da funcionalidade: cadastro de titulos
Função: exibe os titulos e as funcionalidades dele

Variáveis necessárias/ Requisitos: 

- sessao:usu_tipo("usu_tipo"), usu_nome("usu_nome"), usu_login("usu_login"),
         usu_fil("usu_fil"), usu_idi("usu_idi"), per("vetorPermissoes");

- parametro: filtro("filtro"), código do assunto("assunto");

Regras de negócio (pagina):
_________________________________________________________________________________________

Histórico
Data de atualizacao: 14/03/2003 - Desenvolvedor: Leonardo Furlan
Atividade:
          - padronizacao da página;
_________________________________________________________________________________________
-->
<!--***DIRETRIZES DA PAGINA***-->
<!--***IMPORTAÇOES E BEANS***-->
<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*,java.util.*"%>
<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//***DECLARAÇÃO DE VARIÁVEIS***
	ResultSet rs = null;
	ResultSet rs1 = null;

	String query = "", query1 = "", msg = "", filtro = "", valorFiltro = "";
	String assunto = "", cod_assunto = "";
	int cont_tit = 0, cont_pos = 0;

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
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
	Integer usu_cod = (Integer) session.getAttribute("usu_cod");

	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

	/*Recupera tipo da mensagem*/
	msg = (((String) request.getParameter("msgPro") == null)
			? ""
			: (String) request.getParameter("msgPro"));

	if (!(request.getParameter("assunto") == null)) {
		if (request.getParameter("assunto").equals("todos")) {
			assunto = "";
		} else {
			assunto = " WHERE ASS_CODIGO = "
					+ request.getParameter("assunto");
		}
	}
	cod_assunto = request.getParameter("assunto");

	if (request.getParameter("contapos") != null)
		cont_pos = Integer.parseInt(request.getParameter("contapos"));
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><HTML>
<HEAD>
<TITLE>FirstOn - CADASTRO - CADASTRO DE TITULOS</TITLE>
<SCRIPT language="JavaScript" src="/js/scripts.js"></SCRIPT>
<LINK rel="stylesheet" href="../default.css" type="text/css">
<SCRIPT language=JavaScript>
function filtra(){

var parampos = "";

  for(i=1;i<=frmt.contapos.value;i++)
  {
	 if(eval("frmt.checkpos"+i+".value")!="")
	 {
	  parampos = parampos + "checkbox"+i+"="+ eval("frmt.checkpos"+i+".value") + "&";	  
	 }
  }

  window.open("titulos_frame.jsp?assunto="+frmt.assunto.value+"&"+parampos+"&contapos="+frmt.contapos.value ,target="parte_inferior", "_parent"); 
  return true;

}

function monta(){

  var parampos = "";
  var paramtit = "";
  var tem = false;

  for(i=1;i<=frmt.contapos.value;i++)
  {
	 if(eval("frmt.checkpos"+i+".value")!="")
	 {
	  parampos = parampos + "checkpos"+i+"="+ eval("frmt.checkpos"+i+".value") + "&";	  
	 }
  }
  

  for(k=1;k<=frmt.contador.value;k++)
  {
    if(eval("frmt.checktit"+k+".checked")==true)
    {
	  tem = true;
	  paramtit = paramtit + "checktit"+k+"="+ eval("frmt.checktit"+k+".value") + "&";
    }
  }
  

  if (tem)
  {
	parampos = parampos + "contapos=" + frmt.contapos.value;
	paramtit = paramtit + "contatit=" + frmt.contador.value;
	//alert("requisitos_frame.jsp?" + parampos + "/" + "requisitos_frame.jsp?" + paramtit);
	window.open("requisitos_frame.jsp?" + parampos + "&" + paramtit + "",target="parte_inferior1", "_parent"); 	  
  }
  else
  {
    alert(<%=("\"" + trd.Traduz("NENHUM TITULO SELECIONADO") + "\"")%>);   
    return false;
  }
}
</SCRIPT>

</HEAD>
<body onunload='return fecha();' leftMargin="0" topMargin="0"
	marginheight="0" marginwidth="0">
<FORM name="frmt" method="post">
<TABLE height="100%" cellSpacing="0" cellPadding="0" width="60%"
	border="0">
	<TR>
		<TD vAlign=top>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border="0">
		</TABLE>
		<TABLE cellSpacing="0" cellPadding="0" border="0" width="627">
			<tr>
				<td width="24" height="27"><img height="30"
					src="../art/bit.gif" width="20"></td>
				<td align="middle" width="537" height="27">
				<table cellspacing=0 cellpadding=0 border=0 align="center">
					<tr>
						<td width=13><img height=15 src="../art/bit.gif" width=13></td>
						<td class=trontrk width="342"><%=trd.Traduz("CADASTRO DE TITULOS")%></td>
						<td width=16><img height=15 src="../art/bit.gif" width=13></td>
					</tr>
				</table>
				</td>
				<td align=middle width="61" height="27">&nbsp;</td>
				<td width=5 height="27">&nbsp;</td>
			</tr>
			<TR>
				<TD width=24 height=1><IMG height=1 src="../art/bit.gif"
					width=1></TD>
				<TD class=ctvdiv vAlign=top colspan="1" width="537"><IMG
					height=1 src="../art/bit.gif" width=1></TD>
			</TR>
			<TR>
				<TD vAlign=top width=24><IMG height=15 src="../art/bit.gif"
					width=20></TD>

				<TD vAlign=top colspan="2"><IMG height=1 src="../art/bit.gif"
					width=159><BR>
				<TABLE cellSpacing=0 cellPadding=0 width="90%" border=0>
					<tr>
						<td height=12><img height=1 src="../art/bit.gif" width=1></td>
					</tr>
					<TR>
						<TD align=middle class="ctfontc"><%=trd.Traduz("ASSUNTO")%>:
						<select name="assunto">
							<option value="todos"><%=trd.Traduz("TODOS")%></option>
							<%
								query1 = "SELECT ASS_CODIGO, ASS_NOME FROM ASSUNTO ORDER BY ASS_NOME";
								rs1 = conexao.executaConsulta(query1, session.getId());
								while (rs1.next()) {
									if (rs1.getString(1).equals(cod_assunto)) {
							%>
							<option selected value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
							<%
								} else {
							%>
							<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
							<%
								}
								}
								if (rs1 != null) {
									rs1.close();
									conexao.finalizaConexao(session.getId());
								}
							%>

						</select> <INPUT class="botcin"
							value=<%=("\"" + trd.Traduz("FILTRAR") + "\"")%>
							onclick="return filtra();" type="button" name="button1">
						</TD>
					</TR>
					<TR>
						<TD height=12><IMG height=1 src="../art/bit.gif" width=1></TD>
					</TR>
					<TR>
						<TD class=ctvdiv height=1><IMG height=1 src="../art/bit.gif"
							width=1></TD>
					</TR>
					<TR>
						<TD align=middle width="98%">&nbsp;

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

						<table colspan=2 cellspacing=1 cellpadding=2 width="64%" border=0>
							<tr>
								<td width="4%">&nbsp;</td>
								<td class=celtittab width="96%"><%=trd.Traduz("TITULO")%></td>
							</tr>

							<%
								cont_tit = 0;

								query = "SELECT TIT_CODIGO, TIT_NOME FROM TITULO " + assunto
										+ " ORDER BY TIT_NOME";

								rs = conexao.executaConsulta(query, session.getId() + "RS_1");
								while (rs.next()) {
									cont_tit++;
							%>

							<tr class=celnortab>
								<td width="4%">
								<%
									if (cont_pos == 0) {
								%> <input type="checkbox" value="<%=rs.getInt(1)%>" disabled
									name="checktit<%=cont_tit%>"> <%
 	} else {
 %> <input type="checkbox" value="<%=rs.getInt(1)%>"
									name="checktit<%=cont_tit%>"> <%
 	}
 %>
								</td>
								<td width="96%"><%=rs.getString(2)%></td>
							</tr>

							<%
								}
								String cod_pos = "";
								for (int i = 1; i <= cont_pos; i++) {
									if (request.getParameter("checkbox" + i) != null) {
										cod_pos = request.getParameter("checkbox" + i);
									} else {
										cod_pos = "";
									}
							%>
							<INPUT type="hidden" name="checkpos<%=i%>" value="<%=cod_pos%>">
							<%
								}
							%>

							<INPUT type="hidden" name="contapos" value="<%=cont_pos%>">
							<INPUT type="hidden" name="contador" value="<%=cont_tit%>">

						</table>

						&nbsp;
						<p></P>
						</TD>
					</TR>
				</TABLE>
				</TD>

			</TR>
		</TABLE>
		</TD>
	</TR>
</TABLE>
</FORM>
</BODY>
</HTML>
<%
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_1");
	}

	/*FINALIZAÇÕES*/
%>
<script>