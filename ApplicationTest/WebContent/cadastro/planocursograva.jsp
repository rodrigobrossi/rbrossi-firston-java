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

ResultSet rs = null;
String query = "";
String nome1 = "";
String nome2 = "";
String nome3 = "";
String nome4 = "";
String tipo = "";
String cod = "";
String curso = "";

//Verifica se foram digitados os dados
if (!(request.getParameter("tipo") == null))
{ 
  tipo = request.getParameter("tipo");
}

if (!(request.getParameter("codi") == null))
{ 
  cod = request.getParameter("codi");
}

if (!(request.getParameter("curso") == null))
{ 
  curso = request.getParameter("curso");
}

if (!(tipo.equals("E")))
{
  if (!(request.getParameter("textfield1") == null))
  { 
  nome1 = " '" + request.getParameter("textfield1") + "' ";
  }
  else
  {
  %>
   
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
    alert(<%=("\""+trd.Traduz("E necessArio digitar um Plano de Curso!")+"\"")%>);
    window.open("planocurso.jsp?cod=<%=curso%>","_self");
   </script>
  <%
  }
  if (!(request.getParameter("textfield2") == null))
  { 
  nome2 = " '" + request.getParameter("textfield2") + "' ";
  }
    if (!(request.getParameter("textfield3") == null))
  { 
  nome3 = " '" + request.getParameter("textfield3") + "' ";
  }
    if (!(request.getParameter("textfield4") == null))
  { 
  nome4 = " '" + request.getParameter("textfield4") + "' ";
  }

}

//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar o Assunto
if (tipo.equals("I"))
{
 query = "INSERT INTO PLANOCURSO (CUR_CODIGO, PCU_DESCRICAO1, PCU_DESCRICAO2, PCU_DESCRICAO3, PCU_DESCRICAO4) VALUES (" + curso + ", " + nome1 + ", " + nome2 + ", " + nome3 + ", " + nome4 + ")"; 
  conexao.executaAlteracao(query);
 %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("InclusAo efetuada com sucesso")+"\"")%>);
    window.open("planocurso.jsp?cod=<%=curso%>","_self");
  </script>
 <%
}
else
{
   if (tipo.equals("U"))
   {
     query = "UPDATE PLANOCURSO SET PCU_DESCRICAO1 = " + nome1 + ", PCU_DESCRICAO2 = " + nome2 + ", PCU_DESCRICAO3 = " + nome3 + ", PCU_DESCRICAO4 = " + nome4 + " WHERE PCU_CODIGO = " + cod + ""; 

   conexao.executaAlteracao(query);
     %>
   <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("AlteraCAo efetuada com sucesso")+"\"")%>);
    window.open("planocurso.jsp?cod=<%=curso%>","_self");
   </script>
     <%
   }
   if (tipo.equals("E"))
   {
     if (!(request.getParameter("cursos") == null))
       { 
          curso = request.getParameter("cursos");
       }
     %>
   <script language="JavaScript">    
        if (confirm(<%=("\""+trd.Traduz("Deseja Excluir o item selecionado?")+"\"")%>))
      {
    <%
            query = "DELETE FROM PLANOCURSO WHERE PCU_CODIGO = "+cod;
            conexao.executaAlteracao(query);
    %>
              alert(<%=("\""+trd.Traduz("ExclusAo efetuada com sucesso")+"\"")%>);
              window.open("planocurso.jsp?cod=<%=curso%>","_self");
    }     
    else
      {
          window.open("planocurso.jsp?cod=<%=curso%>","_self");  
      }
   </script>
     <%
   }
}
if(rs != null)
  rs.close();
conexao.finalizaConexao();
%>