/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.connection;

import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;



public class InitializeConnectionPool implements ServletContextListener {

	public InitializeConnectionPool() {
	}

	public void contextInitialized(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		String jdbcDriver = context.getInitParameter("jdbcDriver");
		String jdbcURL = context.getInitParameter("jdbcURL");
		String jdbcUserName = context.getInitParameter("jdbcUserName");
		String jdbcPassword = context.getInitParameter("jdbcPassword");
		int minimumConnections = Integer.parseInt(context
				.getInitParameter("minimumConnections"));
		int maximumConnections = Integer.parseInt(context
				.getInitParameter("maximumConnections"));
		try {
			NamingService nameSvc = NamingService.getInstance();
			ConnectionPool connectionPool = new ConnectionPool(jdbcDriver,
					jdbcURL, jdbcUserName, jdbcPassword, minimumConnections,
					maximumConnections);
			nameSvc.setAttribute("connectionPool", connectionPool);
			context.log("Connection pool created for URL=" + jdbcURL);
		} catch (ClassNotFoundException cnfe) {
			context.log("The JDBC Driver class " + jdbcDriver
					+ " was no tfound.", cnfe);
		} catch (InstantiationException ie) {
			context.log("The JDBC Driver class " + jdbcDriver + " could "
					+ "no tmake an object.", ie);
		} catch (IllegalAccessException iae) {
			context.log("The JDBC Driver (" + jdbcDriver + ") class "
					+ "or initializer is no taccessible.", iae);
		} catch (SQLException sex) {
			context.log(
					"There was an error in creating the connection pool for "
							+ jdbcURL, sex);
		}
	}

	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext context = sce.getServletContext();
		NamingService nameSvc = NamingService.getInstance();
		ConnectionPool connectionPool = (ConnectionPool) nameSvc
				.getAttribute("connectionPool");
		connectionPool.shutdown();
		context.log("Connection pool shutdown.");
	}
}