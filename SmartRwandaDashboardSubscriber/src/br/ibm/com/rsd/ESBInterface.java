package br.ibm.com.rsd;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

/**
 * Interface to check information from the subscriber.
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class ESBInterface extends JFrame implements ActionListener {

	/**
	 * Default serial version for serialization
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Text area for log the application
	 */
	private JTextArea tStatus;

	/**
	 * ESBInterface constructor
	 */
	public ESBInterface() {
		super("Rwanda Smart Dashboard - Legacy App Interface 1.0");
		Dimension d = new Dimension(600, 400);
		this.setSize(d);

		// Create Status Bar
		tStatus = new JTextArea("Status component", 20, 30);
		tStatus.setEditable(true);
		tStatus.setLineWrap(true);
		tStatus.setWrapStyleWord(true);

		JScrollPane sp = new JScrollPane(tStatus,
				JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);

		JPanel panel1 = new JPanel(new GridLayout(0, 1));
		panel1.setBorder(BorderFactory.createTitledBorder("ESB Status"));
		panel1.add(sp);

		this.setLayout(new BorderLayout(1, 1));
		this.add(panel1, BorderLayout.CENTER);

		// close window event
		this.addWindowListener(new java.awt.event.WindowAdapter() {
			@Override
			public void windowClosing(java.awt.event.WindowEvent windowEvent) {
				if (JOptionPane.showConfirmDialog(ESBInterface.this,
						"Are you sure to close this window?",
						"Really Closing?", JOptionPane.YES_NO_OPTION,
						JOptionPane.QUESTION_MESSAGE) == JOptionPane.YES_OPTION) {
					System.exit(0);
				}
			}
		});

		this.setVisible(true);

		// Start subscription
		new TSubscriber().subscribe(tStatus);

	}

	/**
	 * Starts the application ESBInterface
	 * @param args Arguments for ESBInterface. 
	 */
	public static void main(String[] args) {
		//Just starts the application
		new ESBInterface();

	}

	/* (non-Javadoc)
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Implements button's actions over here.

	}

}
