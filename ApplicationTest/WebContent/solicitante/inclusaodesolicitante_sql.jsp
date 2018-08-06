<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<body>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.sql.*"%>

<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>


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
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
String aplicacao = (String)session.getAttribute("aplicacao");

//Variaveis
String query="", tipo_operacao="", codigo="", pagina="", cbo_tipo="", txt_login="", cbo_func="";
String fil_cod="", padrao="", def="", senha="", cod_solic="", nome="", tipo_usu="", login="", inc_alt="";
ResultSet rs = null;
int cont=0;

//Recupera parametros e gera login
if (request.getParameter("tipo_op") != null)
  tipo_operacao = request.getParameter("tipo_op");
if (request.getParameter("cod") != null)
  codigo = request.getParameter("cod");
if (request.getParameter("cbo_tipo") != null)
  cbo_tipo = request.getParameter("cbo_tipo");
if (request.getParameter("txt_login") != null)
  txt_login = request.getParameter("txt_login");
if (request.getParameter("fun_cod") != null)
  cbo_func = request.getParameter("fun_cod");
if (request.getParameter("inc_alt") != null)
  inc_alt = request.getParameter("inc_alt");

//*************
//Exclui filial
//*************
if (tipo_operacao.equals("E")) {
	cbo_func = request.getParameter("cbo_func");
	query = "SELECT COUNT(*) FROM FOCOFILIAL WHERE FUN_CODIGO = " +cbo_func;
	rs = conexao.executaConsulta(query,session.getId());
	if (rs.next())
		cont = rs.getInt(1);
	for (int i=0; i<=cont; i++) {
		if (request.getParameter("chk_fil_"+i) != null) {
			codigo = request.getParameter("chk_fil_"+i);
			conexao.finalizaConexao(session.getId());
			query = "SELECT FCO_DEFAULT FROM FOCOFILIAL WHERE FCO_CODIGO = "+codigo;
			rs = conexao.executaConsulta(query,session.getId()+"RS");
			if (rs.next()) {
				if (rs.getString(1).equals("S")) {
					
					out.print("<script language=\"JavaScript\">");
					out.print("alert(\" "+trd.Traduz("A filial padrao nao pode ser excluida!")+" \" );");
					out.print("</script>");
				}
				else {
					query = "DELETE FOCOFILIAL WHERE FCO_CODIGO = " +codigo+ " ";
					conexao.executaAlteracao(query);
				}
			}
                        if(rs!=null){
                           rs.close();
                           conexao.finalizaConexao(session.getId()+"RS");
                        }
		}
	}
	if (inc_alt.equals("I")) {
		pagina = "inclusaodesolicitante.jsp?cbo_func=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login;
	}
	else {
		pagina = "inclusaodesolicitante.jsp?chk_solic=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login;
	}
	%>
<script language="JavaScript">
		window.open("<%=pagina%>", "_parent");
	</script>
<%
}

//***************************
//Inclui filial (foco filial)
//***************************
if (tipo_operacao.equals("IF")) {
	//Recupera parametros da pagina anterior (inclusaodesolicitante.jsp)
	if (request.getParameter("cbo_func") != null)
		cbo_func = request.getParameter("cbo_func");
	if (request.getParameter("cbo_tipo") != null) 
		cbo_tipo = request.getParameter("cbo_tipo");
	if (request.getParameter("txt_login") != null) 
		txt_login = request.getParameter("txt_login");
	if (request.getParameter("fil_cod") != null) 
		fil_cod = request.getParameter("fil_cod");
	if (request.getParameter("padrao") != null) 
		padrao = request.getParameter("padrao");
	String tipo_op2 = "";
	if (request.getParameter("tipo_op2") != null) 
		tipo_op2 = request.getParameter("tipo_op2");
	if (padrao.equals("true"))
		def = "S";
	else
		def = "N";
  	
  	query = "SELECT FCO_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO = "+cbo_func+" AND FIL_CODIGO = "+fil_cod;
  	rs = conexao.executaConsulta(query,session.getId()+"RS_1");
  	
  	if(!rs.next()){
  		query = "SELECT FCO_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO = "+cbo_func;
                conexao.finalizaConexao(session.getId()+"RS_1");
  		rs = conexao.executaConsulta(query,session.getId()+"RS_2");
  		if (rs.next()) {
  			if (def.equals("S")) {
  				query = "UPDATE FOCOFILIAL SET FCO_DEFAULT = 'N' WHERE FUN_CODIGO = "+cbo_func;
      				conexao.executaAlteracao(query);
      				query = "INSERT INTO FOCOFILIAL (FIL_CODIGO, FUN_CODIGO, FCO_DEFAULT ) VALUES (" +fil_cod+ "," +cbo_func+ ", '" +trataAspas(def)+ "')";
      				conexao.executaAlteracao(query);
    			}
    			else {
      				query = "INSERT INTO FOCOFILIAL (FIL_CODIGO, FUN_CODIGO, FCO_DEFAULT ) VALUES (" +fil_cod+ "," +cbo_func+ ", '" +trataAspas(def)+ "')";
      				conexao.executaAlteracao(query);
    			}
  		}
  		else {
    			query = "INSERT INTO FOCOFILIAL (FIL_CODIGO, FUN_CODIGO, FCO_DEFAULT ) VALUES (" +fil_cod+ "," +cbo_func+ ", 'S')";
    			conexao.executaAlteracao(query);
  		}
                if(rs!=null){
                   rs.close();
                   conexao.finalizaConexao(session.getId()+"RS_2");
                }
  	}
  	else{
		%>
<script language="JavaScript">
			alert(<%=("\""+trd.Traduz("IMPOSSIVEL INCLUIR USUARIO JA PERTENCE A ESTA FILIAL")+"\"")%>);
		</script>
<%
  	}
	if (inc_alt.equals("A")) {
    		pagina = "inclusaodesolicitante.jsp?chk_solic=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login+ "&inc_alt=" +inc_alt+ "&tipo_op=" +tipo_op2;
  	}
  	else {
    		pagina = "inclusaodesolicitante.jsp?cbo_func=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login;
  	}
	%>
<script language="JavaScript">
		window.open("<%=pagina%>","_self");
	</script>
<%
  	
	//response.sendRedirect(pagina);
}

