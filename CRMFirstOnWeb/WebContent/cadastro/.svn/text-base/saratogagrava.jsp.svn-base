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

String query = "", nome = "", tipo = "", cod = "", txt_saratoga = "";

//Verifica se foram digitados os dados
if (!(request.getParameter("tipo") == null)){ 
  tipo = request.getParameter("tipo");
}

if (!(request.getParameter("cod") == null)){ 
  cod = request.getParameter("cod");
}

if (!(request.getParameter("txt_saratoga") == null)){ 
  txt_saratoga = request.getParameter("txt_saratoga");
}


if (!(tipo.equals("E"))){
  if (!(request.getParameter("sarnome") == null)){ 
    nome = request.getParameter("sarnome");
  }
  else{
    %>
    
<%@page import="firston.eval.connection.FODBConnectionBean"%>
<%@page import="firston.eval.components.FOLocalizationBean"%><script language="JavaScript">
      alert(<%=("\""+trd.Traduz("E necessArio digitar uma descriCAo!")+"\"")%>);
      window.open("saratoga.jsp","_self");
    </script>
    <%
  }
}

//Abre a conexAo com o Banco e faz o Update, Insert ou Delete para gravar a Saratoga
if (tipo.equals("I"))
{

String  queryVerifica= "SELECT SAR_DESCRICAO FROM SARATOGA WHERE SAR_DESCRICAO='"+nome+"'";
  rsConsulta = conexao.executaConsulta(queryVerifica, session.getId());
  if(!rsConsulta.next()){
    query = "INSERT INTO SARATOGA (SAR_DESCRICAO, SAR_OBSERVACAO) VALUES ('" + nome + "','" + txt_saratoga + "')"; 
 
    conexao.executaAlteracao(query);
    %>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("InclusAo efetuada com sucesso")+"\"")%>);
      window.open("saratoga.jsp","_self");
    </script>
    <%
  }
  else {
  %>
  <script language="JavaScript">
    alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR SARATOGA JA EXISTENTE")+"\"")%>);
    window.open("saratoga.jsp","_self");
  </script>
   <%
  }   
}

else
{
  if (tipo.equals("U"))
  {
    String queryVerifica = "SELECT SAR_DESCRICAO FROM SARATOGA WHERE SAR_DESCRICAO = '"+nome+"' AND SAR_CODIGO <> "+cod;
    rsConsulta = conexao.executaConsulta(queryVerifica, session.getId());
    if(!rsConsulta.next())
    {     
      query = "UPDATE SARATOGA SET SAR_DESCRICAO = '" + nome + "', SAR_OBSERVACAO = '" + txt_saratoga + "' WHERE SAR_CODIGO = " + cod; 
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("AlteraCAo efetuada com sucesso")+"\"")%>);
        window.open("saratoga.jsp","_self");
      </script>
      <%
    }
    else
    {
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("IMPOSSIVEL CADASTRAR SARATOGA JA EXISTENTE")+"\"")%>);
        window.open("saratoga.jsp","_self");
      </script>
      <%
    }   
    
  }
  if (tipo.equals("E"))
  {
    query = "SELECT * FROM CURSO WHERE SAR_CODIGO = "+cod;
    rs = conexao.executaConsulta(query,session.getId());
    if(rs.next())
    {
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ExclusAo nAo permitida. Existe Curso vinculado a esta Saratoga.")+"\"")%>);
        window.open("saratoga.jsp","_self");
      </script>
      <%
    }
    else
    {
      query = "DELETE FROM SARATOGA WHERE SAR_CODIGO = "+cod;
      conexao.executaAlteracao(query);
      %>
      <script language="JavaScript">
        alert(<%=("\""+trd.Traduz("ExclusAo efetuada com sucesso")+"\"")%>);
        window.open("saratoga.jsp","_self");
      </script>
      <%
    } 
  }
  else
  {
    %>
    <script language="JavaScript">
      window.open("saratoga.jsp","_self");
    </script>
    <%
  }

}
if(rsConsulta!=null){
conexao.finalizaConexao(session.getId());
}
if(rs!=null){
conexao.finalizaConexao(session.getId());
}

%>
