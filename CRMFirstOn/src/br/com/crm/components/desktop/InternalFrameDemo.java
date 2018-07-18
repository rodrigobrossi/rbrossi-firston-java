package br.com.crm.components.desktop;

/*
 * @(#)InternalFrameDemo.java	1.14 04/07/26
 */

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;

import javax.swing.AbstractAction;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JDesktopPane;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

/**
 * Internal Frames
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0 09/12/06
 */
public class InternalFrameDemo extends CRMDesktopMain {
	
	private static final long serialVersionUID = -3585759076677395096L;

	int windowCount = 0;

	JDesktopPane desktop = null;

	ImageIcon icon1, icon2, icon3, icon4;

	ImageIcon smIcon1, smIcon2, smIcon3, smIcon4;

	public Integer FIRST_FRAME_LAYER = new Integer(1);

	public Integer DEMO_FRAME_LAYER = new Integer(2);

	public Integer PALETTE_LAYER = new Integer(3);

	public int FRAME0_X = 15;

	public int FRAME0_Y = 280;

	public int FRAME0_WIDTH = 320;

	public int FRAME0_HEIGHT = 230;

	public int FRAME_WIDTH = 225;

	public int FRAME_HEIGHT = 150;

	public int PALETTE_X = 375;

	public int PALETTE_Y = 20;

	public int PALETTE_WIDTH = 260;

	public int PALETTE_HEIGHT = 260;

	JCheckBox windowResizable = null;

	JCheckBox windowClosable = null;

	JCheckBox windowIconifiable = null;

	JCheckBox windowMaximizable = null;

	JTextField windowTitleField = null;

	JLabel windowTitleLabel = null;

	/**
	 * InternalFrameDemo Constructor
	 */
	public InternalFrameDemo() {
		super("FirstOn BI", "toolbar/JDesktop.gif");

		// preload all the icons we need for this demo
		icon1 = createImageIcon("ImageClub/misc/fish.gif",
				getString("InternalFrameDemo.fish"));
		icon2 = createImageIcon("ImageClub/misc/moon.gif",
				getString("InternalFrameDemo.moon"));
		icon3 = createImageIcon("ImageClub/misc/sun.gif",
				getString("InternalFrameDemo.sun"));
		icon4 = createImageIcon("ImageClub/misc/cab.gif",
				getString("InternalFrameDemo.cab"));

		smIcon1 = createImageIcon("ImageClub/misc/fish_small.gif",
				getString("InternalFrameDemo.fish"));
		smIcon2 = createImageIcon("ImageClub/misc/moon_small.gif",
				getString("InternalFrameDemo.moon"));
		smIcon3 = createImageIcon("ImageClub/misc/sun_small.gif",
				getString("InternalFrameDemo.sun"));
		smIcon4 = createImageIcon("ImageClub/misc/cab_small.gif",
				getString("InternalFrameDemo.cab"));

		// Create the desktop pane
		desktop = new JDesktopPane();
		getDemoPanel().add(desktop, BorderLayout.CENTER);

		// Create the "frame maker" palette
		createInternalFramePalette();

		// Create an initial internal frame to show
		JInternalFrame frame1 = createInternalFrame(icon1, FIRST_FRAME_LAYER,
				1, 1);
		frame1.setBounds(FRAME0_X, FRAME0_Y, FRAME0_WIDTH, FRAME0_HEIGHT);

		// Create four more starter windows
		createInternalFrame(icon1, DEMO_FRAME_LAYER, FRAME_WIDTH, FRAME_HEIGHT);
		createInternalFrame(icon3, DEMO_FRAME_LAYER, FRAME_WIDTH, FRAME_HEIGHT);
		createInternalFrame(icon4, DEMO_FRAME_LAYER, FRAME_WIDTH, FRAME_HEIGHT);
		createInternalFrame(icon2, DEMO_FRAME_LAYER, FRAME_WIDTH, FRAME_HEIGHT);
	}

	private ImageIcon createImageIcon(String string, String string2) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * Create an internal frame and add a scrollable imageicon to it
	 */
	public JInternalFrame createInternalFrame(Icon icon, Integer layer,
			int width, int height) {
		JInternalFrame jif = new JInternalFrame();

		if (!windowTitleField.getText().equals(
				getString("InternalFrameDemo.frame_label"))) {
			jif.setTitle(windowTitleField.getText() + "  ");
		} else {
			jif = new JInternalFrame(getString("InternalFrameDemo.frame_label")
					+ " " + windowCount + "  ");
		}

		// set properties
		jif.setClosable(windowClosable.isSelected());
		jif.setMaximizable(windowMaximizable.isSelected());
		jif.setIconifiable(windowIconifiable.isSelected());
		jif.setResizable(windowResizable.isSelected());

		jif.setBounds(20 * (windowCount % 10), 20 * (windowCount % 10), width,
				height);
		jif.setContentPane(new ImageScroller(this, icon, 0, windowCount));

		windowCount++;

		desktop.add(jif, layer);

		// Set this internal frame to be selected

		try {
			jif.setSelected(true);
		} catch (java.beans.PropertyVetoException e2) {
		}

		jif.show();

		return jif;
	}

