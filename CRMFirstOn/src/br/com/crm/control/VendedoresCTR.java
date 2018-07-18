package br.com.crm.control;

import br.com.crm.db.hb.PersistentObject;

/**
 * @author Rodrigo Luis Nolli Brossi 
 * @version 1.0
 *
 */
public class VendedoresCTR extends AbstractDataBaseCTR {

	
	public String getTableName() {
		return "crm_vendedores";
	}

	public PersistentObject add() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public boolean doIt() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean undoIt() {
		// TODO Auto-generated method stub
		return false;
	}

}
