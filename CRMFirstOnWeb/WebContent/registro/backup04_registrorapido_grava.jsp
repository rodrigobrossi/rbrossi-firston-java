
<%
	//Limpa cache
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.text.*,java.util.*"%>

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
	//recupera valores
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	String usu_tipo = ((String) session.getAttribute("usu_tipo"));
	String usu_nome = trataAspas((String) session
			.getAttribute("usu_nome"));
	String usu_login = trataAspas((String) session
			.getAttribute("usu_login"));
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String usu_codigo = "", usu_plano = "";
	usu_codigo = usu_codigo.valueOf((Integer) session
			.getAttribute("fun_codigo"));
	usu_plano = usu_plano.valueOf(session.getAttribute("usu_plano"));

	String ass = (request.getParameter("selectass") == null)
			? ""
			: request.getParameter("selectass");
	String sara = (request.getParameter("sel_saratoga") == null)
			? "NULL"
			: request.getParameter("sel_saratoga");
	String cur = (request.getParameter("curso") == null)
			? ""
			: trataAspas(request.getParameter("curso"));
	String tip = (request.getParameter("sel_tipo") == null)
			? ""
			: request.getParameter("sel_tipo");
	String dtini = (request.getParameter("txtdtinic") == null)
			? ""
			: request.getParameter("txtdtinic");
	String dtfim = (request.getParameter("txtdtfim") == null)
			? ""
			: request.getParameter("txtdtfim");
	String cuscur = (request.getParameter("txtcustocurso") == null)
			? ""
			: trataAspas(request.getParameter("txtcustocurso"));
	String cuslog_txt = (String) request.getParameter("txtcustolog");
	Float cuslog = Float.valueOf(cuslog_txt.replace(',', '.'));
	String duracao = (request.getParameter("txtduracao") == null)
			? ""
			: trataAspas(request.getParameter("txtduracao"));
	String duracao2 = (request.getParameter("txtduracao2") == null)
			? ""
			: trataAspas(request.getParameter("txtduracao2"));
	String entidade = (request.getParameter("selectent") == null)
			? ""
			: request.getParameter("selectent");
	String instrutor = (request.getParameter("selectinst") == null)
			? ""
			: request.getParameter("selectinst");
	String obs = (request.getParameter("txtobs") == null)
			? ""
			: trataAspas(request.getParameter("txtobs"));

	String turma = "", tit = "", codcur = "", des = "", query = "";
	Vector funcvet = new Vector();
	funcvet = (Vector) session.getAttribute("funcs");

	//try{

	float h = 0, m = 0, dur = 0;
	h = (float) Float.parseFloat(duracao);
	m = (float) Float.parseFloat(duracao2);
	dur = (h * 60) + m;

	//Variavel de data atual
	java.util.Date dataAtual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	String dia = formato.format(dataAtual);

	//Valor de titulo aleatorio para o registro rapido
	ResultSet rs = null;
	query = "SELECT TIT_CODIGO FROM TITULO WHERE ASS_CODIGO = " + ass;
	rs = conexao.executaConsulta(query, session.getId());
	if (rs.next())
		tit = rs.getString(1);
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
	//Valor de desenvolvimento aleatorio para o registro rapido
	query = "SELECT DES_CODIGO FROM DESENVOLVIMENTO";
	rs = conexao.executaConsulta(query, session.getId() + "RS_1");
	if (rs.next())
		des = rs.getString(1);
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_1");
	}
	query = "INSERT INTO CURSO (DES_CODIGO, CUR_ATIVO, SAR_CODIGO, CUR_NOME, TIT_CODIGO, CUR_DURACAO, CUR_CUSTO, "
			+ "TCU_CODIGO, CUR_PROGRAMA, CUR_CONSIDERACOES, CUR_OBJETIVO, CUR_DATACADASTRO, CUR_COMOAVALIAR, "
			+ "CUR_CUSTO2, CUR_VERSAOATUAL, CUR_PERIODOREALIZACAO, EMP_CODIGO, FUN_CODIGO_RESP, CUR_SIMPLES) "
			+ "VALUES ("
			+ des
			+ ", 'N',"
			+ sara
			+ ", '"
			+ cur
			+ "', "
			+ tit
			+ ", "
			+ dur
			+ ", "
			+ cuscur
			+ ", "
			+ tip
			+ ", "
			+ "'SIMPLES', 'SIMPLES', 'SIMPLES', CONVERT(datetime, '"
			+ dia
			+ "', 103), "
			+ "'SIMPLES', "
			+ cuslog
			+ ", '1', 'SIMPLES', "
			+ entidade
			+ ", "
			+ usu_codigo
			+ ", 'S')";

	//out.println("<br>QUERY01:"+query);

	conexao.executaAlteracao(query);

	query = "SELECT CUR_CODIGO FROM CURSO " + "WHERE CUR_NOME = '"
			+ cur + "' AND " + "CUR_DATACADASTRO = CONVERT(datetime, '"
			+ dia + "', 103) AND " + "TIT_CODIGO = " + tit + " AND "
			+ "FUN_CODIGO_RESP = " + usu_codigo + "";
	rs = conexao.executaConsulta(query, session.getId() + "RS_2");
	if (rs.next())
		codcur = rs.getString(1);
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_2");
	}
	if (!(instrutor.equals(""))) {
		query = "INSERT INTO TURMA (EMP_CODIGO, FUN_CODIGO, TUR_DATAINICIO, "
				+ "TUR_DATAFINAL, PLA_CODIGO,  TUR_DURACAO, INS_CODIGO, TUR_CUSTO, CUR_CODIGO, TUR_VAGAS, "
				+ "TUR_OBS, TUR_PLANEJADA, TUR_REPROGRAMADA, TUR_REGISTRADA, TUR_CUSTO2, TTR_CODIGO) VALUES ("
				+ entidade
				+ ", "
				+ usu_codigo
				+ ", "
				+ "CONVERT(datetime, '"
				+ dtini
				+ "', 103), CONVERT(datetime, '"
				+ dtfim
				+ "', 103), "
				+ usu_plano
				+ ", "
				+ dur
				+ ", "
				+ instrutor
				+ ", "
				+ cuscur
				+ ", "
				+ codcur
				+ ", 0, '"
				+ obs
				+ "', 'N', 'N', 'S', " + cuslog + ", 4)";
	}

	else {
		query = "INSERT INTO TURMA (EMP_CODIGO, FUN_CODIGO, TUR_DATAINICIO, "
				+ "TUR_DATAFINAL, PLA_CODIGO,  TUR_DURACAO, TUR_CUSTO, CUR_CODIGO, TUR_VAGAS, "
				+ "TUR_OBS, TUR_PLANEJADA, TUR_REPROGRAMADA, TUR_REGISTRADA, TUR_CUSTO2, TTR_CODIGO) VALUES ("
				+ entidade
				+ ", "
				+ usu_codigo
				+ ", "
				+ "CONVERT(datetime, '"
				+ dtini
				+ "', 103), CONVERT(datetime, '"
				+ dtfim
				+ "', 103), "
				+ usu_plano
				+ ", "
				+ dur
				+ ", "
				+ cuscur
				+ ", "
				+ codcur
				+ ", 0, '"
				+ obs
				+ "', 'N', 'N', 'S', "
				+ cuslog + ", 4)";
	}
	//out.println("<br>QUERY02:"+query);
	conexao.executaAlteracao(query);

	//Para os Planejados
	query = "SELECT (TUR_CODIGO) FROM TURMA WHERE FUN_CODIGO = "
			+ usu_codigo + " " + "AND CUR_CODIGO = " + codcur
			+ " AND TUR_DATAINICIO = CONVERT(datetime, '" + dtini
			+ "', 103) " + "AND TUR_OBS = '" + obs + "' ";
	//out.println("******"+query+"*******");
	rs = conexao.executaConsulta(query, session.getId() + "RS_3");
	if (rs.next())
		turma = rs.getString(1);
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_3");
	}
	//Para os NAo Planejados RApidos
	//out.println("tamanho = " + funcvet.size());
	for (int k = 0; k < funcvet.size(); k++) {
		query = "INSERT INTO TREINAMENTO (FUN_CODIGO, CUR_CODIGO, PLA_CODIGO, TTR_CODIGO, QBR_CODIGO, "
				+ "TEF_DURACAO, TEF_CUSTO, TEF_DATASOLICITACAO, TEF_RESULTADOESPERADO, TEF_PLANEJADO, TEF_TIPOSOLICITACAO, TUR_CODIGO_REAL) "
				+ "VALUES ("
				+ funcvet.elementAt(k)
				+ ", "
				+ codcur
				+ ", "
				+ usu_plano
				+ ", 4"
				+ ", 1, "
				+ dur
				+ ", "
				+ cuscur
				+ ", "
				+ "CONVERT(datetime, '"
				+ dia
				+ "', 103), '" + obs + "', 'N', 1, " + turma + ")";

		//out.println("<br>QUERY03:"+query);    

		conexao.executaAlteracao(query);
		//out.println(query);
	}

	//**Insere custo logistaica em banco (tabela CUSTOREAL)**
	Vector vet_desc = new Vector();
	Vector vet_cust = new Vector();
	//recupera da sessao os vetores de custo
	if ((Vector) session.getAttribute("vet_descS") != null)
		vet_desc = (Vector) session.getAttribute("vet_descS");
	if ((Vector) session.getAttribute("vet_custS") != null)
		vet_cust = (Vector) session.getAttribute("vet_custS");
	//insere
	int cont = 0;
	String desc_vet = "", valor_vet = "";
	while (cont < vet_cust.size()) {
		desc_vet = (String) vet_desc.elementAt(cont);
		valor_vet = (String) vet_cust.elementAt(cont);
		query = "INSERT INTO CUSTOREAL (TUR_CODIGO, CRE_DESCRICAO, CRE_CUSTO, FUN_CODIGO) "
				+ "VALUES ("
				+ turma
				+ ", '"
				+ desc_vet
				+ "', "
				+ valor_vet + ", " + usu_codigo + ")";
		//out.println(query +"<br>");
		//out.println("<br>QUERY04:"+query);
		conexao.executaAlteracao(query);
		cont++;
	}
	//limpa vetores
	vet_cust.clear();
	vet_desc.clear();
	session.setAttribute("vet_descS", vet_desc);
	session.setAttribute("vet_custS", vet_cust);

	//limpa vetor
	funcvet.clear();
	session.setAttribute("funcs", funcvet);

	//if(rs != null) rs.close();
	//conexao.finalizaConexao();

	//} catch (Exception r) {
	//  out.println(r);
	//}
%>


<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""
									+ trd
											.Traduz("REGISTRO REALIZADO COM SUCESSO!") + "\"")%>);
    window.open("02_registrorapido.jsp","_self");
</script>
