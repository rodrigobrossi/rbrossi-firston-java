package brossi.helper.inverter;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextField;

public class Inverter extends JFrame implements ActionListener{

	private JTextField tf;
	private JButton invert;
	public Inverter() {
		this.setLayout(new BorderLayout());
		tf = new JTextField(45);
		
		invert = new JButton("Invert");
		invert.addActionListener(this);
		this.add(tf, BorderLayout.CENTER);
		this.add(invert, BorderLayout.WEST);
		this.pack();
		this.setVisible(true);
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Inverter x = new Inverter();

	}

	@Override
	public void actionPerformed(ActionEvent e) {
		String text = tf.getText();
		char[] array = text.toCharArray();
		char[] arrayAux = new char[array.length];
		for (int i = 0, j=array.length-1; i < array.length;i++, --j){
			arrayAux[i] = array[j];
		}
		
		text = new String(arrayAux);
		tf.setText(text);
		
	}

}
