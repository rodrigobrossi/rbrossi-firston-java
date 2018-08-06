<%
response.setHeader("Pragma", "no-cache");
if (request.getProtocol().equals("HTTP/1.1"))
    response.setHeader("Cache-Control", "no-cache");
%>

<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");

if (request.getParameter("limpa") != null) {
     session.setAttribute("vec_registro", null);     
     session.setAttribute("vec_plan", null);     
     session.setAttribute("vec_nplan", null);     
}
%>
<%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Registro")%> - <%=trd.Traduz("Lista de PresenCa")%></title>
</head>
<frameset rows="178,*,239" cols="*" framespacing="0"  border="1" frameborder="no" noresize bordercolor="#000000">
  <frame src="frame_menu.jsp" name="topFrame"  noresize frameborder="no" bordercolor="#000000">
  <frameset rows="*" cols="*,520" framespacing="0" border="1" frameborder="no" bordercolor="#000000">
    <frame src="frame_planejados.jsp" name="mainFrame" noresize>
    <frame src="frame_naoplanejados.jsp" name="rightFrame">
  </frameset>
  <frameset rows="*" cols="*" framespacing="0" border="1" frameborder="no"  bordercolor="#000000">
    <frame src="frame_listafuncionarios.jsp" name="bottomFrame">
  
  </frameset>
</frameset>
<noframes><body  onunload='return fecha();' >
</body></noframes>
</html>
