
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
	String turma = (request.getParameter("turma") == null)
			? ""
			: (String) request.getParameter("turma");
	int cont_avaliacao = (request.getParameter("cont_avaliacao") == null)
			? 0
			: Integer.parseInt((String) request
					.getParameter("cont_avaliacao"));

	ResultSet rs = null, rs_P = null, rs_F = null;

	//variavies
	String query = "", questionario = "", envio = "", vencimento = "";

	Vector processos = new Vector();

	query = "UPDATE TURMA SET TUR_REGISTRADA = 'S' WHERE TUR_CODIGO = "
			+ turma;
	//out.println(query);
	conexao.executaAlteracao(query);
	query = "UPDATE TREINAMENTO SET TUR_CODIGO_REAL = " + turma
			+ " WHERE TUR_CODIGO_PLAN_ANT = " + turma;
	//out.println(query);
	conexao.executaAlteracao(query);

	//insere avaliacoes
	for (int i = 0; i <= cont_avaliacao; i++) {//loop para as avaliacoes
		if (request.getParameter("chk_" + i) != null) {
			if (!request.getParameter("chk_" + i).equals("")) {
				questionario = request.getParameter("cbo_questionario_"
						+ i);
				envio = request.getParameter("txt_dt_envio_" + i);
				vencimento = request.getParameter("txt_dt_vencimento_"
						+ i);
				query = "SELECT PRO_CODIGO FROM PROCESSO WHERE QUE_CODIGO = "
						+ questionario + " AND TUR_CODIGO = " + turma;//verifica se a avalicao ja foi cadastrada
				rs = conexao.executaConsulta(query, session.getId());
				if (!rs.next()) {//senao foi cadastrado, cadastra!
					query = "INSERT INTO PROCESSO (FUN_CODIGO_RESP, QUE_CODIGO, PRO_ENVLAUDO, PRO_FIM, TUR_CODIGO) "
							+ "VALUES ("
							+ usu_codigo
							+ ", "
							+ questionario
							+ ", DATEFMT("
							+ envio
							+ "), "
							+ "DATEFMT("
							+ vencimento
							+ "), "
							+ turma + ")";
					conexao.executaAlteracao(query);
					query = "SELECT PRO_CODIGO FROM PROCESSO WHERE QUE_CODIGO = "
							+ questionario
							+ " AND TUR_CODIGO = "
							+ turma;
					rs_P = conexao.executaConsulta(query, session
							.getId()
							+ "RS_1");
					if (rs_P.next()) {
						processos.addElement(rs_P.getString(1));
					}
					if (rs_P != null) {
						rs_P.close();
						conexao.finalizaConexao(session.getId()
								+ "RS_1");
					}
				} else {
					processos.addElement(rs.getString(1));//vetor com os processos
				}
				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId());
				}
			}
		}
	}

	//insere avaliados
	query = "SELECT FUN_CODIGO FROM TREINAMENTO WHERE TUR_CODIGO_PLAN_ANT = "
			+ turma;
	//out.println(query + "<br>N. processo:" +processos.size());
	rs_F = conexao.executaConsulta(query, session.getId() + "RS_3");
	if (rs_F.next()) {
		do {
			for (int ii = 0; ii < processos.size(); ii++) {
				query = "INSERT INTO AVALIADO (PRO_CODIGO, FUN_CODIGO) VALUES ("
						+ processos.elementAt(ii)
						+ ", "
						+ rs_F.getString(1) + ")";
				conexao.executaAlteracao(query);

				query = "SELECT FUN_CODSOLIC FROM FUNCIONARIO WHERE FUN_CODIGO = "
						+ rs_F.getString(1);
				ResultSet rsU = conexao.executaConsulta(query, session
						.getId()
						+ "RS_5");
				rsU.next();

				query = "SELECT AVD_CODIGO "
						+ "FROM AVALIADO WHERE PRO_CODIGO = "
						+ processos.elementAt(ii) + " "
						+ "AND FUN_CODIGO = " + rs_F.getString(1);
				ResultSet rsV = conexao.executaConsulta(query, session
						.getId()
						+ "RS_4");
				rsV.next();
				query = "INSERT INTO AVALIADOR (PRO_CODIGO, AVD_CODIGO, FUN_CODIGO) "
						+ "VALUES ("
						+ processos.elementAt(ii)
						+ ", "
						+ rsV.getString(1)
						+ ", "
						+ rsU.getString(1)
						+ ")";
				conexao.executaAlteracao(query);
				if (rsU != null) {
					rsU.close();
					conexao.finalizaConexao(session.getId() + "RS_5");
				}
				if (rsV != null) {
					rsV.close();
					conexao.finalizaConexao(session.getId() + "RS_4");
				}
				//out.println(query+"<br>");
			}
		} while (rs_F.next());
	}
	if (rs_F != null) {
		rs_F.close();
		conexao.finalizaConexao(session.getId() + "RS_3");
	}
%>


<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
  alert(<%=("\""
									+ trd
											.Traduz("REGISTRO DA TURMA REALIZADO COM SUCESSO") + "\"")%>);
  window.open("06_criarturmaantecipada.jsp","_self");
</script>

<%
	//} catch (Exception e) {
	//  out.println(e);
	//}
%>