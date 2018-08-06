
<%
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*,java.util.*"%>
<%
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");

	//try{

	Vector titulos = new Vector();
	ResultSet rs = null, rsV = null, rsConsulta = null;

	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");
	titulos = (Vector) session.getAttribute("titulos");

	String query = "";
	String nomeass = "";
	String ativoass = "";
	String avaliaass = "";
	String nometit = "";
	String tipo = "";
	String cod = "";

	//Verifica se foram digitados os dados
	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}

	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	if (!(request.getParameter("sel_assunto") == null)) {
		nometit = request.getParameter("sel_assunto");
	}

	if (!(tipo.equals("E"))) {
		if (!(request.getParameter("assnome") == null)) {
			nomeass = request.getParameter("assnome");
		} else {
			if (titulos.size() == 1) {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
      alert(<%=("\""
												+ trd
														.Traduz("E necessArio digitar um Titulo!") + "\"")%>);
      window.open("titulos.jsp","_self");
     </script>
<%
	}
		}
	}

	if (!(request.getParameter("ativo") == null)) {
		ativoass = " 'S' ";
	} else {
		ativoass = " 'N' ";
	}

	if (!(request.getParameter("avalia") == null)) {
		avaliaass = " 'S' ";
	} else {
		avaliaass = " 'N' ";
	}

	//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o Assunto
	if (tipo.equals("I")) {
		String queryV = "SELECT TIT_NOME, ASS_CODIGO FROM TITULO WHERE TIT_NOME = '"
				+ nomeass + "' AND ASS_CODIGO = " + nometit;
		rsV = conexao.executaConsulta(queryV, session.getId() + "RS1");
		if (rsV.next()) {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR TITULO JA EXISTENTE") + "\"")%>);
      window.open("titulos.jsp","_self");
    </script>
<%
	if (rsV != null) {
				rsV.close();
				conexao.finalizaConexao(session.getId() + "RS1");
			}
		} else {
			query = "INSERT INTO TITULO (TIT_NOME, TIT_ATIVO, TIT_AVALIAEFICACIA, ASS_CODIGO) VALUES ('"
					+ nomeass
					+ "', "
					+ ativoass
					+ ", "
					+ avaliaass
					+ ", " + nometit + ")";
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("InclusAo efetuada com sucesso") + "\"")%>);
      window.open("titulos.jsp","_self");
      </script>
<%
	if (rsV != null) {
				rsV.close();
				conexao.finalizaConexao(session.getId() + "RS1");
			}
		}
	}

	else {
		if (tipo.equals("U")) {

			if (titulos.size() == 1) {
				String queryVerifica = "SELECT TIT_NOME, TIT_CODIGO FROM TITULO WHERE TIT_NOME = '"
						+ nomeass
						+ "' AND ASS_CODIGO = "
						+ nometit
						+ " AND TIT_CODIGO <> " + titulos.elementAt(0);
				rsConsulta = conexao.executaConsulta(queryVerifica,
						session.getId() + "RS2");
				if (!rsConsulta.next()) {
					query = "UPDATE TITULO SET TIT_NOME = '" + nomeass
							+ "', TIT_ATIVO =" + ativoass
							+ ", TIT_AVALIAEFICACIA=" + avaliaass
							+ ", ASS_CODIGO = " + nometit
							+ " WHERE TIT_CODIGO = "
							+ titulos.elementAt(0) + "";
					conexao.executaAlteracao(query);
					session.setAttribute("titulos", null);
%>
<script language="JavaScript">
        alert(<%=("\""
													+ trd
															.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("titulos.jsp","_self");
      </script>
<%
	if (rsConsulta != null) {
						rsConsulta.close();
						conexao
								.finalizaConexao(session.getId()
										+ "RS2");
					}
				} else {
%>
<script language="JavaScript">
        alert(<%=("\""
													+ trd
															.Traduz("IMPOSSIVEL CADASTRAR TITULO JA EXISTENTE") + "\"")%>);
        window.open("titulos.jsp","_self");
      </script>
<%
	if (rsConsulta != null) {
						rsConsulta.close();
						conexao
								.finalizaConexao(session.getId()
										+ "RS2");
					}
				}
			} else {
				for (int i = 0; i < titulos.size(); i++) {
					query = "UPDATE TITULO SET TIT_ATIVO =" + ativoass
							+ ", TIT_AVALIAEFICACIA=" + avaliaass
							+ ", ASS_CODIGO = " + nometit
							+ " WHERE TIT_CODIGO = "
							+ titulos.elementAt(i) + "";
					conexao.executaAlteracao(query);
				}

				session.setAttribute("titulos", null);
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("titulos.jsp","_self");
      </script>
<%
	}
		}
		if (tipo.equals("E")) {
			int cont = Integer.parseInt((String) request
					.getParameter("contador"));

			for (int i = 0; i < cont; i++) {
				if (!(request.getParameter("cod" + i) == null)) {
					cod = request.getParameter("cod" + i);
				}
			}

			session.setAttribute("titulos", null);

			query = "SELECT TIT_CODIGO FROM PLANOCARREIRA WHERE TIT_CODIGO = "
					+ cod;
			rs = conexao
					.executaConsulta(query, session.getId() + "RS3");
			if (rs.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ExclusAo nAo permitida. Existe PrE-requisito vinculado a este TItulo.") + "\"")%>);
        window.open("titulos.jsp","_self");
        </script>
<%
	if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS3");
				}

			} else {
				query = "SELECT TIT_CODIGO FROM CURSO WHERE TIT_CODIGO = "
						+ cod;
				if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS3");
				}
				rs = conexao.executaConsulta(query, session.getId()
						+ "RS4");
				if (rs.next()) {
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("ExclusAo nAo permitida. Existe Curso vinculado a este TItulo.") + "\"")%>);
          window.open("titulos.jsp","_self");
        </script>
<%
	if (rs != null) {
						rs.close();
						conexao
								.finalizaConexao(session.getId()
										+ "RS4");
					}
				} else {
					query = "DELETE FROM COMP_TITULO WHERE TIT_CODIGO = "
							+ cod;
					conexao.executaAlteracao(query);
					query = "DELETE FROM TITULO WHERE TIT_CODIGO = "
							+ cod;
					conexao.executaAlteracao(query);

					if (rs != null) {
						rs.close();
						conexao
								.finalizaConexao(session.getId()
										+ "RS4");
					}
%>
<script language="JavaScript">
          alert(<%=("\""
													+ trd
															.Traduz("ExclusAo efetuada com sucesso") + "\"")%>);
          window.open("titulos.jsp","_self");
        </script>
<%
	}
			}
		} else {
%>
<script language="JavaScript">
      window.open("titulos.jsp","_self");
    </script>
<%
	}
	}
	//}catch(Exception e){out.println("Erro: "+e);}
%>
