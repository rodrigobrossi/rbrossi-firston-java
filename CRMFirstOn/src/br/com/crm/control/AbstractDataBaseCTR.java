package br.com.crm.control;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JOptionPane;

import org.hibernate.HibernateException;
import org.hibernate.transaction.JDBCTransaction;

import br.com.crm.command.AbstractCommand;
import br.com.crm.db.hb.HibernateUtil;
import br.com.crm.db.hb.PersistentObject;

/**
 * Persistent object for all classes.d
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public abstract class AbstractDataBaseCTR extends AbstractCommand implements CTRInterface {
	protected JDBCTransaction tx = null;

	protected PersistentObject object;

	private final static HibernateUtil util = new HibernateUtil();

	/**
	 * Init hibernate session
	 */
	private void init() {
		try {
			util.createSession(this.toString());
			tx = (JDBCTransaction) HibernateUtil.currentSession().beginTransaction();
		} catch (HibernateException e) {
			this.destroySession();
			e.printStackTrace();
		}
	}

	public boolean insert(PersistentObject object) {
		init();
		boolean insert = false;
		try {
			insert = object.insert();
			tx.commit();
			this.destroySession();
		} catch (HibernateException e) {
			e.printStackTrace();
			JOptionPane.showConfirmDialog(new JFrame("Message"), e.getMessage());
		}catch(Exception e ){
			e.printStackTrace();
			JOptionPane.showConfirmDialog(new JFrame("Message"), e.getCause());
		}
		return insert;

	}

	public boolean delete(PersistentObject object) {
		boolean deleted = false;
		try {
			//util.createSession(this.toString());
			object.deleteAll();
			tx.commit();
			//this.destroySession();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return deleted;
	}

	public boolean update(PersistentObject object) {
		boolean update = false;
		try {
			update = object.update();
			tx.commit();
			this.destroySession();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
		return update;
	}

	/**
	 * Return the DAO representative name with the data base.
	 * 
	 * @return Table name
	 */
	public abstract String getTableName();

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#finalize()
	 */
	public void finalize() throws Throwable {
		if (!tx.wasCommitted()) {
			tx.commit();
		}
		if (tx != null) {
			tx = null;
		}
		super.finalize();
	}

	public void roollback() {
		try {
			if (tx == null) {
				throw new NullPointerException("Impossible RollBack");
			}
			if (!tx.wasRolledBack()) {
				tx.rollback();
				tx.commit();
				this.destroySession();
			}
			util.clearThrSession();
		} catch (HibernateException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Set a specific persistent object
	 * 
	 * @return
	 */
	public PersistentObject getObject() {
		return object;
	}

	/**
	 * Get a specific persistent object
	 * 
	 * @return
	 */
	public void setObject(PersistentObject object) {
		this.object = object;
	}

	protected void destroySession() {
		util.destroySession(this.toString());
	}

	public List getData() {
		init();
		List list = object.getAll();
		this.destroySession();
		if (list == null)
			list = new ArrayList(0);
		return list;
	}

}
