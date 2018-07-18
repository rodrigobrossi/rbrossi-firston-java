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
import br.com.crm.control.TipoRelacaoCTR;
import br.com.crm.db.CrmTipoRelacao;
import br.com.crm.db.hb.PersistentObject;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.results.TipoRelacaoResults;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

public class CadastroTipoRelacaoView extends AncestorFrame {

	private static final long serialVersionUID = 1L;

	private JTextField tipoRelacaoField = new JTextField(10);

	private JTextArea observacao = new JTextArea(5, 35);

	private JPanel content;

	private TipoRelacaoResults results;

	public CadastroTipoRelacaoView() {
		createGUI();
	}

	public void createGUI() {
		content = new JPanel(new GridBagLayout());
		
		ValidatorDecorator vtipoRelacao = new ValidatorDecorator(tipoRelacaoField,true,ValidatorConstants.VALIDFOR_TIT);
//		tipoRelacaoField.setName(ValidatorConstants.VALIDFOR_TIT);
		addComponent(0,0,"Título:",vtipoRelacao);
		
		observacao.setLineWrap(true);
		observacao.setWrapStyleWord(true);
		observacao.setBackground(Color.WHITE);
		addComponent(0,1,"Descrição:",new JScrollPane(observacao));
		
		content.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),"Cadastro:"));
		content.setBounds(0, 0, 200, 200);
		JPanel center =new JPanel(new BorderLayout());
		center.add(content, BorderLayout.NORTH);
		results = new  TipoRelacaoResults();
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
			controller = new TipoRelacaoCTR();
		}
		CrmTipoRelacao tipoRelacao = new CrmTipoRelacao();
		tipoRelacao.setTirTipoRelacao(tipoRelacaoField.getText());
		tipoRelacao.setTirObservacao(observacao.getText());
		controller.setObject(tipoRelacao);
		//Clear component
		tipoRelacaoField.setText("");
		observacao.setText("");
		return controller;
	}
	
	public AbstractDataBaseCTR loadDeleteObject() {
		if (this.controller == null) {
			controller = new TipoRelacaoCTR();
		}
		PersistentObject tipoRelacao = results.getSelectedBean();
		controller.setObject(tipoRelacao);
		//Clear component
		//tipoRelacaoField.setText("");
		//observacao.setText("");
		return controller;
	}

	public void setColor(Color color) {
		this.setBackground(color);
	}

	public void updateGUI() {
		// Refresh
	}
}
