<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="java.sql.*"%>
<%
	request.getSession();
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");

	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
	request.getSession();
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	String usu_nome = (String) session.getAttribute("usu_nome");
	String usu_login = (String) session.getAttribute("usu_login");
	Integer usu_fil = (Integer) session.getAttribute("usu_fil");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	//Pega o tipo de cadastro (inclusão ou alteração) e o codigo do assunto
	String tipo = "", avacod = "", cod = "-1", quenome = "", quecom = "";

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}
	if (!(request.getParameter("sel_aval") == null)) {
		avacod = request.getParameter("sel_aval");
	}
	if (!(request.getParameter("que_nome") == null)) {
		quenome = request.getParameter("que_nome");
	}
	if (!(request.getParameter("txt_comentario") == null)) {
		quecom = request.getParameter("txt_comentario");
	}

	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 

	String query = "";
	ResultSet rs = null;

	if (tipo.equals("I")) {
		query = "SELECT QUE_CODIGO FROM QUESTIONARIO WHERE QUE_NOME = '"
				+ quenome + "' AND AVA_CODIGO = " + avacod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>


<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL INCLUIR AVALIACAO JA EXISTENTE") + "\"")%>);
      window.open("questionario.jsp","_self");
    </script>
<%
	} else {
			query = "INSERT INTO QUESTIONARIO (QUE_NOME, QUE_COMENTARIO, AVA_CODIGO) VALUES ('"
					+ quenome + "','" + quecom + "'," + avacod + ")";
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
      window.open("questionario.jsp","_self");
    </script>
<%
	}
	} else if (tipo.equals("U")) {
		query = "SELECT QUE_CODIGO FROM QUESTIONARIO WHERE QUE_NOME = '"
				+ quenome + "' AND AVA_CODIGO <> " + avacod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL INCLUIR AVALIACAO JA EXISTENTE") + "\"")%>);
      window.open("questionario.jsp","_self");
    </script>
<%
	} else {
			query = "UPDATE QUESTIONARIO SET QUE_NOME = '" + quenome
					+ "', AVA_CODIGO = " + avacod
					+ ", QUE_COMENTARIO = '" + quecom
					+ "' WHERE QUE_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
      window.open("questionario.jsp","_self");
    </script>
<%
	}

	}

	else if (tipo.equals("E")) {

		query = "SELECT QUE_CODIGO FROM QUEST_PERGUNTA WHERE QUE_CODIGO = "
				+ cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
                 alert(<%=("\""
											+ trd
													.Traduz("ESSE QUESTIONARIO NAO PODE SER EXCLUIDO POIS EXISTEM PERGUNTAS VINCULADAS") + "\"")%>);
                 window.open("questionario.jsp","_self");
            </script>
<%
	} else {
			query = "SELECT QUE_CODIGO FROM PLANO_AVALIA WHERE QUE_CODIGO = "
					+ cod;

			if (rs != null) {
				rs.close();
				conexao.finalizaConexao(session.getId());
			}

			rs = conexao.executaConsulta(query, session.getId());
			if (rs.next()) {
%>
<script language="JavaScript">
                 alert(<%=("\""
												+ trd
														.Traduz("ESSE QUESTIONARIO NAO PODE SER EXCLUIDO POIS ESTA VINCULADO AO PLANO") + "\"")%>);
                 window.open("questionario.jsp","_self");
            </script>
<%
	} else {
				query = "SELECT QUE_CODIGO FROM PROCESSO WHERE QUE_CODIGO = "
						+ cod;
				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId());
				}
				rs = conexao.executaConsulta(query, session.getId());
				if (rs.next()) {
%>
<script language="JavaScript">
                  alert(<%=("\""
													+ trd
															.Traduz("ESSE QUESTIONARIO NAO PODE SER EXCLUIDO POIS EXISTEM AVALIACOES VINCLULADAS") + "\"")%>);
                  window.open("questionario.jsp","_self");
              </script>
<%
	} else {
					query = "DELETE FROM QUESTIONARIO WHERE QUE_CODIGO = "
							+ cod;
					conexao.executaAlteracao(query);
%>
<script language="JavaScript">
                           alert(<%=("\""
													+ trd
															.Traduz("EXCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
                           window.open("questionario.jsp","_self");
                      </script>
<%
	}
			}

		}

	}

	if (rs != null) {
		rs.close();
		conexao.finalizaConexao(session.getId());
	}
	//}catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>
