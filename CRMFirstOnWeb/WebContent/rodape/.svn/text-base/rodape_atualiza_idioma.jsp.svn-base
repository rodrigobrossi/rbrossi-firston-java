
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.net.*,java.util.*"%>

<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	conexao.getConection();

	FOLocalizationBean trd4 = (FOLocalizationBean) session
			.getAttribute("Traducao");

	//JSP para atualizar o idioma na sessao
	request.getSession(true);
	Integer idioma = new Integer(Integer.parseInt((String) request
			.getParameter("cod")));
	String page1 = (String) request.getParameter("page");
	String par = (((String) session.getAttribute("par") == null) ? ""
			: (String) session.getAttribute("par"));
	session.setAttribute("par", null);
	session.setAttribute("usu_idi", idioma);
	trd4.limpaVetor();
	trd4.setIdioma(idioma.intValue());
	Vector v1 = trd4.montaVetor(idioma.intValue());

	URLDecoder dec = null;
	String vai = dec.decode(par);

	String query = "UPDATE FUNCIONARIO SET IDI_CODIGO="
			+ session.getAttribute("usu_idi") + "  WHERE FUN_CODIGO= "
			+ (Integer) session.getAttribute("usu_cod");

	conexao.executaAlteracao(query);
	//conexao.finalizaConexao();
	response.sendRedirect("" + page1 + "" + vai);
%>
