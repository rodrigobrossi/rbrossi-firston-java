/*
 * Created on Feb 10, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package br.com.crm.components.details;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;

import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;

import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

/**
 * @author wrb051
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DetailsFrame extends JPanel {
	
	private static final long serialVersionUID = 2800937220817350024L;
	private JPanel details, image;
	private JComboBox comboHumor, comboConfiable, comboMore; 
	
	public DetailsFrame(){
		this.setLayout(new BorderLayout());
		details = new JPanel();
		details.setLayout(new GridBagLayout());
		details.setBackground(Color.WHITE);
		image 	= new JPanel();
		image.setLayout(new GridBagLayout());
		image.setBackground(Color.WHITE);
		GridBagConstraints constraints = new  GridBagConstraints();
		constraints.anchor = GridBagConstraints.FIRST_LINE_START;
		constraints.insets =  new Insets(5,5,5,5);
		constraints.weightx =1.0;
		constraints.weighty =1.0;
		constraints.fill = GridBagConstraints.BOTH;
		this.setBackground(Color.WHITE);
		image.setBorder(new TitledBorder(new LineBorder(Color.BLACK),"Contact profile:"));
		//Create combos
		comboHumor =  new JComboBox(new Object[]{"Nervoso","Calmo"});
		comboHumor.setForeground(Color.RED);
		comboConfiable= new  JComboBox(new Object[]{"Trust","Calmo"});
		comboConfiable.setForeground(Color.GREEN);
		comboMore= new  JComboBox(new Object[]{"Client","Prospect","Lead"});
		comboMore.setForeground(Color.BLUE);
		
		//first group
		constraints.gridx=0;
		constraints.gridy=1;
		details.add(new JLabel("Humor:"),constraints);
		constraints.gridx=1;
		details.add(comboHumor,constraints);
		//second group
		constraints.gridx=0;
		constraints.gridy=2;
		details.add(new JLabel("Trust:"),constraints);
		constraints.gridx=1;
		details.add(comboConfiable,constraints);
		//terd group
		constraints.gridx=0;
		constraints.gridy=3;
		details.add(new JLabel("Other:"),constraints);
		constraints.gridx=1;
		details.add(comboMore,constraints);
		
		details.setBorder(new TitledBorder(new LineBorder(Color.BLACK),"Indicators:"));
		this.add(CRMComponentsUtils.createHeader("Details",ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);
		this.add(image, BorderLayout.CENTER);
		this.add(details, BorderLayout.SOUTH);
	}

	public static void main(String[] args) {
		DetailsFrame x = new DetailsFrame();
		JFrame  f = new JFrame("Teste");
		f.getContentPane().setLayout(new BorderLayout());
		x.setOpaque(true);
		f.getContentPane().add(x, BorderLayout.CENTER);
		f.setBackground(Color.WHITE);
		f.setSize(300,400);
		f.setVisible(true);
	}
}
