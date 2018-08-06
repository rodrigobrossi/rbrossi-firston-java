
<%
	//Limpa cache
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*,java.util.*"%>

<%
	//recupera valores
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	String usu_codigo = "";
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	usu_codigo = usu_codigo.valueOf((Integer) session
			.getAttribute("fun_codigo"));
	String usu_plano = "";
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));
	String turma = request.getParameter("turma");
	String contador = (String) request.getParameter("contador"); //contador do numero de funcionarios possiveis

	//TESTE VETOR DADOS
	//Busca e Insere dados no vetor de funcionArios selecionados
	int pag = Integer.parseInt((String) session.getAttribute("pagina"));
	String n = "";
	Vector funcvet = new Vector();
	funcvet = (Vector) session.getAttribute("funcs");

	//insere os elementos no vetor
	for (int k = 1; k <= pag; k++) {
		if (!(request.getParameter("checkbox" + n.valueOf(k)) == null)) {
			//out.println(request.getParameter("checkbox" + n.valueOf(k)));
			if (!(funcvet.contains(request.getParameter("checkbox"
					+ n.valueOf(k)))))
				funcvet.add(request.getParameter("checkbox"
						+ n.valueOf(k)));
		}
	}
	session.setAttribute("funcs", funcvet);

	//Consiste dados de funcionarios
	int tamv = funcvet.size();//Tamanho do vetor de funcionarios
	if (tamv == 0) {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
  alert(<%=("\""
										+ trd
												.Traduz("E NECESSARIO SELECIONAR UM FUNCIONARIO") + "\"")%>);
  history.go(-1);
</script>
<%
	}

	int k = 0;
	ResultSet rs = null;
	String query = "SELECT CUR_CODIGO, TUR_DURACAO, TUR_CUSTO, TUR_CUSTO2, TUR_OBS, TUR_VAGAS, TTR_CODIGO FROM TURMA WHERE TUR_CODIGO = "
			+ turma;
	rs = conexao.executaConsulta(query, session.getId());

	java.util.Date dataAtual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	String dia = formato.format(dataAtual);

	//try {

	if (rs.next()) {
		for (k = 0; k < funcvet.size(); k++) {
			//Variavel de data atual
			query = "UPDATE TREINAMENTO SET TUR_CODIGO_PLAN_ANT = "
					+ turma + ", TTR_CODIGO = " + rs.getString(7)
					+ ", " + "TEF_PLANEJADO = 'S' "
					+ "WHERE TEF_CODIGO = " + funcvet.elementAt(k)
					+ " ";
			//out.println(query);
			conexao.executaAlteracao(query);
		}

		query = "UPDATE TURMA SET TUR_VAGAS = " + (rs.getInt(6) - k)
				+ " WHERE TUR_CODIGO = " + turma;
		//out.println(query);
		conexao.executaAlteracao(query);
	}

	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
%>
<script language="JavaScript">
alert(<%=("\""
									+ trd
											.Traduz("INCLUSAO REALIZADA COM SUCESSO") + "\"")%>);
window.open("10_turmaantecipada_reg.jsp?turma=<%=turma%>","_self");
</script>

<%
	//} catch(Exception t){
	//  out.println(""+t);
	//}
%>