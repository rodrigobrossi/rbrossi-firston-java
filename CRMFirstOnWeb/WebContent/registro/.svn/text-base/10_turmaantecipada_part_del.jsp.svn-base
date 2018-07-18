
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
	//try{

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
	String origem = request.getParameter("origem");
	String contador = (String) request.getParameter("contador"); //contador do numero de funcionarios possiveis

	String codigo_comp = "", codigo_trein = "", query = "", queryA = "", queryB = "", codigo_func = "", dia = "", n = "", planejado = "";
	int tam_codigo = 0, k = 0, cont = 0, pag = 0;
	boolean virgula = false;
	ResultSet rs, rsA, rsB;
	Vector funcvet = new Vector();
	Vector treivet = new Vector();
	Vector funcOK = new Vector();
	Vector funcNO = new Vector();

	int cont_func = (request.getParameter("cont_func") == null
			? 0
			: Integer.parseInt(request.getParameter("cont_func")));

	//Variavel de data atual
	java.util.Date dataAtual = new java.util.Date();
	SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
	dia = formato.format(dataAtual);

	//TESTE VETOR DADOS
	//Busca e Insere dados no vetor de funcionArios selecionados
	pag = Integer.parseInt((String) session.getAttribute("pagina"));
	funcvet = (Vector) session.getAttribute("funcs");
	treivet = (Vector) session.getAttribute("funcs");

	//out.println("FUNCS"+funcvet);

	//insere os elementos no vetor
	for (k = 0; k <= pag; k++) {
		if (!(request.getParameter("checkbox" + n.valueOf(k)) == null)) {
			codigo_trein = request.getParameter("checkbox"
					+ n.valueOf(k));
			treivet.add(codigo_trein);
		}
	}
	session.setAttribute("funcs", funcvet);

	//Consiste dados de funcionarios

	int tamv = treivet.size();//Tamanho do vetor de funcionarios
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

	for (k = 0; k < treivet.size(); k++) {
		queryA = "SELECT TEF_CODIGO FROM LANCAMENTO WHERE TEF_CODIGO = "
				+ treivet.elementAt(k);
		rsA = conexao.executaConsulta(queryA, session.getId());
		//out.println("queryA = " + queryA);

		if (rsA.next()) {
			queryB = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TEF_CODIGO = "
					+ rsA.getString(1);
			rsB = conexao.executaConsulta(queryB, session.getId()
					+ "RS_2");
			//out.println("queryBe = " + queryB);
			if (rsB.next()) {
				if (!funcNO.contains(rsB.getString(1))) {
					funcNO.addElement(rsB.getString(1));
				}
			}
			if (rsB != null) {
				rsB.close();
				conexao.finalizaConexao(session.getId() + "RS_2");
			}
		}

		else {
			queryB = "SELECT FUN_CODIGO, TEF_PLANEJADO FROM TREINAMENTO WHERE TEF_CODIGO = "
					+ treivet.elementAt(k);
			rsB = conexao.executaConsulta(queryB, session.getId()
					+ "RS_2");
			//out.println("queryB = " + queryB);
			if (rsB.next()) {
				if (rsB.getString(1) != null) {
					codigo_func = rsB.getString(1);
					planejado = rsB.getString(2);

					if (planejado.equals("S")) {
						query = "UPDATE TREINAMENTO SET TUR_CODIGO_PLAN_ANT = NULL WHERE FUN_CODIGO = "
								+ codigo_func
								+ " AND TUR_CODIGO_PLAN_ANT = " + turma;
					} else {
						query = "DELETE FROM TREINAMENTO WHERE FUN_CODIGO = "
								+ codigo_func
								+ " AND TUR_CODIGO_PLAN_ANT = " + turma;
					}
					//out.println("query = " + query);
					conexao.executaAlteracao(query);
					if (!funcOK.contains(codigo_func)) {
						funcOK.addElement(codigo_func);
					}
					cont++;
				}
			}
			if (rsB != null) {
				rsB.close();
				conexao.finalizaConexao(session.getId() + "RS_2");
			}
		}
		if (rsA != null) {
			rsA.close();
			conexao.finalizaConexao(session.getId());
		}
	}

	if (funcNO.size() > 0) {
%>

<script language="JavaScript">
	alert(<%=("\""
										+ trd
												.Traduz("PARTICIPANTES COM LANCAMENTOS NAO FORAM EXCLUIDOS!") + "\"")%>);	
        window.open("10_turmaantecipada_reg.jsp?turma=<%=turma%>","_self");
</script>
<%
	}

	//numero de vagas
	int vagas = 0;
	query = "SELECT TUR_VAGAS FROM TURMA WHERE TUR_CODIGO = " + turma
			+ " ";
	rs = conexao.executaConsulta(query, session.getId() + "RS_3");
	if (rs.next()) {
		vagas = rs.getInt(1);
	}
	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId() + "RS_3");
	}

	request.getSession();
	session.setAttribute("funcOK", funcOK);
	session.setAttribute("funcNO", funcNO);

	query = "UPDATE TURMA SET TURMA.TUR_VAGAS = " + (vagas + cont)
			+ " WHERE TURMA.TUR_CODIGO = " + turma;
	conexao.executaAlteracao(query);

	//if(rs != null) rs.close();

	//conexao.finalizaConexao();
	if (funcOK.size() > 0) {
%>
<script language="JavaScript">
	//showModalDialog("alert2.jsp","popup","center=yes;status=no;dialogWidth=470px;dialogHeight=400px");
        alert(<%=("\""
										+ trd
												.Traduz("PARTICIPANTE EXCLUIDO COMSUCESSO!") + "\"")%>);
	window.open("10_turmaantecipada_reg.jsp?turma=<%=turma%>","_self");
</script>
<%
	}
	//} catch(Exception e){
	//  out.println("ERRO: "+e);
	//}
%>
