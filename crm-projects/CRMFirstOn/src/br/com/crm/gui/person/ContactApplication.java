package br.com.crm.gui.person;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.ButtonGroup;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.border.LineBorder;

import br.com.crm.components.JCommandPanel;
import br.com.crm.components.calendar.JDateChooser;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.ClubeClienteCRT;
import br.com.crm.control.ContatoCTR;
import br.com.crm.control.CrencaClienteCTR;
import br.com.crm.control.EmpresasCTR;
import br.com.crm.control.EsporteClienteCTR;
import br.com.crm.control.EstiloClienteCTR;
import br.com.crm.control.LazerContatosCTR;
import br.com.crm.control.ProfissaoClienteCTR;
import br.com.crm.db.CrmClubeCliente;
import br.com.crm.db.CrmContato;
import br.com.crm.db.CrmCrencaCliente;
import br.com.crm.db.CrmEmpresas;
import br.com.crm.db.CrmEsporteCliente;
import br.com.crm.db.CrmEstiloCliente;
import br.com.crm.db.CrmLazerCliente;
import br.com.crm.db.CrmProfissaoCliente;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

/**
 * This class is responsible to render the view for record a new contact register.
 * This will also apply the most part of the intelligence of the framework.
 * 
 * @author Rodrigo Luis Nolli Brossi 
 * @version 1.0 
 * 
 */
public class ContactApplication extends AncestorFrame {

	private static final int NONE = GridBagConstraints.NONE;

	private static final int PAGE_START = GridBagConstraints.FIRST_LINE_START;

	private static final long serialVersionUID = -2931073495710425475L;
	
	
	private JComboBox positionCombo, ufCombo, lazer1Combo, 
			esporteCombo, clubeCombo, tipoRelacaoCombo, empresaCombo,
			estiloCombo;

	private JTextField cidadeField = new JTextField(35);
	
	private JTextField profissaoField = new JTextField(35);

	private JTextField nomeField = new JTextField(35);

	private JTextField cepField = new JTextField(7);

	private JTextField logradouroField = new JTextField(35);

	private JTextField numeroField = new JTextField(5);

	private JTextField complementoField = new JTextField(35);

	private JTextField bairroField = new JTextField(35);

	private JTextField tel1Field = new JTextField(8);

	private JTextField ddd1Field = new JTextField(3);

	private JTextField tel2Field = new JTextField(8);

	private JTextField ddd2Field = new JTextField(3);

	private JTextField faxField = new JTextField(8);

	private JTextField dddFaxField = new JTextField(3);

	private JTextField celField = new JTextField(8);

	private JTextField dddCelField = new JTextField(3);

	private JTextField emailField = new JTextField(15);

	private JDateChooser aniversarioDate = new JDateChooser();

	private JDateChooser admissaoDate = new JDateChooser();

	private JRadioButton masculino, feminino;

	private JRadioButton simRadioButton;

	private JRadioButton naoRadioButton;

	

	/**
	 * 
	 */
	public ContactApplication() {
		this.createGUI("First One - Contact Appliation");
	}
	
	
	
