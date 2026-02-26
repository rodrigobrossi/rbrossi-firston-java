<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	String query = "", queryB = "", per_codigo = "", queryI = "", gru_codigo = "", queryR = "", per_tipo = "", que_codigo = "", fun_cod = "", res_codigo = "", queryA = "", qgr_valor = "", resp_diss = "", resp_num = "", pro_codigo = "", qtde_numericas = "";

	ResultSet rs = null, rsR = null, rsB = null;
	int i = 0, a = 0;

	if (request.getParameter("per_tipo") != null) {
		per_tipo = request.getParameter("per_tipo");
	}
	if (request.getParameter("que_codigo") != null) {
		que_codigo = request.getParameter("que_codigo");
	}
	if (request.getParameter("fun_cod") != null) {
		fun_cod = request.getParameter("fun_cod");
	}
	if (request.getParameter("pro_codigo") != null) {
		pro_codigo = request.getParameter("pro_codigo");
	}

	queryB = "SELECT FUN_CODSOLIC FROM FUNCIONARIO WHERE FUN_CODIGO = "
			+ fun_cod;
	rsB = conexao.executaConsulta(queryB, session.getId() + "RS_1");
	rsB.next();

	query = "SELECT AVD_STATUS FROM AVALIADO WHERE FUN_CODIGO = "
			+ fun_cod + " AND PRO_CODIGO = " + pro_codigo
			+ " AND AVD_STATUS = 'S'";
	rs = conexao.executaConsulta(query, session.getId() + "RS_2");

	if (rs.next()) {
%>

<script
	language="JavaScript">
    alert(<%=("\""
										+ trd
												.Traduz("ESTE QUESTIONARIO JA FOI RESPONDIDO") + "\"")%>);
    //return false;
  </script>
<%
	} else {
		query = "SELECT P.PER_NOME, P.PER_CODIGO, P.PER_TIPO, Q.GRU_CODIGO "
				+ "FROM PERGUNTA P, QUEST_PERGUNTA Q "
				+ "WHERE Q.QUE_CODIGO = "
				+ que_codigo
				+ " "
				+ "AND P.PER_CODIGO = Q.PER_CODIGO";
		//out.println("QUERY1: "+query);
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_2");
		}

		rs = conexao.executaConsulta(query, session.getId() + "RS_3");

		if (rs.next()) {
			do {
				//out.println("<br>PER" + rs.getString(2));
				if (!per_codigo.equals(rs.getString(2))) {
					per_codigo = rs.getString(2);
					per_tipo = rs.getString(3);
					gru_codigo = rs.getString(4);

					if (per_tipo.equals("ME")) {
						i++;
						res_codigo = request.getParameter("resp" + i);

						queryR = "SELECT QGR_VALOR FROM QUEST_RESP"
								+ " WHERE QUE_CODIGO = " + que_codigo
								+ " AND PER_CODIGO = " + per_codigo
								+ " AND RES_CODIGO = " + res_codigo;
						//out.println(queryR);
						rsR = conexao.executaConsulta(queryR, session
								.getId()
								+ "RS_4");
						if (rsR.next()) {
							qgr_valor = rsR.getString(1);
							resp_diss = "";
							resp_num = "";
						}
					} else if (per_tipo.equals("N ")) {
						a++;
						resp_num = request.getParameter("num_" + a);
						qgr_valor = "";
						resp_diss = "";
						res_codigo = "";

					} else {
						qgr_valor = "";
						res_codigo = "";
						resp_diss = request.getParameter("txt_"
								+ per_codigo);
					}
				}

				if (per_tipo.equals("ME")) {
					queryI = "INSERT INTO LAUDO (AVR_CODIGO, PRO_CODIGO, RES_CODIGO, PER_CODIGO, PER_TIPO, GRU_CODIGO, "
							+ "QGR_VALOR) VALUES "
							+ "("
							+ rsB.getString(1)
							+ ","
							+ pro_codigo
							+ ","
							+ res_codigo
							+ ","
							+ per_codigo
							+ ",'"
							+ per_tipo
							+ "',"
							+ gru_codigo
							+ ","
							+ qgr_valor + ")";
				} else if (per_tipo.equals("D ")) {
					queryI = "INSERT INTO LAUDO (AVR_CODIGO, PRO_CODIGO, PER_CODIGO, PER_TIPO, "
							+ "LAU_RESPDISSERT) VALUES "
							+ "("
							+ rsB.getString(1)
							+ ","
							+ pro_codigo
							+ ","
							+ per_codigo
							+ ",'"
							+ per_tipo
							+ "','"
							+ resp_diss + "')";
				} else if (per_tipo.equals("N ")) {
					queryI = "INSERT INTO LAUDO (AVR_CODIGO, PRO_CODIGO, PER_CODIGO, PER_TIPO, "
							+ "LAU_RESPNUMERICA) VALUES "
							+ "("
							+ rsB.getString(1)
							+ ","
							+ pro_codigo
							+ ","
							+ per_codigo
							+ ",'"
							+ per_tipo
							+ "',"
							+ resp_num + ")";
				}
				//out.println("QUERY:"+queryI);
				conexao.executaAlteracao(queryI);

				/*    
				out.println("<br>COdigo do avaliador:    "+rsB.getString(1));
				out.println("<br>COdigo do processo:     "+pro_codigo);
				out.println("<br>Tipo da pergunta:       "+per_tipo);
				out.println("<br>COdigo do questionArio: "+que_codigo);
				out.println("<br>COdigo do funcionArio:  "+fun_cod);
				out.println("<br>COdigo do grupo:        "+gru_codigo);
				out.println("<br>COdigo da pergunta:     "+per_codigo);
				out.println("<br>COdigo da resposta:     "+res_codigo);
				out.println("<br>Valor da resposta ME:   "+qgr_valor);
				out.println("<br>Resposta dissertativa:  "+resp_diss);
				out.println("<br>Resposta numErica:      "+resp_num);
				out.println("<br>*************************************");
				 */
			} while (rs.next());

		}

		queryI = "UPDATE AVALIADO SET AVD_STATUS = 'S' WHERE FUN_CODIGO = "
				+ fun_cod + " AND PRO_CODIGO = " + pro_codigo;
		conexao.executaAlteracao(queryI);

		if (rsB != null) {
			rsB.close();
			conexao.finalizaConexao(session.getId() + "RS_1");
		}

		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId() + "RS_3");
		}

		if (rsR != null) {
			rsR.close();
			conexao.finalizaConexao(session.getId() + "RS_4");
		}

	}
%>

<script language="JavaScript">
  window.open("responder.jsp","_self");
</script>

<%
	//}catch(Exception e){out.println("Erro: "+e);}
%>
