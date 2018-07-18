<!--
 When the password were null or being empty, the password view comes up!(senhaUp.jsp).
  -->

<%@page import="java.util.*,java.io.*,java.sql.*"%>


<%@page import="firston.eval.connection.FODBComplaintBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.components.FOParametersBean"%><html>
<head>
<title>FirstOn - Carrier Manager (1.0)</title>
<script language="JavaScript" src="scripts.js"></script>
<link rel="stylesheet" href="default.css" type="text/css">
</head>

<%
	//Limpa cache
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}

	//Conexao conn = Conexao.getConection();
	FODBConnectionBean conn2 = new FODBConnectionBean();

	//try{

	String login = "", senha = "", query = "", usu_nome = "", usu_senha = "";
	Integer usu_codigo = new Integer(0);
	Integer usu_fil = new Integer(0);
	Integer usu_idi = new Integer(0);
	Integer usu_plano = new Integer(0);
	String pag = "7";
	Vector funcs = new Vector();
	ResultSet rs = null;
	String url = "", user = "", password = "", BARRA = "", EMAIL_DE_SUPORTE = "", driver = "";
	boolean nova_senha = false;
	int aplic = 0;

	//*********************Recupera parâmetros de inicializacao do web.xml***********************
	ServletContext context = pageContext.getServletContext();
	driver = context.getInitParameter("jdbcDriver");
	url = context.getInitParameter("jdbcURL");
	user = context.getInitParameter("jdbcUserName");
	password = context.getInitParameter("jdbcPassword");
	//BARRA = context.getInitParameter("barra");
	//EMAIL_DE_SUPORTE = context.getInitParameter("emailSuporte");
	//*******************************************************************************************

	//trd1.setConecta(DRIVERNAME, USERNAME, PASSWORD,DRIVER_BD);

	conn2.realizaConexao(url, user, password, driver);
	//conn2.setConection(conn2);
	FOLocalizationBean trd1 = new FOLocalizationBean(conn2);
	FOParametersBean prm = new FOParametersBean();

	//prm.setConecta(DRIVERNAME, USERNAME, PASSWORD,DRIVER_BD);

	//*********************Checagem de Login***********************	 
	if (request.getParameter("login") != null)
		login = (request.getParameter("login")).toUpperCase();
	if (request.getParameter("senha") != null)
		senha = (request.getParameter("senha")).toUpperCase();

	java.util.Date hoje = new java.util.Date();

	request.getSession(true);
	session.setMaxInactiveInterval(18000);

	//Seta o id da sessão no bean de param
	prm.setSession(session.getId());

	session.setAttribute("Conn", (java.sql.Connection) conn2
			.getObjConection());
	session.setAttribute("Param", prm);
	session.setAttribute("Conexao", conn2);
	FODBConnectionBean conn = (new FODBConnectionBean()).getConection();
	session.setAttribute("Traducao", trd1);
	int dia = hoje.getDate();
	int mes = (hoje.getMonth()) + 1;
	int ano = (hoje.getYear()) + 1900;

	String ano_plano = "", sigla = "";
	ano_plano = ano_plano.valueOf(ano);

	query = "SELECT PLA_CODIGO FROM PLANO ORDER BY PLA_DATAINICIO DESC";
	//query = "SELECT PLA_CODIGO FROM PLANO WHERE PLA_CODIGO = 0";//teste para nenhum plano

	if (conn == null)
		response.sendRedirect("login.jsp?msgerro=Conexão zuada!!");

	rs = conn.executaConsulta(query, session.getId() + "PLANO");

	if (rs == null)
		response.sendRedirect("login.jsp?msgerro=Conexão zuada!!");

	if (rs.next()) {
		usu_plano = new Integer(rs.getInt(1));
	} else {
%>
<!-- tradução não funciona -->
<script language="JavaScript">
		alert("DADOS INCOMPLETOS. FAVOR ACIONAR O SUPORTE");
		window.open("login.jsp","_self");
	</script>
<%
	}
	//if (rs != null) {
	//	rs.close();
	//	conn.finalizaConexao(session.getId() + "PLANO");
	//	}

	//Verifica se o usuário é Supervisor
	if (login.equals("SUPERVISOR_EM"))
		sigla = "EM";
	if (login.equals("SUPERVISOR_CM"))
		sigla = "CM";
	if (login.equals("SUPERVISOR_EF"))
		sigla = "EF";
	if (BARRA.equals("S")) {
		BARRA = "..";
		session.setAttribute("barra", BARRA);
	} else {
		BARRA = "";
		session.setAttribute("barra", BARRA);
	}

	if (!sigla.equals("")) {
		String soma = "";

		int senha_soma = dia + mes + ano;

		soma = soma.valueOf(senha_soma);

		if (senha.equals(soma)) {
			request.getSession(true);
			session.setMaxInactiveInterval(18000);

			query = "SELECT FUN_CODIGO, FIL_CODIGO, IDI_CODIGO FROM FUNCIONARIO";
			rs = conn.executaConsulta(query, session.getId() + "FUNC");
			if (rs.next()) {
				usu_codigo = new Integer(rs.getInt(1));
				session.setAttribute("usu_cod", rs.getString(1));
				session.setAttribute("usu_nome", "Supervisor");
				session
						.setAttribute("usu_login", "Supervisor_"
								+ sigla);
				session.setAttribute("usu_fil", new Integer(rs
						.getInt(2)));
				session.setAttribute("usu_idi", new Integer(rs
						.getInt(3)));
				Vector v1 = (Vector) trd1
						.montaVetor(usu_idi.intValue());
				trd1.setSession(session.getId());
				//session.setAttribute("vet_td", (Vector) v1);
				session.setAttribute("Traducao", trd1);

			}

			if (rs != null) {
				rs.close();
				//	conn.finalizaConexao(session.getId() + "FUNC");
			}

			session.setAttribute("usu_tipo", "F");
			session.setAttribute("aplicacao", sigla);
			session.setAttribute("usu_plano", usu_plano);
			session.setAttribute("funcs", funcs);
			session.setAttribute("pagina", pag);
			//session.setAttribute("s_conexao", DRIVERNAME);
			//session.setAttribute("s_usubanco", USERNAME);
			//session.setAttribute("s_senbanco", PASSWORD);
			//session.setAttribute("s_driverbanco", DRIVER_BD);
			//session.setAttribute("conn",conn);
			session.setAttribute("barra", BARRA);
			session.setAttribute("email_suporte", EMAIL_DE_SUPORTE);

			query = "SELECT APL_ENDERECO FROM APLICACAO WHERE APL_SIGLA = '"
					+ sigla + "'";
			rs = conn.executaConsulta(query, session.getId() + "APL");
			if (rs.next()) {
%>
<script language="JavaScript">
			window.open("<%=rs.getString(1)%>","_self");
			</script>
<%
	//response.sendRedirect(rs.getString(1));
			}
			if (rs != null) {
				rs.close();
				//conn.finalizaConexao(session.getId() + "APL");
			}
		} else {
%>
<script language="JavaScript">
			    window.open("login.jsp?msgerro=Senha incorreta, tente novamente!","_self");    
			</script>
<%
	}
	}

	else {
		query = "SELECT FUNCIONARIO.FUN_CODIGO, FUNCIONARIO.FUN_NOME, FUNCIONARIO.FUN_SENHA, "
				+ "FOCOFILIAL.FIL_CODIGO, FUNCIONARIO.IDI_CODIGO "
				+ "FROM FUNCIONARIO, FOCOFILIAL "
				+ "WHERE FUNCIONARIO.FUN_CODIGO OUTER FOCOFILIAL.FUN_CODIGO "
				+ "AND FUNCIONARIO.FUN_LOGIN = '"
				+ login
				+ "' "
				+ "AND FOCOFILIAL.FCO_DEFAULT = 'S'";

		rs = conn.executaConsulta(query, session.getId() + "FIL");

		if (rs.next()) {
			usu_codigo = new Integer(rs.getString(1));
			usu_nome = new String(rs.getString(2));

			if (rs.getString(4) == null) {
%>
<script language="JavaScript">
				window.open("login.jsp?msgerro=Usuário sem permissão de acesso!","_self");
			</script>
<%
	} else {
				usu_fil = new Integer(rs.getString(4));
			}

			usu_idi = new Integer(rs.getInt(5));
			/*verifica se a senha é nula ou vazia*/
			if ((rs.getString(3) != null)
					&& (!rs.getString(3).equals(""))) {
				usu_senha = new String(rs.getString(3));

				if (!(usu_senha.toUpperCase()).equals(senha)) {
%>
<script language="JavaScript">
					window.open("login.jsp?msgerro=Senha incorreta, tente novamente!","_self");    
				</script>
<%
	} else {
					request.getSession(true);
					session.setMaxInactiveInterval(18000);//***************/
					session.setAttribute("usu_cod", usu_codigo);
					session.setAttribute("usu_nome", usu_nome);
					session.setAttribute("usu_login", login);
					session.setAttribute("usu_filial", login);
					session.setAttribute("usu_fil", usu_fil);
					session.setAttribute("usu_idi", usu_idi);
					Vector v1 = (Vector) trd1.montaVetor(usu_idi
							.intValue());
					trd1.setSession(session.getId());
					session.setAttribute("Traducao", trd1);

					session.setAttribute("usu_plano", usu_plano);
					session.setAttribute("funcs", funcs);
					session.setAttribute("pagina", pag);
					//session.setAttribute("s_conexao", DRIVERNAME);
					//session.setAttribute("s_usubanco", USERNAME);
					//session.setAttribute("s_senbanco", PASSWORD);
					//session.setAttribute("s_driverbanco", DRIVER_BD);
					//session.setAttribute("conn",conn);  

					session.setAttribute("fun_codigo", usu_codigo);
					session.setAttribute("fun_nome", usu_nome);
					session.setAttribute("fun_login", login);
					session.setAttribute("fun_idi", usu_idi);
					session.setAttribute("barra", BARRA);
					session.setAttribute("email_suporte",
							EMAIL_DE_SUPORTE);

					if (rs != null) {
						rs.close();
						//conn.finalizaConexao(session.getId() + "FIL");
					}

					query = "SELECT COUNT(APL_CODIGO) FROM APLICACAO";
					rs = conn.executaConsulta(query, session.getId()
							+ "CONTAPL");
					if (rs.next()) {
						aplic = rs.getInt(1);
					}

					if (rs != null) {
						rs.close();
						//conn.finalizaConexao(session.getId()+ "CONTAPL");
					}

					query = "SELECT APL_SIGLA, APL_NOME, APL_ENDERECO FROM APLICACAO";
					rs = conn.executaConsulta(query, session.getId()
							+ "APLSIGLA");

					if (rs.next()) {
						if (aplic > 1) {
%>
<table width="100%" align="center" border="0" cellspacing="0"
	cellpadding="0" scroll="no">
	<tr class="hcfundo" valign="top">
		&nbsp;
	</tr>
</table>
<table width="100%" height="80%" scroll="no" border="0" cellspacing="12"
	cellpadding="0" valign="top" align="center">
	<%
		do {
									if (rs.getString(1).equals("CM")) {
	%>
	<tr>
		<td>
		<div align="center"><a
			href="grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>"><img
			src="art/cm_peq.gif" border="0"></a></div>
		</td>
	</tr>
	<%
		}

									if (rs.getString(1).equals("EM")) {
	%>
	<tr>
		<td>
		<div align="center"><a
			href="grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>"><img
			src="art/em_peq.gif" border="0"></a></div>
		</td>
	</tr>

	<%
		}

									if (rs.getString(1).equals("EF")) {
	%>
	<tr>
		<td>
		<div align="center"><a
			href="grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>"><img
			src="art/ef_peq.gif" border="0"></a></div>
		</td>
	</tr>
	<%
		}
								} while (rs.next());
	%>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	scroll="no">
	<tr align="right">
		<td colspan="3" class="difundo" height="30">
		<table scroll="no" width="100%" valign="top" border="0"
			cellspacing="0" cellpadding="0">
			<tr>
				<td height="13" width="400">
				<table scroll="no" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20" height="13"><img src="art/bit.gif" width="20"
							height="10"></td>
						<td width="10" height="13">&nbsp;</td>
						<td class="difont" width="400" height="13">
						<%
							if (!EMAIL_DE_SUPORTE.equals("")) {
						%> <b>D&uacute;vidas?</b> Entre em contato com:&nbsp;<a
							href="mailto:<%=EMAIL_DE_SUPORTE%>" class="dilink"><%=EMAIL_DE_SUPORTE%></a>
						<%
							}
						%>
						</td>
					</tr>
				</table>
				</td>
				<td align="right" width="79" height="13"><img src="art/bit.gif"
					width="20" height="10"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	}//if(aplic > 1)

						else {
%>
<script language="JavaScript">
					window.open("grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>","_self");
					</script>
<%
	}
					}
					if (rs != null) {
						rs.close();
						//	conn.finalizaConexao(session.getId()+ "APLSIGLA");
					}
					//if(rs.next())
				}//else 
			}//if(rs.getString(3) != null)

			else {
%>
<script language="JavaScript">
					var sRtn;					
					sRtn = showModalDialog("senhaUp.jsp?login=<%=login%>","","center=yes;status=no;scroll=no;dialogWidth=400px;dialogHeight=200px");

					if(sRtn == 2)
						window.open("login.jsp", "_self");
				</script>
<%
	request.getSession(true);
				session.setMaxInactiveInterval(18000);
				session.setAttribute("usu_cod", usu_codigo);
				session.setAttribute("usu_nome", usu_nome);
				session.setAttribute("usu_login", login);
				session.setAttribute("usu_filial", login);
				session.setAttribute("usu_fil", usu_fil);
				session.setAttribute("usu_idi", usu_idi);
				Vector v1 = (Vector) trd1
						.montaVetor(usu_idi.intValue());
				trd1.setSession(session.getId());
				session.setAttribute("Traducao", trd1);
				session.setAttribute("usu_plano", usu_plano);
				session.setAttribute("funcs", funcs);
				session.setAttribute("pagina", pag);
				//session.setAttribute("s_conexao", DRIVERNAME);
				//session.setAttribute("s_usubanco", USERNAME);
				//session.setAttribute("s_senbanco", PASSWORD);
				//session.setAttribute("s_driverbanco", DRIVER_BD);
				//session.setAttribute("conn",conn);
				session.setAttribute("barra", BARRA);
				session.setAttribute("email_suporte", EMAIL_DE_SUPORTE);

				session.setAttribute("fun_codigo", usu_codigo);
				session.setAttribute("fun_nome", usu_nome);
				session.setAttribute("fun_login", login);
				session.setAttribute("fun_idi", usu_idi);

				query = "SELECT COUNT(APL_CODIGO) FROM APLICACAO";
				rs = conn.executaConsulta(query, session.getId()
						+ "CONTAPL");
				if (rs.next()) {
					aplic = rs.getInt(1);
				}

				if (rs != null) {
					rs.close();
					//conn.finalizaConexao(session.getId() + "CONTAPL");
				}

				query = "SELECT APL_SIGLA, APL_NOME, APL_ENDERECO FROM APLICACAO";
				rs = conn.executaConsulta(query, session.getId()
						+ "APLSIGLA");

				if (rs.next()) {
					if (aplic > 1) {
%>
<table width="100%" align="center" border="0" cellspacing="0"
	cellpadding="0" scroll="no">
	<tr class="hcfundo" valign="top">
		&nbsp;
	</tr>
</table>

<table width="100%" height="80%" scroll="no" border="0" cellspacing="12"
	cellpadding="0" valign="top" align="center">

	<%
		do {
								if (rs.getString(1).equals("CM")) {
	%>
	<tr>
		<td>
		<div align="center"><a
			href="grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>"><img
			src="art/cm_peq.gif" border="0"></a></div>
		</td>
	</tr>
	<%
		}

								if (rs.getString(1).equals("EM")) {
	%>
	<tr>
		<td>
		<div align="center"><a
			href="grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>"><img
			src="art/em_peq.gif" border="0"></a></div>
		</td>
	</tr>

	<%
		}

								if (rs.getString(1).equals("EF")) {
	%>
	<tr>
		<td>
		<div align="center"><a
			href="grava_aplicacao.jsp?aplicacao=<%=rs.getString(1)%>&endereco=<%=rs.getString(3)%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>"><img
			src="art/ef_peq.gif" border="0"></a></div>
		</td>
	</tr>
	<%
		}
							} while (rs.next());
	%>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	scroll="no">
	<tr align="right">
		<td colspan="3" class="difundo" height="30">
		<table scroll="no" width="100%" valign="top" border="0"
			cellspacing="0" cellpadding="0">
			<tr>
				<td height="13" width="400">
				<table scroll="no" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20" height="13"><img src="art/bit.gif" width="20"
							height="10"></td>
						<td width="10" height="13"><img src="art/bit.gif" width="10"
							height="10"></td>
						<td class="difont" width="400" height="13">
						<%
							if (!EMAIL_DE_SUPORTE.equals("")) {
						%> <b>D&uacute;vidas?</b> Entre em contato com:&nbsp;<a
							href="mailto:<%=EMAIL_DE_SUPORTE%>" class="dilink"><%=EMAIL_DE_SUPORTE%></a>
						<%
							}
						%>
						</td>
					</tr>
				</table>
				</td>
				<td align="right" width="79" height="13"><img src="art/bit.gif"
					width="20" height="10"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	}//if(aplic > 1)

					else {
						String aplX = "", end2 = "";
						aplX = rs.getString(1);
						end2 = rs.getString(3);
%>
<script language="JavaScript">
	window.open("grava_aplicacao.jsp?aplicacao=<%=aplX%>&endereco=<%=end2%>&func=<%=usu_codigo%>&senha=<%=senha%>&login=<%=login%>","_self");
</script>
<%
	//response.sendRedirect("grava_aplicacao.jsp?aplicacao="+rs.getString(1)+"&endereco="+rs.getString(3)+"&func="+usu_codigo+"&senha="+senha+"&login="+login);
					}
				}//if(rs.next())
				if (rs != null) {
					rs.close();
					//conn.finalizaConexao(session.getId() + "APLSIGLA");
				}
			}
		} else {
			if (rs != null) {
				rs.close();
				//conn.finalizaConexao(session.getId() + "FIL");
			}
%>
<script language="JavaScript">
	window.open("login.jsp?msgerro=Usuario nao cadastrado!", "_self");
</script>
<%
	}
	}

	conn.finalizaConexao();
	//} catch(Exception e){
	//	out.println("Erro: "+e);
	//}
%>

</html>