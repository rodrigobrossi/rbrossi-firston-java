<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>
<%request.getSession();FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");%>
<%request.getSession();FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");%>

<%
//try{
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")){
  response.setHeader("Cache-Control", "no-cache");
}
request.getSession();
String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

String tipo = "", cod = "-1", grunome = "";

if (!(request.getParameter("tipo") == null)){ 
  tipo = request.getParameter("tipo");
}
if (!(request.getParameter("cod") == null)){ 
  cod = request.getParameter("cod");
}
if (!(request.getParameter("gru_nome") == null)){ 
  grunome = request.getParameter("gru_nome");
}

//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 

String query="";
ResultSet rs;

if(tipo.equals("I")){
  query = "SELECT GRU_CODIGO FROM PERGRUPO WHERE GRU_NOME = '"+grunome+"'";
  rs = conexao.executaConsulta(query,session.getId());
  if(rs.next()){
    %>
    
<%@page import="firston.eval.components.FOLocalizationBean"%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><script language="JavaScript">
      alert("IMPOSSIVEL INCLUIR GRUPO JA EXISTENTE");
      window.open("grupopergunta.jsp","_self");
    </script>
    <%
  }
  else{
    query = "INSERT INTO PERGRUPO (GRU_NOME) VALUES ('"+grunome+"')";
    conexao.executaAlteracao(query);
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("INCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
      window.open("grupopergunta.jsp","_self");
    </script>
    <%
  }
  if(rs!=null){
    rs.close();
    conexao.finalizaConexao(session.getId());
    }
}
else if(tipo.equals("U")){
  query = "SELECT GRU_CODIGO FROM PERGRUPO WHERE GRU_NOME = '"+grunome+"' AND GRU_CODIGO <> "+cod;
  rs = conexao.executaConsulta(query,session.getId());
  if(rs.next()){
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("IMPOSSIVEL INCLUIR GRUPO JA EXISTENTE")+"\"")%>);
      window.open("grupopergunta.jsp","_self");
    </script>
    <%
  }
  else{
    query = "UPDATE PERGRUPO SET GRU_NOME = '"+grunome+"' WHERE GRU_CODIGO = "+cod;
    conexao.executaAlteracao(query);
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("ALTERACAO EFETUADA COM SUCESSO")+"\"")%>);
      window.open("grupopergunta.jsp","_self");
    </script>
    <%
  }
  if(rs!=null){
    rs.close();
    conexao.finalizaConexao(session.getId());
    }
}
else if(tipo.equals("E")){
    //testa se o grupo faz parte de um questionario
    query = "SELECT GRU_CODIGO FROM QUEST_PERGUNTA WHERE GRU_CODIGO = "+cod;
    rs = conexao.executaConsulta(query,session.getId());
    //out.println(""+query);
    if (rs.next()) {%>
        <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ESSE GRUPO NAO PODE SER EXCLUIDO POR FAZER PARTE DE UM QUESTIONARIO!")+"\"")%>);
        window.open("grupopergunta.jsp","_self");
    </script>
<%  } 
    else 
    {
     
    if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId());
    }

    query = "SELECT GRU_CODIGO FROM PERGUNTA WHERE GRU_CODIGO = " + cod;
    rs = conexao.executaConsulta(query,session.getId());

    if (rs.next()) {%>
        <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ESSE GRUPO NAO PODE SER EXCLUIDO POR EXISTIREM PERGUNTAS VINCULADAS!")+"\"")%>);
        window.open("grupopergunta.jsp","_self");
    </script>
    <%
    }
    else
    {
     
       query = "DELETE FROM PERGRUPO WHERE GRU_CODIGO = "+cod;
       conexao.executaAlteracao(query);
       //out.println(""+query);
       %>
       <script language="JavaScript">
          alert(<%=("\""+trd.Traduz("EXCLUSAO EFETUADA COM SUCESSO")+"\"")%>);
          window.open("grupopergunta.jsp","_self");
       </script>
       <%
       }//fim do else
       
       if(rs!=null){
          rs.close();
          conexao.finalizaConexao(session.getId());
       }
    }

}
//catch(Exception e){
//  out.println("Erro: "+e);
//}

%>
