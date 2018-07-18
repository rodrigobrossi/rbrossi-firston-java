
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
%>
<%
	request.getSession();
	firston.eval.components.FOParametersBean prm = (firston.eval.components.FOParametersBean) session
			.getAttribute("Param");
%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
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

	/*Variaveis de controle*/
	boolean parametro = false, dicionario = false, perImport = false, admLog = false;
	boolean troca_senha = true;//troca_senha sempre vai aparecer, por isso E true//
	Vector per = (Vector) session.getAttribute("vetorPermissoes");
	/*Verifica permissoes*/
	if (per.contains("FERRAMENTAS PARAMETROS")) {
		parametro = true;
	} // Sub-Menu Parametros
	if (per.contains("FERRAMENTAS DICIONARIO - CONSULTA")) {
		dicionario = true;
	} // Sub-Menu Dicionario
	if (per.contains("FERRAMENTAS - IMPORTACAO DE DADOS")) {
		perImport = true;
	} // Sub-Menu ImportaCAo
	if (per.contains("FERRAMENTAS - ADMINISTRADOR DE LOG")) {
		admLog = true;
	} // Sub-Menu Administrador de log

	String linha = "<td width='1' class='snhdiv'><img src='imagens/bit.gif' width='1' height='1'></td>";
	String importacao = "";

	importacao = prm.buscaparam("IMPORTACAO");

	if (parametro) {
		if (dequem.equals("P")) {
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><td onClick="location='parametros.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="parametros.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("CONFIGURACAO DOS PARAMETROS DO SISTEMA") + "\"")%>><%=trd.Traduz("PARAMETROS")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
%>
<td onClick="location='parametros.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="parametros.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("CONFIGURACAO DOS PARAMETROS DO SISTEMA") + "\"")%>><%=trd.Traduz("PARAMETROS")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	if (perImport) {
		if (importacao.equals("txt")) {
			if (dequem.equals("I")) {
				if (parametro) {
					out.println(linha);
				}
%>
<td onClick="location='importacao.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="importacao.jsp" class="snofitm"><label
	title=<%=("\""
												+ trd
														.Traduz("ATUALIZACAO DO BANCO DE DADOS DO FUNCIONARIO") + "\"")%>><%=trd.Traduz("IMPORTACAO")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
				if (parametro) {
					out.println(linha);
				}
%>
<td onClick="location='importacao.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="importacao.jsp" class="snofitm"><label
	title=<%=("\""
												+ trd
														.Traduz("ATUALIZACAO DO BANCO DE DADOS DO FUNCIONARIO") + "\"")%>><%=trd.Traduz("IMPORTACAO")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
		}
	}

	if (dicionario) {
		if (dequem.equals("D")) {
			if ((parametro == true)
					|| (perImport == true && importacao.equals("txt"))) {
				out.println(linha);
			}
%>
<td onClick="location='traducao.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="traducao.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("ALTERACAO DOS TERMOS DO SISTEMA") + "\"")%>><%=trd.Traduz("DICIONARIOS")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
			if ((parametro == true)
					|| (perImport == true && importacao.equals("txt"))) {
				out.println(linha);
			}
%>
<td onClick="location='traducao.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="traducao.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("ALTERACAO DOS TERMOS DO SISTEMA") + "\"")%>><%=trd.Traduz("DICIONARIOS")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	if (troca_senha) {
		if (dequem.equals("T")) {
			if ((parametro == true)
					|| (perImport == true && importacao.equals("txt"))
					|| (dicionario == true)) {
				out.println(linha);
			}
%>
<td onClick="location='trocasenha.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="trocasenha.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("ALTERACAO DA SENHA DO USUARIO") + "\"")%>><%=trd.Traduz("TROCA SENHA")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
			if ((parametro == true)
					|| (perImport == true && importacao.equals("txt"))
					|| (dicionario == true)) {
				out.println(linha);
			}
%>
<td onClick="location='trocasenha.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="trocasenha.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("ALTERACAO DA SENHA DO USUARIO") + "\"")%>><%=trd.Traduz("TROCA SENHA")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}

	if (admLog) {
		if (dequem.equals("A")) {
			if ((parametro == true)
					|| (perImport == true && importacao.equals("txt"))
					|| (dicionario == true) || (troca_senha == true)) {
				out.println(linha);
			}
%>
<td onClick="location='fer_administrar_log.jsp';"
	onMouseOver="this.className='snobck';"
	onMouseOut="this.className='snobck';" nowrap class="snobck"><img
	src="imagens/bit.gif" width="10" height="5"><a
	href="fer_administrar_log.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("ADMINISTRACAO DO LOG") + "\"")%>><%=trd.Traduz("ADMINISTRADOR DE LOG")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	} else {
			if ((parametro == true)
					|| (perImport == true && importacao.equals("txt"))
					|| (dicionario == true) || (troca_senha == true)) {
				out.println(linha);
			}
%>
<td onClick="location='fer_administrar_log.jsp';"
	onMouseOver="this.className='snobck';" onMouseOut="this.className='';"
	nowrap><img src="imagens/bit.gif" width="10" height="5"><a
	href="fer_administrar_log.jsp" class="snofitm"><label
	title=<%=("\""
											+ trd
													.Traduz("ADMINISTRACAO DO LOG") + "\"")%>><%=trd.Traduz("ADMINISTRADOR DE LOG")%></label></a><img
	src="imagens/bit.gif" width="10" height="5"></td>
<%
	}
	}
%>
<td nowrap width="100%">&nbsp;</td>
