
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@ page import="java.util.*,java.sql.*"%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>

<%
	/**
	 * Esta é a página de permissoes de acesso do usuário FirstOn EM®.
	 * Aqui os valores são jogados na sessao através de um Vetor da classe java.util.Vector.
	 * Desta forma possibilitando a agilidade e minimizando o acesso a banco durante o tempo de execução
	 * mas contudo, o acesso a memória é maior.
	 * Autor: Rodrigo Luis Nolli Brossi
	 * Data criação : 18/11/2002.
	 * Data da ultima atualização : 18/11/2002.
	 * SER - informática ® - Software de RH de resultados
	 */
%>
<%
	/*Vetor de permissoes*/
	request.getSession(true);

	String queryPermissoes = "SELECT FUNCIONALIDADE.FLD_DESCRICAO FROM FUNCIONALIDADE,TIPOUSU_FUNCIONALID WHERE FUNCIONALIDADE.FLD_CODIGO=TIPOUSU_FUNCIONALID.FLD_CODIGO AND TIPOUSU_FUNCIONALID.TIP_TIPO='"
			+ (String) session.getAttribute("usu_tipo") + "'";
	ResultSet rsPermissoes = conexao.executaConsulta(queryPermissoes,
			session.getId() + "RS_1");

	Vector permissoes = new Vector(60, 10);
	/*Carrega Vetor*/
	if (rsPermissoes.next()) {
		do {
			permissoes.addElement(new String(rsPermissoes.getString(1)
					.trim()));
		} while (rsPermissoes.next());
	} else {
	}
	request.getSession();
	session.setAttribute("vetorPermissoes", permissoes);

	if (rsPermissoes != null) {
		rsPermissoes.close();
		conexao.finalizaConexao(session.getId() + "RS_1");
	}
%>
