
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

	FODBConnectionBean conexao = new FODBConnectionBean();
	conexao = conexao.getConection();

	ResultSet rs = null, rsPermissoes = null;

	String sigla = "", endereco = "", func = "", usu_tipo = "", query = "";

	if (request.getParameter("aplicacao") != null)
		sigla = request.getParameter("aplicacao");
	if (request.getParameter("endereco") != null)
		endereco = request.getParameter("endereco");
	if (request.getParameter("func") != null)
		func = request.getParameter("func");
	if (sigla.equals("EM")) {

	}

	// ****** RECUPERA O TIPO DO USUÁRIO ******
	query = "SELECT F.TIP_TIPO "
			+ "FROM FUNC_USUARIO F, TIPOUSUARIO T, APLICACAO A "
			+ "WHERE F.FUN_CODIGO = '" + func + "' "
			+ "AND F.TIP_TIPO = T.TIP_TIPO " + "AND A.APL_SIGLA = '"
			+ sigla + "' " + "AND T.APL_CODIGO = A.APL_CODIGO";

	rs = conexao.executaConsulta(query, session.getId() + "res_1");

	Vector inicia = (((Vector) session.getAttribute("vetorPermissoes") == null) ? null
			: (Vector) session.getAttribute("vetorPermissoes"));
	session.setAttribute("vetorPermissoes", inicia);

	if (rs.next()) {

		usu_tipo = rs.getString(1);

		session.setAttribute("usu_tipo", usu_tipo);
		if (sigla.equals("EM")) {
			//******************************************PERMISSOES********************************//
			String queryPermissoes = "SELECT FUNCIONALIDADE.FLD_DESCRICAO FROM FUNCIONALIDADE,TIPOUSU_FUNCIONALID WHERE FUNCIONALIDADE.FLD_CODIGO=TIPOUSU_FUNCIONALID.FLD_CODIGO AND TIPOUSU_FUNCIONALID.TIP_TIPO='"
			+ usu_tipo + "'";
			rsPermissoes = conexao.executaConsulta(queryPermissoes,
			session.getId() + "res_2");

			Vector permissoes = new Vector(60, 10);
			/*Carrega Vetor*/
			if (rsPermissoes.next()) {
		do {
			permissoes.addElement(new String(rsPermissoes
			.getString(1).trim()));
		} while (rsPermissoes.next());
			} else {
			}
			if (rsPermissoes != null) {
		rsPermissoes.close();
		//   conexao.finalizaConexao(session.getId()+"res_2");
			}
			out.println("" + permissoes);
			session.setAttribute("vetorPermissoes", permissoes);
			//******************************************PERMISSOES********************************//
		}
		session.setAttribute("fun_tipo", usu_tipo);

		request.getSession();
		session.setAttribute("aplicacao", sigla);

		response.sendRedirect(endereco);
	}

	else {
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><script language="JavaScript">
		window.open("login.jsp?msgerro=Usuário sem permissão de acesso!","_self");    
		</script>
<%
	}

	if (rs != null) {
		rs.close();
		//conexao.finalizaConexao(session.getId()+"res_1");	            
	}
%>
