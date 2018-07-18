package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import br.com.crm.components.calendar.JDateChooser;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.VendedoresCTR;
import br.com.crm.db.CrmVendedores;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.results.VendedoresResults;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

/**
 * @author Alexandre Rezende Romero
 * @version 1.0
 *
 */
public class CadastroVendedoresView extends AncestorFrame {

	private static final long serialVersionUID = 1L;

	private JTextField vendedorField = new JTextField(30);

	private JTextArea observacoes = new JTextArea(5, 30);

	private JPasswordField senhaVenda = new JPasswordField(15);

	private JPasswordField senhaVendaConfirma = new JPasswordField(15);

	private JDateChooser admission = new JDateChooser();
	
	private JPanel content;

	public CadastroVendedoresView() {
		createGUI();
	}

	public void createGUI() {
		GridBagLayout gridbag = new GridBagLayout();

		content = new JPanel();
		content.setLayout(gridbag);

		// Vendedor
		ValidatorDecorator vVendedor = new ValidatorDecorator(vendedorField, true, ValidatorConstants.VALIDFOR_TIT);
		//vendedorField.setName(ValidatorConstants.VALIDFOR_TIT);
		addComponent(0,0,"Vendedor:",vVendedor);
		
//		JLabel vendedorLabel = new JLabel("Vendedor:");
//		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
//		content.add(vendedorLabel,constraints);
//		setConstraints(1, 0, 1,1, GridBagConstraints.PAGE_START,GridBagConstraints.NONE);
//		content.add(vendedor,constraints);

		// DataControlInterface Adimissão
		JLabel dataAdmissaoLabel = new JLabel("Data de Admissão:");
		admission.setEnabled(true);
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		content.add(dataAdmissaoLabel, constraints);
		setConstraints(1, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		content.add(admission, constraints);

		// Senha Venda
		JLabel senhaVendaLabel = new JLabel("Senha Venda:");
		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		content.add(senhaVendaLabel, constraints);
		setConstraints(1, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		content.add(senhaVenda,constraints);

		// Confirma Senha Venda
		JLabel senhaVendaConfirmaLabel = new JLabel("Confirma Senha Venda:");
		setConstraints(0, 3, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		content.add(senhaVendaConfirmaLabel,constraints);
		setConstraints(1, 3, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		content.add(senhaVendaConfirma,constraints);
		
		//Observacoes
		observacoes.setLineWrap(true);
		observacoes.setWrapStyleWord(true);
		observacoes.setBackground(Color.WHITE);
		JLabel observacoesLabel = new JLabel("Observações:");
		setConstraints(0, 4, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		content.add(observacoesLabel,constraints);
		setConstraints(1, 4, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		content.add(new JScrollPane(observacoes), constraints);
		
		JPanel center = new JPanel(new BorderLayout());
		center.add(content, BorderLayout.NORTH);
		VendedoresResults results = new VendedoresResults();
		MainFrame.addFisrstOnListener(results);
		center.add(results, BorderLayout.CENTER);
		putComponent(center);
	}
	
	private void addComponent(int x, int y, String title, JComponent component) {
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.NONE;
		constraints.weightx = 0.0;
		constraints.gridx = x;
		constraints.gridy = y;
		content.add(new JLabel(title, JLabel.LEFT), constraints);
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.NONE;
		constraints.weightx = 1.0;
		constraints.gridx = x+1;
		constraints.gridy = y;
		content.add(component, constraints);
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		if (this.controller == null) {
			controller = new VendedoresCTR();
		}
		CrmVendedores vendedor = new CrmVendedores();
		vendedor.setVnrVendedor(vendedorField.getText());
		vendedor.setVnrDataAdmissao(admission.getToolTipText());
		vendedor.setVnrSenhaVenda(senhaVenda.getToolTipText());
		vendedor.setVnrSenhaVenda(senhaVendaConfirma.getToolTipText());
		vendedor.setVnrObservacao(observacoes.getText());
		controller.setObject(vendedor);
		
		//Clear component
		vendedorField.setText("");
		admission.setToolTipText("");
		senhaVenda.setToolTipText("");
		senhaVendaConfirma.setToolTipText("");
		observacoes.setText("");
		return controller;
	}

	public void setColor(Color color) {
		this.setBackground(color);
	}

	public void updateGUI() {
		
	}
}
