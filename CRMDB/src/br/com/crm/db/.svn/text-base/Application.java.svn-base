/**
 * 
 */
package br.com.crm.db;

import java.awt.BorderLayout;
import java.awt.Color;

import javax.swing.JFrame;
import javax.swing.JLabel;

/**
 * @author Rodrigo Luis Nolli Brossi
 * 
 */
public class Application extends JFrame {

	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = 2195476040130182268L;
	private JLabel label;

	/**
	 * Constructor of this application
	 */
	public Application() {
		this.setTitle("DB Status indicator");
		label = new JLabel("Stoped...");
		label.setBackground(Color.RED);
		this.setLayout(new BorderLayout());
		this.add(label, BorderLayout.CENTER);
		this.pack();
		this.setVisible(true);
	}

	public void startDb() {

		ServerStart s = new ServerStart(this);
		Thread n = new Thread(s, "SERVER DB");
		synchronized (this) {
			try {
				n.start(); // server stats here
				this.wait();
				System.out.println("[BROSSI]: Waiting for server initiate");
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("[BROSSI]: Free Thread to use the software");
		label.setText("Running..");
		label.setBackground(Color.GREEN);

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Application x = new Application();
		x.startDb();

	}

}
