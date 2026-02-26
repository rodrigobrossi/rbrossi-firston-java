package br.com.crm.components.agenda;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JPanel;

import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

public class Agenda extends JPanel implements ActionListener {

	private static final long serialVersionUID = 1L;

	/**
	 * Constructor
	 */
	public Agenda() {
		super.setLayout(new BorderLayout());
		// Agenda
		JPanel agendaPanel = new JPanel();
		agendaPanel.setLayout(new BorderLayout());
		agendaPanel.setBackground(Color.WHITE);

		AgendaPanel calendar = new AgendaPanel();
		this.setToolTipText(this.getAgendaToolTipText());
		agendaPanel.add(calendar);
		// Cadastro Tabs
		this.add(CRMComponentsUtils.createHeader("Agenda 1.0",
				ViewConstants.CRM_HEADER_SUB_TITLE,
				"../util/resources/officetools.png"), BorderLayout.NORTH);
		this.add(agendaPanel, BorderLayout.CENTER);
		setBackground(Color.WHITE);
	}

	public static void main(String[] args) {
		Agenda cadastro = new Agenda();
		cadastro.setVisible(true);
	}

	private String getAgendaToolTipText() {

		StringBuffer bf = new StringBuffer();

		bf.append("<html>");
		bf.append("<table> ");
		bf
				.append("<tr> <td bgcolor='#990000'><font color='WHITE'>Version ID</font></td><td>Version 1.0&nbsp;</td></tr>");
		bf
				.append("<tr> <td bgcolor='#990000'><font color='WHITE'>Created by</font></td><td>powered by <b>Brossi</b></td></tr>");
		bf
				.append("<tr> <td bgcolor='#990000'><font color='WHITE'>Rights</td></font><td><i>copyright 2006</i></td></tr>");
		bf.append("</html>");

		return bf.toString();
	}

	public void actionPerformed(ActionEvent e) {

	}

}
