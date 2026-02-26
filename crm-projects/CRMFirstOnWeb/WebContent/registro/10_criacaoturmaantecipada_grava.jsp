
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
	//try {

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

	String ass = (request.getParameter("selectass") == null)
			? ""
			: request.getParameter("selectass");
	String tit = (request.getParameter("selecttit") == null)
			? ""
			: request.getParameter("selecttit");
	String cur = (request.getParameter("selectcur") == null)
			? ""
			: request.getParameter("selectcur");
	String tip = (request.getParameter("selecttip") == null)
			? ""
			: request.getParameter("selecttip");
	String dtini = (request.getParameter("textdatai") == null)
			? ""
			: request.getParameter("textdatai");
	String dtfim = (request.getParameter("textdataf") == null)
			? ""
			: request.getParameter("textdataf");
	String tipo_treinamento = (request.getParameter("longa") == null)
			? "2"
			: "3";//2=turma antecipada & 3=lomga duracao
	String cuscur = (request.getParameter("textcustocur") == null)
			? ""
			: request.getParameter("textcustocur");
	cuscur = replaceString(cuscur, ",", ".");
	String cuslog = (request.getParameter("textcustolog") == null)
			? ""
			: request.getParameter("textcustolog");
	cuslog = replaceString(cuslog, ",", ".");
	String pmin = (request.getParameter("txtmin") == null)
			? ""
			: request.getParameter("txtmin");
	String pmax = (request.getParameter("txtmax") == null)
			? ""
			: request.getParameter("txtmax");
	String duracao = (request.getParameter("textdurh") == null)
			? ""
			: request.getParameter("textdurh");
	String duracao2 = (request.getParameter("textdurm") == null)
			? ""
			: request.getParameter("textdurm");
	String entidade = (request.getParameter("selectent") == null)
			? ""
			: request.getParameter("selectent");
	String instrutor = (request.getParameter("selectinst") == null)
			? ""
			: request.getParameter("selectinst");
	String obs = (request.getParameter("txtobs") == null)
			? ""
			: trataAspas(request.getParameter("txtobs"));
	String tipo = (request.getParameter("tipo") == null) ? "" : request
			.getParameter("tipo");
	String turma = (request.getParameter("rdo_turma") == null)
			? ""
			: request.getParameter("rdo_turma");
	int cont_avaliacao = (request.getParameter("cont_avaliacao") == null)
			? 0
			: Integer.parseInt((String) request
					.getParameter("cont_avaliacao"));

	float h = 0, m = 0, dur = 0;
	h = (float) Float.parseFloat(duracao);
	m = (float) Float.parseFloat(duracao2);
	dur = (h * 60) + m;
	String query = "", query_t = "", nova_turma = "", questionario = "", envio = "", vencimento = "", processo = "";
	ResultSet rs = null;
	int qtde = 0, vagas = 0;

	if (tipo.equals("I")) {
		if (!(instrutor.equals(""))) {
			query = "INSERT INTO TURMA (EMP_CODIGO, FUN_CODIGO, TUR_DATAINICIO, TUR_DATAFINAL, PLA_CODIGO, TUR_DURACAO, INS_CODIGO, "
					+ "TUR_CUSTO, CUR_CODIGO, TUR_VAGAS, TUR_OBS, TUR_PLANEJADA, TUR_REPROGRAMADA, TUR_REGISTRADA, TUR_CUSTO2, TUR_PARTICIPMIN, "
					+ "TUR_PARTICIPMAX, TCU_CODIGO, TTR_CODIGO) "
					+ "VALUES ("
					+ entidade
					+ ", "
					+ usu_codigo
					+ ",  DATEFMT("
					+ dtini
					+ "),  DATEFMT("
					+ dtfim
					+ "), "
					+ usu_plano
					+ ", "
					+ dur
					+ ", "
					+ instrutor
					+ ", "
					+ cuscur
					+ ", "
					+ cur
					+ ", "
					+ pmax
					+ ", '"
					+ obs
					+ "', 'S', 'N', 'N', "
					+ cuslog
					+ ", "
					+ pmin
					+ ", "
					+ pmax
					+ ", "
					+ tip
					+ ", "
					+ tipo_treinamento + ")";
		} else {
			query = "INSERT INTO TURMA (EMP_CODIGO, FUN_CODIGO, TUR_DATAINICIO, TUR_DATAFINAL, PLA_CODIGO, TUR_DURACAO, "
					+ "TUR_CUSTO, CUR_CODIGO, TUR_VAGAS, TUR_OBS, TUR_PLANEJADA, TUR_REPROGRAMADA, TUR_REGISTRADA, TUR_CUSTO2, TUR_PARTICIPMIN, "
					+ "TUR_PARTICIPMAX, TCU_CODIGO, TTR_CODIGO) "
					+ "VALUES ("
					+ entidade
					+ ", "
					+ usu_codigo
					+ ",  DATEFMT("
					+ dtini
					+ "),  DATEFMT("
					+ dtfim
					+ "), "
					+ usu_plano
					+ ", "
					+ dur
					+ ", "
					+ cuscur
					+ ", "
					+ cur
					+ ", "
					+ pmax
					+ ", '"
					+ obs
					+ "', 'S', 'N', 'N', "
					+ cuslog
					+ ", "
					+ pmin
					+ ", "
					+ pmax
					+ ", "
					+ tip
					+ ", "
					+ tipo_treinamento + ")";
		}

		conexao.executaAlteracao(query);

		//Recupera a turma inserida
		query_t = "SELECT MAX(TUR_CODIGO) FROM TURMA WHERE FUN_CODIGO = "
				+ usu_codigo
				+ " "
				+ "AND CUR_CODIGO = "
				+ cur
				+ " AND TUR_DATAINICIO =  DATEFMT("
				+ dtini
				+ ") "
				+ "AND TUR_OBS = '" + obs + "' ";
		rs = conexao.executaConsulta(query_t, session.getId() + "RS_1");

		if (rs.next()) {
			nova_turma = rs.getString(1);
		}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_1");
		}

	} else {
		query = "SELECT COUNT(*) FROM TREINAMENTO WHERE TUR_CODIGO_PLAN_ANT = "
				+ turma;
		rs = conexao.executaConsulta(query, session.getId() + "RS_2");
		if (rs.next()) {
			qtde = rs.getInt(1);
		}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_2");
		}
		vagas = Integer.parseInt(pmax) - qtde;

		if (!(instrutor.equals(""))) {
			query = "UPDATE TURMA SET EMP_CODIGO = " + entidade
					+ ", FUN_CODIGO = " + usu_codigo + ", "
					+ "TUR_DATAINICIO = DATEFMT(" + dtini + "), "
					+ "TUR_DATAFINAL =  DATEFMT(" + dtfim
					+ "), TUR_DURACAO = " + dur + ", "
					+ "INS_CODIGO = " + instrutor + ", TUR_CUSTO = "
					+ cuscur + ", CUR_CODIGO = " + cur + ", "
					+ "TUR_OBS = '" + obs + "', TUR_CUSTO2 = " + cuslog
					+ ", TUR_PARTICIPMIN = " + pmin + ", "
					+ "TUR_PARTICIPMAX = " + pmax + ", TCU_CODIGO = "
					+ tip + ", " + "TTR_CODIGO = " + tipo_treinamento
					+ ", TUR_VAGAS = " + vagas + " WHERE TUR_CODIGO = "
					+ turma;
		} else {
			query = "UPDATE TURMA SET EMP_CODIGO = " + entidade
					+ ", FUN_CODIGO = " + usu_codigo + ", "
					+ "TUR_DATAINICIO =  DATEFMT(" + dtini + "), "
					+ "TUR_DATAFINAL =  DATEFMT(" + dtfim
					+ "), TUR_DURACAO = " + dur + ", " + "TUR_CUSTO = "
					+ cuscur + ", CUR_CODIGO = " + cur + ", "
					+ "TUR_OBS = '" + obs + "', TUR_CUSTO2 = " + cuslog
					+ ", TUR_PARTICIPMIN = " + pmin + ", "
					+ "TUR_PARTICIPMAX = " + pmax + ", TCU_CODIGO = "
					+ tip + ", " + "TTR_CODIGO = " + tipo_treinamento
					+ ", TUR_VAGAS = " + vagas + " WHERE TUR_CODIGO = "
					+ turma;
		}
		//out.println(query);
		conexao.executaAlteracao(query);
		//turma modificada
		nova_turma = turma;
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

	//detela os anteriores para nao haver duplicidade
	if (!turma.equals("")) {
		query = "DELETE CUSTOREAL WHERE TUR_CODIGO = " + turma;
		//out.println(query);
		conexao.executaAlteracao(query);
	}

	while (cont < vet_cust.size()) {
		desc_vet = (String) vet_desc.elementAt(cont);
		valor_vet = (String) vet_cust.elementAt(cont);
		query = "INSERT INTO CUSTOREAL (TUR_CODIGO, CRE_DESCRICAO, CRE_CUSTO, FUN_CODIGO) "
				+ "VALUES ("
				+ nova_turma
				+ ", '"
				+ desc_vet
				+ "', "
				+ valor_vet + ", " + usu_codigo + ")";

		conexao.executaAlteracao(query);
		cont++;
	}
	//limpa vetores
	vet_cust.clear();
	vet_desc.clear();
	session.setAttribute("vet_descS", vet_desc);
	session.setAttribute("vet_custS", vet_cust);

	if (tipo.equals("I")) {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
  alert(<%=("\""
										+ trd
												.Traduz("CRIACAO DE TURMA REALIZADA COM SUCESSO!") + "\"")%>);
  window.open("06_criarturmaantecipada.jsp","_self");
</script>
<%
	} else {
%>
<script language="JavaScript">
  alert(<%=("\""
										+ trd
												.Traduz("ALTERACAO REALIZADA COM SUCESSO!") + "\"")%>);
  window.open("06_criarturmaantecipada.jsp","_self");
</script>
<%
	}

	//} catch (Exception e) {
	//  out.println(e);
	//}
%>
