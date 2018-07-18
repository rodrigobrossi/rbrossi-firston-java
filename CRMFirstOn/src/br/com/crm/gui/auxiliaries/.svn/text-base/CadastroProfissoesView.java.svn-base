package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.util.Iterator;
import java.util.List;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import br.com.crm.components.calendar.JDateChooser;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.ProfissaoClienteCTR;
import br.com.crm.db.CrmProfissaoCliente;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.results.ProfissaoClienteResults;

/**
 * 
 * @author Rodrigo Rocha Costa
 * @version 1.0
 * 
 */
public class CadastroProfissoesView extends AncestorFrame {

	/**
	 * Serial ID
	 */
	private static final long serialVersionUID = 1L;

	private JTextArea observacao = new JTextArea(5, 35);

	private JTextArea dicaRelacionamento = new JTextArea(5, 35);

	private JDateChooser dia = new JDateChooser();

	private JDateChooser mes = new JDateChooser();

	private JTextField profissao = null;

	public CadastroProfissoesView() {
		createGUI();
	}

	public void createGUI() {
		this.setLayout(new BorderLayout());
		GridBagLayout gridbag = new GridBagLayout();

		JPanel panel = new JPanel();
		panel.setLayout(gridbag);
		panel.setBackground(Color.WHITE);
		mes.setEnabled(true);
		mes.setFocusable(true);

		// Profissoes
		JLabel profissaoLabel = new JLabel("Profissão:");
		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);

		panel.add(profissaoLabel, constraints);
		setConstraints(1, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);

		profissao = new JTextField(30);
		panel.add(profissao, constraints);

		// Dia & Mes Comemorativo
		JLabel diaComemorativoLabel = new JLabel("Dia Comemorativo:");
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(diaComemorativoLabel, constraints);

		setConstraints(1, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(dia, constraints);

		JLabel mesComemorativoLabel = new JLabel("Mes Comemorativo:");
		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(mesComemorativoLabel, constraints);

		setConstraints(1, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(mes, constraints);

		// Observacao
		JLabel observacaoLabel = new JLabel("Observação:");
		setConstraints(0, 3, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(observacaoLabel, constraints);

		observacao.setLineWrap(true);
		observacao.setWrapStyleWord(true);
		observacao.setBackground(Color.WHITE);
		setConstraints(1, 3, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		panel.add(new JScrollPane(observacao), constraints);

		// Dica Relacionamento
		JLabel dicaRelacionamentoLabel = new JLabel("Dica de Relacionamento:");
		setConstraints(0, 4, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.NONE);
		panel.add(dicaRelacionamentoLabel, constraints);
		dicaRelacionamento.setLineWrap(true);
		dicaRelacionamento.setWrapStyleWord(true);
		dicaRelacionamento.setBackground(Color.WHITE);
		setConstraints(1, 4, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		panel.add(new JScrollPane(dicaRelacionamento), constraints);
		JPanel center =new JPanel(new BorderLayout());
		center.add(panel, BorderLayout.NORTH);
		ProfissaoClienteResults results = new  ProfissaoClienteResults();
		MainFrame.addFisrstOnListener(results);
		center.add(results, BorderLayout.CENTER);
		putComponent(center);

	}

	/**
	 * Retorna o númeoro de profissoes de um kara
	 * @return String[] contendo o nome dos profissionais
	 */
	private String[] getProfissoes() {
		//TODO Registrar os componentes em um map para fazer a busca posteriormente do kara selecionado
		ProfissaoClienteCTR profissoes = new ProfissaoClienteCTR();
		profissoes.setObject(new CrmProfissaoCliente());
		List list = profissoes.getData();
		Iterator i = list.iterator();
		String[] profs = new String[list.size()];
		for (int x = 0; i.hasNext(); x++) {
			CrmProfissaoCliente obj = (CrmProfissaoCliente) i.next();
			profs[x] = obj.getPfcTitulo();
		}
		return profs;
	}

	/* (non-Javadoc)
	 * @see br.com.crm.gui.app.AncestorFrame#loadPersistentObject()
	 * 
	 */
	public AbstractDataBaseCTR loadPersistentObject() {
		ProfissaoClienteCTR profissoes = new ProfissaoClienteCTR();
		CrmProfissaoCliente prof = new CrmProfissaoCliente();
		prof.setPfcDcaRelacionamento(this.dicaRelacionamento.getText());
		prof.setPfcTitulo(profissao.getText());
		prof.setPfcDiaComemorativo("" + this.dia.getDate().getDay());
		prof.setPfcMesComemorativo("" + this.dia.getDate().getMonth());
		profissoes.setObject(prof);
		super.setAbstractDataBaseCTR(profissoes);
		return profissoes;
	}

	public void setColor(Color color) {
		// TODO Auto-generated method stub

	}

	public void updateGUI() {
		// TODO Auto-generated method stub

	}

}
