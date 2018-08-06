<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
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

	//Pega o tipo de cadastro (inclusAo ou alteraCAo) e o codigo do assunto
	String tipo = "", grucod = "", cod = "-1", quenome = "", quecom = "", tipoquest = "";
	String query = "";
	ResultSet rs;

	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}
	if (!(request.getParameter("sel_quest") == null)) {
		grucod = request.getParameter("sel_quest");
	}
	if (!(request.getParameter("que_nome") == null)) {
		quenome = request.getParameter("que_nome");
	}
	if (!(request.getParameter("rad") == null)) {
		tipoquest = request.getParameter("rad");
	}

	//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 

	if (tipo.equals("I")) {
		query = "SELECT PER_CODIGO FROM PERGUNTA WHERE PER_NOME = '"
				+ quenome + "'";
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script language="JavaScript">
      alert("IMPOSSIVEL INCLUIR PERGUNTA JA EXISTENTE");
      window.open("questoes.jsp","_self");
    </script>
<%
	} else {
			query = "INSERT INTO PERGUNTA (PER_NOME, GRU_CODIGO, PER_TIPO) VALUES ('"
					+ quenome + "'," + grucod + ",'" + tipoquest + "')";
			//out.println(query);
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert("INCLUSAO EFETUADA COM SUCESSO");
      window.open("questoes.jsp","_self");
    </script>
<%
	}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId());
		}
	} else if (tipo.equals("U")) {
		query = "SELECT PER_CODIGO FROM PERGUNTA WHERE PER_NOME = '"
				+ quenome + "' AND PER_CODIGO <> " + cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
      alert("IMPOSSIVEL INCLUIR AVALIACAO JA EXISTENTE");
      window.open("questoes.jsp","_self");
    </script>
<%
	} else {
			query = "UPDATE PERGUNTA SET PER_NOME = '" + quenome
					+ "', GRU_CODIGO = " + grucod + ", PER_TIPO = '"
					+ tipoquest + "' WHERE PER_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert("ALTERACAO EFETUADA COM SUCESSO");
      window.open("questoes.jsp","_self");
    </script>
<%
	}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId());
		}

	}

	else if (tipo.equals("E")) {

		//testa se a pergunta faz parte de um questionario
		query = "SELECT GRU_CODIGO FROM QUEST_PERGUNTA WHERE PER_CODIGO = "
				+ cod;
		rs = conexao.executaConsulta(query, session.getId());
		if (rs.next()) {
%>
<script language="JavaScript">
    alert(<%=("\""
											+ trd
													.Traduz("ESSA PERGUNTA NAO PODE SER EXCLUIDA POR FAZER PARTE DE UM QUESTIONARIO!") + "\"")%>);
    window.open("questoes.jsp","_self");
  </script>
<%
	} else {
			query = "DELETE FROM PERGUNTA WHERE PER_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
    alert(<%=("\""
											+ trd
													.Traduz("EXCLUSAO EFETUADA COM SUCESSO!") + "\"")%>);
    window.open("questoes.jsp","_self");
  </script>
<%
	}
		if (rs != null) {
			rs.close();
			conexao.finalizaConexao(session.getId());
		}
	}

	//}catch(Exception e){
	//  out.println("Erro: "+e);
	//}
%>
