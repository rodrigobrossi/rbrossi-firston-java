package br.com.crm.db.hb.gui;

import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.transaction.JDBCTransaction;

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

		try {
			util.createSession(TesteHB.class.getName());
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@SuppressWarnings("unchecked")
	TesteHB() {
			
		JDBCTransaction tx = null;
		try {
			tx = (JDBCTransaction) HibernateUtil.currentSession().beginTransaction();

			//CrmEsporteCliente users = new CrmEsporteCliente();
			CrmEmpresas users = new CrmEmpresas();

			List l = users.getAll();
			
			Iterator i = l.iterator();
			while (i.hasNext()) {
				//CrmEsporteCliente o = (CrmEsporteCliente) i.next();
				CrmEmpresas o = (CrmEmpresas) i.next();
				//System.out.println("[User:]" + o.getEspTitulo());
				System.out.println("[User:]" + o.getEmpNome());
			}
			

			CrmProduto p = new CrmProduto("V600");

			if (p.insert().booleanValue()) {
				System.out.println("OK");
			} else {
				System.out.println("!OK");
			}

			tx.commit();
		} catch (HibernateException he) {
			he.printStackTrace();
			if (HibernateUtil.currentSession() != null) {
				HibernateUtil.currentSession().clear();
			}

		} catch (Exception e) {
			e.printStackTrace();
			if (HibernateUtil.currentSession() != null) {
				HibernateUtil.currentSession().clear();
			}

		} finally {
			// TODO implement a intelient Error hadling
			System.out.println("Fim!");

		}

	}

	public static void main(String args[]) {
		TesteHB x = new TesteHB();
		System.out.println(x.toString());

	}
}
