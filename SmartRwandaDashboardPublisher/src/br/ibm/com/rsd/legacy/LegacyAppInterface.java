package br.ibm.com.rsd.legacy;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

/**
 * This application represents the Legacy systems.
 * 
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class LegacyAppInterface extends JFrame implements ActionListener {

	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * Start the connection with the ESB
	 */
	private JButton bStart;
	/**
	 * Load KPi comma separated file
	 */
	private JButton bLoadFile;
	/**
	 * Close the application
	 */
	private JButton bClose;
	/**
	 * Refresh the ESB information.
	 */
	private JButton bRefresh;

	/**
	 * The TPublisher is responsible to connect with the ESB
	 */
	private TPublisher tPublisher;

	/**
	 * Text are to log the information from the background engine
	 */
	private JTextArea tStatus;

	/**
	 * Progress bar indicating 
	 */
	private JProgressBar pLoadFile;

	/**
	 * Constructor of LegacyAppInterfaces
	 */
	public LegacyAppInterface() {
	
		super("Rwanda Smart Dashboard - Legacy App Interface 1.0");
 		Dimension d = new Dimension(600, 400);
		this.setSize(d);

		GridBagLayout grid = new GridBagLayout();

		GridBagConstraints cons = new GridBagConstraints();

		cons.ipadx = 5;
		cons.ipady = 5;
		cons.weightx = 100;
		cons.weighty = 100;
		//cons.gridheight = 3;
		//cons.gridwidth = 2;
		
		cons.insets = new Insets(5, 3, 3, 5);
		cons.anchor = GridBagConstraints.WEST;
		cons.fill = GridBagConstraints.BOTH;

		// Create Layout 
		bStart = new JButton("Connect to ESB");
		bStart.addActionListener(this);

		bLoadFile = new JButton("Load KPI files");
		bLoadFile.addActionListener(this);

		bRefresh = new JButton("Refresh EBS Info");
		bRefresh.addActionListener(this);

		bClose = new JButton("Exit");
		bClose.addActionListener(this);

		tStatus = new JTextArea("Status component", 20, 30);
		tStatus.setEditable(true);
		tStatus.setLineWrap(true);
		tStatus.setWrapStyleWord(true);

		JScrollPane sp = new JScrollPane(tStatus,
				JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);

		pLoadFile = new JProgressBar(JProgressBar.HORIZONTAL,0, 100);
		pLoadFile.setStringPainted(true);

		JPanel panel1 = new JPanel(grid);
		panel1.setBorder(BorderFactory.createTitledBorder("Publisher"));

		cons.gridx = 0;
		cons.gridy = 0;
		panel1.add(bStart, cons);
		cons.gridx = 1;
		cons.gridy = 0;
		panel1.add(new JLabel("ESB Connection Status"), cons);
		cons.gridx = 0;
		cons.gridy = 1;
		panel1.add(bLoadFile, cons);
		cons.gridx = 1;
		cons.gridy = 1;
		panel1.add(pLoadFile, cons);
		cons.gridx = 0;
		cons.gridy = 2;
		bRefresh.setEnabled(false);
		panel1.add(bRefresh, cons);
		cons.gridx = 1;
		cons.gridy = 2;
		panel1.add(new JLabel("Click on this button to see the EBS Status"),
				cons);

		JPanel panel2 = new JPanel(new GridLayout(0, 1));
		panel2.setBorder(BorderFactory.createTitledBorder("Connection Status"));
		panel2.add(sp);

		this.setLayout(new BorderLayout(1, 1));
		this.add(panel1, BorderLayout.NORTH);
		this.add(panel2, BorderLayout.CENTER);

		// close window event
		this.addWindowListener(new java.awt.event.WindowAdapter() {
			@Override
			public void windowClosing(java.awt.event.WindowEvent windowEvent) {
				if (JOptionPane.showConfirmDialog(LegacyAppInterface.this,
						"Are you sure to close this window?",
						"Really Closing?", JOptionPane.YES_NO_OPTION,
						JOptionPane.QUESTION_MESSAGE) == JOptionPane.YES_OPTION) {
					System.exit(0);
				}
			}
		});
		this.setVisible(true);

	}

	/**
	 * Start the application
	 * @param args Arguments for the applications
	 */
	public static void main(String[] args) {
	
		LegacyAppInterface lap = new LegacyAppInterface();

	}

	/* (non-Javadoc)
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	@Override
	public void actionPerformed(ActionEvent e) {

		if (e.getSource().equals(bStart)) {
			this.setP(new TPublisher(tStatus));
			Thread t = new Thread(this.getP(), "RSD Publish process");
			t.start();
			bStart.setBackground(Color.green);
		} else if (e.getSource().equals(bLoadFile)) {

			JFileChooser fileChooser = new JFileChooser();
			fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

			int result = fileChooser.showOpenDialog(this);

			if (result == JFileChooser.CANCEL_OPTION)
				return;

			// Obtain selected file
			File fileName = fileChooser.getSelectedFile();
			try {

				// Create object of FileReader
				FileReader inputFile = new FileReader(fileName);

				// Instantiate the BufferedReader Class
				BufferedReader bufferReader = new BufferedReader(inputFile);

				// Variable to hold the one line data
				String line;

				int i = 10; //help the fake progress bar to implement

				// Read file line by line and print on the console
				while ((line = bufferReader.readLine()) != null) {
					System.out.println(line);
					tStatus.append(line);
					this.getP().sendMessage(line);
					pLoadFile.setValue(i = i + 2);
				}
				pLoadFile.setValue(100);
				// Close the buffer reader
				bufferReader.close();
				pLoadFile.setValue(0);
			} catch (Exception ex) {
				System.out.println("Error while reading file line by line:"
						+ ex.getMessage());
			}

		}

	}

	/**
	 * Getter for TPublisher object
	 * @return TPublisher Class
	 */
	public TPublisher getP() {
		return tPublisher;
	}

	
	/**
	 * Setter for TPublisher object
	 * @param tPublisher TPublisher object
	 */
	public void setP(TPublisher tPublisher) {
		this.tPublisher = tPublisher;
	}

}
