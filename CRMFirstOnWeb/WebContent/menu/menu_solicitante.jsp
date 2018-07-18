
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%
	request.getSession();
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	String fun_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	String dequem = (((String) request.getParameter("op") == null) ? "N"
			: (String) request.getParameter("op"));

	Vector per = (Vector) session.getAttribute("vetorPermissoes");

	boolean cadastro = false, limpaSenha = false, geraLogin = false;
	/*VerificaCAo*/
	if (per.contains("SOLICITANTE - CONSULTA")) {
		cadastro = true;
	} // Sub-Menu Cadastro 
	if (per.contains("SOLICITANTE - LIMPA SENHA")) {
		limpaSenha = true;
	} // Sub-Menu Limpa Senha
	if (per.contains("SOLICITANTE - GERA LOGIN")) {
		geraLogin = true;
	} // Sub-Menu Gera Login

	// **************** TRADUCAO ****************
	//trd.setConecta((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"));
	//trd.setIdioma(usu_idi.intValue());
	// **************** TRADUCAO **************** 

	String limpa_senha = "", gera_login = "", aprova_plano = "";

	gera_login = prm.buscaparam("GERA_LOGIN");
	limpa_senha = prm.buscaparam("LIMPA_SENHA");

	if (cadastro) {
		if (dequem.equals("C")) {
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><td onClick="location='solicitantes.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="solicitantes.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("CADASTRO DE SOLICITANTE") + "\"")%>><%=trd.Traduz("CADASTRO")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
%>
<td onClick="location='solicitantes.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="solicitantes.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("CADASTRO DE SOLICITANTE") + "\"")%>><%=trd.Traduz("CADASTRO")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}
	if (limpaSenha) {
		if (limpa_senha.equals("S")) {
			if (dequem.equals("L")) {
%>
<td width="1" class="snhdiv"><img src="imagens/bit.gif" width="1"
	height="1"></td>
<td onClick="location='limpa_senha.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="limpa_senha.jsp" class="snofitm"><label
	title=<%=("\""
												+ trd
														.Traduz("LIMPA A SENHA DOS USUARIOS DO SISTEMA") + "\"")%>><%=trd.Traduz("LIMPA SENHA")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
%>
<td width="1" class="snhdiv"><img src="imagens/bit.gif" width="1"
	height="1"></td>
<td onClick="location='limpa_senha.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="limpa_senha.jsp" class="snofitm"><label
	title=<%=("\""
												+ trd
														.Traduz("LIMPA A SENHA DOS USUARIOS DO SISTEMA") + "\"")%>><%=trd.Traduz("LIMPA SENHA")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
		}
	}
	if (geraLogin) {
		if (gera_login.equals("S")) {
			if (dequem.equals("G")) {
%>
<td width="1" class="snhdiv"><img src="imagens/bit.gif" width="1"
	height="1"></td>
<td onClick="location='gera_login.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="gera_login.jsp" class="snofitm"><label
	title=<%=("\""
												+ trd
														.Traduz("GERA O LOGIN DOS USUARIOS DO SISTEMA") + "\"")%>><%=trd.Traduz("GERA LOGIN")%></label><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
%>
<td width="1" class="snhdiv"><img src="imagens/bit.gif" width="1"
	height="1"></td>
<td onClick="location='gera_login.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="gera_login.jsp" class="snofitm"><label
	title=<%=("\""
												+ trd
														.Traduz("GERA O LOGIN DOS USUARIOS DO SISTEMA") + "\"")%>><%=trd.Traduz("GERA LOGIN")%></label><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
		}
	}
%>
<td nowrap width="100%">&nbsp;</td>
