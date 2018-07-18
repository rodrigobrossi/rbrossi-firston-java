package br.com.crm.gui.auxiliaries;

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

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.VendedoresCTR;
import br.com.crm.db.CrmVendas;
import br.com.crm.gui.app.AncestorFrame;

public class CadastroVendasView extends AncestorFrame {

	private static final long serialVersionUID = 1L;

	private final String[] numVidas = { "1", "2", "3", "4", "5", "6", "7", "8",
			"9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
			"20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30",
			"31" };

	private JTextField produto = new JTextField(35);

	private JTextArea classificacao = new JTextArea(5, 35);

	private JComboBox numVidasCombo = new JComboBox(numVidas);

	public CadastroVendasView() {
		createGUI();
	}

	public void createGUI() {
		GridBagLayout gridbag = new GridBagLayout();

		JPanel panel = new JPanel();
		panel.setLayout(gridbag);
		panel.setBackground(Color.WHITE);

		// Produto
		JLabel produtoLabel = new JLabel("Produto:");
		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		panel.add(produtoLabel,constraints);
		
		setConstraints(1, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		gridbag.setConstraints(produto, constraints);
		panel.add(produto,constraints);

		// Numero de vidas
		JLabel numVidasLabel = new JLabel("Numero de Vidas:");
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		panel.add(numVidasLabel,constraints);
		
		setConstraints(1, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		panel.add(numVidasCombo, constraints);

		// Classificacao
		JLabel classificacaoLabel = new JLabel("Classificação:");
		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.NONE);
		panel.add(classificacaoLabel,constraints);
		classificacao.setLineWrap(true);
		classificacao.setWrapStyleWord(true);
		classificacao.setBackground(Color.WHITE);
		setConstraints(1, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		panel.add(new JScrollPane(classificacao), constraints);
		
		JPanel center =new JPanel(new BorderLayout());
		center.add(panel, BorderLayout.NORTH);
		putComponent(center);
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		VendedoresCTR salesCtr = new VendedoresCTR();
		CrmVendas vendas = new CrmVendas();

		salesCtr.setObject(vendas);
		super.setAbstractDataBaseCTR(salesCtr);
		return salesCtr;
	}

	public void setColor(Color color) {
		// TODO Auto-generated method stub

	}

	public void updateGUI() {
		this.removeAll();
		this.createGUI();
		this.validate();
		this.repaint();
	}
}
