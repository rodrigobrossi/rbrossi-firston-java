<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*"%>

<%request.getSession();FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");%>
<%request.getSession();FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<form name="frm"> 
<%
  Integer usu_idi = (Integer)session.getAttribute("usu_idi");
  
  //Declaracao de variaveis
  ResultSet rs = null;
  String query = "", nome = "", login = "";
  int cont_resp = Integer.parseInt(request.getParameter("cont"));
  boolean contem = false;

  //Gera os Logins
  for (int k=0; k<=cont_resp; k++) 
  {  
    if(request.getParameter("chk"+k) != null) 
	{
		//Pega o Nome funcionario
	    query = "SELECT FUN_NOME FROM FUNCIONARIO WHERE FUN_CODIGO = " + request.getParameter("chk"+k) + " ";
		rs = conexao.executaConsulta(query);
		if (rs.next())
			nome = rs.getString(1).trim(); 
	    
		//Gera login do funcionario
		login = nome.charAt(0) + nome.substring((nome.lastIndexOf(" ")+1), nome.length());


        query = "UPDATE FUNCIONARIO SET FUN_LOGIN = '"+login+"' "+
                "WHERE FUN_CODIGO = " + request.getParameter("chk"+k) + " ";

	    contem = true;
        conexao.executaAlteracao(query);
    }
  }

  if (!contem) {%>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("Favor escolher um funcionario!")+"\"")%>);
    </script>
<%}

if(rs != null) rs.close();
conexao.finalizaConexao();
%>

<script language="JavaScript">
  window.open("gera_login.jsp","_self");
</script>
</html>
 