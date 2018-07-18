package br.com.firston.bar.applets;

import java.applet.AppletContext;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 * This class is responsible to include an element on the client tables
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public class InsertClientBar extends JFrame implements ActionListener{
	
	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = 8304692766053181088L;

	/**
	 * Constraints
	 */
	private GridBagConstraints c = new GridBagConstraints();
	
	private AppletContext appletContext;
	
	private JTextField email, name, phone, cep;
	private JButton insert, clean, cancel;
	private JLabel emailL, nameL, phoneL, cepL;
	private String urlString = null;

	public void createUI() {
		this.setLayout(new GridBagLayout());
		email 	=  	new JTextField(30);
		name 	= 	new JTextField(30);
		phone 	= 	new JTextField(30);
		cep  	=	new JTextField(11);
		emailL = new JLabel("E-mail:");
		nameL = new JLabel("Name:");
		phoneL = new JLabel("Phone:");
		cepL = new JLabel("CEP:");
		insert = new JButton("Insert");
		clean = new JButton("Clean");
		cancel = new JButton("Cancel");
		this.setSize(new Dimension(600,200));
		
		c.anchor = GridBagConstraints.FIRST_LINE_START;
		c.fill = GridBagConstraints.BOTH;
		c.weightx = 1.0;
		c.weighty = 0.0; 
		c.gridheight = 1;
		c.gridwidth = 1;
		c.insets = new Insets(0, 5, 5, 0);
		c.ipadx = 1;
		c.ipady = 1;
		
		//Start positions 
		c.gridx = 0; 
		c.gridy = 0; 
		this.add(nameL,c);
		c.gridx = 0; 
		c.gridy = 1;
		this.add(emailL,c);
		c.gridx = 0; 
		c.gridy = 2;
		this.add(cepL,c);
		c.gridx = 0; 
		c.gridy = 3;
		this.add(phoneL,c);
		
		//Adding fields
		c.gridx = 1; 
		c.gridy = 0;
		this.add(name,c);
		c.gridx = 1; 
		c.gridy = 1;
		this.add(email,c);
		c.gridx = 1; 
		c.gridy = 2;
		this.add(cep,c);
		c.gridx = 1; 
		c.gridy = 3;
		this.add(phone,c);
		
		//Adding buttons
		
		JPanel buttons = new JPanel(new FlowLayout(3));
		buttons.add(insert);
		buttons.add(clean);
		buttons.add(cancel);
		c.gridwidth = 3; 
		c.gridx = 0; 
		c.gridy = 4;
		this.add(buttons,c);
		
		insert.addActionListener(this);
		cancel.addActionListener(this);
		clean.addActionListener(this);
		setResizable(false);
		
		Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
		
		double xposition = ((screenSize.getWidth() /2) - (this.getSize().getWidth() /2));
		double yposition = ((screenSize.getHeight() /2) - (this.getSize().getHeight() /2));
		this.setLocation((int)xposition,(int)yposition);
		//this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setTitle("Insert Client - FirstOnBar 2010");
	}

	public InsertClientBar(String urlString, AppletContext appletContext) {
		createUI();
		this.urlString = urlString;
		this.appletContext = appletContext; 
	}

	public void actionPerformed(ActionEvent e) {
		System.out.println(e.getSource());
		
		if(e.getSource().equals(insert)){
			try{
				
				 String content =
					    
			    "op="+  "i"+
			    "&email="+ email.getText()+
			    "&name="+ name.getText()+
				"&cep="+ cep.getText()+
				"&phone="+ phone.getText();
				URL url=null;
				url=new URL(urlString+"/Client?"+content);
				
				HttpURLConnection
				connection=(HttpURLConnection)url.openConnection() ;
				connection.setRequestMethod("GET");
				connection.setDoOutput(true);
				connection.setDoInput(true);
				
				//DataOutputStream    printout;
				//DataInputStream     input;
				//input = new DataInputStream(connection.getInputStream());
				
				//printout  = new DataOutputStream (connection.getOutputStream());
				
				
				//connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			    // Send POST output.
			    
//			    String content =
//			    
//			    "op="+  URLEncoder.encode ("i")+
//			    "&email="+ URLEncoder.encode (email.getText())+
//			    "&name="+ URLEncoder.encode (name.getText())+
//			    "&cep="+ URLEncoder.encode (cep.getText())+
//			    "&phone="+ URLEncoder.encode (phone.getText());
			    
			    
			    //printout.writeBytes (content);
			    //printout.flush ();
			    //printout.close ();
			    // Get response data.
			    //input = new DataInputStream (connection.getInputStream ());
			    //String str;
			    //while (null != ((str = input.readLine())))
			    //{
			    //System.out.println (str);
			    //JOptionPane.showMessageDialog((Component)this,str ,"Error send information!",JOptionPane.INFORMATION_MESSAGE);
			    //}
			    ///input.close ();
			    appletContext.showDocument(url,"status");
			}catch(IOException ie){
					JOptionPane.showMessageDialog((Component)this,ie.getMessage() ,"Error send information!",JOptionPane.ERROR_MESSAGE);
			}
			clean();
			setVisible(false);
			
		}else if(e.getSource().equals(cancel)){
			clean();
			this.setVisible(false);
		}
		else if(e.getSource().equals(clean)){
			clean();
		}
	}

	private void clean() {
		email.setText("");
		phone.setText("");
		name.setText("");
		cep.setText("");
	} 
}
