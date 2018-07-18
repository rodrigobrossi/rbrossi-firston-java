package br.com.crm.command;

import br.com.crm.control.AbstractDataBaseCTR;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 *
 */
public abstract class AbstractCommand {
	private static final CommandManager manager = CommandManager.getInstance();
	
	protected AbstractCommand obj;
	/**
	 * Do a specific Action
	 */
	public abstract boolean doIt();
	/**
	 * Undo a specific Action
	 */
	public abstract boolean undoIt();
	
	/**
	 * @return
	 */
	public static CommandManager getManager() {
		return manager;
	}
	
	public void setPersistentObject(AbstractCommand obj){
		this.obj = obj;
	}
	
	public AbstractCommand getPersistentObject(){
		return obj;
	}
	
}
