package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;

import br.com.crm.command.CommandManager;
import br.com.crm.command.CommandsConstants;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.UsuariosCTR;
import br.com.crm.db.CrmUsuarios;
import br.com.crm.gui.app.AncestorFrame;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 *
 */
public class CadastroUsuariosView extends AncestorFrame implements ActionListener {

	private static final long serialVersionUID = 4460266380094652284L;

	private static final String CADASTRAR = "Cadastrar";

	private JTextField usuario = new JTextField(15);

	private JPasswordField senhaUsuario = new JPasswordField(15);

	private JPasswordField confirmaSenhaUsuario = new JPasswordField(15);

	private String user;

	/**
	 * Constructor
	 * 
	 * @param user
	 */
	public CadastroUsuariosView(String user) {
		this.user = user;
		this.createGUI();
	}

	public void createGUI() {
		this.setLayout(new BorderLayout());
		GridBagLayout gridbag = new GridBagLayout();

		JPanel panel = new JPanel();
		panel.setLayout(gridbag);
		panel.setBackground(Color.WHITE);

		// Usuario
		JLabel usuarioLabel = new JLabel("Usuario:");
		setConstraints(0, 0, 1, 1, GridBagConstraints.PAGE_START,
				GridBagConstraints.NONE);
		gridbag.setConstraints(usuarioLabel, constraints);
		panel.add(usuarioLabel);
		setConstraints(1, 0, 1, 1, GridBagConstraints.HORIZONTAL,
				GridBagConstraints.BOTH);
		usuario.setText(user);
		gridbag.setConstraints(usuario, constraints);
		panel.add(usuario);

		// Senha Usuario
		JLabel senhaUsuarioLabel = new JLabel("Senha:");
		setConstraints(0, 1, 1, 1, GridBagConstraints.PAGE_START,
				GridBagConstraints.NONE);
		gridbag.setConstraints(senhaUsuarioLabel, constraints);
		panel.add(senhaUsuarioLabel);
		setConstraints(1, 1, 1, 1, GridBagConstraints.HORIZONTAL,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(senhaUsuario, constraints);
		panel.add(senhaUsuario);

		// Confirma Senha Usuario
		JLabel confirmaSenhaUsuarioLabel = new JLabel("Confirma Senha:");
		setConstraints(0, 2, 1, 1, GridBagConstraints.PAGE_START,
				GridBagConstraints.NONE);
		gridbag.setConstraints(confirmaSenhaUsuarioLabel, constraints);
		panel.add(confirmaSenhaUsuarioLabel);
		setConstraints(1, 2, 1, 1, GridBagConstraints.HORIZONTAL,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(confirmaSenhaUsuario, constraints);
		panel.add(confirmaSenhaUsuario);

		JPanel panel2 = new JPanel();
		panel2.setBackground(Color.WHITE);
		JButton cadastrarButton = new JButton(CADASTRAR);
		cadastrarButton.addActionListener(this);
		cadastrarButton.setActionCommand(CADASTRAR);
		setConstraints(0, 0, 1, 1, GridBagConstraints.CENTER,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(cadastrarButton, constraints);
		panel2.add(cadastrarButton);

		JButton limparButton = new JButton("Limpar");
		cadastrarButton.addActionListener(this);
		setConstraints(0, 1, 1, 1, GridBagConstraints.CENTER,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(limparButton, constraints);
		panel2.add(limparButton);

		setConstraints(1, 3, 1, 1, GridBagConstraints.CENTER,
				GridBagConstraints.BOTH);
		gridbag.setConstraints(panel2, constraints);
		panel.add(panel2);
		JPanel center =new JPanel(new BorderLayout());
		center.add(panel, BorderLayout.NORTH);
		putComponent(center);
	}

	public void setColor(Color color) {
		
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		UsuariosCTR usuarioCTR = new UsuariosCTR();

		String senha = new String(senhaUsuario.getPassword());
		String confirmaSenha = new String(confirmaSenhaUsuario.getPassword());

		if (checkSenhas(senha, confirmaSenha)) {
			CrmUsuarios usuarios = new CrmUsuarios();
			usuarios.setUsrNomeUsuario(this.usuario.getText());
			usuarios.setUsrSenhaUsuario(senha);
			usuarioCTR.setObject(usuarios);
			super.setAbstractDataBaseCTR(usuarioCTR);
		}
		return usuarioCTR;
	}

	private boolean checkSenhas(String senha1, String senha2) {

		if (!senha1.equals(senha2)) {
			JOptionPane.showMessageDialog(this, "Senhas nao conferem !");
			return false;
		}

		return true;

	}

	public void updateGUI() {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
	 */
	public void actionPerformed(ActionEvent evt) {
		String command = evt.getActionCommand();

		if (command.equals(CADASTRAR)) {
			AbstractDataBaseCTR obj = loadPersistentObject();
			// Insert Command call
			CommandManager.getInstance().invokeCommandByName(
					CommandsConstants.INSERT, obj);
		}
	}
}
