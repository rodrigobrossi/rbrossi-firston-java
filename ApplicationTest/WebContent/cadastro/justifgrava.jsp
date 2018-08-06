<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*"%>

<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");


String usu_tipo = (String)session.getAttribute("usu_tipo"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

ResultSet rs = null, rsH = null, rsConsulta = null;
String query = "", nome = "", tipo = "", cod = "";

//Verifica se foram digitados os dados
if (!(request.getParameter("tipo") == null)){ 
  tipo = request.getParameter("tipo");
}

if (!(request.getParameter("cod") == null)){ 
  cod = request.getParameter("cod");
}

if (!(tipo.equals("E"))){
  if (request.getParameter("jusnome") != null)  { 
    nome = request.getParameter("jusnome");
  }
  else  {
  %>
   
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""+trd.Traduz("E necessArio digitar uma justificativa!")+"\"")%>);
    window.open("justificativas.jsp","_self");
   </script>
  <%
  }
}

//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar a Justificativa
if (tipo.equals("I")){
  String help = "SELECT JUS_NOME FROM JUSTIFICATIVA WHERE JUS_NOME = '"+nome+"'";
  rsH = conexao.executaConsulta(help,session.getId()+"RS_1");
  if(!rsH.next())  {
    query = "INSERT INTO JUSTIFICATIVA (JUS_NOME) VALUES ('" + nome + "')"; 
    conexao.executaAlteracao(query);
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("InclusAo efetuada com sucesso")+"\"")%>);
      window.open("justificativas.jsp","_self");
    </script>
    <%
  }
  else{
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR JUSTIFICATIVA JA EXISTENTE")+"\"")%>);
      window.open("justificativas.jsp","_self");
    </script>
    <%
  }
  if(rsH!=null){
    rsH.close();
    conexao.finalizaConexao(session.getId()+"RS_1");
    }
}

else{
  if (tipo.equals("U")){
    String queryVerifica = "SELECT JUS_NOME FROM JUSTIFICATIVA WHERE JUS_NOME = '"+nome+"' AND JUS_CODIGO <> "+cod;
    rsConsulta = conexao.executaConsulta(queryVerifica,session.getId()+"RS_2");
    if(!rsConsulta.next()){     
      query = "UPDATE JUSTIFICATIVA SET JUS_NOME = '" + nome + "' WHERE JUS_CODIGO = " + cod; 
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("AlteraCAo efetuada com sucesso")+"\"")%>);
        window.open("justificativas.jsp","_self");
      </script>
      <%
    }
    else{
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR JUSTIFICATIVA JA EXISTENTE")+"\"")%>);
        window.open("justificativas.jsp","_self");
      </script>
      <%
    }
    if(rsConsulta!=null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId()+"RS_2");
        }
  }
  if (tipo.equals("E")){
    query = "SELECT * FROM TREINAMENTO WHERE JUS_CODIGO = "+cod;
    rs = conexao.executaConsulta(query,session.getId()+"RS_3");
    if(rs.next()){
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ExclusAo nAo permitida. Existe Treinamento vinculado a esta Justificativa.")+"\"")%>);
        window.open("justificativas.jsp","_self");
      </script>
      <%
    }
    else{
      query = "DELETE FROM JUSTIFICATIVA WHERE JUS_CODIGO = "+cod;
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ExclusAo efetuada com sucesso")+"\"")%>);
        window.open("justificativas.jsp","_self");
      </script>
      <%
    }
    if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId()+"RS_3");
        }
  }
  else{
    %>
    <script language="JavaScript">
      window.open("justificativas.jsp","_self");  
    </script>
    <%
  }
}
/**
conexao.finalizaConexao();
conexaoH.finalizaConexao();
conexaoH.finalizaBD();
conexaoConsulta.finalizaConexao();
conexaoConsulta.finalizaBD();*/
%>
