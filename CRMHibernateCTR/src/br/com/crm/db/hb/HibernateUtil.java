package br.com.crm.db.hb;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;




/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public class HibernateUtil {
	private static final ThreadLocal sessionContext = new ThreadLocal();

	private static final SessionFactory sessionFactory;

	private Session session;

	private int level;

	private boolean request;

	static {
		long start = System.currentTimeMillis();
		System.out
				.println("FirstOn: Wait for build Hibernate SessionFactory...");
		try {
			sessionFactory = new Configuration().configure("br/com/crm/db/hibernate.sqlserver.cfg.xml").buildSessionFactory();
			
			//sessionFactory = new Configuration().configure().buildSessionFactory();
		} catch (Throwable ex) {
			ex.printStackTrace();
			throw new RuntimeException("Exception building SessionFactory: "
					+ ex.getMessage(), ex);
		}
		System.out
				.println("FirstOn: Build ok in "
						+ ((System.currentTimeMillis() - start) / 1000)
						+ " second(s)!");
	}

	/**
	 * 
	 * 
	 */
	public static Session openSession(String who) {
		try {
			// return sessionFactory.openSession(new ApplicationInterceptor());
			return sessionFactory.openSession(((HibernateUtil)NamingService.getInstance().getAttribute(who)).session.connection());
		} catch (HibernateException he) {
			return null;
		}
	}

	public synchronized void createSession(String who)

	throws HibernateException {
		NamingService value = NamingService.getInstance();
		System.out.println("[createSession]:Before");

		HibernateUtil tlSession = null;

		if (value.getAttribute(who) == null) {
			tlSession = (HibernateUtil) sessionContext.get();
			if (tlSession == null) {
				tlSession = new HibernateUtil();
				tlSession.level = 0;
			}
			if (tlSession.session == null) {
				// tlSession.session = sessionFactory.openSession(new
				// ApplicationInterceptor());
				tlSession.session = sessionFactory.openSession();
			}
			tlSession.level++;
			tlSession.request = true;
			value.setAttribute(who, tlSession);
			sessionContext.set(tlSession);
			return;
		} else {
			tlSession = (HibernateUtil) value.getAttribute(who);
		}

		while (tlSession.request == true) {
			try {
				System.out.println("[createSession]:waiting");
				wait(50);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		tlSession.level++;
		tlSession.request = true;
		// System.out.println(" #createSession:notifyAll "
		// + Thread.currentThread());
		notifyAll();
		// System.out.println(" #createSession " + tlSession.session + " "
		// + tlSession.level + " ThreadID:" + tlSession
		// + " Thread.currentThread():" + Thread.currentThread()
		// + " -> After");
	}

	public synchronized static Session currentSession() {
		HibernateUtil tlSession = null;
		try {
			tlSession = (HibernateUtil) sessionContext.get();
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		if (tlSession != null) {
			return tlSession.session;
		} else {
			return null;
		}

	}

	public synchronized void destroySession(String who) {
		NamingService value = NamingService.getInstance();
		System.out.println("    #destroySession:    Before");
		
		HibernateUtil tlSession = null;
		
		if (value.getAttribute(who)==null){
			return; 
		}	else{
			tlSession = (HibernateUtil)value.getAttribute(who);
			if(tlSession!=null){
				value.removeAttribute(who);
			}
		}
				
		while (tlSession.request == false) {
			try {
				System.out.println("    !vai aguardar 2");
				wait(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		tlSession.level--;
		if (tlSession.level <= 0) {
			if (tlSession.session != null && tlSession.session.isOpen()) {
				try {
					tlSession.session.disconnect();
					tlSession.session.close();
					tlSession.session = null;
					/*
					 * if (value!=null) value.removeAttribute(who);
					 */
				} catch (HibernateException he) {
					he.printStackTrace();
				}
			}
			sessionContext.set(null);
			tlSession.level = 0;
		}
		tlSession.request = false;
		System.out.println("     #destroySession:notifyAll "
				+ Thread.currentThread());
		notifyAll();
		System.out.println("    #destroySession:level " + tlSession.level
				+ "  After");
	}

	/**
	 * Deprecated
	 * 
	 * @throws HibernateException
	 * @deprecated not more used!
	 */
	public static void closeSession() throws HibernateException {
		/*
		 * Deprecated - N\u00e3o usual o controle esta sendo executado nos
		 * filtros.
		 */
	}

	public synchronized void clearThrSession() throws HibernateException {
		HibernateUtil tlSession = (HibernateUtil) sessionContext.get();
		System.out.println("    #HibernateUtil:clearThrSession "
				+ tlSession.level + "   Before " + Thread.currentThread());

		while (tlSession.request == false) {
			try {
				System.out.println("    !vai aguardar 3");
				wait(50);
			} catch (InterruptedException e) {
				e.printStackTrace();

			}
		}
		tlSession.level--;
		tlSession.request = false;
		System.out.println("     #clearThrSession:notifyAll "
				+ Thread.currentThread());
		notifyAll();
		System.out.println("    #HibernateUtil:clearThrSession "
				+ tlSession.level + "   After");
	}
}
