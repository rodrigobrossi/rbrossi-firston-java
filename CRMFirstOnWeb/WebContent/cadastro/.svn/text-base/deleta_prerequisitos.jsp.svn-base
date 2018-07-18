<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
request.getSession();
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");

String usu_tipo   = (String) session.getAttribute("usu_tipo"); 
String usu_nome   = (String) session.getAttribute("usu_nome"); 
String usu_login  = (String) session.getAttribute("usu_login"); 
Integer usu_fil   = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi   = (Integer)session.getAttribute("usu_idi"); 

int cont = Integer.parseInt((String)request.getParameter("cont"));

String query="";

try{

for (int i=0; i<=cont; i++) {
  if (request.getParameter("pre"+i) != null) {
    query = "DELETE FROM PLANOCARREIRA WHERE PLC_CODIGO = " +request.getParameter("pre"+i)+ " ";
    conexao.executaAlteracao(query);
  }
}
%>

<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
    window.open("prerequisitos.jsp","_self");
</script>
<%
}
catch(Exception e){
  %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("PRE-REQUISITO NAO PODE SER EXCLUIDO")+"\"")%>);
    window.open("prerequisitos.jsp","_self");
  </script>
  <%
 }
%>