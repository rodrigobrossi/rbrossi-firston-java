<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*,java.text.*"%>

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

<%!public String replaceString(String s, String busca, String troca) {
		String nova = "";
		int ini = s.indexOf(busca);
		boolean ok = false;
		if (ini > 0) {
			ok = true;
		} else {
			nova = s;
		}
		while (ok) {
			int fim = busca.length();
			nova = s.substring(0, ini) + troca
					+ s.substring(ini + fim, s.length());
			ini = nova.indexOf(busca);
			if (ini > 0) {
				s = nova;
			} else {
				ok = false;
			}
		}
		return nova;
	}%>

<%
	//Variaveis e parametros
	String query = "";
	String usu_codigo = "";

	Integer plano = (Integer) session.getAttribute("usu_plano");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	usu_codigo = usu_codigo.valueOf((Integer) session
			.getAttribute("fun_codigo"));

	String curso = (String) request.getParameter("txt_curso");

	String tip = (request.getParameter("sel_tipo") == null)
			? ""
			: request.getParameter("sel_tipo");
	String ass = (request.getParameter("cboassunto") == null)
			? ""
			: request.getParameter("cboassunto");
	String dtinicio = (request.getParameter("dtinicio") == null)
			? ""
			: request.getParameter("dtinicio");
	String dtfim = (request.getParameter("dtfim") == null)
			? ""
			: request.getParameter("dtfim");
	String entidade = (request.getParameter("cboentidade") == null)
			? ""
			: request.getParameter("cboentidade");
	String custo1 = replaceString(
			(request.getParameter("custo") == null) ? "" : request
					.getParameter("custo"), ".", "");
	Float custo = Float.valueOf(custo1.replace(',', '.'));
	String duracao = (request.getParameter("duracao") == null)
			? ""
			: request.getParameter("duracao");
	String duracao2 = (request.getParameter("duracao2") == null)
			? ""
			: request.getParameter("duracao2");
	String observacao = (request.getParameter("observacao") == null)
			? "NULL"
			: "'" + request.getParameter("observacao") + "'";
	String sara = (request.getParameter("sel_saratoga") == null)
			? "NULL"
			: request.getParameter("sel_saratoga");
	String cuslog1 = replaceString(
			(request.getParameter("custo_log") == null) ? "" : request
					.getParameter("custo_log"), ".", "");
	Float cuslog = new Float("0");

	if (!cuslog1.equals("")) {
		cuslog = Float.valueOf(cuslog1.replace(',', '.'));
	}

	String des = "", tit = "", cur_codigo = "";
	ResultSet rs;
	//converte duracao
	int d1 = Integer.parseInt(duracao);
	int d2 = Integer.parseInt(duracao2);
	d1 = d1 * 60;
	int duracaototal = d1 + d2;

	java.util.Date dataAtual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	String dia = formato.format(dataAtual);

	//Dados com os codigos dos funcionarios escolhidos
	Vector functemp = new Vector();
	functemp = (Vector) session.getAttribute("funcs");

	query = "SELECT TIT_CODIGO FROM TITULO WHERE ASS_CODIGO = " + ass;
	rs = conexao.executaConsulta(query, session.getId() + "RS1");
	if (rs.next()) {
		tit = rs.getString(1);
	}

	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS1");
	}

	query = "SELECT DES_CODIGO FROM DESENVOLVIMENTO";
	rs = conexao.executaConsulta(query, session.getId() + "RS2");
	if (rs.next()) {
		des = rs.getString(1);
	}

	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS2");
	}

	/*
	 //este mOdulo verifica se existe algum curso com o mesmo nome do que se estA cadastrando
	 query = "SELECT CUR_CODIGO FROM CURSO " +
	 "WHERE CUR_NOME = '"+curso+"'";
	 rs = conexao.executaConsulta(query);
	 if(!rs.next()){
	 */
	query = "INSERT INTO CURSO (DES_CODIGO, CUR_ATIVO, SAR_CODIGO, CUR_NOME, TIT_CODIGO, CUR_DURACAO, CUR_CUSTO, "
			+ "TCU_CODIGO, CUR_PROGRAMA, CUR_CONSIDERACOES, CUR_OBJETIVO, CUR_DATACADASTRO, CUR_COMOAVALIAR, "
			+ "CUR_CUSTO2, CUR_VERSAOATUAL, CUR_PERIODOREALIZACAO, EMP_CODIGO, FUN_CODIGO_RESP, CUR_SIMPLES) "
			+ "VALUES ("
			+ des
			+ ", 'N',"
			+ sara
			+ ", '"
			+ curso
			+ "', "
			+ tit
			+ ", "
			+ duracao
			+ ", "
			+ custo
			+ ", "
			+ tip
			+ ", "
			+ "'SIMPLES', 'SIMPLES', 'SIMPLES', DATEFMT("
			+ dia
			+ "), "
			+ "'SIMPLES', "
			+ cuslog
			+ ", '1', 'SIMPLES', "
			+ entidade
			+ ", " + usu_codigo + ", 'S')";

	conexao.executaAlteracao(query);

	query = "SELECT CUR_CODIGO FROM CURSO " + "WHERE CUR_NOME = '"
			+ curso + "' AND " + "CUR_DATACADASTRO = DATEFMT(" + dia
			+ ") AND " + "TIT_CODIGO = " + tit + " AND "
			+ "FUN_CODIGO_RESP = " + usu_codigo + "";

	rs = conexao.executaConsulta(query, session.getId() + "RS3");
	if (rs.next()) {
		cur_codigo = (rs.getString(1) == null) ? "" : rs.getString(1);
	}

	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS3");
	}

	//out.println("CODIGO: "+cur_codigo);

	//Loop para inserir os dados
	for (int i = 0; i < functemp.size(); i++) {
		query = "INSERT INTO TREINAMENTO (FUN_CODIGO, PLA_CODIGO, CUR_CODIGO, EMP_CODIGO, "
				+ "TTR_CODIGO, TEF_INICIO, TEF_FIM, TEF_CUSTO, TEF_DURACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO) "
				+ "VALUES ("
				+ functemp.elementAt(i)
				+ ", "
				+ plano
				+ ", "
				+ cur_codigo
				+ ", "
				+ entidade
				+ ", 5, "
				+ "DATEFMT("
				+ dtinicio
				+ "), DATEFMT("
				+ dtfim
				+ "), "
				+ custo
				+ ", "
				+ duracaototal
				+ ", "
				+ observacao
				+ ", 'N')";

		//out.println(query + " - ");
		conexao.executaAlteracao(query);
	}

	//limpa o vetor
	functemp.clear();
	session.setAttribute("funcs", functemp);
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script language="JavaScript">
	    alert(<%=("\""
									+ trd
											.Traduz("REGISTRO REALIZADO COM SUCESSO") + "\"")%>);
	    window.open("14_lancamentosanteriores.jsp","_self");
	</script>
<%
	//}
	/*
	 ////este else nAo deixa incluir dois cursos com o mesmo nome/////
	 else{
%>
<script language="JavaScript">
	    alert(<%=("\""+trd.Traduz("ESTE CURSO JA EXISTE")+"\"")%>);
	    history.go(-1);
	    //window.open("14_lancamentosanteriores.jsp","_self");
	</script>
<%
	}*/
%>