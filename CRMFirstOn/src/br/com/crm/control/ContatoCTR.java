package br.com.crm.control;

import br.com.crm.db.CrmContato;
import br.com.crm.db.hb.PersistentObject;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public class ContatoCTR extends AbstractDataBaseCTR {

	public String getTableName() {
		return "crm_contato";
	}

	public PersistentObject add() {
		CrmContato persistentObject = new CrmContato();
		this.setObject(persistentObject);
		return persistentObject;
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
