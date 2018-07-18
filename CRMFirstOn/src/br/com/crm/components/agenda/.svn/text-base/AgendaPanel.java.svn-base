package br.com.crm.components.agenda;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JToggleButton;
import javax.swing.JToolBar;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;

import br.com.crm.components.agenda.tasks.TaskForAgenda;
import br.com.crm.components.calendar.JDatePicker;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.core.ApplicationContext;
import br.com.crm.core.ContactInfo;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0 
 * 
 * This Class is part of the FirstOn Relationship.
 * The Agenda schedule meetings and other kind of events and is a separated 
 * plug in of this entire software But is not finished in yet
 */
public class AgendaPanel extends AncestorFrame implements ActionListener {

	private static final long serialVersionUID = 5040835283705551812L;

	private JDatePicker calendar1;

	private String date;

	private JTable table;

	private JPanel panel;
	
	private JToolBar toolbar;
	
	private ContactInfo contactInfo;

	private JLabel name;
	private JLabel code;

	public ContactInfo getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(ContactInfo contactInfo) {
		this.contactInfo = contactInfo;
	}

	public AgendaPanel() {

		GridBagConstraints c = new GridBagConstraints();

		JPanel mainPanel = new JPanel(new BorderLayout());

		JPanel contactInfo = new JPanel(new GridLayout(2,2));
		
		JPanel textEditor = new JPanel(new BorderLayout());
		toolbar=new JToolBar(JToolBar.HORIZONTAL);
		

		contactInfo.setBorder(new TitledBorder(new LineBorder(Color.blue, 1),"Contact Info"));
		name = new JLabel("");
		contactInfo.add(new JLabel("Contact Name: "));
		contactInfo.add(name);
		code = new JLabel("");
		contactInfo.add(new JLabel("Contact Code: "));
		contactInfo.add(code);

		c.insets = new Insets(5, 0, 0, 0);
		this.setLayout(new GridBagLayout());
		JPanel calendars = createCalendars();
		calendars.setOpaque(false);
		c.anchor = GridBagConstraints.FIRST_LINE_START;
		c.gridx = 0;
		c.gridy = 0;

		mainPanel.add(calendars, BorderLayout.NORTH);
		mainPanel.add(contactInfo, BorderLayout.CENTER);

		this.add(mainPanel, c);

		c.gridx = 1;
		c.gridy = 0;
		c.fill = GridBagConstraints.BOTH;
		c.weightx = 1.0;
		c.weighty = 1.0;
		c.insets = new Insets(5, 0, 0, 0);
		this.add(createWeekComments(), c);

		c.gridx = 0;
		c.gridy = 1;
		c.fill = GridBagConstraints.BOTH;
		c.weightx = 1.0;
		c.weighty = 1.0;
		c.gridwidth = 2;
		c.insets = new Insets(5, 0, 0, 0);
		
		JToggleButton b = new JToggleButton("Insert Text");
		
		toolbar.add(b);
		toolbar.add(new JComboBox(new String[]{"Arial","Verdana","Comin Sans MS"}));
		toolbar.add(new JButton("B"));
		toolbar.add(new JButton("I"));
		textEditor.add(toolbar,BorderLayout.NORTH);
		textEditor.add(new JScrollPane(new JTextArea(50, 30)), BorderLayout.CENTER);
		
		this.add(textEditor,c);
		/* Never forget that */
		MainFrame.addFisrstOnListener(this);
	

		// FIXME Create a data base for this panel
	}

	private JPanel createCalendars() {
		JPanel calendars = new JPanel(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.NONE;
		c.insets = new Insets(5, 2, 0, 2);
		c.anchor = GridBagConstraints.FIRST_LINE_START;
		c.gridx = 0;
		c.gridy = 0;
		calendar1 = new JDatePicker();
		calendar1.addActionListener(this);
		calendars.add(calendar1, c);

		Date d = new Date();
		calendar1.setDate(d);
		return calendars;
	}

	/**
	 * @return
	 */
	private Component createWeekComments() {
		panel = new JPanel();
		List<TaskForAgenda> l = new ArrayList<TaskForAgenda>();

		for (int i = 0; i < 24; i++) {
			l.add(new TaskForAgenda("click to add a event", null, null,
					new Integer(1)));
		}

		table = new JTable(new AgendaTableModel(l));

		table.getColumnModel().getColumn(0).setCellRenderer(
				new AgendaTableCellRenderer(table));
		table.getColumnModel().getColumn(1).setCellRenderer(
				new AgendaTableCellRenderer(table));

		table.setRowHeight(32);
		table.getColumnModel().getColumn(0).setWidth(10);
		table.setAutoResizeMode(JTable.AUTO_RESIZE_LAST_COLUMN);
		table.getColumnModel().getColumn(0).setMaxWidth(40);

		table.setGridColor(Color.DARK_GRAY);
		table.setBackground(Color.LIGHT_GRAY);
		table.setAutoscrolls(true);
		table.setToolTipText("Ageenda");
		table.getTableHeader().setDefaultRenderer(
				new AgendaTableHeaderRenderer(table.getTableHeader()));

		panel.setLayout(new BorderLayout());
		GridBagConstraints constraits = new GridBagConstraints();
		constraits.anchor = GridBagConstraints.WEST;
		constraits.fill = GridBagConstraints.BOTH;
		constraits.weightx = 1.0f;
		constraits.weighty = 1.0f;
		constraits.insets = new Insets(5, 5, 5, 5);

		JPanel panelTest = new JPanel();
		panelTest.setLayout(new GridBagLayout());
		constraits.gridx = 0;
		constraits.gridy = 0;
		panelTest.add(new JScrollPane(table), constraits);
		panelTest.setOpaque(false);

		panel.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),
				"Contact management hystory:"));
		panel.add(panelTest, BorderLayout.CENTER);
		return panel;
	}

	public void createGUI() {
		// TODO Auto-generated method stub

	}

	public void updateGUI() {
		updateContactInfoInformation();

	}

	private void updateContactInfoInformation() {
		this.contactInfo = ApplicationContext.getInstance().getContatcInfo();
		if(name!=null){
			String sname = this.contactInfo.getName();
			sname = sname.trim();
			int size = sname.length();
			
			name.setToolTipText(sname);
			if(size > 10){
				sname = sname.substring(0,9)+"...";
				
			}
			name.setText(sname);
			
			String scode = this.contactInfo.getCode();
			code.setText(scode);
		}
		this.validate();
		this.repaint();
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		return null;
	}

	public void setColor(Color color) {
		// TODO Auto-generated method stub
	}

	public void actionPerformed(ActionEvent e) {
		// FIXME Correct the action listener
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}