package br.com.crm.gui.juridic;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import br.com.crm.components.JCommandPanel;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

public class CadastroPessoaJuridicaView extends AncestorFrame {

	private static final int NONE = GridBagConstraints.NONE;

	private static final long serialVersionUID = 1633478247533884394L;

	private static final int PAGE_START = GridBagConstraints.FIRST_LINE_START;

	private JTextField nomeField = new JTextField(35);
	
	private JTextField cnpjField = new JTextField(13);
	
	private JTextField websiteField = new JTextField(35);
	
	private JTextField emailField = new JTextField(35);
	
	private JTextField cepField = new JTextField(7);

	private JTextField logradouroField = new JTextField(35);

	private JTextField numeroField = new JTextField(5);

	private JTextField complementoField = new JTextField(35);

	private JTextField bairroField = new JTextField(35);
	
	private JTextField cidadeField = new JTextField(35);
	
	private JComboBox ufCombo = new JComboBox();
	
	private JTextField tel1Field = new JTextField(8);

	private JTextField ddd1Field = new JTextField(3);

	private JTextField tel2Field = new JTextField(8);

	private JTextField ddd2Field = new JTextField(3);

	private JTextField faxField = new JTextField(8);

	private JTextField ddd3Field = new JTextField(3);

	private JTextField celField = new JTextField(8);

	private JTextField ddd4Field = new JTextField(3);
	
	private JTextField numEmpregado;
	
	private JTextArea observacao = new JTextArea(5, 35);

	public CadastroPessoaJuridicaView() {
		this.createGUI();
	}

