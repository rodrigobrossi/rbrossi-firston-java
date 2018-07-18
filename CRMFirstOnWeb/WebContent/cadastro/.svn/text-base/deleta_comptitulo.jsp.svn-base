<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>

<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}

request.getSession();
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");
  
int cod_pre = Integer.parseInt((String)request.getParameter("pre"));
String  sel_titulo = (String)request.getParameter("titulo");
String  sel_competencia = (String)request.getParameter("competencia");

String usu_tipo  = (String) session.getAttribute("usu_tipo"); 
String usu_nome  = (String) session.getAttribute("usu_nome"); 
String usu_login = (String) session.getAttribute("usu_login"); 
Integer usu_fil  = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi  = (Integer)session.getAttribute("usu_idi"); 

String query = "delete from comp_titulo where cti_codigo="+cod_pre;
  
//try{
  conexao.executaAlteracao(query);
//}catch(Exception e){out.println(""+e);} 

conexao.finalizaConexao();
 
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%>
<script language="JavaScript">
  alert(<%=("\""+trd.Traduz("ExclusAo efetuada com sucesso")+"\"")%>);
  window.open("competencia_titulo.jsp?sel_titulo=<%=sel_titulo%>&sel_competencia=<%=sel_competencia%>","_self");
</script>
