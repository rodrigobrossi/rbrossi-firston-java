package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import br.com.crm.components.calendar.JDateChooser;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.gui.app.AncestorFrame;

public class CadastroNestosView extends AncestorFrame {

	/**
	 * Serial version
	 */
	private static final long serialVersionUID = 433220885108648347L;

	private JTextField nomeNeto = new JTextField(50);
	
	private JTextField idadeNeto = new JTextField(2);
	
    //XDate declaration 
    private JDateChooser born = new JDateChooser();
    
    /**
     * Constructor
     */
    public CadastroNestosView() {
        this.createGUI();
    }
	

	public void createGUI() {
        this.setLayout(new BorderLayout());
        GridBagLayout gridbag = new GridBagLayout();

        JPanel panel = new JPanel();
        panel.setLayout(gridbag);
        panel.setBackground(Color.WHITE);

        // Nome Neto
        JLabel nomeNetoLabel = new JLabel("Nome Neto:");
        setConstraints(0, 0, 1, 1, GridBagConstraints.PAGE_START,
                GridBagConstraints.NONE);
        gridbag.setConstraints(nomeNetoLabel, constraints);
        panel.add(nomeNetoLabel);
        setConstraints(1, 0, 1, 1, GridBagConstraints.HORIZONTAL,
                GridBagConstraints.BOTH);
        gridbag.setConstraints(nomeNeto, constraints);
        panel.add(nomeNeto);
        
        // DataControlInterface Aniversario
        setConstraints(0, 1, 1, 1, GridBagConstraints.BOTH,GridBagConstraints.BOTH);
        constraints.fill = GridBagConstraints.NONE;
        panel.add(new JLabel("DataControlInterface Aniversário:"), constraints);
        setConstraints(1, 1, 1, 1, GridBagConstraints.PAGE_START,GridBagConstraints.NONE);
        panel.add(born, constraints);
        
        // Idade Neto
        JLabel idadeNetoLabel = new JLabel("Idade:");
        setConstraints(0, 2, 1, 1, GridBagConstraints.PAGE_START,
                GridBagConstraints.NONE);
        gridbag.setConstraints(idadeNetoLabel, constraints);
        panel.add(idadeNetoLabel);
        setConstraints(1, 2, 1, 1, GridBagConstraints.HORIZONTAL,
                GridBagConstraints.BOTH);
        gridbag.setConstraints(idadeNeto, constraints);
        panel.add(idadeNeto);
        JPanel center =new JPanel(new BorderLayout());
		center.add(panel, BorderLayout.NORTH);
        putComponent(center);
		
	}

	
	public void updateGUI() {
		// TODO Auto-generated method stub
		
	}


	public AbstractDataBaseCTR loadPersistentObject() {
		return null;
		// TODO Auto-generated method stub
		
	}

	public void setColor(Color color) {
		// TODO Auto-generated method stub
		
	}

}
