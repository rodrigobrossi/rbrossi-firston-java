package br.com.crm.components;

import javax.swing.JPanel;
import javax.swing.JProgressBar;

public class ProgressBar extends JPanel {

	private static JProgressBar progressBar;

	private float lastStep;

	private static final int DEFAULT_MIN = 0;

	private static final int DEFAULT_MAX = 100;

	static {
		progressBar = new JProgressBar(0, 100);
		progressBar.setStringPainted(true);
		progressBar.setVisible(false);
		progressBar.setMinimum(DEFAULT_MIN);
		progressBar.setMaximum(DEFAULT_MAX);
	}

	/**
	 * Singleton pattern: Get an instance of the JStatusBar
	 * 
	 * @return instance of JStatusBar
	 */
	public static final JProgressBar getInstance() {
		return progressBar;
	}

	/**
	 * Start the progress bar of the status bar
	 * 
	 * @param message -
	 *            The message to exhibit at the moment the progress bar starts
	 */
	public void startProgress(String message) {
		lastStep = 0;
		progressBar.setValue(DEFAULT_MIN);
		progressBar.setVisible(true);
		progressBar.validate();
		//progressBar(message);
	}

	/**
	 * Stop the progress bar of the status bar
	 */
	public void stopProgress() {
		progressBar.setValue(DEFAULT_MAX);
		progressBar.setVisible(false);
		progressBar.validate();
//		setMessage(I18N_BUNDLE
//				.getMessage(I18NStatusBarMessages.STATUSBAR_LABEL_READY));
	}

	/**
	 * Set the progress of progress bar
	 * 
	 * @param message -
	 *            The message to exhibit at the moment the progress bar is set
	 * @param progress -
	 *            The progress of progress bar
	 */
	private void setProgress(String message, int progress) {
		progressBar.setValue(progress);

//		if (!this.getMessage().equals(message)) {
//			this.setMessage(message);
//		}

		progressBar.paintImmediately(this.getVisibleRect());

	}

	/**
	 * Update the status bar according to the progressFactor
	 * 
	 * @param message -
	 *            The message to exhibit at the moment the progress bar is
	 *            updated
	 * @param progressFactor -
	 *            Number from 0 to 1 from which the progress bar will be added
	 */
	public void stepProgress(String message, float progressFactor) {
		lastStep += progressFactor;

		if ((lastStep > 1)
				&& ((progressBar.getValue() + progressFactor) < progressBar
						.getMaximum())) {
			setProgress(message, progressBar.getValue()
					+ (int) Math.floor(lastStep));
			lastStep -= (int) Math.floor(lastStep);
		}
	}

}
