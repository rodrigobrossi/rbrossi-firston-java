package br.com.crm.control.actions;

import org.hibernate.TransactionException;

import br.com.crm.command.AbstractCommand;
import br.com.crm.control.AbstractDataBaseCTR;

public class InsertCommand extends AbstractCommand {

	public InsertCommand(AbstractCommand obj) {
		this.obj = obj;
	}

	public InsertCommand() {
	}

	public boolean doIt() {
		try {
			return ((AbstractDataBaseCTR) obj).insert(((AbstractDataBaseCTR)obj).getObject());
		} catch (RuntimeException e) {
			e.printStackTrace();
			System.exit(0);
			return false;
		}
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
