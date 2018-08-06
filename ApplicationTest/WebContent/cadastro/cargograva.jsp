
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

<%
	//try{
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	//conexaoConsulta.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco"), (String)session.getAttribute("s_driverbanco")); 
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	ResultSet rs, rsConsulta = null;
	String query = "", nome = "", tipo = "", cod = "", filial = "", diretoria = "", celula = "", time = "";

	//Verifica se foram digitados os dados
	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}

	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	if (!(tipo.equals("E"))) {
		nome = ((request.getParameter("carnome") == null)
				? ""
				: request.getParameter("carnome"));
		filial = ((request.getParameter("sel_filial") == null)
				? ""
				: request.getParameter("sel_filial"));
		diretoria = ((request.getParameter("sel_dept") == null)
				? ""
				: request.getParameter("sel_dept"));
		celula = ((request.getParameter("sel_cel") == null)
				? ""
				: request.getParameter("sel_cel"));
		time = ((request.getParameter("sel_tim") == null)
				? ""
				: request.getParameter("sel_tim"));
	}

	if (celula.equals("")) {
		celula = null;
	}
	if (time.equals("")) {
		time = null;
	}

	if (tipo.equals("I")) {
		String queryVerifica = "SELECT CAR_NOME FROM CARGO WHERE CAR_NOME='"
				+ nome + "' AND CAR_CODCLI = NULL";
		rsConsulta = conexao.executaConsulta(queryVerifica, session
				.getId());
		if (!rsConsulta.next()) {
			query = "INSERT INTO CARGO (CAR_NOME, CAR_CODCLI, TB5_CODIGO, TB6_CODIGO, TB7_CODIGO, TB8_CODIGO) VALUES "
					+ "('"
					+ nome
					+ "',NULL,"
					+ filial
					+ ","
					+ diretoria + "," + celula + "," + time + ")";
			//out.println("QUERY: "+query);
			conexao.executaAlteracao(query);
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
      window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
    </script>
<%
	} else {
%>
<script language="JavaScript">
    alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR CARGO JA EXISTENTE") + "\"")%>);
    window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
  </script>
<%
	}
		if (rsConsulta != null) {
			rsConsulta.close();
			conexao.finalizaConexao(session.getId());
		}
	}

	else {
		if (tipo.equals("U")) {
			String queryVerifica = "SELECT CAR_NOME FROM CARGO WHERE CAR_NOME = '"
					+ nome
					+ "' AND CAR_CODIGO <> "
					+ cod
					+ " AND CAR_CODCLI = NULL";
			rsConsulta = conexao.executaConsulta(queryVerifica, session
					.getId()
					+ "RS_1");
			if (!rsConsulta.next()) {
				query = "UPDATE CARGO SET CAR_NOME = '" + nome + "', "
						+ "TB5_CODIGO = " + filial + ", TB6_CODIGO = "
						+ diretoria + ", TB7_CODIGO = " + celula
						+ ", TB8_CODIGO = " + time + " "
						+ "WHERE CAR_CODIGO = " + cod;
				conexao.executaAlteracao(query);
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
      </script>
<%
	} else {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("IMPOSSIVEL CADASTRAR CARGO JA EXISTENTE") + "\"")%>);
        window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
      </script>
<%
	}
			if (rsConsulta != null) {
				rsConsulta.close();
				conexao.finalizaConexao(session.getId() + "RS_1");
			}

		}
		if (tipo.equals("E")) {

			query = "SELECT CAR_CODIGO FROM FUNCIONARIO WHERE CAR_CODIGO = "
					+ cod;
			rs = conexao.executaConsulta(query, session.getId()
					+ "RS_2");
			if (rs.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("EXCLUSAO NAO PERMITIDA. EXISTE FUNCIONARIO(S) VINCULADO A ESTE CARGO") + "\"")%>);
        window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
      </script>
<%
	} else {
				query = "DELETE FROM CARGO WHERE CAR_CODIGO = " + cod;
				conexao.executaAlteracao(query);
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("EXCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
      </script>
<%
	}
			if (rs != null) {
				rs.close();
				conexao.finalizaConexao(session.getId() + "RS_2");
			}
		} else {
%>
<script language="JavaScript">
      window.open("auxiliares.jsp?opcombo=<%=trd.Traduz("CARGO")%>&filtro=","_self");
    </script>
<%
	}

	}
	//conexao.finalizaConexao();

	//conexaoConsulta.finalizaConexao();
	//conexaoConsulta.finalizaBD();
	//}catch(Exception e){out.println("Erro: "+e);}
%>
