
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	//conexaoX.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

	//conexaoConsulta.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs, rsX = null, rsConsulta = null;

	String query = "";
	String nomeass = "";
	String ativoass = "";
	String avaliaass = "";
	String tipo = "";
	String cod = "";

	//Verifica se foram digitados os dados
	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}

	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	if (!(tipo.equals("E"))) {
		if (!(request.getParameter("tipnome") == null))
			nomeass = request.getParameter("tipnome");
		else {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("E necessArio digitar um Tipo!") + "\"")%>);
      window.open("tipos.jsp","_self");
    </script>
<%
	}
	}

	//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o Tipo
	if (tipo.equals("I")) {
		String queryX = "SELECT TCU_NOME FROM TIPOCURSO WHERE TCU_NOME = '"
				+ nomeass + "'";
		rsX = conexao.executaConsulta(queryX, session.getId() + "x");
		if (!rsX.next()) {
			query = "INSERT INTO TIPOCURSO (TCU_NOME) VALUES ('"
					+ nomeass + "')";
			conexao.executaAlteracao(query);
			rsX.close();
			conexao.finalizaConexao(session.getId() + "x");
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("InclusAo efetuada com sucesso") + "\"")%>);
      window.open("tipos.jsp","_self");
    </script>
<%
	} else {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR TIPO JA EXISTENTE") + "\"")%>);
      window.open("tipos.jsp","_self");
    </script>
<%
	}
	} else {
		if (tipo.equals("U")) {
			String queryVerifica = "SELECT TCU_NOME FROM TIPOCURSO WHERE TCU_NOME = '"
					+ nomeass + "' AND TCU_CODIGO <> " + cod;
			rsConsulta = conexao.executaConsulta(queryVerifica, session
					.getId()
					+ "Verifica");
			if (!rsConsulta.next()) {
				query = "UPDATE TIPOCURSO SET TCU_NOME = '" + nomeass
						+ "' WHERE TCU_CODIGO = " + cod + "";
				conexao.executaAlteracao(query);
				conexao.finalizaConexao(session.getId() + "Verifica");
				rsConsulta.close();
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("AlteraCAo efetuada com sucesso") + "\"")%>);
        window.open("tipos.jsp","_self");
      </script>
<%
	} else {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("IMPOSSIVEL CADASTRAR TIPO JA EXISTENTE") + "\"")%>);
        window.open("tipos.jsp","_self");
      </script>
<%
	}

		}
		if (tipo.equals("E")) {
			query = "SELECT * FROM TURMA WHERE TCU_CODIGO = " + cod;
			rs = conexao.executaConsulta(query, session.getId());
			if (rs.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ExclusAo nAo permitida. Existem Treinamentos vinculados a este Tipo.") + "\"")%>);
        window.open("tipos.jsp","_self");
      </script>
<%
	} else {
				query = "SELECT * FROM CURSO WHERE TCU_CODIGO = " + cod;
				rs = conexao.executaConsulta(query, session.getId());
				if (rs.next()) {
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("ExclusAo nAo permitida. Existe Curso vinculado a este Tipo.") + "\"")%>);
          window.open("tipos.jsp","_self");
        </script>
<%
	} else {
					query = "DELETE FROM TIPOCURSO WHERE TCU_CODIGO = "
							+ cod;
					conexao.executaAlteracao(query);
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("ExclusAo efetuada com sucesso") + "\"")%>);
          window.open("tipos.jsp","_self");
        </script>
<%
	}
			}
		} else {
%>
<script language="JavaScript">
      window.open("tipos.jsp","_self");  
    </script>
<%
	}
	}
	conexao.finalizaConexao(session.getId());
%>
