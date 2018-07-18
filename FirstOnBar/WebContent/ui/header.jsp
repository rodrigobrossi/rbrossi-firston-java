<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="scripts/header.js"></script>
<body>
<table align="center" width="100%" height="100px" border="0">
	<tr>
		<td colspan="2" bgcolor="#EFEFEF" valign="top">
		
		
			<applet codebase="../applets" code="br.com.firston.bar.applets.MenuBar.class" width="200px" height="30px">
			
			<%
				StringBuffer url  = new StringBuffer();
				url.append("http://");
				url.append(request.getServerName());
				url.append(":");
				url.append(request.getServerPort());
				url.append(request.getContextPath());
				
				
			
				out.println("<param name=\"url\" value=\""+url+"\" />");
			
			%>
			</applet>
		</td>
	</tr>
	<tr valign="top">
		<td width="20%" align="left" valign="top">This is a simple test</td>
		<td width="80%" align="left" valign="top">
		<form name="f1">
  			<p>Client name: <input name="word" type="text" 
  				onblur='JavaScript:xmlhttpPost("menusearch.jsp")' 
  				onkeyup='JavaScript:xmlhttpPost("menusearch.jsp")'
  			>  
  			<input value="Go" type="button" onclick='JavaScript:xmlhttpPost("menusearch.jsp")'>
		</p>
		</form>
		</td>
	</tr>
</table>
</body>
</html>