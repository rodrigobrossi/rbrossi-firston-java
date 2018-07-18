package firston.eval.connection;

import java.sql.*;
import java.util.*;


public class ConnectionPool {
	
	private static final int DEFAULT_MIN_CONN = 5;
	private static final int DEFAULT_MAX_CONN = 20;
	private String jdbcDriverClass;
	private String jdbcURL;
	private String jdbcUserName;
	private String jdbcPassword;
	private int minimumConnections;
	private int maximumConnections;
	private transient List freeConnections;
	private transient Map usedConnections;
	private transient boolean shuttingDown;
	private transient boolean shutdownComplete;
	private transient Thread maintThread;
	class MaintenanceRunner implements Runnable {

		public void run() {
			synchronized (ConnectionPool.this) {
				maintLoop();
				shutdown();
			}
		}

		private void maintLoop() {
			while (!shuttingDown) {
				for (int i = getSize(); freeConnections.size() > minimumConnections; i--) {
					Connection conn = (Connection) freeConnections.remove(0);
					try {
						conn.close();
					} catch (SQLException sqlexception) {
					}
				}

				for (int i = getSize(); i < minimumConnections; i++)
					try {
						Connection conn = makeConnection();
						freeConnections.add(conn);
					} catch (SQLException sqlexception1) {
					}

				try {
					wait();
				} catch (InterruptedException interruptedexception) {
				}
			}
		}

		private void shutdown() {
			if (shutdownCourtesyTimeout > -1 && !usedConnections.isEmpty())
				if (shutdownCourtesyTimeout == 0)
					while (!usedConnections.isEmpty())
						try {
							wait(shutdownCourtesyTimeout);
						} catch (InterruptedException interruptedexception) {
						}
				else if (!usedConnections.isEmpty())
					try {
						wait(shutdownCourtesyTimeout);
					} catch (InterruptedException interruptedexception1) {
					}
			for (Iterator connections = freeConnections.iterator(); connections
					.hasNext();) {
				Connection conn = (Connection) connections.next();
				try {
					conn.close();
				} catch (SQLException sqlexception) {
				}
			}

			for (Iterator connections = usedConnections.keySet().iterator(); connections
					.hasNext();) {
				Connection conn = (Connection) connections.next();
				try {
					conn.close();
				} catch (SQLException sqlexception1) {
				}
			}

			shutdownComplete = true;
			notifyAll();
		}

		private static final int DEFAULT_SHUTDOWN_TIMEOUT = 10000;
		private int shutdownCourtesyTimeout;

		public MaintenanceRunner(int timeout) {
			shutdownCourtesyTimeout = timeout;
		}

		public MaintenanceRunner() {
			this(10000);
		}
	}

	public ConnectionPool(String jdbcDriverClass, String jdbcURL,
			String jdbcUserName, String jdbcPassword, int minimumConnections,
			int maximumConnections, int shutdownCourtesyTimeout)
			throws ClassNotFoundException, InstantiationException,
			IllegalAccessException, SQLException {
		freeConnections = new LinkedList();
		usedConnections = new HashMap();
		shuttingDown = false;
		shutdownComplete = false;
		maintThread = null;
		this.jdbcDriverClass = jdbcDriverClass;
		this.jdbcURL = jdbcURL;
		this.jdbcUserName = jdbcUserName;
		this.jdbcPassword = jdbcPassword;
		this.minimumConnections = minimumConnections;
		this.maximumConnections = maximumConnections;
		Driver driver = (Driver) Class.forName(jdbcDriverClass).newInstance();
		DriverManager.registerDriver(driver);
		for (int i = 0; i < minimumConnections; i++)
			freeConnections.add(makeConnection());

		maintThread = new Thread(new MaintenanceRunner(shutdownCourtesyTimeout));
		maintThread.start();
	}

	public ConnectionPool(String jdbcDriverClass, String jdbcURL,
			String jdbcUserName, String jdbcPassword, int minimumConnections,
			int maximumConnections) throws ClassNotFoundException,
			InstantiationException, IllegalAccessException, SQLException {
		this(jdbcDriverClass, jdbcURL, jdbcUserName, jdbcPassword,
				minimumConnections, maximumConnections, 10000);
	}

