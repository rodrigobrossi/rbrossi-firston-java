package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.text.SimpleDateFormat;

import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;

import com.sun.org.apache.xerces.internal.impl.dv.ValidationContext;

import br.com.crm.components.calendar.JDateChooser;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.EmpresasCTR;
import br.com.crm.db.CrmEmpresas;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

public class CadastroEmpresaView extends AncestorFrame {

	private static final long serialVersionUID = 1L;

	private JTextField emp_ddd;

	private JTextField emp_telefone1;

	private JTextField emp_telefone2;

	private JTextField emp_fax;

	private JTextField emp_email;

	private JTextField emp_website;

	private JTextField emp_condicao_pagamento;

	private JTextArea emp_observacao;

	private JTextField emp_num_benefciarios;

	private JTextArea emp_produto;

	private JDateChooser emp_data_contrato;

	private JTextField emp_preco;

	private JComboBox emp_subsidia_para_funcionario;

	private JTextField emp_valor_fatura;

	private JTextField emp_porcentagem_ultimo_reajuste;

	private JTextArea emp_qualificacao_margem;

	private JTextArea emp_beneficicios_agregados;

	private JTextArea emp_caixa_postal;

	private JDateChooser emp_data_ultimo_reajuste;

	private JPanel cadastro;

	private JPanel cadastro2;

	private JPanel mainPanel;

	public CadastroEmpresaView() {
		createGUI();

	}

