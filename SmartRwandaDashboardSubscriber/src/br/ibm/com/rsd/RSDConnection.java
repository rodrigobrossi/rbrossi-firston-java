package br.ibm.com.rsd;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


/**
 * 
 * RSDConnection is responsible to connect with the database
 * 
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class RSDConnection {

	/**
	 * Connection with database
	 */
	private Connection connection = null;

	/**
	 * Default constructor for RSDConnection database
	 */
	public RSDConnection() {

	}

	/**
	 * Create a JDBC connection, the information here is hard
	 * 
	 * @return
	 */
	public Connection createConnection() {

		try {

			Class.forName("org.postgresql.Driver");


			connection = DriverManager.getConnection(this.getProperty("url"),
					this.getProperty("user"), this.getProperty("password"));
			return connection;

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your PostgreSQL JDBC Driver? "
					+ "Include in your library path!");
			e.printStackTrace();

		}

		catch (SQLException e) {

			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();

		}
		return connection;

	}

	/**
	 * Return the connection with the database
	 * 
	 * @return Connection object
	 */
	public Connection getConnection() {
		return (connection == null) ? createConnection() : connection;
	}

	/**
	 * Set the Connection object
	 * 
	 * @param connection
	 *            Object of a Connection class
	 */
	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	/**
	 * Get the properties from the properties file
	 * 
	 * @param property
	 *            Property ID
	 * @return Property value
	 */
	private String getProperty(String property) {
		Properties prop = new Properties();
		InputStream input = null;

		try {

			input = new FileInputStream("config.properties");

			// load a properties file
			prop.load(input);

			String strProp = prop.getProperty(property);
			// get the property value and print it out
			System.out.println(strProp);

			return strProp;

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
		return null;
	}
	
	public static void main(String args[]){
		
		RSDConnection con =  new RSDConnection();
		con.createConnection();
	}

}