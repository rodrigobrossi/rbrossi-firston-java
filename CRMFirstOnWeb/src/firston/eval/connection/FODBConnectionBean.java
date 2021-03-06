package firston.eval.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class FODBConnectionBean {
	private FODBComplaintBean eq;
	public String str_Driver;
	public String str_erro;
	private Connection connection;
	private static String driver;
	private static String userName;
	private static String password;
	private static String urlDB;

	public FODBConnectionBean() {
		eq = new FODBComplaintBean();
		str_Driver = "";
		str_erro = "";
		connection = null;
		// recuperaConexao();
	}

	public FODBConnectionBean getConection() {

		if (driver == null)
			return null;

		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(urlDB, userName, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return this;
	}

	public void setConection(FODBConnectionBean conn) {
		conn = conn;
	}

	public Connection getObjConection() {
		return connection;
	}

	public ResultSet executaConsulta(String str_query) {

		return executaConsulta(str_query, "TEST");
	}

	public ResultSet executaConsulta(String str_query, String str_name) {
		ResultSet rs = null;
		try {
			connection.setAutoCommit(true);
		} catch (SQLException comit) {
			comit.printStackTrace(System.err);
		}
		try {
			PreparedStatement statement = connection.prepareStatement(eq
					.equivalencia(str_query.toUpperCase(), driver), 1004, 1008);
			rs = statement.executeQuery();
		} catch (SQLException e) {

			e.printStackTrace(System.err);
		} catch (Exception ex) {

			ex.printStackTrace(System.err);
		}
		return rs;
	}

	public synchronized boolean executaAlteracao(String str_query) {
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement(eq.equivalencia(str_query
					.toUpperCase(), driver), 1004, 1008);
			statement.executeUpdate();
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace(System.out);
			return false;

		} catch (ConnNotAvailException e) {
			e.printStackTrace(System.out);

			return false;
		}
		return true;
	}

	public void finalizaConexao() {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @param str_name
	 * @deprecated
	 */
	public void finalizaConexao(String str_name) {
		//this.finalizaConexao();
	}

	/**
	 * @param connection
	 * @deprecated
	 */
	public void finalizaBD(Connection connection) {
		/*
		 * if (connection != null) try {
		 * connectionPool.releaseConnection(connection);
		 * System.err.println("HOME OPEN:" + connectionPool.getSize());
		 * System.err.println("HOME IN USE:" + connectionPool.getUseCount()); }
		 * catch (Exception ee) { ee.printStackTrace(System.err); }
		 */
	}

	/**
	 * @return
	 * @deprecated
	 */
	public String getAge() {
		return "";
	}

	/**
	 * @deprecated
	 */
	public synchronized void checkNumberConnections() {
		// if (stmtMap.size() > connectionPool.getSize() - 5
		// && connectionPool.getSize() > connectionPool
		// .getMaximumConnections() - 5)
		// try {
		// if (connection != null)
		// connectionPool.releaseConnection(connection);
		// connectionPool = (ConnectionPool) nameSvc
		// .getAttribute("connectionPool");
		// System.err.println("HOME : CHANGE");
		// synchronized (connectionPool) {
		// connection = connectionPool.getConnectionWait();
		// }
		// } catch (WrongPoolException e) {
		// e.printStackTrace(System.err);
		// } catch (SQLException e) {
		// e.printStackTrace(System.err);
		//			}
	}

	/**
	 * @return
	 * @deprecated
	 */
	public String getError() {
		return str_erro;
	}

	public ResultSet paginacao(int pag, String str_query, String str_name) {
		Statement statement = null;
		ResultSet res_paginacao = null;
		try {
			statement = connection.createStatement(1004, 1008);
			res_paginacao = statement.executeQuery(eq.equivalencia(str_query
					.toUpperCase(), driver));
			res_paginacao.setFetchSize(pag);
			statement.setFetchDirection(1000);
		} catch (SQLException e) {
			str_erro = "PAGINCAO:" + e;
		}
		return res_paginacao;
	}

	public void realizaConexao(String url, String user, String password,
			String driver) {

		try {
			Class.forName(driver);
			connection = DriverManager.getConnection(url, user, password);
			// set values if connection OK
			this.urlDB = url;
			this.userName = user;
			this.password = password;
			this.driver = driver;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static void main(String args[]) {

		FODBConnectionBean conn = new FODBConnectionBean();

		conn
				.realizaConexao(
						"jdbc:sqlserver://localhost:1433;databaseName=didaxisem_marelli_01_prod",
						"USER", "366684",
						"com.microsoft.jdbc.sqlserver.SQLServerDriver");

		try {
			Statement st = conn.getObjConection().createStatement();
			ResultSet rs = st.executeQuery("Select * from acesso");
			while (rs.next()) {
				System.out.println("" + rs.getString(2));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
