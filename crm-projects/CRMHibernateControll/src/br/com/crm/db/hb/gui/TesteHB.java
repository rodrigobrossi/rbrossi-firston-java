package br.com.crm.db.hb.gui;

import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.crm.db.CrmEmpresas;
import br.com.crm.db.CrmProduto;
import br.com.crm.db.hb.HibernateUtil;

/**
 * Create to test if the componet is available 
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class TesteHB {

	/**
	 * To create the session for use the hibernate component
	 */
	static HibernateUtil util = new HibernateUtil();

	static {

		// Removed legacy session creation

	}

	@SuppressWarnings("unchecked")
	TesteHB() {
		Transaction tx = null;
		Session session = null;
		try {
			session = HibernateUtil.openSession();
			tx = session.beginTransaction();

			CrmEmpresas emp = new CrmEmpresas();
			emp.setEmpNome("IBM");
			emp.insert(session);
			
			List l = emp.getAll(session);
			
			if(l==null){
				System.out.println("Did not work");
			}
			
			Iterator i = l.iterator();
			while (i.hasNext()) {
				CrmEmpresas o = (CrmEmpresas) i.next();
				System.out.println("[User:]" + o.getEmpNome());
			}

			CrmProduto p = new CrmProduto("V600");

			if (p.insert(session).booleanValue()) {
				System.out.println("OK");
			} else {
				System.out.println("!OK");
			}

			tx.commit();
		} catch (HibernateException he) {
			he.printStackTrace();
			if (session != null) {
				session.clear();
			}

		} catch (Exception e) {
			e.printStackTrace();
			if (session != null) {
				session.clear();
			}

		} finally {
			if (session != null && session.isOpen()) {
				session.close();
			}
			System.out.println("Fim!");
		}
	}

	public static void main(String args[]) {
		TesteHB x = new TesteHB();
		System.out.println(x.toString());

	}
}
