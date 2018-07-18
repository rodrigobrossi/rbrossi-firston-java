package br.com.bar.firston;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestConnection {

	public TestConnection() {
		Connection conn  = ConnectionUtils.getConnection();
		Statement st;
		try {
			st = conn.createStatement();
			ResultSet rs = st.executeQuery("select * from CRM_CLUBE_CLIENTE  ");
		
		while (rs.next()){
			System.out.println("USER "+rs.getString(1));
		}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		TestConnection x  = new TestConnection();

	}

}
