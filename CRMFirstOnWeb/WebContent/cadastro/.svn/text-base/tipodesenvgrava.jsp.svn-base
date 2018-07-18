
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>

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
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	ResultSet rs = null, rsConsulta = null;

	String query = "", nome = "", tipo = "", cod = "";

	//Verifica se foram digitados os dados
	if (!(request.getParameter("tipo") == null))
		tipo = trataAspas(request.getParameter("tipo"));

	if (!(request.getParameter("cod") == null))
		cod = trataAspas(request.getParameter("cod"));

	if (!(tipo.equals("E"))) {
		if (!(request.getParameter("desnome") == null)) {
			nome = " '" + trataAspas(request.getParameter("desnome"))
					+ "' ";
		} else {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("E necessArio digitar um tipo de desenvolvimento!") + "\"")%>);
      window.open("tipodedesenv.jsp","_self");
     </script>
<%
	}
	}
	String queryVerifica = "";

	if (tipo.equals("I")) {
		queryVerifica = "SELECT DES_DESCRICAO FROM DESENVOLVIMENTO WHERE DES_DESCRICAO="
				+ nome + "";
		rsConsulta = conexao.executaConsulta(queryVerifica, session
				.getId()
				+ "RS1");
		if (!rsConsulta.next()) {
			query = "INSERT INTO DESENVOLVIMENTO (DES_DESCRICAO) VALUES ("
					+ nome + ")";
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("InclusAo efetuada com sucesso") + "\"")%>);
      window.open("tipodedesenv.jsp","_self");
    </script>
<%
	if (rsConsulta != null) {
				rsConsulta.close();
				conexao.finalizaConexao(session.getId() + "RS1");
			}
		} else {
%>
<script language="JavaScript">
    alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR TIPO DE DESENVOLVIMENTO JA EXISTENTE") + "\"")%>);
    window.open("tipodedesenv.jsp","_self");
  </script>
<%
	if (rsConsulta != null) {
				rsConsulta.close();
				conexao.finalizaConexao(session.getId() + "RS1");
			}
		}
	}

	else {
		if (tipo.equals("U")) {
			queryVerifica = "SELECT DES_DESCRICAO FROM DESENVOLVIMENTO WHERE DES_DESCRICAO="
					+ nome + "";
			rsConsulta = conexao.executaConsulta(queryVerifica, session
					.getId()
					+ "RS2");
			if (rsConsulta.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("IMPOSSIVEL CADASTRAR TIPO DE DESENVOLVIMENTO JA EXISTENTE") + "\"")%>);
        window.open("tipodedesenv.jsp","_self");
      </script>
<%
	if (rsConsulta != null) {
					rsConsulta.close();
					conexao.finalizaConexao(session.getId() + "RS2");
				}
			} else {
				query = "UPDATE DESENVOLVIMENTO SET DES_DESCRICAO = "
						+ nome + " WHERE DES_CODIGO = " + cod;
				conexao.executaAlteracao(query);
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("AlteraCAo efetuada com sucesso") + "\"")%>);
        window.open("tipodedesenv.jsp","_self");
      </script>
<%
	if (rsConsulta != null) {
					rsConsulta.close();
					conexao.finalizaConexao(session.getId() + "RS2");
				}
			}
		}
		if (tipo.equals("E")) {
			query = "SELECT * FROM CURSO WHERE DES_CODIGO = " + cod;
			rs = conexao
					.executaConsulta(query, session.getId() + "RS3");
			if (rs.next()) {
%>
<script langauge="JavaScript">
      alert(<%=("\""
												+ trd
														.Traduz("ExclusAo nAo permitida. Existe Curso vinculado a este Tipo de Desenvolvimento.") + "\"")%>);
      window.open("tipodedesenv.jsp","_self");
      </script>
<%
	if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS3");
				}
			} else {
				query = "DELETE FROM DESENVOLVIMENTO WHERE DES_CODIGO = "
						+ cod;
				conexao.executaAlteracao(query);
%>
<script langauge="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ExclusAo efetuada com sucesso") + "\"")%>);
        window.open("tipodedesenv.jsp","_self");
      </script>
<%
	if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS3");
				}
			}
		} else {
%>
<script langauge="JavaScript">
      window.open("tipodedesenv.jsp","_self");  
    </script>
<%
	}
	}
%>