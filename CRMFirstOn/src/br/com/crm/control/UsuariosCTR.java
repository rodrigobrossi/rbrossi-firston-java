package br.com.crm.control;

import br.com.crm.db.CrmUsuarios;
import br.com.crm.db.hb.Filter;
import br.com.crm.db.hb.PersistentObject;

/**
 * Cadastro de usu�rios
 * 
 * @author Rodrigo Luis Nolli Brossi
 * 
 */
public class UsuariosCTR extends AbstractDataBaseCTR {

	public String getTableName() {
		return null;
	}

	public boolean checkLogin(String login, String senha) {

		CrmUsuarios usr = (CrmUsuarios) super.getObject();

		new Filter("usr_nome_usuario", "=", login);

		return false;
	}

	public boolean isAValidUser(String string) {
		// TODO Auto-generated method stub
		return false;
	}

	public PersistentObject add() {
		// TODO Auto-generated method stub
		return null;
	}

//	public List getData() {
//		List list = this.getObject().getAll();
//		super.destroySession();
//		return list;
//	}
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
