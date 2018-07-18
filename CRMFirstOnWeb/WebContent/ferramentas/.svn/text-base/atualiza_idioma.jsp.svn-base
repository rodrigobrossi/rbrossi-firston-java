<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%
Integer  idioma = new Integer(Integer.parseInt((String)request.getParameter("cod")));
String page1 =(String)request.getParameter("page");
out.println("i ="+idioma+" "+page1);
request.getSession(true);
session.setAttribute("usu_idi",idioma); 
response.sendRedirect(""+page1);

%>