package br.com.crm.components.desktop;


import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;

import javax.swing.BoxLayout;
import javax.swing.Icon;
import javax.swing.JPanel;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.EmptyBorder;
import javax.swing.border.SoftBevelBorder;

import br.com.crm.control.AbstractDataBaseCTR;

/**
 * A Search module
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0 09/12/06 
 */
public class CRMDesktopMain extends JPanel {

	private static final long serialVersionUID = -8745319490606731556L;

	// The preferred size of the demo
	private int PREFERRED_WIDTH = 680;

	private int PREFERRED_HEIGHT = 600;

	Border loweredBorder = new CompoundBorder(new SoftBevelBorder(
			SoftBevelBorder.LOWERED), new EmptyBorder(5, 5, 5, 5));

	// Premade convenience dimensions, for use wherever you need 'em.
	public static Dimension HGAP2 = new Dimension(2, 1);

	public static Dimension VGAP2 = new Dimension(1, 2);

	public static Dimension HGAP5 = new Dimension(5, 1);

	public static Dimension VGAP5 = new Dimension(1, 5);

	public static Dimension HGAP10 = new Dimension(10, 1);

	public static Dimension VGAP10 = new Dimension(1, 10);

	public static Dimension HGAP15 = new Dimension(15, 1);

	public static Dimension VGAP15 = new Dimension(1, 15);

	public static Dimension HGAP20 = new Dimension(20, 1);

	public static Dimension VGAP20 = new Dimension(1, 20);

	public static Dimension HGAP25 = new Dimension(25, 1);

	public static Dimension VGAP25 = new Dimension(1, 25);

	public static Dimension HGAP30 = new Dimension(30, 1);

	public static Dimension VGAP30 = new Dimension(1, 30);

	private JPanel panel = null;

	private String resourceName = null;

	private String sourceCode = null;

	public CRMDesktopMain() {
		this(null, null);
	}

	public CRMDesktopMain(String resourceName, String iconPath) {
		createGUI();
	}

	public String getResourceName() {
		return resourceName;
	}

	public JPanel getDemoPanel() {
		return panel;
	}

	public String getSourceCode() {
		return sourceCode;
	}

	public String getName() {
		return "Desktop CRM";
	};

	public Icon getIcon() {
		return null;
	};

	public String getString(String label) {
		return label;
	}

	public String getToolTip() {
		return "Brand new Desktop pane for CRM";
	};

	public JPanel createHorizontalPanel(boolean threeD) {
		JPanel p = new JPanel();
		p.setLayout(new BoxLayout(p, BoxLayout.X_AXIS));
		p.setAlignmentY(TOP_ALIGNMENT);
		p.setAlignmentX(LEFT_ALIGNMENT);
		if (threeD) {
			p.setBorder(loweredBorder);
		}
		return p;
	}

	public JPanel createVerticalPanel(boolean threeD) {
		JPanel p = new JPanel();
		p.setLayout(new BoxLayout(p, BoxLayout.Y_AXIS));
		p.setAlignmentY(TOP_ALIGNMENT);
		p.setAlignmentX(LEFT_ALIGNMENT);
		if (threeD) {
			p.setBorder(loweredBorder);
		}
		return p;
	}


	void updateDragEnabled(boolean dragEnabled) {
	}

	/**
	 * FIXME Create n interface for this methods and change the name of the Ancestor
	 * Frame
	 */
	public void createGUI() {
		// UIManager.put("swing.boldMetal", Boolean.FALSE);
		panel = new JPanel();
		panel.setLayout(new BorderLayout());
		panel.validate();
		this.setLayout(new BorderLayout());
		this.add(panel, BorderLayout.CENTER);
		getDemoPanel().setPreferredSize(new Dimension(PREFERRED_WIDTH, PREFERRED_HEIGHT));
	}

	/**
	 * FIXME Create n interface for this methods and change the name of the Ancestor
	 * Frame
	 */
	public void updateGUI() {

	}
	/**
	 * FIXME Create n interface for this methods and change the name of the Ancestor
	 * Frame
	 */
	public AbstractDataBaseCTR loadPersistentObject() {
		return null;
	}
	/**
	 * FIXME Create n interface for this methods and change the name of the Ancestor
	 * Frame
	 * @deprecated remove it.
	 */
	public void setColor(Color color) {

	}
}
