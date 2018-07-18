<%
//Limpa cache
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1")) {
  response.setHeader("Cache-Control", "no-cache");
}
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import=" java.sql.*, java.text.*, java.util.*"%>

<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
  <form name="frm">
    <input type="hidden" name="limpa" value="N">
  </form>
</html>
<%
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

//Recupera parametros
request.getSession();
FODBConnectionBean conexao  = (FODBConnectionBean)session.getAttribute("Conexao");
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

Integer usu_codigo = (Integer)session.getAttribute("usu_cod");
String fun_codigo = "";
if ((String)request.getParameter("cbonome") != null) 
  fun_codigo = (String)request.getParameter("cbonome");
String fun_chapa = "";
if ((String)request.getParameter("txtchapa") != null)
  fun_chapa = (String)request.getParameter("txtchapa");;

//Variaveis
String query = "";
ResultSet rs = null;
boolean consulta = true;
int tot = 0;

//Abre a conexAo com o Banco
//conexao.realizaConexao((String)session.getAttribute("s_conexao"), (String)session.getAttribute("s_usubanco"), (String)session.getAttribute("s_senbanco")); 

//Define codigo do funcionario
if (fun_codigo.equals("")) {
  query = "SELECT FUN_CODIGO FROM FUNCIONARIO WHERE FUN_CHAPA = '" + fun_chapa + "'";
  rs = conexao.executaConsulta(query);
  if(rs.next()) {;
    fun_codigo = rs.getString(1);
  } else {%>
    <script language="JavaScript">
      alert(<%=("\""+trd.Traduz("Nao existe funcionario com esta chapa!")+"\"")%>);
      window.open("01_registrolistadepresenca.jsp?limpa=N&selectcur=<%=("\""+ request.getParameter("selectcur")+"\"")%>, "_parent");
    </script><%
    consulta = false;
  }
  //out.println("QUERY1: " + query);
}

if (consulta) {
  //Teste se o funcionario ja esta cadastrado temporariamente
  query = "SELECT COUNT(*) FROM INCNPTEMP WHERE INC_USU_CODIGO = " + usu_codigo + " AND FUN_CODIGO = " + fun_codigo;
  rs = conexao.executaConsulta(query);
  if (rs.next()) 
    tot = rs.getInt(1);

  if (tot == 0) {
    query = "INSERT INTO INCNPTEMP (INC_USU_CODIGO, FUN_CODIGO) VALUES ('" + usu_codigo + "', " + fun_codigo + ")";
    //out.println("QUERY2: " + query);
    conexao.executaAlteracao(query);
    //response.sendRedirect("01_registrolistadepresenca.jsp");
    %>
    <script language="JavaScript">
      window.open("01_registrolistadepresenca.jsp?limpa=N&selectcur="+ <%=("\""+request.getParameter("selectcur")+"\"")%>, "_parent");
    </script><%
  } else {%>
    <script language="JavaScript">
    
      alert(<%=("\""+trd.Traduz("Funcionario ja adicionado!")+"\"")%>);
      window.open("01_registrolistadepresenca.jsp?limpa=N&selectcur="+ <%=("\""+request.getParameter("selectcur")+"\"")%>, "_parent");
      
    </script>
    <%
  }
}

//Adiciona dados escolhidos no vetor de Treinamentos Planejados
String n = "";
Vector funcvet = new Vector();
funcvet = (Vector)session.getAttribute("funcs");
int pag = Integer.parseInt((String)session.getAttribute("pagina"));
for(int k=1 ; k<=pag;k++) {
  if ((request.getParameter("chktreiplan" + n.valueOf(k)) != null)) {
    //out.println(request.getParameter("chktreiplan" + n.valueOf(k)));
    if (!(funcvet.contains(request.getParameter("chktreiplan" + n.valueOf(k)))))
      funcvet.add(request.getParameter("chktreiplan" + n.valueOf(k)));
  }
}
session.setAttribute("funcs",funcvet);

if(rs != null) rs.close();
conexao.finalizaConexao();
%>