	public void createGUI() {
		add(CRMComponentsUtils.createHeader("Cadastro Pessoa Juridica",
				ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);

		JPanel panel = new JPanel(new GridBagLayout());

		// Nome
		JLabel nomeLabel = new JLabel("Nome:", JLabel.LEFT);
		setConstraints(0, 1, 1, 1, PAGE_START, NONE);
		panel.add(nomeLabel, constraints);
		setConstraints(1, 1, 1, 1, PAGE_START, NONE);
		panel.add(nomeField, constraints);
		
		//CNPJ
		JLabel cnpjLabel = new JLabel("CNPJ:", JLabel.LEFT);
		setConstraints(0, 2, 1, 1, PAGE_START, NONE);
		panel.add(cnpjLabel, constraints);
		setConstraints(1, 2, 1, 1, PAGE_START, NONE);
		panel.add(cnpjField, constraints);
		
		//WebSite
		JLabel websiteLabel = new JLabel("Web Site:", JLabel.LEFT);
		setConstraints(0, 3, 1, 1, PAGE_START, NONE);
		panel.add(websiteLabel, constraints);
		setConstraints(1, 3, 1, 1, PAGE_START, NONE);
		panel.add(websiteField, constraints);
		
		//email
		JLabel emailLabel = new JLabel("e-mail:", JLabel.LEFT);
		setConstraints(0, 4, 1, 1, PAGE_START, NONE);
		panel.add(emailLabel, constraints);
		setConstraints(1, 4, 1, 1, PAGE_START, NONE);
		panel.add(emailField, constraints);

		// CEP
		JLabel cepLabel = new JLabel("CEP:", JLabel.LEFT);
		setConstraints(0, 8, 1, 1, PAGE_START, NONE);
		panel.add(cepLabel, constraints);
		setConstraints(1, 8, 1, 1, PAGE_START, NONE);
		panel.add(cepField, constraints);

		// Logradouro
		JLabel logradouroLabel = new JLabel("Logradouro:", JLabel.LEFT);
		setConstraints(0, 9, 1, 1, PAGE_START, NONE);
		panel.add(logradouroLabel, constraints);
		setConstraints(1, 9, 1, 1, PAGE_START, NONE);
		panel.add(logradouroField, constraints);

		// Numero
		JLabel numeroLabel = new JLabel("Numero:", JLabel.LEFT);
		setConstraints(0, 10, 1, 1, PAGE_START, NONE);
		panel.add(numeroLabel, constraints);
		setConstraints(1, 10, 1, 1, PAGE_START, NONE);
		panel.add(numeroField, constraints);

		// Complemento
		JLabel complementoLabel = new JLabel("Complemento:", JLabel.LEFT);
		setConstraints(0, 11, 1, 1, PAGE_START, NONE);
		panel.add(complementoLabel, constraints);
		setConstraints(1, 11, 1, 1, PAGE_START, NONE);
		panel.add(complementoField, constraints);

		// Bairro
		JLabel bairroLabel = new JLabel("Bairro:", JLabel.LEFT);
		setConstraints(0, 12, 1, 1, PAGE_START, NONE);
		panel.add(bairroLabel, constraints);
		setConstraints(1, 12, 1, 1, PAGE_START, NONE);
		panel.add(bairroField, constraints);

		// Cidade
		JLabel cidadeLabel = new JLabel("Cidade:", JLabel.LEFT);
		setConstraints(0, 13, 1, 1, PAGE_START, NONE);
		panel.add(cidadeLabel, constraints);
		setConstraints(1, 13, 1, 1, PAGE_START, NONE);
		panel.add(cidadeField, constraints);

		// UF
		JLabel ufLabel = new JLabel("UF:", JLabel.LEFT);
		setConstraints(0, 14, 1, 1, PAGE_START, NONE);
		panel.add(ufLabel, constraints);
		setConstraints(1, 14, 1, 1, PAGE_START, NONE);
		panel.add(ufCombo, constraints);

		// Telefone 1
		JLabel tel1Label = new JLabel("Telefone 1:", JLabel.LEFT);
		setConstraints(0, 15, 1, 1, PAGE_START, NONE);
		panel.add(tel1Label, constraints);

		JPanel panel4 = new JPanel(new GridBagLayout());
		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel4.add(ddd1Field, constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel4.add(tel1Field, constraints);

		setConstraints(1, 15, 1, 1, PAGE_START, NONE);
		panel.add(panel4, constraints);

		// Telefone 2
		JLabel tel2Label = new JLabel("Telefone 2:", JLabel.LEFT);
		setConstraints(0, 16, 1, 1, PAGE_START, NONE);

		panel.add(tel2Label, constraints);
		JPanel panel5 = new JPanel(new GridBagLayout());
		setConstraints(0, 0, 1, 1, PAGE_START, NONE);

		panel5.add(ddd2Field, constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel5.add(tel2Field, constraints);
		setConstraints(1, 16, 1, 1, PAGE_START, NONE);
		panel.add(panel5, constraints);

		// FAX
		JLabel faxLabel = new JLabel("FAX:", JLabel.LEFT);
		setConstraints(0, 17, 1, 1, PAGE_START, NONE);
		panel.add(faxLabel, constraints);
		JPanel panel6 = new JPanel(new GridBagLayout());
		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel6.add(ddd3Field, constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel6.add(faxField, constraints);
		setConstraints(1, 17, 1, 1, PAGE_START, NONE);
		panel.add(panel6, constraints);

		// Observacao
		JLabel observacaoLabel = new JLabel("Observação:", JLabel.LEFT);
		setConstraints(0, 30, 1, 1, PAGE_START, NONE);
		panel.add(observacaoLabel, constraints);
		observacao.setLineWrap(true);
		observacao.setWrapStyleWord(true);
		setConstraints(1, 30, 1, 1, PAGE_START, NONE);
		panel.add(new JScrollPane(observacao), constraints);
		putComponent(panel);

		//Create command Panel
		JCommandPanel commandPanel = new JCommandPanel(this);
		add(commandPanel, BorderLayout.SOUTH);
	}

	public void updateGUI() {
		// TODO Auto-generated method stub
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		return null;
		// TODO Auto-generated method stub
	}

	public void setColor(Color color) {

	}

//	public static void main(String args[]) {
//		JFrame f = new JFrame();
//		f.add(new CadastroPessoaJuridicaView());
//		f.setVisible(true);
//		f.pack();
//
//	}
}
