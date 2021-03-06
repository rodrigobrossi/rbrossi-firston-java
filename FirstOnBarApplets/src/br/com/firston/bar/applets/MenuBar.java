package br.com.firston.bar.applets;
import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.KeyEvent;

import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButtonMenuItem;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.KeyStroke;

import br.com.firston.wizard.Wizard;
import br.com.firston.wizard.WizardPanelDescriptor;
import br.com.firston.wizard.sample.TestPanel1Descriptor;
import br.com.firston.wizard.sample.TestPanel2;
import br.com.firston.wizard.sample.TestPanel2Descriptor;
import br.com.firston.wizard.sample.TestPanel3Descriptor;

/**
 * Menu of the application
 * This menu is part of a entire software.
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class MenuBar extends Applet implements ActionListener ,ItemListener{

	
	/**
	 * Serial Version ID
	 */
	private static final long serialVersionUID = 5795481036258254718L;
	
	//Command definitions
	private static final String ABOUT = "ABOUT";
	private static final String INSERT = "INSERT";
	private static final String CREATE_MENU = "CREATE_MENU";
	
	//Other items definitions
	private JTextArea output;
	private JScrollPane scrollPane;
	private String newline = "\n";
	private InsertClientBar insertView;
	

	public MenuBar() throws HeadlessException {
		


		this.setBackground(new Color(239,239,239));
		JMenuBar menuBar;
		JMenu menu, submenu;
		JMenuItem menuItem;
		JRadioButtonMenuItem rbMenuItem;
		JCheckBoxMenuItem cbMenuItem;
		
		ImageIcon icon = createImageIcon("images/people.jpg");

		// Create the menu bar.
		menuBar = new JMenuBar();

		// Build the first menu.
		menu = new JMenu("Arquivo");
		menu.setMnemonic(KeyEvent.VK_A);
		menu.getAccessibleContext().setAccessibleDescription("The only menu in this program that has menu items");
		menuBar.add(menu);

		// a group of JMenuItems
		menuItem = new JMenuItem("Incluir Cliente",icon);
		// menuItem.setMnemonic(KeyEvent.VK_T); //used constructor instead
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_1,ActionEvent.ALT_MASK));
		menuItem.getAccessibleContext().setAccessibleDescription("This doesn't really do anything");
		menuItem.addActionListener(this);
		menuItem.setActionCommand(INSERT);
		menu.add(menuItem);

		icon = createImageIcon("images/insert.jpg");
		
		menuItem = new JMenuItem("Incluir Item de Card�pio", icon);
		menuItem.setMnemonic(KeyEvent.VK_B);
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_2,ActionEvent.ALT_MASK));
		menuItem.setActionCommand(CREATE_MENU);
		menuItem.addActionListener(this);
		menu.add(menuItem);

		menuItem = new JMenuItem("Incluir Usu�rio",icon);
		menuItem.setMnemonic(KeyEvent.VK_D);
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_3,ActionEvent.ALT_MASK));
		menuItem.addActionListener(this);
		menu.add(menuItem);

		// a group of radio button menu items
		menu.addSeparator();
		ButtonGroup group = new ButtonGroup();

		rbMenuItem = new JRadioButtonMenuItem("A radio button menu item");
		rbMenuItem.setSelected(true);
		rbMenuItem.setMnemonic(KeyEvent.VK_R);
		group.add(rbMenuItem);
		rbMenuItem.addActionListener(this);
		menu.add(rbMenuItem);

		rbMenuItem = new JRadioButtonMenuItem("Seu Jeito Bar");
		rbMenuItem.setMnemonic(KeyEvent.VK_O);
		group.add(rbMenuItem);
		rbMenuItem.addActionListener(this);
		menu.add(rbMenuItem);

		// a group of check box menu items
		menu.addSeparator();
		cbMenuItem = new JCheckBoxMenuItem("A check box menu item");
		cbMenuItem.setMnemonic(KeyEvent.VK_C);
		cbMenuItem.addItemListener(this);
		menu.add(cbMenuItem);


		// a submenu
		menu.addSeparator();
		submenu = new JMenu("A submenu");
		submenu.setMnemonic(KeyEvent.VK_S);
		submenu.addActionListener(this);
		submenu.setActionCommand("HELP");

		menuItem = new JMenuItem("An item in the submenu");
		menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_2,
				ActionEvent.ALT_MASK));
		menuItem.addActionListener(this);
		submenu.add(menuItem);

		menuItem = new JMenuItem("Another item");
		menuItem.addActionListener(this);
		submenu.add(menuItem);
		menu.add(submenu);

		// Build second menu in the menu bar.
		menu = new JMenu("Help");
		menu.setMnemonic(KeyEvent.VK_N);
		menu.getAccessibleContext().setAccessibleDescription("About the Software");
		menuBar.add(menu);
		
		
		menuItem = new JMenuItem("About this software");
		menuItem.addActionListener(this);
		menuItem.setActionCommand(ABOUT);
		menu.add(menuItem);
		

		cbMenuItem = new JCheckBoxMenuItem("Log on");
		cbMenuItem.setMnemonic(KeyEvent.VK_H);
		cbMenuItem.addItemListener(this);
		menu.add(cbMenuItem);

		this.add(menuBar);
	}

	public Container createContentPane() {
		// Create the content-pane-to-be.
		JPanel contentPane = new JPanel(new BorderLayout());
		contentPane.setOpaque(true);

		// Create a scrolled text area.
		output = new JTextArea(5, 30);
		output.setEditable(false);
		scrollPane = new JScrollPane(output);

		// Add the text area to the content pane.
		contentPane.add(scrollPane, BorderLayout.CENTER);

		return contentPane;
	}

	public void actionPerformed(ActionEvent e) {
		//		JMenuItem source = (JMenuItem) (e.getSource());
		//		String s = "Action event detected." + newline + "    Event source: "
		//				+ source.getText() + " (an instance of " + getClassName(source)
		//				+ ")";
		//		output.append(s + newline);
		//		output.setCaretPosition(output.getDocument().getLength());
		
		if(e.getActionCommand().equals(INSERT)){
			insertView = new InsertClientBar(this.getParameter("url"), this.getAppletContext());
			insertView.setVisible(true);
		} else if (e.getActionCommand().equals(ABOUT)) {
			JOptionPane op = new JOptionPane();
			op.setSize(new Dimension(100,50));
			Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
			double xposition = ((screenSize.getWidth() / 2) - (op.getSize().getWidth() / 2));
			double yposition = ((screenSize.getHeight() / 2) - (op.getSize().getHeight() / 2));
			op.setLocation((int) xposition, (int) yposition);
			op.showMessageDialog(this, "FirstOn Bar 1.0 \n (C) Copyright 2010 \n By Rodrigo Luis Nolli Brossi \n brossi.consulting@gmail.com","About",JOptionPane.INFORMATION_MESSAGE); 
		}else if (e.getActionCommand().equals(CREATE_MENU)){
			Wizard wizard = new Wizard();
	        wizard.getDialog().setTitle("Seu Jeito Bar - Criar Card�pio");
	        
	        WizardPanelDescriptor descriptor1 = new TestPanel1Descriptor();
	        wizard.registerWizardPanel(TestPanel1Descriptor.IDENTIFIER, descriptor1);

	        WizardPanelDescriptor descriptor2 = new TestPanel2Descriptor();
	        wizard.registerWizardPanel(TestPanel2Descriptor.IDENTIFIER, descriptor2);

	        WizardPanelDescriptor descriptor3 = new TestPanel3Descriptor();
	        wizard.registerWizardPanel(TestPanel3Descriptor.IDENTIFIER, descriptor3);
	        
	        wizard.setCurrentPanel(TestPanel1Descriptor.IDENTIFIER);
	        
	        int ret = wizard.showModalDialog();
	        
	        System.out.println("Dialog return code is (0=Finish,1=Cancel,2=Error): " + ret);
	        System.out.println("Second panel selection is: " + 
	            (((TestPanel2)descriptor2.getPanelComponent()).getRadioButtonSelected()));
	        
	        System.exit(0);
			
		}
	}

	public void itemStateChanged(ItemEvent e) {
		JMenuItem source = (JMenuItem) (e.getSource());
		String s = "Item event detected."
				+ newline
				+ "    Event source: "
				+ source.getText()
				+ " (an instance of "
				+ getClassName(source)
				+ ")"
				+ newline
				+ "    New state: "
				+ ((e.getStateChange() == ItemEvent.SELECTED) ? "selected"
						: "unselected");
		output.append(s + newline);
		output.setCaretPosition(output.getDocument().getLength());
	}

	// Returns just the class name -- no package info.
	protected String getClassName(Object o) {
		String classString = o.getClass().getName();
		int dotIndex = classString.lastIndexOf(".");
		return classString.substring(dotIndex + 1);
	}

	/** Returns an ImageIcon, or null if the path was invalid. */
	protected static ImageIcon createImageIcon(String path) {
		java.net.URL imgURL = MenuDemo.class.getResource(path);
		if (imgURL != null) {
			return new ImageIcon(imgURL);
		} else {
			System.err.println("Couldn't find file: " + path);
			return null;
		}
	}

	/**
	 * Create the GUI and show it. For thread safety, this method should be
	 * invoked from the event-dispatching thread.
	 */
	private static void createAndShowGUI() {
		// Create and set up the window.
		JFrame frame = new JFrame("MenuDemo");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		// Create and set up the content pane.
		MenuDemo demo = new MenuDemo();
		frame.setJMenuBar(demo.createMenuBar());
		frame.setContentPane(demo.createContentPane());

		// Display the window.
		frame.setSize(450, 260);
		frame.setVisible(true);
	}

	public static void main(String[] args) {
		// Schedule a job for the event-dispatching thread:
		// creating and showing this application's GUI.
		javax.swing.SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				createAndShowGUI();
			}
		});
	}

}
