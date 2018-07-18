
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><%@page
	contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*,java.text.*"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String query = "";
	java.util.Date dataAtual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	String dia = formato.format(dataAtual);

	String ii = (((String) session.getAttribute("contador") == null) ? "0"
			: (String) session.getAttribute("contador"));
	String justificativa = (String) request.getParameter("select3");
	String reprogramar = (((String) request.getParameter("radiobutton") == null) ? "N"
			: (String) request.getParameter("radiobutton"));

	int tot = Integer.valueOf(ii).intValue();
	for (int i = 1; i <= tot; i++) {
		if (request.getParameter("h" + i) != null) {
			query = "UPDATE TREINAMENTO SET JUS_CODIGO = "
					+ justificativa + ", TEF_REPROGRAMAR = '"
					+ reprogramar
					+ "', TEF_DATAJUSTIFICATIVA = DATEFMT(" + dia
					+ ") WHERE TEF_CODIGO = "
					+ request.getParameter("h" + i);

			conexao.executaAlteracao(query);
		}
	}

	response.sendRedirect("justificativa.jsp");
%>
