package br.com.crm.components.search;

import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.Vector;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;

import br.com.crm.control.ContatoCTR;
import br.com.crm.core.ApplicationContext;
import br.com.crm.core.ContactInfo;
import br.com.crm.db.CrmContato;
import br.com.crm.gui.NavigatorPanel;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

public class SearchFrame extends JPanel implements ActionListener,
		TableModelListener, MouseListener, KeyListener {

	/**
	 * Serial version Id
	 */
	private static final long serialVersionUID = 4569627347640202448L;

	/**
	 * Command search.
	 */
	private static final String COMMAND_SEARCH = "Search";

	/**
	 * Clean Command
	 */
	private static final String COMMAND_CLEAN = "Clean";

	/**
	 * This is the main Panel
	 */
	private JPanel results;
	/**
	 * Search Panel for a specific law profile.
	 */
	private JPanel searchP1Panel;
	/**
	 * Search Panel for a specific law profile.
	 */
	private JPanel searchP2Panel;

	private JTextField nameField = new JTextField(100);

	private JTextField phoneField = new JTextField(100);

	/**
	 * This field is originally used to represents the company id under the
	 * Brazil states law, a.k.a CNPJ
	 */
	private JTextField id1Field = new JTextField(100);

	/**
	 * This field is originally used to represents the CPF (personal ID) under
	 * Brazil states law.
	 */
	private JTextField id2Field = new JTextField(100);

	private static final ArrayList filters = new ArrayList();

	/**
	 * Table of results, that will show all records.
	 */
	private JTable table;

	private JButton searchButton = new JButton(Messages
			.getString(I18NGUIMessage.SEARCH_PANEL_SEARCH));

	private JButton limparButton = new JButton(Messages
			.getString(I18NGUIMessage.SEARCH_PANEL_CLEAN));

	private GridBagConstraints constraints = new GridBagConstraints();;

	public SearchFrame() {

		this.setLayout(new GridBagLayout());
		this.setBackground(Color.WHITE);
		table = new JTable(new SearchTableModel(searchUsers()));
		// Create Tabs

		JPanel panel = new JPanel();
		panel.setLayout(new GridBagLayout());
		panel.setBackground(Color.WHITE);

		JPanel panelButtons = new JPanel();
		panelButtons.setLayout(new GridBagLayout());
		panelButtons.setBackground(Color.WHITE);

		searchP1Panel = new JPanel();
		searchP1Panel.setLayout(new GridBagLayout());
		searchP1Panel.setBackground(Color.WHITE);

		searchP2Panel = new JPanel();
		searchP2Panel.setLayout(new GridBagLayout());
		searchP2Panel.setBackground(Color.WHITE);

		// Resultados
		results = new JPanel();
		results.setLayout(new GridBagLayout());
		results.setBackground(Color.WHITE);
		results.setBorder(new TitledBorder(new LineBorder(Color.BLACK),	"Resultados da Busca"));
		setConstraints(0, 0, 1, 1, GridBagConstraints.CENTER,GridBagConstraints.BOTH);
		constraints.weightx = 1.0;
		constraints.weighty = 1.0;
		table.setShowHorizontalLines(false);
		table.setShowVerticalLines(false);
		table.setRowHeight(33);
		table.setBackground(Color.WHITE);
		table.getColumnModel().getColumn(0).setCellRenderer(new SearchTableCellRenderer());
		results.add(new JScrollPane(table), constraints);
		
		setConstraints(0, 1, 1, 1, GridBagConstraints.CENTER,GridBagConstraints.BOTH);
		constraints.weightx = 1.0;
		constraints.weighty = 1.0;
		NavigatorPanel nav = new NavigatorPanel();
		results.add(nav, constraints);
		constraints.weighty = 0.0;

		constraints.insets = new Insets(5, 5, 5, 5);
		panel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),"Filtro"));
		

		
		// FIXME localization
		JLabel nomeLabel = new JLabel("Name");
		setConstraints(0, 1, 1, 1, GridBagConstraints.WEST,GridBagConstraints.NONE);
		searchP1Panel.add(nomeLabel, constraints);
		setConstraints(0, 2, 1, 1, GridBagConstraints.WEST,GridBagConstraints.HORIZONTAL);
		nameField.addKeyListener(this);
		searchP1Panel.add(nameField, constraints);

		// FIXME localization
		JLabel telLabel = new JLabel("Telefone/Fax");
		setConstraints(0, 3, 1, 1, GridBagConstraints.WEST,GridBagConstraints.NONE);
		searchP1Panel.add(telLabel, constraints);
		setConstraints(0, 4, 1, 1, GridBagConstraints.WEST,GridBagConstraints.HORIZONTAL);
		searchP1Panel.add(phoneField, constraints);

		// FIXME localization
		JLabel razaoLabel = new JLabel("Razão Social");
		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		searchP2Panel.add(razaoLabel, constraints);
		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		searchP2Panel.add(id1Field, constraints);

		// FIXME localization
		JLabel cnpjLabel = new JLabel("CNPJ");
		setConstraints(0, 3, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		searchP2Panel.add(cnpjLabel, constraints);
		setConstraints(0, 4, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		searchP2Panel.add(id2Field, constraints);
		searchP2Panel.setBorder(null);

		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,GridBagConstraints.BOTH);
		panel.setOpaque(false);

		// Pesquisar
		constraints.weightx = 0.0;
		searchButton.addActionListener(this);
		searchButton.setActionCommand(COMMAND_SEARCH);

		setConstraints(0, 1, 2, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		panelButtons.add(this.nameField, constraints);

		setConstraints(1, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		panelButtons.add(searchButton, constraints);

		// Limpar
		limparButton.addActionListener(this);
		limparButton.setActionCommand(COMMAND_CLEAN);
		limparButton.setPreferredSize(searchButton.getPreferredSize());
		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		panelButtons.add(limparButton, constraints);

		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.BOTH);
		panel.add(panelButtons, constraints);

		setConstraints(0, 0, 1, 1, GridBagConstraints.FIRST_LINE_START,	GridBagConstraints.NONE);
		this.add(CRMComponentsUtils.createHeader("Busca",	ViewConstants.CRM_HEADER_SUB_TITLE,"../util/resources/images/search_contact_icon.gif"),
				constraints);

		setConstraints(0, 1, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		this.add(panel, constraints);

		constraints.weightx = 1.0;
		constraints.weighty = 1.0;

		setConstraints(0, 2, 1, 1, GridBagConstraints.FIRST_LINE_START,
				GridBagConstraints.BOTH);
		this.add(results, constraints);

	}

	private void setConstraints(int x, int y, int width, int height,
			int anchor, int fill) {
		constraints.gridx = x;
		constraints.gridy = y;
		constraints.gridwidth = width;
		constraints.gridheight = height;
		constraints.anchor = anchor;
		constraints.fill = fill;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * java.awt.event.ActionListeneractionPerformed(java.awt.event.ActionEvent)
	 */
	public void actionPerformed(ActionEvent e) {

		if (e.getActionCommand().equals(COMMAND_SEARCH)) {
			search();

		} else if (e.getActionCommand().equals(COMMAND_CLEAN)) {
			cleanSelectedForm();
		}
	}

	/**
	 * 
	 */
	private void search() {
		if (table != null) {
			((SearchTableModel) table.getModel()).removeAll();
		}
		((SearchTableModel) table.getModel()).setAssets(searchUsers());
	}

	/**
	 * Clean forms.
	 */
	private void cleanSelectedForm() {
		nameField.setText("");
		phoneField.setText("");
		id1Field.setText("");
		id2Field.setText("");
	}

	/**
	 * Search for a user.
	 * 
	 * @return A List with all user selected
	 */
	private String[][] searchUsers() {

		if (table == null)
			return new String[][] {};
		if (table.getModel() == null)
			return new String[][] {};

		int rows = table.getModel().getRowCount();

		table.getModel().addTableModelListener(this);
		table.addMouseListener(this);

		for (int i = 0; i < rows; i++) {
			table.setValueAt("", i, 0);
			//table.setValueAt("", i, 1);
		}
		String name = nameField.getText();
		ContatoCTR contatosCtr = new ContatoCTR(); // Instantiate Elements
		CrmContato contatos = (CrmContato) contatosCtr.add(); //
		String[][] result = CRMComponentsUtils.getElementsFrom(contatosCtr.getData(), "Id","CntNome");

		return getStringArray(result, nameField.getText());
	}

	/**
	 * @param maps
	 * @param name
	 * @return
	 */
	private String[][] getStringArray(String[][] str, String name) {

		String str1 = name.toLowerCase();

		Vector search = new Vector();

		for (int i = 0; i < str.length; i++) {
			String str2 = str[i][1].toLowerCase();
			if (str2.startsWith(str1))
				search.add(str[i]);
		}
		String[][] array = new String[search.size()][];
		search.copyInto(array);
		return array;
	}

	public void tableChanged(TableModelEvent tablemodelevent) {
		System.out.println(tablemodelevent.getSource());
		System.out.println(""+tablemodelevent.getSource());
		select();
	}

	public void mouseClicked(MouseEvent e) {
		System.out.println("ROW SELECTED 1" + e.getSource().toString());
		//select();
	}

	public void mouseEntered(MouseEvent e) {
		System.out.println("ROW SELECTED 2" + e.getSource().toString());
		//select();
	}

	public void mouseExited(MouseEvent e) {
		System.out.println("ROW SELECTED 3" + e.getSource().toString());
		//select();
	}

	public void mousePressed(MouseEvent e) {
		System.out.println("ROW SELECTED 4" + e.getSource().toString());
		select();
	}

	public void mouseReleased(MouseEvent e) {
		System.out.println("ROW SELECTED 5" + e.getSource().toString());
		//select();
	}

	public void select() {
		int select = table.getSelectedRow();
		String code = null;
		String name = null;
		if (select >= 0) {
			code = table.getModel().getValueAt(select, 0).toString();
			name = table.getModel().getValueAt(select, 1).toString();

			JPopupMenu j = new JPopupMenu();
			j.add(new JMenuItem("Test "+code+" "+name));
			j.setBounds(0, 0, 500, 500);
		}
		
		System.out.println("[BROSSI DEBUG]Clique aqui "+ name +" "+code);
		ContactInfo contactInfo = new ContactInfo();
		contactInfo.setCode(code==null?"[code]":code);
		contactInfo.setName(name==null?"[name]":name);
		ApplicationContext.getInstance().setContatcInfo(contactInfo);
	}

	public void keyPressed(KeyEvent e) {
		search();
	}

	public void keyReleased(KeyEvent e) {
		//search();
	}

	public void keyTyped(KeyEvent e) {
		search();
	}
}