
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

	ResultSet rs = null, rsV = null;

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
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""
										+ trd
												.Traduz("E NECESSARIO SELECIONAR UM FUNCIONARIO") + "\"")%>);
    history.go(-1);
</script>
<%
	}

	//Variaveis
	int k = 0, contem = 0;
	java.util.Date dataAtual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	String dia = formato.format(dataAtual);//data atual
	String query = "", query_update = "", tur_inicio = "", tur_fim = "";

	//try {

	query = "SELECT CUR_CODIGO, TUR_DURACAO, TUR_CUSTO, TUR_CUSTO2, TUR_OBS, TUR_VAGAS, TTR_CODIGO, TUR_DATAINICIO, TUR_DATAFINAL "
			+ "FROM TURMA WHERE TUR_CODIGO = " + turma;
	rs = conexao.executaConsulta(query, session.getId());
	if (rs.next()) {
		tur_inicio = formato.format(rs.getDate(8));
		tur_fim = formato.format(rs.getDate(9));
		for (k = 0; k < funcvet.size(); k++) {
			//verifica se ja existe
			query = "SELECT TEF_CODIGO FROM TREINAMENTO WHERE FUN_CODIGO = "
					+ funcvet.elementAt(k)
					+ " AND TUR_CODIGO_PLAN_ANT = " + turma + " ";
			rsV = conexao.executaConsulta(query, session.getId()
					+ "RS_1");
			if (rsV.next()) {
				contem++;
			} else {
				//out.println("<br>" + k + " - ");
				query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, "
						+ "TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO, TUR_CODIGO_PLAN_ANT, "
						+ "TEF_INICIO, TEF_FIM) " + "VALUES ("
						+ funcvet.elementAt(k)
						+ ", "
						+ rs.getString(1)
						+ ", "
						+ usu_plano
						+ ", "
						+ rs.getString(7)
						+ ", 1, "
						+ rs.getString(2)
						+ ", "
						+ rs.getString(3)
						+ ", CONVERT(datetime, '"
						+ dia
						+ "', 103), '"
						+ rs.getString(5)
						+ "','N', 1, "
						+ turma
						+ ", "
						+ "CONVERT(datetime, '"
						+ tur_inicio
						+ "', 103), CONVERT(datetime, '"
						+ tur_fim
						+ "', 103))";
				//out.println(query+"<br>");
				conexao.executaAlteracao(query);
			}
			if (rsV != null) {
				rsV.close();
				conexao.finalizaConexao(session.getId() + "RS_1");
			}
		}
		query_update = "UPDATE TURMA SET TURMA.TUR_VAGAS = "
				+ (rs.getInt(6) - k + contem)
				+ " WHERE TURMA.TUR_CODIGO = " + turma;
		conexao.executaAlteracao(query_update);
	}
	//***!!!ERRO SE FINALIZAR CONEXAO!!!***
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
	//} catch (Exception e) {
	//  out.println(e);
	//}
%>