//***********************
//Inclusao de solicitante
//***********************
if (tipo_operacao.equals("IS")){
	if (request.getParameter("cbo_func") != null)
		cbo_func = request.getParameter("cbo_func");
	if (request.getParameter("senha") != null) 
		senha = request.getParameter("senha");
	if (request.getParameter("cbo_tipo") != null) 
		cbo_tipo = request.getParameter("cbo_tipo");
	if (request.getParameter("txt_login") != null) 
		txt_login = request.getParameter("txt_login");
	
	query = "SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FUN_LOGIN = '"+txt_login+"' AND FUN_CODIGO <> "+cbo_func+"";
	rs = conexao.executaConsulta(query,session.getId()+"RS_3");
	if(rs.next()){
		%>
<script language="JavaScript">
			alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR LOGIN JA EXISTENTE")+"\"")%>);
			history.go(-1);
		</script>
<%
	}
	else{
		query = "SELECT FIL_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO = " +cbo_func+ " ";
		rs = conexao.executaConsulta(query,session.getId()+"RS_4");
		if (rs.next()){
			
			
			
			
			if(senha.equals("")){
				query = "UPDATE FUNCIONARIO SET FUN_TIPOUSUARIO = '" +trataAspas(cbo_tipo)+ "', "+
					"FUN_LOGIN = '" +txt_login+ "', IDI_CODIGO = " +usu_idi+ " "+
					"WHERE FUN_CODIGO = " +cbo_func+ " ";
			}
			else{
				query = "UPDATE FUNCIONARIO SET FUN_TIPOUSUARIO = '" +trataAspas(cbo_tipo)+ "', FUN_LOGIN = '" +(txt_login)+ "', "+
					"FUN_SENHA = '" +trataAspas(senha)+ "', IDI_CODIGO = " +usu_idi+ " "+
					"WHERE FUN_CODIGO = " +cbo_func+ " ";
			}
			conexao.executaAlteracao(query);
			if (inc_alt.equals("I")) {
				query = "INSERT INTO FUNC_USUARIO (FUN_CODIGO, TIP_TIPO) VALUES (" +cbo_func+ ", '" +trataAspas(cbo_tipo)+ "')";
			}
			else {
				query = "UPDATE FUNC_USUARIO SET TIP_TIPO = '" +trataAspas(cbo_tipo)+ "' "+
					"WHERE FUS_CODIGO = (SELECT F.FUS_CODIGO FROM FUNC_USUARIO F, TIPOUSUARIO T, APLICACAO A "+
					"WHERE A.APL_SIGLA = '" +trataAspas(aplicacao)+ "' AND A.APL_CODIGO = T.APL_CODIGO "+
					"AND T.TIP_TIPO = F.TIP_TIPO AND F.FUN_CODIGO = " +cbo_func+ ")";
			}
			conexao.executaAlteracao(query);
			%>
<script language="JavaScript">
				alert(<%=("\""+trd.Traduz("INCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
				window.open("solicitantes.jsp","_self");
			</script>
<%
			//response.sendRedirect("solicitantes.jsp");
		}
		else {
			if (inc_alt.equals("I")) {
				pagina = "inclusaodesolicitante.jsp?cbo_func=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login;
			}
			else {
				pagina = "inclusaodesolicitante.jsp?chk_solic=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login+ "&inc_alt=A";
			}
			%>
<script language="JavaScript">
				alert(<%=("\""+trd.Traduz("Favor incluir uma filial!")+"\"")%>);
				window.open("<%=pagina%>", "_parent");
			</script>
<%
		}
                if(rs!=null){
                rs.close();
                conexao.finalizaConexao(session.getId()+"RS_4");
                }
	}
}

//************************
//Alteracao de solicitante
//************************
/*
if (tipo_operacao.equals("AS")) {
  if (request.getParameter("cbo_func") != null)
    cbo_func = request.getParameter("cbo_func");
  if (request.getParameter("senha") != null) 
    senha = request.getParameter("senha");
  if (request.getParameter("cbo_tipo") != null) 
    cbo_tipo = request.getParameter("cbo_tipo");
  if (request.getParameter("txt_login") != null) 
    txt_login = request.getParameter("txt_login");
  query = "SELECT FIL_CODIGO FROM FOCOFILIAL WHERE FUN_CODIGO = " +cbo_func+ " ";
  rs = conexao.executaConsulta(query);
  if (rs.next()){
    query = "UPDATE FUNCIONARIO SET FUN_TIPOUSUARIO = '" +cbo_tipo+ "', FUN_LOGIN = '" +txt_login+ "', "+
            "FUN_SENHA = '" +senha+ "', IDI_CODIGO = " +usu_idi+ " "+
            "WHERE FUN_CODIGO = " +cbo_func+ " ";
    conexao.executaAlteracao(query);
    query = "INSERT INTO FUNC_USUARIO (FUN_CODIGO, TIP_TIPO) VALUES (" +cbo_func+ ", '" +cbo_tipo+ "')";
    conexao.executaAlteracao(query);
    response.sendRedirect("solicitantes.jsp");
  } else {
    pagina = "inclusaodesolicitante.jsp?cbo_func=" +cbo_func+ "&cbo_tipo=" +cbo_tipo+ "&txt_login=" +txt_login;%>
<script language="JavaScript">
      //alert("<%//=trd.Traduz("Favor incluir uma filialAAAAAA!")+"\"")%>);
      //window.open("<%//=pagina%>", "_parent");
    </script>
<%}
}*/

//*******************
//Exclui solicitantes
//*******************
if (tipo_operacao.equals("ES")) {
	if (request.getParameter("chk_solic") != null)
		cod_solic = request.getParameter("chk_solic");
  
	query = "SELECT F.FUN_NOME, U.TIP_TIPO, F.FUN_LOGIN "+
		"FROM FUNCIONARIO F, FUNC_USUARIO U "+
		"WHERE F.FUN_CODIGO = " +cod_solic+ " "+
		"AND F.FUN_CODIGO = U.FUN_CODIGO";

	rs = conexao.executaConsulta(query,session.getId()+"RS_8");
	if (rs.next()) {
		nome = rs.getString(1); 
		tipo_usu = rs.getString(2); 

		if(rs.getString(3) != null)
			login = rs.getString(3); 
	}
        if(rs!=null){
            conexao.finalizaConexao(session.getId()+"RS_8");
        }
	if (login.equals(usu_login)){
		%>
<script language="JavaScript">
			alert(<%=("\""+trd.Traduz("Este funcionario nao pode ser excluido no momento")+"\"")%>);
			window.open("solicitantes.jsp", "_parent");
		</script>
<%
	} 
	else {
		rs = null;
		query = "SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FUN_CODSOLIC = " +cod_solic+ " ";
		rs = conexao.executaConsulta(query,session.getId()+"RS_9");
		if (rs.next()) {
			
				String msgStr  = "\""+trd.Traduz("O(A) solicitante ") + nome.trim()+ trd.Traduz(" possui subordinados!")+ "\r"+ trd.Traduz("Deseja continuar a exclusao?")+"\"";
				%>
<script language="JavaScript">
				var msg = "<%=msgStr%>";
				var conf = confirm();
				if (!conf) {
					window.open("solicitantes.jsp", "_parent");
				}
				else{
					<%
					//Exclui vinculo de subordinado
					query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = NULL WHERE FUN_CODSOLIC = " +cod_solic+ " ";
					conexao.executaAlteracao(query);
					//Atualiza o tipo do usuario
					query = "UPDATE FUNCIONARIO SET FUN_TIPOUSUARIO = NULL, FUN_LOGIN = NULL, "+
						"FUN_SENHA = NULL "+
						"WHERE FUN_CODIGO = " +cod_solic+ " ";
					conexao.executaAlteracao(query);
					//Exclui o funcionario da lista de usuarios
					query = "DELETE FROM FUNC_USUARIO " +
						"WHERE FUN_CODIGO = "+cod_solic+ " AND TIP_TIPO = '" +tipo_usu.trim()+ "' ";
					conexao.executaAlteracao(query);
					//Exclui o funcionario da FocoFilial
					query = "DELETE FROM FOCOFILIAL " +
						"WHERE FUN_CODIGO = "+cod_solic+ " ";
					conexao.executaAlteracao(query);	
					%>
				}
			</script>
<%   			
		}
		else{
			//Exclui vinculo de subordinado
			query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = NULL WHERE FUN_CODSOLIC = " +cod_solic+ " ";
			conexao.executaAlteracao(query);
			//Atualiza o tipo do usuario
			query = "UPDATE FUNCIONARIO SET FUN_TIPOUSUARIO = NULL, FUN_LOGIN = NULL, "+
				"FUN_SENHA = NULL "+
				"WHERE FUN_CODIGO = " +cod_solic+ " ";
			conexao.executaAlteracao(query);
			//Exclui o funcionario da lista de usuarios
			query = "DELETE FROM FUNC_USUARIO " +
				"WHERE FUN_CODIGO = "+cod_solic+ " AND TIP_TIPO = '" +tipo_usu.trim()+ "' ";
			conexao.executaAlteracao(query);	
			//Exclui o funcionario da FocoFilial
			query = "DELETE FROM FOCOFILIAL " +
				"WHERE FUN_CODIGO = "+cod_solic+ " ";
			conexao.executaAlteracao(query);	
		}
                if(rs!=null){
                   rs.close();
                   conexao.finalizaConexao(session.getId()+"RS_9");
                }
			out.print("	<script language=\"JavaScript\" >" );
			out.print("	alert(<%=( \""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\" )");
			out.print("window.open(\"solicitantes.jsp\", \"_parent\");");
			out.print("</script>");
	}
}

//*******************
//Exclui subordinados
//*******************
if (tipo_operacao.equals("ESUB")) {
	if (request.getParameter("chk_solic") != null)
		cbo_func = request.getParameter("chk_solic");
	query = "SELECT COUNT(*) FROM FUNCIONARIO WHERE FUN_CODSOLIC IS NOT NULL AND FUN_CODSOLIC = " +cbo_func+ " ";
	rs = conexao.executaConsulta(query,session.getId());
	if (rs.next())
		cont = rs.getInt(1);
	for (int i=0; i<=cont; i++) {
		if (request.getParameter("chk"+i) != null) {
			query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = NULL "+
				"WHERE FUN_CODSOLIC = " +cbo_func+ " AND FUN_CODIGO = " +request.getParameter("chk"+i)+ " ";
			conexao.executaAlteracao(query);
		}
	}
        if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId());
        }
	
	out.print("<script language=\"JavaScript\">");
	out.print("alert(<\" "+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+" \" );");
	out.print("window.open(\"subordinados.jsp?filtro=\" "+ cbo_func+" \",\"_self\")");
	out.print("</script>");
	
}

