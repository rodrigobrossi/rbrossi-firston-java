<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.lang.Math.*, java.util.*"%>

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

String query = "", queryH = "";
ResultSet rs = null, rsH = null;

String t = "";
if(request.getParameter("sel_func") != null)
  t = request.getParameter("sel_func");
String codigo = "";
if(request.getParameter("codigo") != null)
  codigo = request.getParameter("codigo");
  
queryH = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+codigo;
rsH = conexao.executaConsulta(queryH,session.getId()+"RS_1");
rsH.next();

query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = "+t;
rs = conexao.executaConsulta(query,session.getId()+"RS_2");
rs.next();

if(rsH.getString(1).equals(rs.getString(1)))
{
  //****************TABELA COMP_FUNC************************//
  query = "UPDATE COMP_FUNC SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA FOCOFILIAL***********************//
  query = "UPDATE FOCOFILIAL SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA TREINAMENTO***********************//
  query = "UPDATE TREINAMENTO SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA TURMA*****************************//
  query = "UPDATE TURMA SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  query = "UPDATE TURMA SET FUN_CODIGO_INSTR = "+t+" WHERE FUN_CODIGO_INSTR = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA FUNC_USUARIO**********************//
  query = "UPDATE FUNC_USUARIO SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA CURSO*****************************//
  query = "UPDATE CURSO SET FUN_CODIGO_RESP = "+t+" WHERE FUN_CODIGO_RESP = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA FILIAL****************************//
  query = "UPDATE FILIAL SET FUN_CODIGO_RESP = "+t+" WHERE FUN_CODIGO_RESP = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA PLANO_SUCESSORIO******************//
  query = "UPDATE PLANO_SUCESSORIO SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA SOLIC_PLANO***********************//
  query = "UPDATE SOLIC_PLANO SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA SOLICITACAO***********************//
  query = "UPDATE SOLICITACAO SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA CUSTOREAL***********************//
  query = "UPDATE CUSTOREAL SET FUN_CODIGO = "+t+" WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  //****************TABELA FUNCIONARIO**********************//
  query = "UPDATE FUNCIONARIO SET FUN_CODSOLIC = "+t+" WHERE FUN_CODSOLIC = "+codigo;
  conexao.executaAlteracao(query);
  query = "DELETE FUNCIONARIO WHERE FUN_CODIGO = "+codigo;
  conexao.executaAlteracao(query);
  %>
  
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script language="JavaScript">   
  alert("EFETIVACAO DO FUNCIONARIO EFETUADA COM SUCESSO");
  window.open("funcionarios.jsp", "_parent");
  </script>
  <%
}
else{
  %>
  <script language="JavaScript">   
  alert("IMPOSSIVEL EFETTIVACAO: NOMES INCOMPATIVEIS");
  window.open("efetiva.jsp?codigo=<%=codigo%>", "_parent");
  </script>
  <%  
}
//FinalziaConexao
if(rs != null){
    rs.close();
    conexao.finalizaConexao(session.getId()+"RS_2");
    }
if(rsH!=null){
    rsH.close();
    conexao.finalizaConexao(session.getId()+"RS_1");
    }
%>