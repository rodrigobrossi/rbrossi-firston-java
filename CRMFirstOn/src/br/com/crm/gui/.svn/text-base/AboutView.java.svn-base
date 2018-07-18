package br.com.crm.gui;

import java.awt.BorderLayout;
import java.awt.Frame;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.ImageIcon;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JPanel;

import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.util.CRMComponentsUtils;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0 
 *
 * About View
 */
public class AboutView extends JDialog {

	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = -5984245765832303484L;
	private final String ABOUT_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_MAIN_ABOUT_IMAGE);

	public AboutView(Frame parent) {
		JDialog d = new JDialog(parent, Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_ABOUT_TEXT));
		d.setLayout(new BorderLayout());

		GridBagLayout gridbag = new GridBagLayout();

		JPanel aboutPanel = new JPanel();
		aboutPanel.setLayout(gridbag);

		GridBagConstraints constraints = new GridBagConstraints();
		constraints.gridx = 0;
		constraints.gridy = 0;
		constraints.fill = GridBagConstraints.NONE;
		constraints.anchor = GridBagConstraints.FIRST_LINE_START;

		JLabel labelPicture = new JLabel();
		labelPicture.setIcon(new ImageIcon(CRMComponentsUtils.class
				.getResource(ABOUT_IMAGE)));
		gridbag.setConstraints(labelPicture, constraints);
		aboutPanel.add(labelPicture);

		constraints.gridy = 1;
		constraints.fill = GridBagConstraints.HORIZONTAL;
		constraints.anchor = GridBagConstraints.WEST;

		JLabel label = new JLabel(" ");
		gridbag.setConstraints(label, constraints);
		aboutPanel.add(label);

		constraints.gridy = 2;

		JLabel label1 = new JLabel(
				" "
						+ Messages
								.getString(I18NGUIMessage.GUI_MAINFRAME_COPYRIGHT_TITLE));
		gridbag.setConstraints(label1, constraints);
		aboutPanel.add(label1);

		constraints.gridy = 3;

		JLabel label2 = new JLabel(" ");
		gridbag.setConstraints(label2, constraints);
		aboutPanel.add(label2);

		constraints.gridy = 4;

		JLabel label3 = new JLabel(
				" "
						+ Messages
								.getString(I18NGUIMessage.GUI_MAINFRAME_COPYRIGHT_VERSION));
		gridbag.setConstraints(label3, constraints);
		aboutPanel.add(label3);

		constraints.gridy = 5;

		JLabel label4 = new JLabel(" ");
		gridbag.setConstraints(label4, constraints);
		aboutPanel.add(label4);

		constraints.gridy = 6;

		JLabel label5 = new JLabel(" "
				+ Messages.getString(I18NGUIMessage.GUI_MAINFRAME_COPYRIGHT));
		gridbag.setConstraints(label5, constraints);
		aboutPanel.add(label5);

		constraints.gridy = 7;

		JLabel label7 = new JLabel(" ");
		gridbag.setConstraints(label7, constraints);
		aboutPanel.add(label7);

		constraints.gridy = 8;

		JLabel label8 = new JLabel(" "
				+ Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_COPYRIGHT_MSG));
		gridbag.setConstraints(label8, constraints);
		aboutPanel.add(label8);

		constraints.gridy = 9;

		JLabel label9 = new JLabel(" ");
		gridbag.setConstraints(label9, constraints);
		aboutPanel.add(label9);

		aboutPanel.setVisible(true);

		d.add(aboutPanel, BorderLayout.NORTH);
		d.setSize(200, 210);
		d.setResizable(false);
		d.setVisible(true);
	}

}