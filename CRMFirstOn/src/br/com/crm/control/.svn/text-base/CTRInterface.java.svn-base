package br.com.crm.control;

import java.util.List;

import br.com.crm.db.hb.PersistentObject;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public interface CTRInterface {
	
	public static final String CRT_TIPO_RELACAO = TipoRelacaoCTR.class.getName();
	
	
	/**
	 * Insert an specific obeject
	 * 
	 * @param object
	 * @return
	 */
	public boolean insert(PersistentObject object);

	/**
	 * Update an specific obeject
	 * 
	 * @param object
	 * @return
	 */
	public boolean update(PersistentObject object);

	/**
	 * Delete an specific obeject
	 * 
	 * @param object
	 * @return
	 */
	public boolean delete(PersistentObject object);

	/**
	 * List objects of an element
	 * 
	 * @param object
	 * @return
	 */
	public List getData();

	/**
	 * Roll back a transaction
	 * 
	 * @param object
	 * @return
	 */
	public void roollback();
	
	/**
	 * Add a new persistent Object
	 * @return
	 */
	public PersistentObject add();

}
