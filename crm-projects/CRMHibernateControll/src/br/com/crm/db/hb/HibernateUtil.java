package br.com.crm.db.hb;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;




/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public class HibernateUtil {
	private static final Logger logger = LoggerFactory.getLogger(HibernateUtil.class);
	private static final SessionFactory sessionFactory;

	static {
		long start = System.currentTimeMillis();
		logger.info("Initializing Hibernate SessionFactory...");
		try {
			sessionFactory = new Configuration()
				.configure("br/com/crm/db/hibernate.hsqldb.cfg.xml")
				.buildSessionFactory();
			logger.info("Hibernate SessionFactory initialized in {} seconds", (System.currentTimeMillis() - start) / 1000);
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
	 * Get the SessionFactory
	 * @return SessionFactory
	 */
	public static SessionFactory getSessionFactory() {
		return sessionFactory;
	}
}
