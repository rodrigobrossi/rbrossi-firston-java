package br.com.crm.command;

import java.util.HashMap;
import java.util.Map;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.actions.InsertCommand;
import br.com.crm.control.actions.RemoveCommand;
import br.com.crm.control.actions.UpdateCommand;

/**
 * @author Rodrigo Luis Nolli Brossi
 * 
 * This Class is responsible for build the command actions.
 *
 *
 */
public class CommandFactory implements ActionMapConstants{
	
	
	private static final Map<String, Integer> actionMap ;
	
	
	
	static{
		actionMap = new HashMap<String, Integer>();
		actionMap.put(CommandsConstants.INSERT,INSERT_PRODUTO);
		actionMap.put(CommandsConstants.REMOVE,REMOVE_PRODUTO);
		actionMap.put(CommandsConstants.UPDATE,UPDATE_PRODUTO);
		
	}


	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO this is to test the command action, but it is not in use any more remove it when necessary 
	}
	
	
	/**
	 * Create the command object 
	 * @param command
	 * @param obj
	 * @return
	 * @throws NoSuchCommandFound
	 */
	public static AbstractCommand createCommand(String command,AbstractCommand obj)throws NoSuchCommandFound{
		if(obj==null)
			throw new PersistentObjectNullException();
		
		AbstractCommand absCommand = null;
		
		int action = ((Integer)actionMap.get(command)).intValue();
		switch(action){
			case 1 :  return absCommand = new InsertCommand(obj);
			case 2 :  return absCommand = new RemoveCommand(obj);
			case 3 :  return absCommand = new UpdateCommand(obj);
			default:
				return absCommand;
		
		}
		
	}

}
