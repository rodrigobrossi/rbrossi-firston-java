<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.net.*,java.util.*"%>

<%
/*VALIDA��O DOS PARAMETROS PARA RODAP�*/
String parametro= "?";
//try{
  for (Enumeration e = request.getParameterNames() ; e.hasMoreElements() ;) {
    String nome = ""+e.nextElement();
    if(nome.equals("msgPro")) {
   	} else {
   	  parametro =parametro+ nome+"="+(String)request.getParameter(nome)+"&";
   	}
  }
//} catch(Exception e ){out.println("Erro do Rodap� "+e);};

URLEncoder codec=null;
parametro = codec.encode(parametro);
request.getSession(true);
session.setAttribute("par",parametro);
%>