<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%
//*******************************//
//   DECLARACAO DAS VARIAVEIS    //
//*******************************//
Vector fun_ok	= new Vector();
Vector fun_no	= new Vector();
int contador = 0;
int a = 0;
String query = "", nome = "";
ResultSet rs;

//*******************************//
//   RECUPERA DADOS DA SESSAO    //
//*******************************//
request.getSession();
fun_ok	= (Vector) session.getAttribute("funcOK");
fun_no 	= (Vector) session.getAttribute("funcNO");
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title><%=trd.Traduz("FirstOn")%></title>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body  onunload='return fecha();' >

<%
//*******************************//
//          PROGRAMACAO          //
//*******************************//
%>
<table border="0" width="100%" height="100%" cellspacing="1">
	<%
	if(fun_ok.size() != 0){
		%>
		<tr class="celnortab">
		 <td height="10%">
		   <b><%=trd.Traduz("FUNCIONARIO(S) EXCLUIDO(S) COM SUCESSO")%>:</b>
		 </td>
		</tr>
		<tr class="ftverdanacinza">
		 <td valign="top">
		<%
		for(a = 0; a < fun_ok.size(); a++){
			query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+fun_ok.elementAt(a);
			rs = conexao.executaConsulta(query,session.getId()+"RS_2");
			if(rs.next()){
				if(rs.getString(1) != null){
					out.println("<li>"+rs.getString(1));
				}
			}
                        if(rs!=null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS_2");
                        } 
		}
		%>
		 </td>
		</tr>
		<%
	}
	if(fun_no.size() != 0){
		%>
		<tr class="celnortab">
		 <td height="10%">
		  <b><%=trd.Traduz("FUNCIONARIO(S) NAO EXCLUIDO(S). EXISTE(M) REGISTRO(S) REALIZADO(S) PARA ESTE(S) FUNCIONARIO(S)")%>:</b>
		 </td>
		</tr>
		<tr class="ftverdanacinza">
		 <td valign="top">
		<%
		for(a = 0; a < fun_no.size(); a++){
			query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+fun_no.elementAt(a);
			rs = conexao.executaConsulta(query,session.getId()+"RS_1");
			if(rs.next()){
				if(rs.getString(1) != null){
					out.println("<li>"+rs.getString(1));
				}
			}
                        if(rs!=null){
                        rs.close();
                        conexao.finalizaConexao(session.getId()+"RS_1");
                        }
		}
		%>
		 </td>
		</tr>
		<%
	}
	%>
	<tr class="ftverdanacinza">
	 <td align="center" class="ftverdanacinza" height="10%">
	  <input type="button" class="botcin" value="       <%=trd.Traduz("OK")%>       " name="botao" onClick="JavaScript:window.close();">
	 </td>
	</tr>
</body>
</html>
