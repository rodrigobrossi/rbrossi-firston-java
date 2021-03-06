package br.com.crm.validation;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Frame;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowFocusListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JEditorPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.JWindow;
import javax.swing.border.Border;
import javax.swing.border.LineBorder;

import br.com.crm.util.ViewConstants;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0 
 * Validator Decorator Object
 */
public class ValidatorDecorator extends JComponent implements
		PropertyChangeListener, KeyListener, ActionListener, ComponentListener,
		WindowFocusListener, Validator {

	private static final long serialVersionUID = -1361291219628182623L;

	protected JComponent child;

	private JButton button = new JButton(ViewConstants.ERROR_ICON);

	boolean minimum = false;

	private LineBorder mandatoryBorder = new LineBorder(Color.BLUE, 1);
	
	private LineBorder errorBorder = new LineBorder(Color.RED, 1);

	private JWindow errorWindow;

	private Frame parent;

	private JEditorPane ta;

	private JPanel panel;

	private boolean mandatory;

	private Border defaultBorder;
	
	private boolean valid;

	private Color bkErrorColor 	   = new Color(255,170,170);
	private Color bkCompletedColor = new Color(255,255,170);
	private Color bkMandatorycolor = Color.WHITE;
	
	private int validation;

	/**
	 * Constructor of this element
	 * 
	 * @author Rodrigo Luis Nolli Brossi
	 * @param component
	 * @param mandatory
	 */
	public ValidatorDecorator(JComponent component, boolean mandatory, int validation) {
		/* Receive and configure a component */
		child = component;
		child.addPropertyChangeListener(this);
		child.addKeyListener(this);

		/* Create this decorated component */
		this.setLayout(new BorderLayout());
		this.add(child);
		this.mandatory = mandatory;
		
		this.validation = validation;

		child.setLayout(null);
		/* Create decorated button */
		button.setBounds(0, 0, 8, 8);
		button.setBorder(null);
		button.setVisible(false);
		button.addActionListener(this);

		/* Create message panel */
		panel = createMessagePanel();
		child.add(button);
	}


	private JPanel createMessagePanel() {
		panel = new JPanel();
		panel.setLayout(new BorderLayout());
		ta = new JEditorPane("text/html", "Window warnign");
		ta.setEditable(false);
		ta.setBackground(new Color(240, 240, 155));
		JScrollPane sp = new JScrollPane(ta);
		sp.setBorder(new LineBorder(Color.YELLOW, 1));
		panel.add(sp);
		return panel;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.beans.PropertyChangeListener#propertyChange(java.beans.PropertyChangeEvent)
	 */
	public void propertyChange(PropertyChangeEvent evt) {
		validate((JComponent) evt.getSource());

	}

	public void keyTyped(KeyEvent evt) {
		validate((JComponent) evt.getSource());

	}

	public void keyPressed(KeyEvent evt) {
		validate((JComponent) evt.getSource());

	}

	public void keyReleased(KeyEvent evt) {
		validate((JComponent) evt.getSource());

	}

	/**
	 * Validador
	 * 
	 * @param component
	 */
	private void validate(JComponent component) {
		if (component instanceof JTextField) {
			JTextField obj = (JTextField) component;
			if (mandatory) {
				isMandatoryJTextField(obj);
			}
			showMessage(obj, ValidationRules.validateJTextFiel(obj, validation));
		}
		else if (component instanceof JComboBox){
			
		}

	}

	private void showMessage(JTextField component, String[] messages) {
		if (messages != null) {
			ta.setText(ValidatiorEval.getValidateMessage(messages,validation));
			ta.validate();
			ta.updateUI();
			button.setVisible(true);
			if(component!=null){
				component.validate();
				component.repaint();
				//	component.setBorder(new LineBorder(Color.RED, 1));
				//	component.setBackground(bkErrorColor);
			}
			
		} else {
			button.setVisible(false);
			if (errorWindow != null)
				errorWindow.setVisible(false);
		}
	}

	/**
	 * Verify if a JTextField is mandatory
	 * 
	 * @param component
	 */
	private void isMandatoryJTextField(JTextField component) {
		if (component != null) {
			if (component.getText().trim().equals("")) {
				if (defaultBorder == null){
					defaultBorder = new LineBorder(Color.BLACK, 1);
				}
				// Set Mandatory Border
				component.setBorder(mandatoryBorder);
				component.setBackground(bkMandatorycolor);
			} else {
				if (defaultBorder != null)
					component.setBorder(defaultBorder);
					component.setBackground(bkCompletedColor);
			}
		}
	}

	/**
	 * Return parent frame
	 * 
	 * @param component
	 * @return parent Frame
	 */
	private Frame getFrame(Component component) {
		if (component == null)
			component = this;

		if (component.getParent() instanceof Frame) {
			return (Frame) component.getParent();
		}
		return getFrame(component.getParent());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == button) {
			Point p = new Point(child.getLocationOnScreen().x
					+ child.getSize().width, child.getLocationOnScreen().y);
			if (errorWindow == null) {
				parent = getFrame(ValidatorDecorator.this.getParent());
				parent.addComponentListener(this);
				parent.addWindowFocusListener(this);
				errorWindow = new JWindow(parent);
				errorWindow.setSize(new Dimension(300, 100));
				errorWindow.setAlwaysOnTop(true);
				errorWindow.add(panel);
			}
			errorWindow.setLocation(p);
			errorWindow.repaint();
			errorWindow.setVisible(!errorWindow.isVisible());
			errorWindow.requestFocus();
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.ComponentListener#componentResized(java.awt.event.ComponentEvent)
	 */
	public void componentResized(ComponentEvent e) {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.ComponentListener#componentMoved(java.awt.event.ComponentEvent)
	 */
	public void componentMoved(ComponentEvent e) {
		System.out.println("teste");
		Point p = new Point(child.getLocationOnScreen().x
				+ child.getSize().width, child.getLocationOnScreen().y);
		errorWindow.setLocation(p);
		errorWindow.repaint();

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.ComponentListener#componentShown(java.awt.event.ComponentEvent)
	 */
	public void componentShown(ComponentEvent e) {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.ComponentListener#componentHidden(java.awt.event.ComponentEvent)
	 */
	public void componentHidden(ComponentEvent e) {
		if (button != null && errorWindow != null) {
			button.setVisible(false);
			errorWindow.setVisible(false);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.WindowFocusListener#windowGainedFocus(java.awt.event.WindowEvent)
	 */
	public void windowGainedFocus(WindowEvent e) {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.WindowFocusListener#windowLostFocus(java.awt.event.WindowEvent)
	 */
	public void windowLostFocus(WindowEvent e) {
	}

	/* (non-Javadoc)
	 * @see java.awt.Component#isValid()
	 */
	public boolean isValid() {
		return valid;
	}

	/**
	 * Reset the validator conditions.
	 */
	public void reset() {
		valid = false;
		if (errorWindow != null)
			errorWindow.setVisible(false);
		if (button != null)
			button.setVisible(false);
	}

	

}