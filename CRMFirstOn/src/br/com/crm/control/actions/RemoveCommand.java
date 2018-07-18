package br.com.crm.control.actions;

import org.hibernate.TransactionException;

import br.com.crm.command.AbstractCommand;
import br.com.crm.control.AbstractDataBaseCTR;

public class RemoveCommand extends AbstractCommand {

	public RemoveCommand(AbstractCommand obj) {
		super.setPersistentObject(obj);
	}

	public boolean doIt() {
		return ((AbstractDataBaseCTR)obj).delete(((AbstractDataBaseCTR)obj).getObject());
	}

	public boolean undoIt() {
		boolean ok = true;
		try {
			((AbstractDataBaseCTR)obj).roollback();
		} catch (Exception e) {
			ok = false;
			try {
				throw new TransactionException("RollBack problems!");
			} catch (TransactionException e1) {
				e1.printStackTrace();
			}
		}
		return ok;

	}

}
