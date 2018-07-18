package br.com.crm.main;

import javax.swing.UIManager;

import br.com.crm.components.JSplash;
import br.com.crm.components.MsgDialogUtil;
import br.com.crm.core.ApplicationContext;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.log.ILogger;
import br.com.crm.log.LoggerConstants;
import br.com.crm.log.LoggerFactory;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 *          Main class of this system.
 * 
 */
public final class Main {

	private static MainFrame mainFrame;

	private static ILogger logger = LoggerFactory
			.getFactory(LoggerConstants.LOG4J);

	private static final int SPLASH_DELAY = 3000;

	private static final String SPLASH_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_MAIN_SPLASH_IMAGE);
	static {
		logger.configureLogger(Main.class);
		logger.setLogToHTMLFile("CRM_LOG");
	}

	/**
	 * Gets the instance of ILogger responsible for logging messages in this
	 * class.
	 * 
	 * @return logger of thi class
	 */
	public static ILogger getLogger() {
		return logger;
	}

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

			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());

			JSplash splash = new JSplash(SPLASH_IMAGE, SPLASH_DELAY);
			splash.setVisible(true);
			Thread.sleep(SPLASH_DELAY);

			mainFrame = new MainFrame() {
				/**
				 *Default serial version ID
				 */
				private static final long serialVersionUID = 1L;

				{
					setVisible(true);
					requestFocus();
				}
			};
			
			ApplicationContext.getInstance().setMainFrame(mainFrame);
			

		} catch (Throwable e) {
			getLogger().error("Error starting application", e);
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