	public ConnectionPool(String jdbcDriverClass, String jdbcURL,
			String jdbcUserName, String jdbcPassword)
			throws ClassNotFoundException, InstantiationException,
			IllegalAccessException, SQLException {
		this(jdbcDriverClass, jdbcURL, jdbcUserName, jdbcPassword, 20, 5, 10000);
	}

	public String getJdbcDriverClass() {
		return jdbcDriverClass;
	}

	public String getJdbcURL() {
		return jdbcURL;
	}

	public String getJdbcUserName() {
		return jdbcUserName;
	}

	public String getJdbcPassword() {
		return jdbcPassword;
	}

	public int getMinimumConnections() {
		return minimumConnections;
	}

	public int getMaximumConnections() {
		return maximumConnections;
	}

	public synchronized Connection getConnectionNoWait()
			throws ConnNotAvailException, ShuttingDownException {
		Connection result = null;
		if (shuttingDown)
			throw new ShuttingDownException();
		result = getConnectionInternal();
		if (result == null)
			throw new ConnNotAvailException();
		else
			return result;
	}

	public synchronized Connection getConnectionWait()
			throws ShuttingDownException {
		Connection result;
		for (result = null; !shuttingDown
				&& (result = getConnectionInternal()) == null;)
			try {
				wait();
			} catch (InterruptedException interruptedexception) {
			}

		if (shuttingDown)
			throw new ShuttingDownException();
		else
			return result;
	}

	public synchronized Connection getConnectionWait(int timeout)
			throws ShuttingDownException, ConnNotAvailException {
		Connection result = null;
		if (shuttingDown)
			throw new ShuttingDownException();
		result = getConnectionInternal();
		if (result != null)
			return result;
		try {
			wait(timeout);
		} catch (InterruptedException interruptedexception) {
		}
		if (shuttingDown)
			throw new ShuttingDownException();
		result = getConnectionInternal();
		if (result == null)
			throw new ConnNotAvailException();
		else
			return result;
	}

	public synchronized void releaseConnection(Connection connection)
			throws WrongPoolException, SQLException {
		if (usedConnections.containsKey(connection)) {
			usedConnections.remove(connection);
			if (!connection.isClosed())
				if (shuttingDown)
					try {
						connection.close();
					} catch (SQLException sqlexception) {
					}
				else
					freeConnections.add(connection);
		} else {
			throw new WrongPoolException();
		}
		notifyAll();
	}

	public synchronized void shutdown() {
		shuttingDown = true;
		notifyAll();
		while (!shutdownComplete)
			try {
				wait();
			} catch (InterruptedException interruptedexception) {
			}
	}

	public synchronized long getAge(Connection connection) {
		Long start_time = (Long) usedConnections.get(connection);
		if (start_time == null)
			return -1L;
		else
			return System.currentTimeMillis() - start_time.longValue();
	}

	public synchronized int getSize() {
		return usedConnections.size() + freeConnections.size();
	}

	public synchronized int getUseCount() {
		return usedConnections.size();
	}

	private Connection getConnectionInternal() {
		Connection result = null;
		if (!freeConnections.isEmpty())
			result = (Connection) freeConnections.remove(0);
		else if (usedConnections.size() < maximumConnections)
			try {
				result = makeConnection();
			} catch (SQLException sex) {
				sex.printStackTrace(System.err);
			}
		if (result != null) {
			Long start_time = new Long(System.currentTimeMillis());
			usedConnections.put(result, start_time);
		}
		return result;
	}

	private Connection makeConnection() throws SQLException {
		if (jdbcUserName.length() > 0)
			return DriverManager.getConnection(jdbcURL, jdbcUserName,
					jdbcPassword);
		else
			return DriverManager.getConnection(jdbcURL);
	}



}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from: C:\eclipseWTC\onix\Oregon\WebContent\WEB-INF\lib\pool.jar
 * Total time: 672 ms Jad reported messages/errors: Exit status: 0 Caught
 * exceptions:
 */