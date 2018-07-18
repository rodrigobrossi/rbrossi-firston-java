package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.ClubeClienteCRT;
import br.com.crm.db.CrmClubeCliente;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.validation.ValidatorConstants;
import br.com.crm.validation.ValidatorDecorator;

/**
 * Rodrigo Luis Nolli Brossi
 * 
 * @author wrb051
 * @version 1.0
 */
public class CadastroClubeClienteView extends AncestorFrame {

	private static final long serialVersionUID = -7384172944530564139L;

	private JTextField tituloField = new JTextField(35);
	
	private JTextArea observacao = new JTextArea(5, 35);

	public CadastroClubeClienteView() {

		JPanel panel = new JPanel(new GridBagLayout());
		
		// Tipo Relacao
		JLabel tituloLabel = new JLabel("Titulo:");
		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		panel.add(tituloLabel, constraints);
		setConstraints(1, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		panel.add(new ValidatorDecorator(tituloField,true, ValidatorConstants.VALIDFOR_TIT), constraints);

		// Observacao
		JLabel observacaoLabel = new JLabel("Observação:");
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		panel.add(observacaoLabel, constraints);
		observacao.setLineWrap(true);
		observacao.setWrapStyleWord(true);
		observacao.setBackground(Color.WHITE);
		setConstraints(1, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		panel.add(new JScrollPane(observacao), constraints);
		//Centralize panel
		JPanel center = new JPanel(new BorderLayout());
		center.add(panel, BorderLayout.NORTH);
		putComponent(center);
		
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#createGUI()
	 */
	public void createGUI() {

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#loadPersistentObject()
	 */
	public AbstractDataBaseCTR loadPersistentObject() {
		/* Create a Object */
		ClubeClienteCRT ccCTR = new ClubeClienteCRT();
		CrmClubeCliente clubeCliente = new CrmClubeCliente();
		clubeCliente.setCclTitulo(tituloField.getText());
		clubeCliente.setCclObservacao(observacao.getText());
		/* Set a persisten obeject to a controler */
		ccCTR.setObject(clubeCliente);
		/* Set to super, an object to keep a reference for this element */
		super.setAbstractDataBaseCTR(ccCTR);
		return ccCTR;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#setColor(java.awt.Color)
	 */
	public void setColor(Color color) {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#updateGUI()
	 */
	public void updateGUI() {
	}

}
