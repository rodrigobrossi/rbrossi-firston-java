package br.com.crm.gui;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.InvocationTargetException;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.UsuariosCTR;
import br.com.crm.db.CrmUsuarios;
import br.com.crm.gui.app.AncestorFrame;

public class LoginView extends AncestorFrame implements ActionListener {

	private static final long serialVersionUID = 1L;

	private static final String COMMAND_ENTRAR = "Entrar";

	private static final String COMMAND_CADASTRAR = "Cadastrar";

	private JTextField username = new JTextField(15);
	
	private JDialog parent; 

	private JPasswordField password = new JPasswordField(15);

	private boolean loginResult;

	private void setLoginResult(boolean loginResult) {
		this.loginResult = loginResult;
	}

	public LoginView(JDialog parent) {
		this.parent = parent;

		try {
			SwingUtilities.invokeAndWait(new Runnable() {
				public void run() {
					createGUI();
				}

			});
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

	
	public void createGUI() {
		GridBagLayout gridbag = new GridBagLayout();

		JPanel panel = new JPanel();
		panel.setLayout(gridbag);
		panel.setBackground(Color.WHITE);

		JLabel logoLabel = new JLabel("");
		setConstraints(1, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.HORIZONTAL);
		gridbag.setConstraints(logoLabel, constraints);
		panel.add(logoLabel);

		JLabel usernameLabel = new JLabel("Usuário:");
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		gridbag.setConstraints(usernameLabel, constraints);
		panel.add(usernameLabel);
		setConstraints(1, 1, 15, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(username, constraints);
		panel.add(username);

		JLabel passwordLabel = new JLabel("Senha:");
		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		gridbag.setConstraints(passwordLabel, constraints);
		panel.add(passwordLabel);
		setConstraints(1, 2, 15, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(password, constraints);
		panel.add(password);

		JPanel panel2 = new JPanel();
		panel2.setBackground(Color.WHITE);
		JButton entrarButton = new JButton("Entrar");
		entrarButton.addActionListener(this);
		entrarButton.setActionCommand(COMMAND_ENTRAR);
		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(entrarButton, constraints);
		panel2.add(entrarButton);

		JButton cadastrarButton = new JButton("Cadastrar");
		cadastrarButton.addActionListener(this);
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		gridbag.setConstraints(entrarButton, constraints);
		panel2.add(cadastrarButton);

		setConstraints(1, 3, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		gridbag.setConstraints(panel2, constraints);
		panel.add(panel2);
		putComponent(panel);
		parent.add(this);
	
	}

	public void actionPerformed(ActionEvent evt) {
		String command = evt.getActionCommand();
		UsuariosCTR usrCTR = (UsuariosCTR) loadPersistentObject();
		
		String login  = ((CrmUsuarios)usrCTR.getObject()).getUsrNomeUsuario();
		String senha  = ((CrmUsuarios)usrCTR.getObject()).getUsrSenhaUsuario();

		//LoadViews.loadWindow(LoadViews.CADASTRO_USUARIOS);
		//FIXME solve the problem with the login view
		// Just checa o commando entrar.
		if (command.equals(COMMAND_ENTRAR)) {
			if (usrCTR.checkLogin(login, senha)) {
				this.setLoginResult(true);
				parent.dispose();
				return;
			} else {
				String str_message = null;
				if (login!= null) {
					
					if (usrCTR.isAValidUser(this.username.getText().trim())) {
						if (senha!= null) {
							str_message = "Password invalido";
							JOptionPane.showMessageDialog(this, str_message);
						} else {
							str_message = "Senha não cadastrada!";
							JOptionPane.showMessageDialog(this, str_message);
							//LoadViews.loadWindow(LoadViews.CADASTRO_USUARIOS);
							//FIXME sove the problem with the login view
						}
					}else{
						str_message = "Usuário não cadastrado!";
						JOptionPane.showMessageDialog(this, str_message);
						this.setLoginResult(false);	
					}
				} else {
					str_message = "Usuário não cadastrado!";
					JOptionPane.showMessageDialog(this, str_message);
					this.setLoginResult(false);
				}
			}
		} else if (command.equals(COMMAND_CADASTRAR)) {
			//LoadViews.loadWindow(LoadViews.CADASTRO_USUARIOS);
			//FIXME Solve the problem with the login view 
		} else {
			JOptionPane.showMessageDialog(this, "Invalid Command!!");
		}
		this.setLoginResult(true);	
		parent.dispose();
		return;
	}

	
	public void setColor(Color color) {
		// TODO Looking for any component that needs set a specific Color
	}

	
	public AbstractDataBaseCTR loadPersistentObject() {
		UsuariosCTR usrCTR = new UsuariosCTR();
		CrmUsuarios users = new CrmUsuarios();
		users.setUsrNomeUsuario(this.username.getText().trim());
		users.setUsrSenhaUsuario(this.password.getText().trim());
		usrCTR.setObject(users);
		return usrCTR;
	}

	public boolean getLoginResult() {
		return this.loginResult;
	}


	public void updateGUI() {
	}
}
