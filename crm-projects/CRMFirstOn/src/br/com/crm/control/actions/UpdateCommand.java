package br.com.crm.control.actions;

import org.hibernate.TransactionException;

import br.com.crm.command.AbstractCommand;
import br.com.crm.control.AbstractDataBaseCTR;

public class UpdateCommand extends AbstractCommand {

	public UpdateCommand(AbstractCommand obj) {
		this.obj = obj;
	}

	public UpdateCommand() {
	}

	public boolean doIt() {
		return ((AbstractDataBaseCTR)obj).update(((AbstractDataBaseCTR)obj).getObject());
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
