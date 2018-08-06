<!--

Nome do arquivo: cadastro/assuntosgrava.jsp
Nome da funcionalidade: Gravação de Assunto
Função: incluir, excluir ou alterar um assunto, fazendo as verificações necessárias.
Variáveis necessárias/ Requisitos: 
- sessao: idioma do usuário ("usu_idi"), tipo do usuário ("usu_tipo")
- parametro: tipo da ação ("tipo"), código do assunto ("cod"), nome do assunto ("nomeass"), ativo ("ativoass")
Regras de negócio (pagina):
- verifica se o campo "nome do assunto" foi preenchido;
- Inclusão: Verifica a existência do assunto na tabela ASSUNTO, caso já exista, ele não insere;
- Alteração: Verifica a existência do assunto na tabela ASSUNTO, caso já exista, ele não altera;
- Exclusão: Verfica nas tabela TITULO se o assunto está sendo usado, caso não esteja ele exclui o assunto
            da tabela ASSUNTO;
_________________________________________________________________________________________

Histórico
Data de atualizacao: 11/03/2003 - Desenvolvedor: Anderson Inoue
Atividade:
          - padronizacao da página;
          - retirada da verificação na tabela FUNCPROJETO pois esta foi apagada do bd.
_________________________________________________________________________________________

-->

<!--***DIRETRIZES DA PAGINA***-->
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<!--***IMPORTAÇOES E BEANS***-->
<%@page import="java.sql.*"%>

<%
	//*configuracao de cache*//
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//***DECLARAÇÃO DE VARIÁVEIS***//
	ResultSet rs = null, rsV = null, rsConsulta = null;
	String query = "", nomeass = "", tipo = "", avaliaass = "", cod = "", queryV = "", ativoass = "", igual = "", queryVerifica = "";

	//***RECUPERCAO DE PARAMETROS***//
	/*valores de sessao*/
	request.getSession();
	FODBConnectionBean conexao = (FODBConnectionBean) session
			.getAttribute("Conexao");
	FOLocalizationBean trd = (FOLocalizationBean) session
			.getAttribute("Traducao");
	String usu_tipo = (String) session.getAttribute("usu_tipo");
	Integer usu_idi = (Integer) session.getAttribute("usu_idi");

	/*Verifica se foram digitados os dados*/
	if (!(request.getParameter("tipo") == null)) {
		tipo = request.getParameter("tipo");
	}
	if (!(request.getParameter("cod") == null)) {
		cod = request.getParameter("cod");
	}

	if (!(tipo.equals("E"))) {
		if (!(request.getParameter("assnome") == null)) {
			nomeass = (String) request.getParameter("assnome");
		} else {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script
	language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("E NECESSARIO DIGITAR UM ASSUNTO") + "\"")%>);
      window.open("assuntos.jsp","_self");
    </script>
<%
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

	//***CORPO DA PÁGINA***//
	//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o Assunto
	if (tipo.equals("I")) {
		queryV = "SELECT ASS_NOME FROM ASSUNTO WHERE ASS_NOME = '"
				+ nomeass + "'";
		rsV = conexao.executaConsulta(queryV, session.getId() + "RS1");
		if (!rsV.next()) {
			query = "INSERT INTO ASSUNTO (ASS_NOME, ASS_ATIVO, ASS_AVALIAEFICACIA) VALUES ('"
					+ nomeass
					+ "', "
					+ ativoass
					+ ", "
					+ avaliaass
					+ ")";
			conexao.executaAlteracao(query);
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("INCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
      window.open("assuntos.jsp","_self");    
    </script>
<%
	if (rsV != null) {
				rsV.close();
				conexao.finalizaConexao(session.getId() + "RS1");
			}
			//response.sendRedirect("assuntos.jsp?msgPro=I");
		} else {
%>
<script language="JavaScript">
      alert(<%=("\""
											+ trd
													.Traduz("IMPOSSIVEL CADASTRAR ASSUNTO JA EXISTENTE") + "\"")%>);
      window.open("assuntos.jsp","_self");
    </script>
<%
	if (rsV != null) {
				rsV.close();
				conexao.finalizaConexao(session.getId() + "RS1");
			}
		}
	} else {
		if (tipo.equals("U")) {
			queryVerifica = "SELECT ASS_NOME FROM ASSUNTO WHERE ASS_NOME = '"
					+ nomeass + "' AND ASS_CODIGO <> " + cod;
			rsConsulta = conexao.executaConsulta(queryVerifica, session
					.getId()
					+ "RS2");
			if (!rsConsulta.next()) {
				query = "UPDATE ASSUNTO SET ASS_NOME = '" + nomeass
						+ "', ASS_ATIVO =" + ativoass
						+ ", ASS_AVALIAEFICACIA=" + avaliaass
						+ " WHERE ASS_CODIGO = " + cod + "";
				conexao.executaAlteracao(query);
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("ALTERACAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("assuntos.jsp","_self");
      </script>
<%
	if (rsConsulta != null) {
					rsConsulta.close();
					conexao.finalizaConexao(session.getId() + "RS2");
				}
			} else {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("IMPOSSIVEL CADASTRAR ASSUNTO JA EXISTENTE") + "\"")%>);
        window.open("assuntos.jsp","_self");
      </script>
<%
	if (rsConsulta != null) {
					rsConsulta.close();
					conexao.finalizaConexao(session.getId() + "RS2");
				}
			}
		} else if (tipo.equals("E")) {
			query = "SELECT * FROM TITULO WHERE ASS_CODIGO = " + cod;
			rs = conexao
					.executaConsulta(query, session.getId() + "RS3");
			if (rs.next()) {
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("EXCLUSAO NAO PERMITIDA. EXISTE TITULO VINCULADO A ESTE ASSUNTO") + "\"")%>);
        window.open("assuntos.jsp","_self");
      </script>
<%
	if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS3");
				}
			}//if
			else {
				query = "DELETE FROM ASSUNTO WHERE ASS_CODIGO = " + cod;
				conexao.executaAlteracao(query);
%>
<script language="JavaScript">
        alert(<%=("\""
												+ trd
														.Traduz("EXCLUSAO EFETUADA COM SUCESSO") + "\"")%>);
        window.open("assuntos.jsp","_self");
      </script>
<%
	if (rs != null) {
					rs.close();
					conexao.finalizaConexao(session.getId() + "RS3");
				}
			}//else
		}//else if
		else {
%>
<script language="JavaScript">
      window.open("assuntos.jsp","_self");
    </script>
<%
	}//else
	}//else

	//***FINALIZAÇÕES***//
%>
