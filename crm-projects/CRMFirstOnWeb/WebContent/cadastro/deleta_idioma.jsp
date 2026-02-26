<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><html>
<body  onunload='return fecha();' >
<%
request.getSession();
FOLocalizationBean trd   = (FOLocalizationBean) session.getAttribute("Traducao");
FODBConnectionBean conexao = (FODBConnectionBean)session.getAttribute("Conexao");

Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 
int cod_idi = Integer.parseInt((String)request.getParameter("idi"));
ResultSet rs = null;
String query = "";

query = "SELECT IDI_CODIGO FROM FUNCIONARIO WHERE IDI_CODIGO = "+cod_idi;
rs = conexao.executaConsulta(query,session.getId()+"RS1");
if(rs.next()){
  %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("O IDIOMA NAO PODE SER EXCLUIDO")+"\"")%>);
    window.open("idioma.jsp","_self");
  </script>
  <%
}

else if(usu_idi.intValue() == cod_idi){
  %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("O IDIOMA NAO PODE SER EXCLUIDO POIS ESTA SENDO UTILIZADO")+"\"")%>);
    window.open("idioma.jsp","_self");
  </script>
  <%
  
}

else{
  String queryDEL = "DELETE FROM LNG_TRADUCAO WHERE IDI_CODIGO = "+cod_idi;
  conexao.executaAlteracao(queryDEL);
  queryDEL = "DELETE FROM LNG_IDIOMA WHERE IDI_CODIGO = "+cod_idi;
  conexao.executaAlteracao(queryDEL);
  %>
  <script language=""JavaScript>
  alert(<%=("\""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
  window.open("idioma.jsp","_self");
  </script>
  <%
}
if(rs != null){
  rs.close();
  conexao.finalizaConexao(session.getId()+"RS1");
}


%>

</body>
</html>