	public JInternalFrame createInternalFramePalette() {
		JInternalFrame palette = new JInternalFrame("Consulta 1");
		palette.putClientProperty("Teste 1", Boolean.TRUE);
		palette.getContentPane().setLayout(new BorderLayout());
		palette.setBounds(PALETTE_X, PALETTE_Y, PALETTE_WIDTH, PALETTE_HEIGHT);
		palette.setResizable(true);
		palette.setIconifiable(true);
		desktop.add(palette, PALETTE_LAYER);

		// *************************************
		// * Create create frame maker buttons *
		// *************************************
		JButton b1 = new JButton("Criar Consulta");
		JButton b2 = new JButton("Autom�tica");
		JButton b3 = new JButton("Gerar Gr�fico");
		JButton b4 = new JButton("Consulta em Foco");

		// add frame maker actions
		b1.addActionListener(new ShowFrameAction(this, icon1));
		b2.addActionListener(new ShowFrameAction(this, icon2));
		b3.addActionListener(new ShowFrameAction(this, icon3));
		b4.addActionListener(new ShowFrameAction(this, icon4));

		// add frame maker buttons to panel
		JPanel p = new JPanel();
		p.setLayout(new BoxLayout(p, BoxLayout.Y_AXIS));

		JPanel buttons1 = new JPanel();
		buttons1.setLayout(new BoxLayout(buttons1, BoxLayout.X_AXIS));

		JPanel buttons2 = new JPanel();
		buttons2.setLayout(new BoxLayout(buttons2, BoxLayout.X_AXIS));

		buttons1.add(b1);
		buttons1.add(Box.createRigidArea(HGAP15));
		buttons1.add(b2);

		buttons2.add(b3);
		buttons2.add(Box.createRigidArea(HGAP15));
		buttons2.add(b4);

		p.add(Box.createRigidArea(VGAP10));
		p.add(buttons1);
		p.add(Box.createRigidArea(VGAP15));
		p.add(buttons2);
		p.add(Box.createRigidArea(VGAP10));

		palette.getContentPane().add(p, BorderLayout.NORTH);

		// ************************************
		// * Create frame property checkboxes *
		// ************************************
		p = new JPanel() {
			/**
			 * Properti box
			 */
			private static final long serialVersionUID = 1L;

			Insets insets = new Insets(10, 15, 10, 5);

			public Insets getInsets() {
				return insets;
			}
		};
		p.setLayout(new GridLayout(1, 2));

		Box box = new Box(BoxLayout.Y_AXIS);
		windowResizable = new JCheckBox(
				getString("Pessoa Jur�dica"), true);
		windowIconifiable = new JCheckBox(
				getString("Pessoa F�sica"), true);

		box.add(Box.createGlue());
		box.add(windowResizable);
		box.add(windowIconifiable);
		box.add(Box.createGlue());
		p.add(box);

		box = new Box(BoxLayout.Y_AXIS);
		windowClosable = new JCheckBox(
				getString("Sele��o autom�tica"), true);
		windowMaximizable = new JCheckBox(
				getString("Organizar por cliente"), true);

		box.add(Box.createGlue());
		box.add(windowClosable);
		box.add(windowMaximizable);
		box.add(Box.createGlue());
		p.add(box);

		palette.getContentPane().add(p, BorderLayout.CENTER);

		// ************************************
		// * Create Frame title textfield *
		// ************************************
		p = new JPanel() {
			private static final long serialVersionUID = 3091019284986005369L;

			Insets insets = new Insets(0, 0, 10, 0);

			public Insets getInsets() {
				return insets;
			}
		};

		windowTitleField = new JTextField(getString("[Digite aqui o nome da Consulta]"));
		windowTitleLabel = new JLabel(getString("Nome:"));

		p.setLayout(new BoxLayout(p, BoxLayout.X_AXIS));
		p.add(Box.createRigidArea(HGAP5));
		p.add(windowTitleLabel, BorderLayout.WEST);
		p.add(Box.createRigidArea(HGAP5));
		p.add(windowTitleField, BorderLayout.CENTER);
		p.add(Box.createRigidArea(HGAP5));

		palette.getContentPane().add(p, BorderLayout.SOUTH);

		palette.show();

		return palette;
	}

	class ShowFrameAction extends AbstractAction {
		private static final long serialVersionUID = -3313473452782144532L;

		InternalFrameDemo demo;

		Icon icon;

		public ShowFrameAction(InternalFrameDemo demo, Icon icon) {
			this.demo = demo;
			this.icon = icon;
		}

		public void actionPerformed(ActionEvent e) {
			demo.createInternalFrame(icon, getDemoFrameLayer(),
					getFrameWidth(), getFrameHeight());
		}
	}

	public int getFrameWidth() {
		return FRAME_WIDTH;
	}

	public int getFrameHeight() {
		return FRAME_HEIGHT;
	}

	public Integer getDemoFrameLayer() {
		return DEMO_FRAME_LAYER;
	}

	class ImageScroller extends JScrollPane {

		private static final long serialVersionUID = 4165669303340070671L;

		public ImageScroller(InternalFrameDemo demo, Icon icon, int layer,
				int count) {
			super();
			JPanel p = new JPanel();
			p.setBackground(Color.white);
			p.setLayout(new BorderLayout());

			p.add(new JLabel(icon), BorderLayout.CENTER);

			getViewport().add(p);
			getHorizontalScrollBar().setUnitIncrement(10);
			getVerticalScrollBar().setUnitIncrement(10);
		}

		public Dimension getMinimumSize() {
			return new Dimension(25, 25);
		}

	}

	void updateDragEnabled(boolean dragEnabled) {
		windowTitleField.setDragEnabled(dragEnabled);
	}
	
	public static void main(String args[]){
		new InternalFrameDemo();
		
	}
	

}
