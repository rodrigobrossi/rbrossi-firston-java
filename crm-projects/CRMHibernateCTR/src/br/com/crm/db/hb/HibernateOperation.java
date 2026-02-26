/*
 * HibernateOperation.java
 *
 * Created on 28 de Abril de 2004, 11:48
 */

package br.com.crm.db.hb;

/**
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public class HibernateOperation {
	public static final int INSERT = 0;

	public static final int UPDATE = 1;

	public static final int DELETE = 2;

	/**
	 * Holds value of property operacao.
	 */
	private int operation;

	/**
	 * Holds value of property objeto.
	 */
	private PersistentObject object;

	/** Creates a new instance of HibernateOperation */
	public HibernateOperation() {
	}

	/** Creates a new instance of HibernateOperation */
	public HibernateOperation(int operacao, PersistentObject objeto) {
		setOperacao(operacao);
		setObjeto(objeto);
	}

	/**
	 * Getter for property operacao.
	 * 
	 * @return Value of property operacao.
	 */
	public int getOperacao() {
		return this.operation;
	}

	/**
	 * Setter for property operacao.
	 * 
	 * @param operacao
	 *            New value of property operacao.
	 */
	public void setOperacao(int operation) {
		this.operation = operation;
	}

	/**
	 * Getter for property objeto.
	 * 
	 * @return Value of property objeto.
	 */
	public PersistentObject getObject() {
		return this.object;
	}

	/**
	 * Setter for property objeto.
	 * 
	 * @param objeto
	 *            New value of property objeto.
	 */
	public void setObjeto(PersistentObject object) {
		this.object = object;
	}

}
