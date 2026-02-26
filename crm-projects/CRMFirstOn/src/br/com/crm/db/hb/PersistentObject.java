package br.com.crm.db.hb;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import br.com.crm.db.hb.HibernateUtil;

/**
 * Persistent object for all classes.
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public abstract class PersistentObject {
	protected Session session;
	protected Transaction tx;

	/**
	 * Default constructor.
	 */
	public PersistentObject() {
	}

	/**
	 * Insert a new object.
	 * 
	 * @return boolean
	 */
	public boolean insert() {
		boolean insert = false;
		try {
			session = HibernateUtil.getCurrentSession();
			tx = session.beginTransaction();
			session.save(this);
			tx.commit();
			insert = true;
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return insert;
	}

	/**
	 * Update an object.
	 * 
	 * @return boolean
	 */
	public boolean update() {
		boolean update = false;
		try {
			session = HibernateUtil.getCurrentSession();
			tx = session.beginTransaction();
			session.update(this);
			tx.commit();
			update = true;
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return update;
	}

	/**
	 * Delete an object.
	 * 
	 * @return boolean
	 */
	public boolean delete() {
		boolean delete = false;
		try {
			session = HibernateUtil.getCurrentSession();
			tx = session.beginTransaction();
			session.delete(this);
			tx.commit();
			delete = true;
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return delete;
	}

	/**
	 * Delete all objects.
	 * 
	 * @return boolean
	 */
	public boolean deleteAll() {
		boolean delete = false;
		try {
			session = HibernateUtil.getCurrentSession();
			tx = session.beginTransaction();
			session.createQuery("delete from " + this.getClass().getName()).executeUpdate();
			tx.commit();
			delete = true;
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return delete;
	}

	/**
	 * Get all objects.
	 * 
	 * @return List
	 */
	@SuppressWarnings("unchecked")
	public List getAll() {
		List list = null;
		try {
			session = HibernateUtil.getCurrentSession();
			tx = session.beginTransaction();
			list = session.createQuery("from " + this.getClass().getName()).list();
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return list;
	}

	/**
	 * Get an object by id.
	 * 
	 * @param id
	 *            Object id
	 * @return Object
	 */
	public Object getById(Long id) {
		Object obj = null;
		try {
			session = HibernateUtil.getCurrentSession();
			tx = session.beginTransaction();
			obj = session.get(this.getClass(), id);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return obj;
	}
} 