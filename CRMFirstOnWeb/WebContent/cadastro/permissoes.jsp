
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@ page import="java.util.*"%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>
<%
	/**
	 * Esta � a p�gina de permissoes de acesso do usu�rio FirstOn EM�.
	 * Aqui os valores s�o jogados na sessao atrav�s de um Vetor da classe java.util.Vector.
	 * Desta forma possibilitando a agilidade e minimizando o acesso a banco durante o tempo de execu��o
	 * mas contudo, o acesso a mem�ria � maior.
	 * Autor: Rodrigo Luis Nolli Brossi
	 * Data cria��o : 18/11/2002.
	 * Data da ultima atualiza��o : 18/11/2002.
	 * SER - inform�tica � - Software de RH de resultados
	 */
%>
<%
	/*Conexao ao Banco de Dados*/
	request.getSession();

	/*Vetor de permissoes*/
	request.getSession(true);
	String queryPermissoes = "SELECT FUNCIONALIDADE.FLD_DESCRICAO FROM FUNCIONALIDADE,TIPOUSU_FUNCIONALID WHERE FUNCIONALIDADE.FLD_CODIGO=TIPOUSU_FUNCIONALID.FLD_CODIGO AND TIPOUSU_FUNCIONALID="
			+ (String) session.getAttribute("usu_tipo");
	Vector permissoes = new Vector(60, 10);
%>
<%
	/**
	 *Fim do c�digo
	 */
%>