	public void createGUI() {

		if (mainPanel == null)
			mainPanel = new JPanel(new BorderLayout());
		else
			mainPanel.setLayout(new BorderLayout());

		cadastro = new JPanel(new GridBagLayout());
		cadastro.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),
				"Endereço da empresa"));

		// Initialize components
		emp_ddd = new JTextField(3);
		//emp_ddd.setName(ValidatorConstants.VALIDFOR_DDD);
		addComponent(0, 0, "DDD:", new ValidatorDecorator(emp_ddd,true,ValidatorConstants.VALIDFOR_TIT));

		emp_telefone1 = new JTextField(8);
		//emp_telefone1.setName(ValidatorConstants.VALIDFOR_TEL);
		addComponent(0, 2, "Telefone 1:", new ValidatorDecorator(emp_telefone1,	true, ValidatorConstants.VALIDFOR_TIT));

		emp_fax = new JTextField(8);
		//emp_fax.setName(ValidatorConstants.VALIDFOR_TEL);
		addComponent(0, 4, "Fax:",  new ValidatorDecorator(emp_fax,false, ValidatorConstants.VALIDFOR_TIT));

		
		emp_telefone2 = new JTextField(8);
		//emp_telefone2.setName(ValidatorConstants.VALIDFOR_TEL);
		addComponent(0, 6, "Telefone 2:", new ValidatorDecorator(emp_telefone2,false, ValidatorConstants.VALIDFOR_TIT));

		mainPanel.add(cadastro, BorderLayout.NORTH);

		cadastro2 = new JPanel(new GridBagLayout());

		emp_email = new JTextField(30);
		//emp_email.setName(ValidatorConstants.VALIDFOR_EMAIL);
		addComponent2(0, 0, "Email:", new ValidatorDecorator(emp_email,false,ValidatorConstants.VALIDFOR_TIT));

		emp_website = new JTextField(30);
		//emp_website.setName(ValidatorConstants.VALIDFOR_HTTP);
		addComponent2(2, 0, "Web site:", new ValidatorDecorator(emp_website,false, ValidatorConstants.VALIDFOR_TIT));

		/* FIXME change it to a combo box */
		emp_condicao_pagamento = new JTextField(30);
		addComponent2(0, 2, "Condição do pagamento:", emp_condicao_pagamento);

		emp_num_benefciarios = new JTextField(3);
		//emp_num_benefciarios.setName(ValidatorConstants.VALIDFOR_NUMERIC_1);
		addComponent2(2, 2, "Número de beneficiarios:", new ValidatorDecorator(
				emp_num_benefciarios,true,ValidatorConstants.VALIDFOR_TIT));

		emp_observacao = new JTextArea(5, 30);
		addComponent2(0, 4, "Observaçao:", new JScrollPane(emp_observacao));

		/* FIXME should be a combo from populate with DB data */
		emp_produto = new JTextArea(5, 30);
		addComponent2(2, 4, "Produtos:", new JScrollPane(emp_produto));

		emp_data_contrato = new JDateChooser();
		addComponent2(0, 6, "Data do Contrato:", emp_data_contrato);

		emp_preco = new JTextField(10);
	//	emp_preco.setName(ValidatorConstants.VALIDFOR_PRICE);
		addComponent2(2, 6, "Preço:", new ValidatorDecorator(emp_preco,true,ValidatorConstants.VALIDFOR_TIT));

		emp_subsidia_para_funcionario = new JComboBox(new String[] { "SIM",
				"NAO" });
		addComponent2(0, 8, "Subsidia para funcionario:",
				emp_subsidia_para_funcionario);

		emp_valor_fatura = new JTextField(10);
		//emp_valor_fatura.setName(ValidatorConstants.VALIDFOR_PRICE);
		addComponent2(2, 8, "Valor da fatura:", new ValidatorDecorator(
				emp_valor_fatura,true,ValidatorConstants.VALIDFOR_TIT));

		emp_data_ultimo_reajuste = new JDateChooser();
		addComponent2(0, 10, "Data ultimo reajuste:", emp_data_ultimo_reajuste);

		emp_porcentagem_ultimo_reajuste = new JTextField(3);
		//emp_porcentagem_ultimo_reajuste	.setName(ValidatorConstants.VALIDFOR_NUMERIC_3);
		addComponent2(2, 10, "Porcentagem ultimo reajuste:",
				new ValidatorDecorator(emp_porcentagem_ultimo_reajuste,true,ValidatorConstants.VALIDFOR_TIT));

		/* TODO Ask Garcia how to do that */
		emp_qualificacao_margem = new JTextArea(5, 30);
		addComponent2(0, 12, "Qualificação e margem:", new JScrollPane(
				emp_qualificacao_margem));

		/* TODO Ask Garcia how to do that */
		emp_beneficicios_agregados = new JTextArea(5, 30);
		addComponent2(2, 12, "Benefícios agregados:", new JScrollPane(
				emp_beneficicios_agregados));
		
		/* TODO Ask Garcia how to do that */
		emp_caixa_postal = new JTextArea(5, 30);
		addComponent2(0, 14, "Caixa postal:", new JScrollPane(emp_caixa_postal));
		cadastro2.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),"Info gerais"));
		mainPanel.add(cadastro2, BorderLayout.CENTER);
		putComponent(mainPanel);
	}

	private void addComponent(int x, int y, String title, JComponent combo) {
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.NONE;
		constraints.weightx = 0.0;
		constraints.gridx = x;
		constraints.gridy = y;
		cadastro.add(new JLabel(title, JLabel.RIGHT), constraints);
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.HORIZONTAL;
		constraints.weightx = 0.5;
		constraints.gridx = x;
		constraints.gridy = y + 1;
		cadastro.add(combo, constraints);
	}

	private void addComponent2(int x, int y, String title, JComponent combo) {
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.NONE;
		constraints.weightx = 0.0;
		constraints.gridx = x;
		constraints.gridy = y;
		cadastro2.add(new JLabel(title, JLabel.LEFT), constraints);
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.HORIZONTAL;
		constraints.weightx = 1.0;
		constraints.gridx = x;
		constraints.gridy = y + 1;
		cadastro2.add(combo, constraints);
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		if (this.controller == null) {
			controller = new EmpresasCTR();
		}

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyy");
		CrmEmpresas empresa = new CrmEmpresas();
		empresa.setEmpBeneficiciosAgregados(this.emp_beneficicios_agregados
				.getText());
		empresa.setEmpCaixaPostal(emp_caixa_postal.getText());
		empresa.setEmpCondicaoPagamento(this.emp_condicao_pagamento.getText());
		empresa.setEmpDataContrato(sdf.format(emp_data_contrato.getDate()));
		empresa.setEmpDataUltimoReajuste(sdf.format(emp_data_ultimo_reajuste
				.getDate()));
		empresa.setEmpDdd(emp_ddd.getText());
		empresa.setEmpEmail(emp_email.getText());
		empresa.setEmpFax(emp_fax.getText());
		empresa.setEmpNumBenefciarios(emp_num_benefciarios.getText());
		empresa.setEmpObservacao(emp_observacao.getText());
		empresa.setEmpPorcentagemUltimoReajuste(emp_porcentagem_ultimo_reajuste
				.getText());
		empresa.setEmpPreco(emp_preco.getText());
		empresa.setEmpProduto(emp_produto.getText());
		empresa.setEmpQualificacaoMargem(emp_qualificacao_margem.getText());
		empresa
				.setEmpSubsidiaParaFuncionario((String) emp_subsidia_para_funcionario
						.getSelectedItem());
		empresa.setEmpTelefone1(emp_telefone1.getText());
		empresa.setEmpTelefone2(emp_telefone2.getText());
		empresa.setEmpValorFatura(emp_valor_fatura.getText());
		empresa.setEmpWebsite(emp_website.getText());
		controller.setObject(empresa);
		this.cleanForm();

		return controller;
	}

	public void setColor(Color color) {
		this.setBackground(color);
	}

	public void updateGUI() {

	}

	public void cleanForm() {
		emp_caixa_postal.setText("");
		emp_ddd.setText("");
		emp_telefone1.setText("");
		emp_telefone2.setText("");
		emp_fax.setText("");
		emp_email.setText("");
		emp_website.setText("");
		emp_condicao_pagamento.setText("");
		emp_observacao.setText("");
		emp_num_benefciarios.setText("");
		emp_produto.setText("");
		emp_data_contrato.setDate(null);
		emp_beneficicios_agregados.setText("");
		emp_preco.setText("");
		emp_subsidia_para_funcionario.setSelectedIndex(0);
		emp_valor_fatura.setText("");
		emp_qualificacao_margem.setText("");
		emp_data_ultimo_reajuste.setDate(null);
		emp_porcentagem_ultimo_reajuste.setText("");

	}

}
