
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.util.*"%>
<%
	request.getSession();
	FOLocalizationBean trd4 = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conn = (FODBConnectionBean) session
			.getAttribute("Conexao");
%>

<%!public String trataAspas(String conteudo) {

		char troca[] = conteudo.toCharArray();
		int contador = 0;
		while (contador < conteudo.length()) {
			String alfa = "" + troca[contador];
			if (alfa.equals("'")) {
				troca[contador] = '\"';
			} else if (alfa.equals("/")) {
				troca[contador] = '/';
			}
			contador = contador + 1;
		}

		String retorna = "";
		return retorna.copyValueOf(troca);
	}%>

<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	String cod = (String) request.getParameter("cod");
	String traduz = (String) request.getParameter("traduz");

	out.println("" + cod + " " + traduz);
	String query = "";

	query = "update  lng_traducao SET trd_traducao='"
			+ trataAspas(traduz) + "' " + " where  trd_codigo=" + cod;
	out.println(query);
	conn.executaAlteracao(query);
	Integer idioma = (Integer) session.getAttribute("usu_idi");
	Vector v1 = trd4.montaVetor(idioma.intValue());

	response.sendRedirect("traducao.jsp");
%>