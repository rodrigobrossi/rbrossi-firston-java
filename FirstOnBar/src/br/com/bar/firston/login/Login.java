package br.com.bar.firston.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.bar.firston.AbstractServletControl;
import br.com.bar.firston.ConnectionUtils;

/**
 * Servlet implementation class Login
 * @author Rodrigo Luis Nolli Brossi
 */
public class Login extends AbstractServletControl {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }
	
	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		super.processRequest(request, response);
		String login 	 = request.getParameter("login");
		String password  = request.getParameter("password");
		Connection conn = ConnectionUtils.getConnection();
		
		try {
			Statement st = (Statement) conn.createStatement();
			ResultSet rs = st.executeQuery("select * from baruser where usr_login='" +login+"'");
			String dbuser = null;
			String dbpass = null;
			String dbcredid = null;
			int errortype = 0;
			if(rs.next()){
				dbuser = rs.getString(2);
				dbpass = rs.getString(3);
				dbcredid = rs.getString(4);
			}else{
				//user does not exist or invalid user
				errortype=1;
			}
			
			st.close();
			st = conn.createStatement();
			
			if(dbpass!=null && password.equals(dbpass)){
				
				ResultSet credentialsRs = st.executeQuery("select crd_name from credentials where crd_id="+dbcredid);
				String credential = null;
				if(credentialsRs.next())
					credential = credentialsRs.getString(1);
				
				if(credential!=null && (credential.equals("ADMIN")||credential.equals("USER"))){
					session.setAttribute("user", dbuser);
					session.setAttribute("conn", conn);
					session.setAttribute("credentials",credential);
					response.sendRedirect("ui/bar.html");
				}
				else{
					errortype = 3 ;
				}
				credentialsRs.close();
			}
			else{
				//wrong pass word s
				errortype = 2;	
			}
			
			rs.close();
			st.close();
			if(errortype>0)
				response.sendRedirect("Error?errorcode="+errortype);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
