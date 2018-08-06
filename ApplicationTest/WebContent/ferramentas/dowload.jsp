
<%
    response.setHeader("Pragma", "no-cache");
    if (request.getProtocol().equals("HTTP/1.1"))
    {
      response.setHeader("Cache-Control", "no-cache");
    }
%>
<%@page contentType="text/html" errorPage="/erro/ExceptionPage.jsp"%>
<%@page import="java.io.*,java.util.*"%>

<%
request.getSession();
FOLocalizationBean trd  = (FOLocalizationBean) session.getAttribute("Traducao");
firston.eval.components.FOParametersBean prm  = (firston.eval.components.FOParametersBean)session.getAttribute("Param");
String usu_tipo = (String)session.getAttribute("usu_tipo"); 
String usu_nome = (String)session.getAttribute("usu_nome"); 
String usu_login = (String)session.getAttribute("usu_login"); 
Integer usu_fil = (Integer)session.getAttribute("usu_fil"); 
Integer usu_idi = (Integer)session.getAttribute("usu_idi"); 

%>

<%@page import="firston.eval.components.FOLocalizationBean"%><%@page import="firston.eval.connection.FODBConnectionBean"%><%@page import="firston.eval.components.FOLocalizationBean"%><html>
<head>
<title>FirstOn - <%=trd.Traduz("Ferramentas")%></title>
<script language="JavaScript" src="/js/scripts.js"></script>
<link rel="stylesheet" href="../default.css" type="text/css">
</head>
<body onunload='return fecha();' leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0"
	onLoad="MM_preloadImages('../art/ico_home_on.gif','../art/ico_mensagens_on.gif','../art/ico_batepapo_on.gif','../art/ico_anotacoes_on.gif','../art/ico_listadecursos_on.gif','../art/ico_glossario_on.gif','../art/ico_ajuda_on.gif','solicitacao/../art/onenglish.gif','solicitacao/../art/onespanol.gif')">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	height="100%">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="59" class="hcfundo">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%
    String ponto = (String)session.getAttribute("barra");
        if(ponto.equals("..")){%>
						<jsp:include page="../menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="FE" /></jsp:include>
						<%}else{%>
						<jsp:include page="/menu/banner.jsp" flush="true"><jsp:param
								value="opt" name="FE" /></jsp:include>
						<%}%>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="mnfundo"><img src="../art/bit.gif" width="12"
					height="5"></td>
			</tr>
			<tr>
				<td height="25" class="mnfundo">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<%    if(ponto.equals("..")){%>
						<jsp:include page="../menu/menu.jsp" flush="true"></jsp:include>
						<%}else{%>
						<jsp:include page="/menu/menu.jsp" flush="true"></jsp:include>
						<%}%>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		<table border="0" cellspacing="2" cellpadding="0" bgcolor="c0c0c0">
			<tr>
				<%    if(ponto.equals("..")){%>
				<jsp:include page="../menu/menu_ferramentas.jsp" flush="true"></jsp:include>
				<%}else{%>
				<jsp:include page="/menu/menu_ferramentas.jsp" flush="true"></jsp:include>
				<%}%>
			</tr>
		</table>

		<%
String op =(( (String)request.getParameter("opt")==null)?"N": (String)request.getParameter("opt"));

if(op.equals("N")){
%> <%}
else if(op.equals("E")){
  //try{
  Process p = Runtime.getRuntime().exec("plugin.exe");
  //Process p = Runtime.getRuntime().exec("\\\\ser_16\\c$\\Tomcat 4.1\\webapps\\FirstOnEM\\ferramentas\\plugin.exe");
  String buf;
  BufferedReader se = new BufferedReader(new InputStreamReader(p.getErrorStream()));
  while((buf = se.readLine()) != null)
      {
    out.println(""+buf);
      
    }
  
  
  
  //}catch(IOException r){
  //out.println(""+r);
  ///}
}
%>
		</td>
	<tr>
		<td align="right" height="30" class="difundo">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<%if(ponto.equals("..")){%>
			<jsp:include page="../rodape/rodape.jsp" flush="true"></jsp:include>
			<%}else{%>
			<jsp:include page="/rodape/rodape.jsp" flush="true"></jsp:include>
			<%}%>
		</table>
		</td>
	</tr>
</table>
<table border="0" width="100%" height="200%">
	<tr>
		<td><input type="button" onClick="location='dowload.jsp?opt=E'"
			value="INSTALAR" class="botcin"></td>
	</tr>
</table>


</body>
</html>
