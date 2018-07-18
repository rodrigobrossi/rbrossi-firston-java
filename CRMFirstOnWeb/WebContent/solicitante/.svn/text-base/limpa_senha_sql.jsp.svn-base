<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*"%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<form name="frm"> 
<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

  Integer usu_idi = (Integer)session.getAttribute("usu_idi");
  
  //Declaracao de variaveis
  String query="";
  int cont_resp = Integer.parseInt(request.getParameter("cont"));
  boolean contem = false;

  //Limpa as senhas 
  for (int k=0; k<=cont_resp; k++) {
    if(request.getParameter("chk"+k) != null) {
      query = "UPDATE FUNCIONARIO SET FUN_SENHA = NULL " +
              "WHERE FUN_CODIGO = " + request.getParameter("chk"+k) + " ";
      contem = true;
      conexao.executaAlteracao(query);
    }
  }

  if (!contem) {%>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("Favor escolher um funcionario!")+"\"")%>);
      window.open("limpa_senha.jsp","_self");
    </script>
<%} else {%>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("OperaCAo concluIda com Exito!")+"\"")%>);  
      window.open("limpa_senha.jsp","_self");
    </script>
<%}
	
%>
</html>
 