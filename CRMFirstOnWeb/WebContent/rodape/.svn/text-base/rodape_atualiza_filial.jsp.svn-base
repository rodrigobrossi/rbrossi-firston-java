<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.net.*"%>
<%
//JSP para atualizar o plano na sessao
Integer filial = new Integer(Integer.parseInt((String)request.getParameter("cod")));
String page1 =(String)request.getParameter("page");

String par = (((String) session.getAttribute("par")==null)?"":(String) session.getAttribute("par"));
request.getSession(true);
session.setAttribute("usu_fil",filial); 
session.setAttribute("par",null);

URLDecoder dec = null;
String vai = dec.decode(par);

response.sendRedirect(""+page1+vai);
%>