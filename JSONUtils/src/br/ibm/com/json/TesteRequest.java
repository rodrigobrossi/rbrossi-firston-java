package br.ibm.com.json;

import java.awt.BorderLayout;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.DatagramPacket;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.MulticastSocket;
import java.net.Socket;
import java.net.URL;
import java.net.URLConnection;

import javax.swing.JEditorPane;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextField;

public class TesteRequest extends JFrame{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3431064595588369090L;

	private JEditorPane ep; 
	
	private JTextField tf;
	
	public TesteRequest(){
		
		this.setLayout(new BorderLayout());
		ep = new JEditorPane();
		tf = new JTextField(15);
		this.add(tf,BorderLayout.NORTH);
		this.add(new JScrollPane(ep),BorderLayout.CENTER);
		this.pack();
		this.setVisible(true);
		
	}

	public void setHtml(String html){

		ep.setText(html);
		ep.validate();
		ep.repaint();
	}
	public static void main (String arg[]){
		
		
		TesteRequest  t = new TesteRequest();
		
		String request  = t.doRequest("http://www.google.com.br");
		t.setHtml(request);
		
		System.out.println();
	}

	private String doRequest(String url) {
		
		
		URL urlObject = null;
		URLConnection con = null;
		StringBuffer str = new StringBuffer("");
		String strT = "";
		try {
			urlObject = new URL(url);
			con = urlObject.openConnection();
			con.setRequestProperty("Accept-content", "image/jpg");
			InputStream content = (InputStream) con.getInputStream();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					content));

			while ((strT = in.readLine()) != null) {
				str.append(strT);
			}

			in.close();

		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str.toString();
	}
}
