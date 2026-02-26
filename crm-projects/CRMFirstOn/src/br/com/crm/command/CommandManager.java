package br.com.crm.command;

import java.util.LinkedList;

import br.com.crm.control.AbstractDataBaseCTR;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 * This class will control the re do actions and command actions.
 */
public final class CommandManager {

	private int maxHistoryLenght = 100;

	private LinkedList<AbstractCommand> history = new LinkedList<AbstractCommand>();

	private LinkedList<AbstractCommand> redoList = new LinkedList<AbstractCommand>();

	private static final CommandManager command = new CommandManager();

	private CommandManager() {

	}

	public static CommandManager getInstance() {
		return command;

	}

	/**
	 * Ivloke Command By name.
	 * 
	 * @param command
	 */
	public void invokeCommandByName(String command, AbstractCommand obj) {
		try {
			this.invokeCommand(CommandFactory.createCommand(command, obj));
		} catch (NoSuchCommandFound e) {
			e.printStackTrace();
		}

	}

	/**
	 * Invoke Command
	 * 
	 * @param command
	 */
	public void invokeCommand(AbstractCommand command) {

		if (command instanceof Undo) {
			undo();
			return;
		}
		if (command instanceof Redo) {
			redo();
			return;
		}

		if (command.doIt()) {
			addToHistory(command);
		} else {
			history.clear();
		}
		if (redoList.size() > 0) {
			redoList.clear();
		}

	}

	private void addToHistory(AbstractCommand command) {
		history.addFirst(command);
		if (history.size() > maxHistoryLenght) {
			history.removeLast();
		}

	}

	/**
	 * This is the Redo Method.
	 */
	private void redo() {
		if (redoList.size() > 0) {
			AbstractCommand redoCommand;
			redoCommand = (AbstractCommand) redoList.removeFirst();
			redoCommand.doIt();
			history.addFirst(redoCommand);
		}
	}

	/**
	 * This is the undo Method
	 */
	private void undo() {
		if (history.size() > 0) {
			AbstractCommand undoCommand;
			undoCommand = (AbstractCommand) history.removeFirst();
			undoCommand.undoIt();
			redoList.addFirst(undoCommand);
		}

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
			//TODO remove this actions
	}

}