	/**
	 * Will generate all maps with the information from the database.
	 */
	public void updateMaps() {
		
		// CreateCombos
		empresaCombo 	= createValuesForACombo(new EmpresasCTR(),new CrmEmpresas(),"EmpNome");
		estiloCombo  	= createValuesForACombo(new EstiloClienteCTR(), new CrmEstiloCliente(), "EstTitulo");
		positionCombo 	= createValuesForACombo(new ProfissaoClienteCTR(), new CrmProfissaoCliente(),  "PfcTitulo");
		lazer1Combo 	= createValuesForACombo(new LazerContatosCTR(), new CrmLazerCliente(),  "LazTitulo");
		esporteCombo	= createValuesForACombo(new EsporteClienteCTR(), new CrmEsporteCliente(), "EspTitulo");
		clubeCombo		= createValuesForACombo(new ClubeClienteCRT(),new CrmClubeCliente(), "CclTitulo");
	
	    this.setBorder(empresaCombo);
	    this.setBorder(estiloCombo);
	    this.setBorder(positionCombo);
	    this.setBorder(lazer1Combo);
	    this.setBorder(esporteCombo);
	    this.setBorder(clubeCombo);
		//Common fields 
		//createValues(new ClubeClienteCRT(), new CrmClubeCliente(), "CclTitulo");
		createValues(new CrencaClienteCTR(), new CrmCrencaCliente(), "CrcTitulo");
	
	}

	

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#createGUI()
	 */
	public void createGUI(String title) {
		super.createGUI(title);
		updateMaps();
		JPanel panel = new JPanel(new GridBagLayout());

		// Relationship
//		tipoRelacaoCombo = new JComboBox(getTrpElements());
//		JLabel tipoRelLabel = new JLabel("Tipo Relação:", JLabel.LEFT);
//		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
//		panel.add(tipoRelLabel, constraints);

//		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
//		panel.add(tipoRelacaoCombo, constraints);

		// Nome
		JLabel nomeLabel = new JLabel("Nome:", JLabel.LEFT);
		setConstraints(0, 1, 1, 1, PAGE_START, NONE);
		panel.add(nomeLabel, constraints);
		setConstraints(1, 1, 1, 1, PAGE_START, NONE);
		//Validei o componente
		ValidatorDecorator contactName = new ValidatorDecorator(nomeField,true,ValidatorConstants.VALIDFOR_TIT);
		panel.add(contactName, constraints);

		// Sexo
		JLabel sexoLabel = new JLabel("Sexo:", JLabel.LEFT);
		setConstraints(0, 2, 1, 1, PAGE_START, NONE);
		panel.add(sexoLabel, constraints);

		ButtonGroup buttonGroup = new ButtonGroup();
		masculino = new JRadioButton("Masculino");
		masculino.setSelected(true);
		buttonGroup.add(masculino);
		buttonGroup.add(feminino = new JRadioButton("Femino"));

		JPanel panel2 = new JPanel();

		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel2.add(masculino, constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel2.add(feminino, constraints);
		// Add Panel
		setConstraints(1, 2, 1, 1, PAGE_START, NONE);
		panel.add(panel2, constraints);

//		// Estilo
//		JLabel estiloLabel = new JLabel("Estilo:", JLabel.LEFT);
//		setConstraints(0, 3, 1, 1, PAGE_START, NONE);
//
//		panel.add(estiloLabel, constraints);
//		setConstraints(1, 3, 1, 1, PAGE_START, NONE);
//		panel.add(estiloCombo, constraints);

		// Empresa
		JLabel empresaLabel = new JLabel("Empresa:", JLabel.LEFT);
		setConstraints(0, 4, 1, 1, PAGE_START, NONE);
		panel.add(empresaLabel, constraints);
		setConstraints(1, 4, 1, 1, PAGE_START, NONE);
		panel.add(empresaCombo, constraints);

		// Cargo
		//cargoCombo = new JComboBox(getStringArray(cargos));
		
		JLabel cargoLabel = new JLabel("Cargo:", JLabel.LEFT);
		setConstraints(0, 5, 1, 1, PAGE_START, NONE);
		panel.add(cargoLabel, constraints);
		setConstraints(1, 5, 1, 1, PAGE_START, NONE);
		panel.add(positionCombo, constraints);

//		// Setor
//		JLabel setorLabel = new JLabel("Setor:", JLabel.LEFT);
//		setConstraints(0, 6, 1, 1, PAGE_START, NONE);
//		panel.add(setorLabel, constraints);
//		setConstraints(1, 6, 1, 1, PAGE_START, NONE);
//		panel.add(setorCombo, constraints);

//		// Tipo Endereco
//		JLabel tipoEnderecoLabel = new JLabel("Endereço:", JLabel.LEFT);
//		setConstraints(0, 7, 1, 1, PAGE_START, NONE);
//		panel.add(tipoEnderecoLabel, constraints);
//
//		ButtonGroup buttonGroup2 = new ButtonGroup();
//		buttonGroup2.add( comercialRadioButton = new JRadioButton("Comercial"));
//		buttonGroup2.add(residencialRadioButton= new JRadioButton("Residencial"));
//
//		JPanel panel3 = new JPanel(new GridBagLayout());
//		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
//		panel3.add(comercialRadioButton, constraints);
//		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
//		panel3.add(residencialRadioButton, constraints);
//		setConstraints(1, 7, 1, 1, PAGE_START, NONE);
//		panel.add(panel3, constraints);

		// CEP
		JLabel cepLabel = new JLabel("CEP:", JLabel.LEFT);
		setConstraints(0, 8, 1, 1, PAGE_START, NONE);
		panel.add(cepLabel, constraints);
		setConstraints(1, 8, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(cepField,true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Logradouro
		JLabel logradouroLabel = new JLabel("Logradouro:", JLabel.LEFT);
		setConstraints(0, 9, 1, 1, PAGE_START, NONE);
		panel.add(logradouroLabel, constraints);
		setConstraints(1, 9, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(logradouroField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Numero
		JLabel numeroLabel = new JLabel("Numero:", JLabel.LEFT);
		setConstraints(0, 10, 1, 1, PAGE_START, NONE);
		panel.add(numeroLabel, constraints);
		setConstraints(1, 10, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(numeroField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Complemento
		JLabel complementoLabel = new JLabel("Complemento:", JLabel.LEFT);
		setConstraints(0, 11, 1, 1, PAGE_START, NONE);
		panel.add(complementoLabel, constraints);
		setConstraints(1, 11, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(complementoField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Bairro
		JLabel bairroLabel = new JLabel("Bairro:", JLabel.LEFT);
		setConstraints(0, 12, 1, 1, PAGE_START, NONE);
		panel.add(bairroLabel, constraints);
		setConstraints(1, 12, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(bairroField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Cidade
		JLabel cidadeLabel = new JLabel("Cidade:", JLabel.LEFT);
		setConstraints(0, 13, 1, 1, PAGE_START, NONE);
		panel.add(cidadeLabel, constraints);
		setConstraints(1, 13, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(cidadeField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// UF
		ufCombo = new JComboBox();
		ufCombo.addItem("AC");
		ufCombo.addItem("AL");
		ufCombo.addItem("AM");
		ufCombo.addItem("AP");
		ufCombo.addItem("BA");
		ufCombo.addItem("CE");
		ufCombo.addItem("DF");
		ufCombo.addItem("ES");
		ufCombo.addItem("GO");
		ufCombo.addItem("MA");
		ufCombo.addItem("MG");
		ufCombo.addItem("MS");
		ufCombo.addItem("MT");
		ufCombo.addItem("PA");
		ufCombo.addItem("PB");
		ufCombo.addItem("PE");
		ufCombo.addItem("PI");
		ufCombo.addItem("PR");
		ufCombo.addItem("RJ");
		ufCombo.addItem("RN");
		ufCombo.addItem("RO");
		ufCombo.addItem("PR");
		ufCombo.addItem("RR");
		ufCombo.addItem("RS");
		ufCombo.addItem("SC");
		ufCombo.addItem("SE");
		ufCombo.addItem("SP");
		ufCombo.addItem("TO");
		
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
		panel4.add(getValidatorComponent(ddd1Field, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel4.add(getValidatorComponent(tel1Field, true, ValidatorConstants.VALIDFOR_TIT), constraints);


		setConstraints(1, 15, 1, 1, PAGE_START, NONE);
		panel.add(panel4, constraints);

		// Telefone 2
		JLabel tel2Label = new JLabel("Telefone 2:", JLabel.LEFT);
		setConstraints(0, 16, 1, 1, PAGE_START, NONE);

		panel.add(tel2Label, constraints);
		JPanel panel5 = new JPanel(new GridBagLayout());

		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel5.add(getValidatorComponent(ddd2Field, true, ValidatorConstants.VALIDFOR_TIT), constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel5.add(getValidatorComponent(tel2Field, true, ValidatorConstants.VALIDFOR_TIT), constraints);
		setConstraints(1, 16, 1, 1, PAGE_START, NONE);
		panel.add(panel5, constraints);

		// FAX
		JLabel faxLabel = new JLabel("FAX:", JLabel.LEFT);
		setConstraints(0, 17, 1, 1, PAGE_START, NONE);
		panel.add(faxLabel, constraints);
		JPanel panel6 = new JPanel(new GridBagLayout());
		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel6.add(getValidatorComponent(dddFaxField, true, ValidatorConstants.VALIDFOR_TIT), constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		
		panel6.add(getValidatorComponent(faxField, true, ValidatorConstants.VALIDFOR_TIT), constraints);
		setConstraints(1, 17, 1, 1, PAGE_START, NONE);
		panel.add(panel6, constraints);

		// Celular
		JLabel celLabel = new JLabel("Celular:", JLabel.LEFT);
		setConstraints(0, 18, 1, 1, PAGE_START, NONE);
		panel.add(celLabel, constraints);
		JPanel panel7 = new JPanel(new GridBagLayout());

		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel7.add(getValidatorComponent(dddCelField, true, ValidatorConstants.VALIDFOR_TIT), constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel7.add(getValidatorComponent(celField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		setConstraints(1, 18, 1, 1, PAGE_START, NONE);
		panel.add(panel7, constraints);

	
		// Email
		JLabel emailLabel = new JLabel("Email:", JLabel.LEFT);
		setConstraints(0, 19, 1, 1, PAGE_START, NONE);
		panel.add(emailLabel, constraints);
		setConstraints(1, 19, 1, 1, PAGE_START, NONE);
		panel.add(getValidatorComponent(emailField, true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Data Nascimento
		JLabel nascLabel = new JLabel("Nascimento:", JLabel.LEFT);
		setConstraints(0, 21, 1, 1, PAGE_START, NONE);
		panel.add(nascLabel, constraints);
		setConstraints(1, 21, 1, 1, PAGE_START, NONE);
		aniversarioDate.setBorder(new LineBorder(Color.BLACK, 1, true));
		panel.add(aniversarioDate, constraints);
		

		// Filhos
		JLabel possuiFilhosLabel = new JLabel("Possui filhos:", JLabel.LEFT);
		setConstraints(0, 23, 1, 1, PAGE_START, NONE);
		panel.add(possuiFilhosLabel, constraints);

		ButtonGroup buttonGroup3 = new ButtonGroup();
		buttonGroup3.add(simRadioButton = new JRadioButton("SIM"));
		buttonGroup3.add(naoRadioButton= new JRadioButton("NAO"));

		JPanel panel10 = new JPanel(new GridBagLayout());
		setConstraints(0, 0, 1, 1, PAGE_START, NONE);
		panel10.add(simRadioButton, constraints);
		setConstraints(1, 0, 1, 1, PAGE_START, NONE);
		panel10.add(naoRadioButton, constraints);
		setConstraints(1, 23, 1, 1, PAGE_START, NONE);
		panel.add(panel10, constraints);
		
		//Profissoes
		JLabel profissaoLabel = new JLabel("Profissão:", JLabel.LEFT);
		setConstraints(0, 24, 1, 1, PAGE_START, NONE);
		panel.add(profissaoLabel, constraints);
		setConstraints(1, 24, 1, 1, PAGE_START, NONE);
		panel.add(profissaoField, constraints);
		
		JLabel admissaoLabel = new JLabel("Data Admissão:", JLabel.LEFT);
		setConstraints(0, 25, 1, 1, PAGE_START, NONE);
		panel.add(admissaoLabel, constraints);
		setConstraints(1, 25, 1, 1, PAGE_START, NONE);
		panel.add(admissaoDate, constraints);

		// Lazer 1
		JLabel lazer1Label = new JLabel("Lazer 1:", JLabel.LEFT);
		setConstraints(0, 26, 1, 1, PAGE_START, NONE);
		panel.add(lazer1Label, constraints);
		setConstraints(1, 26, 1, 1, PAGE_START, NONE);
		panel.add(lazer1Combo, constraints);

		
		JLabel esporteLabel = new JLabel("Esporte:", JLabel.LEFT);
		setConstraints(0, 28, 1, 1, PAGE_START, NONE);
		panel.add(esporteLabel, constraints);
		setConstraints(1, 28, 1, 1, PAGE_START, NONE);
		panel.add(esporteCombo, constraints);

		// Clube
		JLabel clubeLabel = new JLabel("Clube:", JLabel.LEFT);
		setConstraints(0, 29, 1, 1, PAGE_START, NONE);
		panel.add(clubeLabel, constraints);
		setConstraints(1, 29, 1, 1, PAGE_START, NONE);
		panel.add(clubeCombo, constraints);

//		// Crença
//		JLabel crencaLabel = new JLabel("Crença:", JLabel.LEFT);
//		setConstraints(0, 29, 1, 1, PAGE_START, NONE);
//		panel.add(crencaLabel, constraints);
//		setConstraints(1, 29, 1, 1, PAGE_START, NONE);
//		panel.add(crencaCombo, constraints);

//		// Observacao
//		JLabel observacaoLabel = new JLabel("Observação:", JLabel.LEFT);
//		setConstraints(0, 30, 1, 1, PAGE_START, NONE);
//		panel.add(observacaoLabel, constraints);
//		observacao.setLineWrap(true);
//		observacao.setWrapStyleWord(true);
//		setConstraints(1, 30, 1, 1, PAGE_START, NONE);
//		panel.add(new JScrollPane(observacao), constraints);
		
		putComponent(panel);
		JCommandPanel commandPanel = new JCommandPanel(this);
		add(commandPanel, BorderLayout.SOUTH);
	}




//	private Border getLineBorder(String string) {
//		return new TitledBorder(new LineBorder(Color.BLACK, 1), string);
//	}
//
//	private String[] getTrpElements() {
//		TipoRelacaoCTR tipoRelacaoCTR = new TipoRelacaoCTR();
//		tipoRelacaoCTR.setObject(new CrmTipoRelacao());
//		List l = tipoRelacaoCTR.getData();
//		return returnStringArray2(l);
//	}
//
//	private String[] getElements() {
//		ClubeClienteCRT clubeComboData = new ClubeClienteCRT();
//		clubeComboData.setObject(new CrmClubeCliente());
//		List l = clubeComboData.getData();
//		return returnStringArray(l);
//	}
//
//	private String[] returnStringArray(List l) {
//		String[] elements = new String[l.size()];
//		Iterator i = l.iterator();
//		int c = 0;
//		while (i.hasNext()) {
//			elements[c++] = ((CrmClubeCliente) i.next()).getCclTitulo();
//		}
//		return elements;
//	}
//
//	private String[] returnStringArray2(List l) {
//		String[] elements = new String[l.size()];
//		Iterator i = l.iterator();
//		int c = 0;
//		while (i.hasNext()) {
//			elements[c++] = ((CrmTipoRelacao) i.next()).getTirTipoRelacao();
//		}
//		return elements;
//	}

	public void updateGUI() {
		// TODO Auto-generated method stub
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		if (this.controller == null) {
			controller = new ContatoCTR();
		}
		CrmContato contato = new CrmContato();
		contato.setCntNome(nomeField.getText());
		contato.setCntSexo("");//arrumar
		contato.setCntEmpresa((String)empresaCombo.getSelectedItem());

		
		//contato.setCntCargo((String) cargoCombo.getSelectedItem());//arrumar
		contato.setCntCep(cepField.getText());
		contato.setCntLogradouro(logradouroField.getText());
		contato.setCntNumero(numeroField.getText());
		contato.setCntComplemento(complementoField.getText());
		contato.setCntBairo(bairroField.getText());
		contato.setCntCidade(cidadeField.getText());
		contato.setCntUf((String)ufCombo.getSelectedItem());
		contato.setCntTelefone(ddd1Field.getText() + "-" + tel1Field.getText());
		contato.setCntNextel(ddd2Field.getText() + "-" + tel2Field.getText());
		contato.setCntFax(dddFaxField.getText() + "-" + faxField.getText());
		contato.setCntCelular(dddCelField.getText() + "-" + celField.getText());
		contato.setCntEmail(emailField.getText());
		contato.setCntAniversario(aniversarioDate.getDate().toString());
		contato.setCntFilhos("");//arrumar
		contato.setCntProfissao(profissaoField.getText());
		/* FK fields */
		contato.setEmpIdFk(Integer.getInteger(getValueForField("EmpNome", (String)empresaCombo.getSelectedItem())));
		contato.setLazIdFk(lazer1Combo.getSelectedIndex());
		contato.setEspIdFk(esporteCombo.getSelectedIndex());
		contato.setEstIdFk(estiloCombo.getSelectedIndex());
		contato.setCclIdFk(clubeCombo.getSelectedIndex());
		contato.setCrcIdFk(1);
		contato.setPfcIdFk(1);
		contato.setTirIdFk(1);
		//contato.setCnt(admissaoDate.getDate().toString());//arrumar
		contato.setCntLazer(getValueForField("LazTitulo", (String)lazer1Combo.getSelectedItem()));
		contato.setCntEsporte((String)esporteCombo.getSelectedItem());
		
		
		controller.setObject(contato);
		
//		//Clear component
//		produtoField.setText("");
//		descProduto.setText("");
//		return controller;
		return controller;
	}

	public void setColor(Color color) {

	}
}
