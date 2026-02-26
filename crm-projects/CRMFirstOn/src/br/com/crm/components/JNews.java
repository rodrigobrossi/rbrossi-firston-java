package br.com.crm.components;

import java.awt.BorderLayout;
import java.awt.Canvas;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Toolkit;

import javax.swing.JPanel;
import javax.swing.border.LineBorder;

import br.com.crm.components.news.INewsModel;

public class JNews extends JPanel {

	private static final long serialVersionUID = 3813303145044082613L;

	private INewsModel model;

	private Canvas canvas;

	private boolean active;

	private Thread news;

	private RunNotice rn;

	/**
	 * 
	 */
	public JNews() {
		this.setSize(300, 400);
		this.setBorder(new LineBorder(Color.RED, 1));
		this.setBackground(Color.WHITE);
		this.setLayout(new BorderLayout());
		
		JBanner banner = new JBanner();
		this.add(banner, BorderLayout.CENTER);
		banner.setVisible(true);
		banner.start();
		
//		rn = new RunNotice();
//		news = new Thread(rn, "News");
//		canvas = new Canvas();
		//this.add(canvas, BorderLayout.CENTER);
	}

	public void paint(Graphics g) {
//		super.paint(g);
//		if(!news.isAlive()){
//			canvas.setEnabled(true);
//			canvas.setPreferredSize(this.getPreferredSize());
//			rn.setG(g);
//			news.start();
//		}
	}

	public JNews(INewsModel model) {

	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public INewsModel getModel() {
		return model;
	}

	public void setModel(INewsModel model) {
		this.model = model;
	}

}

class RunNotice implements Runnable {
	private Graphics g = null;

	RunNotice() {

	}

	public void run() {
		Toolkit tk = Toolkit.getDefaultToolkit();
		Dimension dimension = tk.getScreenSize();

		int xposition = dimension.width;
		String notice = "Noticias FIRSTON";

		while (true) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			g.setColor(Color.BLACK);
			g.fillRect(0, 0, dimension.width, dimension.height);
			g.setColor(Color.RED);
			// g.drawString(notice, xposition, dimension.height / 2);
			g.drawString(notice, xposition, 0);
			xposition = (xposition - 1);
			if (xposition - notice.length() == dimension.width) {
				xposition = dimension.width;
			}
		}
	}

	public Graphics getG() {
		return g;
	}

	public void setG(Graphics g) {
		this.g = g;
	}

}
