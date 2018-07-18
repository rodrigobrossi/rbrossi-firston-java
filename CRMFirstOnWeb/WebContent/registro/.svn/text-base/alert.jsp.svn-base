<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>
<%
//try{

//*******************************//
//   DECLARACAO DAS VARIAVEIS    //
//*******************************//
Vector func_reg 	= new Vector();
Vector func_aval 	= new Vector();
Vector func_reg_ant = new Vector();
int contador = 0;
int a = 0;
String query = "", nome = "";
ResultSet rs;

//*******************************//
//   RECUPERA DADOS DA SESSAO    //
//*******************************//
request.getSession();
func_reg	= (Vector) session.getAttribute("vet1");
func_aval 	= (Vector) session.getAttribute("vet2");
func_reg_ant= (Vector) session.getAttribute("vet3");
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
contador = func_aval.size();
for(a = contador - 1; a >= 0; a--){
	if(func_reg_ant.contains(func_aval.elementAt(a))){
		func_aval.remove(a);
	}
}

%>
<table border="0" width="100%" height="100%" cellspacing="1">
<%
contador = func_reg_ant.size();
if(contador != 0){
	%>
	<tr class="celnortab">
	 <td height="10%">
	   <b><%=trd.Traduz("FUNCIONARIO(S) JA REGISTRADO(S) ANTERIORMENTE")%>:</b>
	 </td>
	</tr>
	<tr class="ftverdanacinza">
	 <td valign="top">
	 <%
	 for(a = 0; a < contador; a++){
		query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+func_reg_ant.elementAt(a);
		rs = conexao.executaConsulta(query,session.getId());
		if(rs.next()){
			if(rs.getString(1)!=null){
				out.println("<li>"+rs.getString(1));
			}
		}
                if(rs!=null){
                rs.close();
                conexao.finalizaConexao(session.getId());
                }
	 }
	 %>
  </td>
</tr>
<%}
contador = func_aval.size();
if(contador != 0){
	%>
	<tr class="celnortab">
	 <td height="10%">
	  <b><%=trd.Traduz("FUNCIONARIO(S) NAO INSERIDOS NA AVALIACAO POR NAO CONTEREM SOLICITANTE")%>:</b>
	 </td>
	</tr>
	<tr class="ftverdanacinza">
	 <td valign="top">
	 <%
	 for(a = 0; a < contador; a++){
		query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+func_aval.elementAt(a);
		rs = conexao.executaConsulta(query,session.getId());
		if(rs.next()){
			if(rs.getString(1)!=null){
				out.println("<li>"+rs.getString(1));
			}
		}
                if(rs!=null){
                rs.close();
                conexao.finalizaConexao(session.getId());
                }
	 }
	 %>
 </td>
</tr>
<%}
contador = func_reg.size();
if(contador != 0){
	%>
	<tr class="celnortab">
	 <td height="10%">
	  <b><%=trd.Traduz("FUNCIONARIO(S) REGISTRADO(S) COM SUCESSO")%>:</b>
	 </td>
	</tr>
	<tr class="ftverdanacinza">
	 <td valign="top">
	 <%
	 for(a = 0; a < contador; a++){
		query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+func_reg.elementAt(a);
		rs = conexao.executaConsulta(query,session.getId());
		if(rs.next()){
			if(rs.getString(1) != null){
				out.println("<li>"+rs.getString(1));
			}
		}
                if(rs!=null){
                rs.close();
                conexao.finalizaConexao(session.getId());
                }
	 }
	  %>
	 </td>
	</tr>
<%}
%>
<tr class="ftverdanacinza">
 <td align="center" class="ftverdanacinza" height="10%">
  <input type="button" class="botcin" value="       <%=trd.Traduz("OK")%>       " name="botao" onClick="JavaScript:window.close();">
 </td>
</tr>
</body>
</html>
<%
//} catch(Exception e){
//  out.println("ERRO:"+e);
//}
%>