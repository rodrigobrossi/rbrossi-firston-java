package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.ProdutoCTR;
import br.com.crm.db.CrmProduto;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.results.ProdutosResults;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

/**
 * @author Alexandre Rezende Romero
 * @version 1.0
 *
 */
public class CadastroProutosView extends AncestorFrame {

	private static final long serialVersionUID = 1729416638921158318L;

	private JTextField produtoField = new JTextField(30);
	
	private JTextArea descProduto = new JTextArea(5, 35);
	
	private JPanel content;

	public CadastroProutosView() {
		createGUI();
	}

	public void createGUI() {
		content = new JPanel(new GridBagLayout());
		
		ValidatorDecorator vProduto = new ValidatorDecorator(produtoField, true, ValidatorConstants.VALIDFOR_TIT);
		//produtoField.setName(ValidatorConstants.VALIDFOR_TIT);
		addComponent(0,0,"Título:",vProduto);
		
		descProduto.setLineWrap(true);
		descProduto.setWrapStyleWord(true);
		descProduto.setBackground(Color.WHITE);
		addComponent(0,1,"Descrição Produto:",new JScrollPane(descProduto));
		
		content.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),"Cadastro:"));
		content.setBounds(0, 0, 200, 200);
		JPanel center = new JPanel(new BorderLayout());
		center.add(content, BorderLayout.NORTH);
		ProdutosResults results = new ProdutosResults();
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
			controller = new ProdutoCTR();
		}
		CrmProduto prod = new CrmProduto();
		prod.setPrdTitulo(produtoField.getText());
		prod.setPrdDescricao(descProduto.getText());
		controller.setObject(prod);
		//Clear component
		produtoField.setText("");
		descProduto.setText("");
		return controller;
	}

	public void setColor(Color color) {
		this.setBackground(color);
	}

	public void updateGUI() {
		
	}
}
