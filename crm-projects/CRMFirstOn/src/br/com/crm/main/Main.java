package br.com.crm.main;

import javax.swing.UIManager;
import javax.swing.SwingUtilities;

import br.com.crm.components.JSplash;
import br.com.crm.components.MsgDialogUtil;
import br.com.crm.core.ApplicationContext;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.log.Logger;
import br.com.crm.log.LoggerConstants;
import br.com.crm.log.ILogger;
import br.com.crm.util.ImageLoader;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 *          Main class of this system.
 * 
 */
public final class Main {

	private static MainFrame mainFrame;

	private static final int SPLASH_DELAY = 3000;

	private static final String SPLASH_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_MAIN_SPLASH_IMAGE);

	/**
	 * Gets the main window of the program.
	 * 
	 * @return the main window of the CRM
	 */
	public static MainFrame getMainWindow() {
		return mainFrame;
	}

	public static void main(String[] args) {
		try {
			// Set system look and feel
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
			
			// Initialize logger
			Logger.initialize(LoggerConstants.SLF4J);
			
			// Load images
			ImageLoader.loadImages();
			
			// Create and show main frame
			SwingUtilities.invokeLater(() -> {
				mainFrame = new MainFrame();
				mainFrame.setVisible(true);
			});
			
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	/**
	 * Shuts down the application
	 * 
	 */
	public static void shutDown() {
		boolean exit = MsgDialogUtil.openQuestionDialog(getMainWindow(),
				Messages.getString(I18NGUIMessage.GUI_MAINFRAME_EXIT_MSG),
				Messages.getString(I18NGUIMessage.GUI_MAINFRAME_EXIT));
		if (exit) {
			System.exit(0);
		}
	}
}
