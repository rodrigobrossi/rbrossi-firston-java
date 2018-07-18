package br.com.crm.gui.user;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;

import javax.swing.JPanel;
import javax.swing.JScrollPane;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.auxiliaries.CadastroUsuariosView;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

/**
 * @author Rodrigo Luis Nolli Brossi
 * 
 */
public class UserApplication extends AncestorFrame {

	private static final long serialVersionUID = 1L;
	
	private String user;

	/**
	 * Constructor
	 */
	public UserApplication(String user) {
		this.user = user;
		createGUI("First One - User Application");
	}

	@Override
	public void createGUI(String title) {
		super.createGUI(title);
		// Usuarios
		JPanel userPanel = new JPanel();
		userPanel.setLayout(new FlowLayout(FlowLayout.LEADING));
		userPanel.setOpaque(false);
		userPanel.add(new CadastroUsuariosView(user));

		JScrollPane sp_user = new JScrollPane(userPanel);

		// Improve it; make a method
		sp_user.getViewport().setBackground(Color.WHITE);

		add(CRMComponentsUtils.createHeader("Cadastro",
				ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);
		add(sp_user, BorderLayout.CENTER);
		setBackground(Color.WHITE);

	}

	@Override
	public void updateGUI() {
		// TODO Auto-generated method stub

	}

	@Override
	public AbstractDataBaseCTR loadPersistentObject() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setColor(Color color) {
		// TODO Auto-generated method stub

	}

}
