package br.com.crm.db.hb;

import java.util.HashMap;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Hibernate Utility class for a Hibernate session.
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public class HibernateUtil {
	private static final SessionFactory sessionFactory;
	private static final ThreadLocal<Session> threadLocal = new ThreadLocal<Session>();
	private static final Map<String, Session> sessions = new HashMap<String, Session>();

	static {
		try {
			// Create the SessionFactory from hibernate.cfg.xml
			sessionFactory = new Configuration().configure().buildSessionFactory();
		} catch (Throwable ex) {
			// Make sure you log the exception, as it might be swallowed
			System.err.println("Initial SessionFactory creation failed." + ex);
			throw new ExceptionInInitializerError(ex);
		}
	}

	/**
	 * Returns the ThreadLocal Session instance. Lazy initialize the Session if
	 * the ThreadLocal is empty.
	 * 
	 * @return Session
	 * @throws HibernateException
	 */
	public static Session getCurrentSession() throws HibernateException {
		Session session = threadLocal.get();

		if (session == null || !session.isOpen()) {
			session = sessionFactory.openSession();
			threadLocal.set(session);
		}

		return session;
	}

	/**
	 * Close the single hibernate session instance.
	 * 
	 * @throws HibernateException
	 */
	public static void closeSession() throws HibernateException {
		Session session = threadLocal.get();
		threadLocal.set(null);

		if (session != null) {
			session.close();
		}
	}

	/**
	 * Default constructor.
	 */
	public HibernateUtil() {
	}

	/**
	 * Creates a new session.
	 * 
	 * @param sessionName
	 *            Session name
	 * @return Session
	 */
	public Session createSession(String sessionName) {
		Session session = sessionFactory.openSession();
		sessions.put(sessionName, session);
		return session;
	}

	/**
	 * Destroys a session.
	 * 
	 * @param sessionName
	 *            Session name
	 */
	public void destroySession(String sessionName) {
		Session session = sessions.get(sessionName);
		if (session != null) {
			session.close();
			sessions.remove(sessionName);
		}
	}

	/**
	 * Clears the thread session.
	 */
	public void clearThrSession() {
		threadLocal.set(null);
	}
} 