/**
 * 
 */
package br.com.firston.bar.applets;

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

/**
 * @author rbrossi
 *
 */
public class LoginBar extends Applet implements ActionListener {

	private JTextField logiField = null;
	private JPasswordField passwordField = null;
	private JButton loginButton = null;
	private JButton cleallButton = null;
	/**
	 * @throws HeadlessException
	 */
	public LoginBar() throws HeadlessException {
		// TODO Auto-generated constructor stub
		
		loginButton = new JButton("Login");
		cleallButton = new JButton("clean all fields");
		logiField = new JTextField("type here your login",30);
		passwordField = new JPasswordField("Type here your password",30);
		
		JPanel panel = new JPanel(new FlowLayout(2));
		JPanel fields = new JPanel(new GridLayout(2,2));
		
		fields.add(new JLabel("Login:"));
		fields.add(logiField);
		fields.add(new JLabel("Password:"));
		fields.add(passwordField);
		
		panel.add(loginButton);
		panel.add(cleallButton);
		
		this.setLayout(new BorderLayout());
		
		this.add(fields, BorderLayout.CENTER);
		this.add(panel, BorderLayout.SOUTH);
	}

	/* (non-Javadoc)
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	public void actionPerformed(ActionEvent arg0) {
		// TODO Auto-generated method stub

	}

}
