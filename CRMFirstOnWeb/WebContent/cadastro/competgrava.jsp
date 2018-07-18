
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

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	ResultSet rs = null;
	String query = "";
	String nomecmp = "";
	String tipo = "";
	String cod = "";

	//Verifica se foram digitados os dados
	if (!(request.getParameter("tipo") == null))
		tipo = request.getParameter("tipo");

	if (!(request.getParameter("cod") == null))
		cod = request.getParameter("cod");

	if (!(tipo.equals("E"))) {
		if (!(request.getParameter("cmpnome") == null))
			nomecmp = " '" + request.getParameter("cmpnome") + "' ";
		else {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("E necessArio digitar uma competEncia!") + "\"")%>);
      window.open("competencias.jsp","_self");
    </script>
<%
	}
	}

	//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o CompetEncia
	if (tipo.equals("I")) {
		query = "INSERT INTO COMPETENCIA (CMP_DESCRICAO) VALUES ("
				+ nomecmp + ")";

		conexao.executaAlteracao(query);
%>
<script language="JavaScript">
    alert(<%=("\""
										+ trd
												.Traduz("InclusAo efetuada com sucesso") + "\"")%>);
    window.open("competencias.jsp","_self");
  </script>
<%
	}

	else {
		if (tipo.equals("U")) {
			query = "UPDATE COMPETENCIA SET CMP_DESCRICAO = " + nomecmp
					+ " WHERE CMP_CODIGO = " + cod;
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("AlteraCAo efetuada com sucesso") + "\"")%>);
      window.open("competencias.jsp","_self");
    </script>
<%
	}
		if (tipo.equals("E")) {
			query = "SELECT * FROM CURSOCOMP WHERE CMP_CODIGO = " + cod;
			rs = conexao
					.executaConsulta(query, session.getId() + "RS1");
			if (rs.next()) {
%>
<script language="JavaScript">
      alert(<%=("\""
												+ trd
														.Traduz("ExclusAo nAo permitida. Existe Curso vinculado a esta CompetEncia.") + "\"")%>);
      window.open("competencias.jsp","_self");
      </script>
<%
	if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS1");
				}
			} else {
				query = "SELECT * FROM TREINCOMP WHERE CMP_CODIGO = "
						+ cod;

				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS1");
				}

				rs = conexao.executaConsulta(query, session.getId()
						+ "RS2");
				if (rs.next()) {
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("ExclusAo nAo permitida. Existe Treinamento vinculado a esta CompetEncia.") + "\"")%>);
          window.open("competencias.jsp","_self");
        </script>
<%
	if (rs != null) {
						rs.close();
						conexao
								.finalizaConexao(session.getId()
										+ "RS2");
					}
				} else {
					query = "SELECT * FROM TREINCOMP WHERE CMP_CODIGO = "
							+ cod;

					if (rs != null) {
						rs.close();
						conexao
								.finalizaConexao(session.getId()
										+ "RS2");
					}

					rs = conexao.executaConsulta(query, session.getId()
							+ "RS3");
					if (rs.next()) {
%>
<script language="JavaScript">
            alert(<%=("\""
														+ trd
																.Traduz("ExclusAo nAo permitida. Existe SolicitaCAo vinculada a esta CompetEncia.") + "\"")%>);
            window.open("competencias.jsp","_self");
          </script>
<%
	if (rs != null) {
							rs.close();
							conexao.finalizaConexao(session.getId()
									+ "RS3");
						}

					} else {
						query = "SELECT * FROM COMP_TITULO WHERE CMP_CODIGO = "
								+ cod;

						if (rs != null) {
							rs.close();
							conexao.finalizaConexao(session.getId()
									+ "RS3");
						}

						rs = conexao.executaConsulta(query, session
								.getId()
								+ "RS4");
						if (rs.next()) {
%>
<script language="JavaScript">
              alert(<%=("\""
															+ trd
																	.Traduz("ExclusAo nAo permitida. Existe Titulo vinculado a esta CompetEncia.") + "\"")%>);
              window.open("competencias.jsp","_self");
            </script>
<%
	if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId()
										+ "RS4");
							}
						} else {
							query = "DELETE FROM COMPETENCIA WHERE CMP_CODIGO = "
									+ cod;

							if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId()
										+ "RS4");
							}

							conexao.executaAlteracao(query);
%>
<script language="JavaScript">
              alert(<%=("\""
															+ trd
																	.Traduz("ExclusAo efetuada com sucesso") + "\"")%>);
              window.open("competencias.jsp","_self");
            </script>
<%
	if (rs != null) {
								rs.close();
								conexao.finalizaConexao(session.getId()
										+ "RS5");
							}
						}
					}
				}
			}
		} else {
%>
<script language="JavaScript">
      window.open("competencias.jsp","_self");  
    </script>
<%
	}
	}
%>