//*******************
//Inclui subordinados
//*******************
if (tipo_operacao.equals("ISUB")) {
	int qtos=0;
	if (request.getParameter("chk_solic") != null)
		cbo_func = request.getParameter("chk_solic");
	query = "SELECT COUNT(*) FROM FUNCIONARIO WHERE FUN_CODSOLIC IS NULL";
	rs = conexao.executaConsulta(query,session.getId());
	if (rs.next())
		cont = rs.getInt(1);
	for (int i=0; i<=cont; i++) {
		if (request.getParameter("chk_sub_"+i) != null) {
			query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = " +cbo_func+ " "+
				"WHERE FUN_CODIGO = " +request.getParameter("chk_sub_"+i)+ " ";
			conexao.executaAlteracao(query);
			qtos++;
		}
	}
	if (qtos == 0) {
		
		out.print("<script language=\"JavaScript\">");
		out.print(" alert(\""+trd.Traduz("NENHUM ITEM SELECIONADO")+"\" );");
		out.print("	window.open(\"subordinados.jsp?filtro="+ cbo_func+ ", \"_parent\");");
		out.print("</script>");
		
	}
	else {
		
	out.print("	<script language=\"JavaScript\" >" );
	out.print("	alert(<%=( \""+trd.Traduz("INCLUSAO EFETUADA COM SUCESSO")+"\" )");
	out.print("window.open(\"subordinados.jsp?filtro="+ cbo_func+ ", \"_parent\");");
	out.print("</script>");
		
	}
        if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId());
        }
	//response.sendRedirect("solicitantes.jsp?filtro=" +cbo_func);
}

if(rs != null) {
    rs.close();
}
%>
</body>
</html>
