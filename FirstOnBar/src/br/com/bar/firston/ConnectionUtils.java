package br.com.bar.firston;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionUtils {
	
	
	public static Connection getConnection(){
			
			Connection conn = null;
			String url = "jdbc:sqlserver://localhost:1433;databaseName=omegafit";
			Properties props = new Properties();
			props.setProperty("user", "sa");
			props.setProperty("password", "Kazu@ibm2020");

			try {
				Class.forName("net.sourceforge.jtds.jdbc.Driver");
				conn = DriverManager.getConnection(url, props);
				System.out.println("[DEBUG]:" + conn);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return conn;
	}

}
