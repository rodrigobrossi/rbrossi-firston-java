package br.com.crm.db.hb.gui;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestSqlServerJdbc {
	public static void main(String[] args) {

		// Create a variable for the connection string.
		String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=bookstore;user=sa;password=Kazu@ibm2020";

		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			Connection con = DriverManager.getConnection(connectionUrl);
			Statement stmt = con.createStatement();

			String SQL = "SELECT TOP 10 * FROM dbo.book";
			ResultSet rs = stmt.executeQuery(SQL);

			// Iterate through the data in the result set and display it.
			while (rs.next()) {
				System.out.println(rs.getString("book_id") + " " + rs.getString("author"));
			}
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// Handle any errors that may have occurred.
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
}