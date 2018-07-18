<%@page import="br.com.bar.firston.ConnectionUtils"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<table cellpadding="0" cellspacing="0">
<% 
	Connection conn = ConnectionUtils.getConnection();
	
	Statement st = conn.createStatement();
	
	String whereclause = ((whereclause = request.getParameter("w"))==null)? "": "where cli_name like '%"+ whereclause+"%'";
	
	ResultSet rs  = st.executeQuery("select * from client "+whereclause);
	
	boolean color = false;
	while(rs.next()){
		String id = rs.getString(1);
		
		String strColor = (color)? "EFEFEF" :"FFFFFF";
		out.println("<tr>"+
				"<td bgcolor='#"+strColor+"' ><input type=\"checkbox\" name='"+id+"' id ='"+id+"'/></td>"+
				"<td bgcolor='#"+strColor+"'><a href='delete.jsp?id="+id+"'><img src=\"images/delete.jpg\" alt=\"Delte\" border='0'/></a></td>"+
				"<td bgcolor='#"+strColor+"'><img src=\"images/person.jpg\" alt=\"Image face\" /></td>"+
				"<td bgcolor='#"+strColor+"'><tt>"+rs.getString(2)+"</tt></td></tr>");		
		color = !color;
	}
	
	rs.close();
	st.close();

%>
</table>
