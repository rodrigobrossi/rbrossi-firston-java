package br.com.crm.db.hb;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Utility class for managing Hibernate sessions and configuration
 * @author Rodrigo Luis Nolli Brossi
 * @version 2.0
 */
public class HibernateUtil {
	private static final Logger logger = LoggerFactory.getLogger(HibernateUtil.class);
	private static final SessionFactory sessionFactory;
	private static final ThreadLocal<Session> sessionContext = new ThreadLocal<>();

	static {
		long start = System.currentTimeMillis();
		logger.info("Initializing Hibernate SessionFactory...");
		try {
			sessionFactory = new Configuration()
				.configure("br/com/crm/db/hibernate.hsqldb.cfg.xml")
				.buildSessionFactory();
			logger.info("Hibernate SessionFactory initialized in {} seconds", 
				(System.currentTimeMillis() - start) / 1000);
		} catch (Throwable ex) {
			logger.error("Failed to initialize Hibernate SessionFactory", ex);
			throw new ExceptionInInitializerError(ex);
		}
	}

	/**
	 * Open a new session
	 * @return Session object
	 */
	public static Session openSession() {
		try {
			return sessionFactory.openSession();
		} catch (HibernateException he) {
			logger.error("Error opening session", he);
			throw he;
		}
	}

	/**
	 * Get the current session for the current thread
	 * @return Session object
	 */
	public static Session getCurrentSession() {
		Session session = sessionContext.get();
		if (session == null || !session.isOpen()) {
			session = sessionFactory.openSession();
			sessionContext.set(session);
		}
		return session;
	}

	/**
	 * Close the current session
	 */
	public static void closeSession() {
		Session session = sessionContext.get();
		if (session != null && session.isOpen()) {
			try {
				session.close();
			} catch (HibernateException he) {
				logger.error("Error closing session", he);
			} finally {
				sessionContext.remove();
			}
		}
	}

	/**
	 * Shutdown Hibernate
	 */
	public static void shutdown() {
		if (sessionFactory != null && !sessionFactory.isClosed()) {
			sessionFactory.close();
		}
	}
}
