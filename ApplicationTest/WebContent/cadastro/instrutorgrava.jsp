<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*,java.util.*"%>
<%
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");



String usu_tipo = (String)session.getAttribute("usu_tipo"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi");  

ResultSet rs=null, rsConsulta = null;

String query = "", nome = "", tipo = "", cod = "", codigo = "";

//Verifica se foram digitados os dados
if (!(request.getParameter("tipo") == null)){ 
  tipo = request.getParameter("tipo");
}

if (!(request.getParameter("cod") == null)){ 
  cod = request.getParameter("cod");
}

if (!(request.getParameter("empresa") == null)){ 
  codigo = request.getParameter("empresa");
}


if (!(tipo.equals("E"))){
  if (request.getParameter("insnome") != null){ 
    nome = request.getParameter("insnome");
  }
  else{
    %>
   
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""+trd.Traduz("E necessArio digitar um nome!")+"\"")%>);
    window.open("instrutor.jsp","_self");
   </script>
  <%
  }
}

//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o Instrutor
if (tipo.equals("I"))
{

String  queryVerifica= "SELECT INS_NOME FROM INSTRUTOR WHERE INS_NOME='"+nome+"'";
rsConsulta = conexao.executaConsulta(queryVerifica,session.getId());
if(!rsConsulta.next()){
    query = "INSERT INTO INSTRUTOR (INS_NOME, EMP_CODIGO) VALUES ('" + nome + "'," + codigo + ")"; 
    conexao.executaAlteracao(query);
   %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("InclusAo efetuada com sucesso")+"\"")%>);
    window.open("instrutor.jsp","_self");
  </script>
   <%
   }
else {
  %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR INSTRUTOR JA EXISTENTE")+"\"")%>);
    window.open("instrutor.jsp","_self");
  </script>
   <%
  } 
 if(rsConsulta!=null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId());
        }
    
  }   
   


else
{   
  if (tipo.equals("U"))
  {
    String queryVerifica = "SELECT INS_NOME FROM INSTRUTOR WHERE INS_NOME = '"+nome+"' AND EMP_CODIGO = "+codigo+" AND INS_CODIGO <> "+cod;
    rsConsulta = conexao.executaConsulta(queryVerifica,session.getId());
    if(!rsConsulta.next())
    {     
      query = "UPDATE INSTRUTOR SET INS_NOME = '" + nome + "',EMP_CODIGO = " + codigo + " WHERE INS_CODIGO = " + cod; 
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("AlteraCAo efetuada com sucesso")+"\"")%>);
        window.open("instrutor.jsp","_self");
      </script>
      <%
    }
    else
    {
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR INSTRUTOR JA EXISTENTE")+"\"")%>);
        window.open("instrutor.jsp","_self");
      </script>
       <%
    } 
    if(rsConsulta!=null){
        rsConsulta.close();
        conexao.finalizaConexao(session.getId());
        }
  }

  if (tipo.equals("E"))
  {
    query = "SELECT * FROM TURMA WHERE INS_CODIGO = "+cod;
    rs = conexao.executaConsulta(query,session.getId());
    if(rs.next())
    {
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ExclusAo nAo permitida. Existe Turma vinculada a este Instrutor.")+"\"")%>);
        window.open("instrutor.jsp","_self");
      </script>
      <%
    }
    else
    {
      query = "DELETE FROM INSTRUTOR WHERE INS_CODIGO = "+cod;
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ExclusAo efetuada com sucesso")+"\"")%>);
        window.open("instrutor.jsp","_self");
      </script>
      <%
    }
 if(rs!=null){
        rs.close();
        conexao.finalizaConexao(session.getId());
        }
    
  }   
  else
  {
    %>
    <script language="JavaScript">
    window.open("instrutor.jsp","_self");
    </script>
    <%
  }
}



%>
