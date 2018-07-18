package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import br.com.crm.components.calendar.JDateChooser;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.FilhosCTR;
import br.com.crm.db.CrmFilhos;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

public class CadastroFilhosView extends AncestorFrame {

	private static final long serialVersionUID = -28874854607063008L;

	private JTextField nomeFilho = new JTextField(35);

	private JTextField idadeFilho = new JTextField(2);

	// XDate declaration
	private JDateChooser born = new JDateChooser();

	/**
	 * Constructor
	 */
	public CadastroFilhosView() {
		this.createGUI();
	}

	public void createGUI() {
		JPanel panel = new JPanel(new GridBagLayout());
		panel.setBackground(Color.WHITE);

		// Nome Filho
		JLabel nomeFilhoLabel = new JLabel("Nome Filho:");
		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(nomeFilhoLabel, constraints);
		setConstraints(1, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		panel.add(nomeFilho, constraints);

		// DataControlInterface Aniversario
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(new JLabel("DataControlInterface Aniversário:"), constraints);
		setConstraints(1, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(new ValidatorDecorator(born,true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Idade Filho
		JLabel idadeFilhoLabel = new JLabel("Idade:");
		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(idadeFilhoLabel, constraints);
		setConstraints(1, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		panel.add(new ValidatorDecorator(idadeFilho,true, ValidatorConstants.VALIDFOR_TIT), constraints);
		
		JPanel center =new JPanel(new BorderLayout());
		center.add(panel, BorderLayout.NORTH);
		putComponent(center);
	}

	public void updateGUI() {
		// TODO Auto-generated method stub

	}

	public AbstractDataBaseCTR loadPersistentObject() {
		if (this.controller == null) {
			controller = new FilhosCTR();
		}
		CrmFilhos filhos = new CrmFilhos();
		filhos.setFilDataAniversario(this.born.getDate().toGMTString());
		filhos.setFilNome(this.nomeFilho.getText());
		filhos.setFilIdade(this.idadeFilho.getText());
		controller.setObject(filhos);
		return controller;
	}

	public void setColor(Color color) {
		// TODO Auto-generated method stub

	}

}
