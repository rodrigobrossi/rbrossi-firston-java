package br.com.crm.components.search;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import javax.swing.table.DefaultTableCellRenderer;

public class SearchTableHeaderRenderer extends DefaultTableCellRenderer implements MouseListener, MouseMotionListener {

	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("Clickei" + e.getSource());
		
	}

	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("Entrei");
		
	}

	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("Exitei");
		
	}

	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void mouseDragged(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	public void mouseMoved(MouseEvent arg0) {
		// TODO Auto-generated method stub
		
	}

}
