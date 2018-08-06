<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.sql.*"%>

<%@page import="br.com.bar.firston.ConnectionUtils"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<table>

		<%
			Connection con = (Connection) session.getAttribute("conn");

			if (con == null) {
				response.sendRedirect("Error?errorcode=4");
			} else {

				Statement st = con.createStatement();

				ResultSet rs = st.executeQuery("select * from products");

				out.println("<th conspan='2'>Producs for the card number = " + 0 + "</th>");
				while (rs.next()) {
					out.println("<tr>");
					out.print("<td><input type='checkbox'></td><td>" + rs.getString(1) + "</td>");
					out.print("</tr>");
				}

				rs.close();
				st.close();
			}
		%>
	</table>

</body>
</html>