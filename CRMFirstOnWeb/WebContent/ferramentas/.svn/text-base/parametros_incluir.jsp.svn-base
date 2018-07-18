<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*"%>

<%
String query = "", valor = "", codigo = "";

int i = 0, count = 0;

request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

count  = Integer.parseInt(request.getParameter("count"));

for(i = 1; i <= count; i++){
  valor = request.getParameter("tf_"+i);
  codigo = request.getParameter("cod_"+i);
  query = "UPDATE PARAM SET PAR_VALOR = '"+valor+"' WHERE PAR_CODIGO = '"+codigo+"'";
  conexao.executaAlteracao(query);    
}
conexao.finalizaConexao();
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
  alert(<%=("\""+trd.Traduz("ALTERACAO EFETUADA COM SUCESSO")+"\"")%>);
  window.open("parametros.jsp","_self");
</script>
