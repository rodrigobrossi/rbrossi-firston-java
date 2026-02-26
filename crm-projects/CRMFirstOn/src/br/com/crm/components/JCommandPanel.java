package br.com.crm.components;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JProgressBar;
import javax.swing.JToolBar;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;

import br.com.crm.command.CommandManager;
import br.com.crm.command.CommandsConstants;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;

/**
 * Control the Event Dispatcher
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0.0.1
 * 
 */
public class JCommandPanel extends JPanel implements ActionListener {

	private static final long serialVersionUID = 1L;

	private GridBagConstraints constraints = new GridBagConstraints();

	private Insets insets = new Insets(5, 5, 5, 5);

	private JButton commit, change, delete;

	private JProgressBar progressBar;

	private AncestorFrame parent;

	private JPanel contents, contents2;
	
	private JToolBar toobarCommand;

	private boolean multiple;

	private boolean record;

	private boolean update;

	private boolean remove;

	private boolean isToolBarModeOn;

	private static final int DEFAULT_MIN = 0;

	private static final int DEFAULT_MAX = 100;

	public JCommandPanel(JComponent parent) {
		this(parent, false, true, false, false);
	}

	public JCommandPanel(JComponent parent, boolean multiple, boolean record,
			boolean update, boolean remove) {
		this.parent = (AncestorFrame) parent;
		this.multiple = multiple;
		this.record = record;
		this.update = update;
		this.remove = remove;
		createGUI();
	}
	
	public JCommandPanel(JComponent parent, boolean multiple, boolean record,
			boolean update, boolean remove, boolean isToolBarModeOn) {
		this.parent = (AncestorFrame) parent;
		this.multiple = multiple;
		this.record = record;
		this.update = update;
		this.remove = remove;
		this.isToolBarModeOn = isToolBarModeOn;
		createGUI();
	}

	public void createGUI() {
		
		if (!isToolBarModeOn){
			createUIButtonsMode();
		} 
		else{
			createUIToolBarMode();
		}
		
	}

	private void createUIToolBarMode() {
		// TODO Auto-generated method stub
		
	}

	/**
	 * If the toolBarmode is off, the 
	 */
	private void createUIButtonsMode() {
		super.setLayout(new BorderLayout());
		constraints.insets = this.insets;

		contents = new JPanel();
		contents2 = new JPanel();
		contents.setLayout(new GridBagLayout());
		contents2.setLayout(new GridBagLayout());

		setConstraints(0, 0, 1, 1, 1, 1);
		progressBar = new JProgressBar(0, 100);
		progressBar.setStringPainted(true);
		progressBar.setVisible(true);
		progressBar.setBorder(new LineBorder(Color.BLACK, 1, true));
		progressBar.setMinimum(DEFAULT_MIN);
		progressBar.setMaximum(DEFAULT_MAX);
		progressBar.setBackground(Color.WHITE);
		constraints.anchor = GridBagConstraints.WEST;
		contents2.setBackground(Color.WHITE);
		contents2.add(progressBar, constraints);
		constraints.fill = GridBagConstraints.NONE;
		constraints.weightx = 0.0;
		constraints.anchor = GridBagConstraints.EAST;
		if (record) {
			commit = new JButton("Gravar");
			commit.addActionListener(this);
			commit.setActionCommand("C");
			setConstraints(1, 0, 1, 1, 1, 1);
			contents.add(commit, constraints);
		}

		if (update) {
			change = new JButton("Alterar");
			change.addActionListener(this);
			change.setActionCommand("U");
			setConstraints(2, 0, 1, 1, 1, 1);
			contents.add(change, constraints);
		}
		if (remove) {
			delete = new JButton("Deletar");
			delete.addActionListener(this);
			delete.setActionCommand("D");
			setConstraints(3, 0, 1, 1, 1, 1);
			contents.add(delete, constraints);
		}
		setColor(Color.WHITE);
		super.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),
				"Commands"));
		super.add(contents2, BorderLayout.CENTER);
		super.add(contents, BorderLayout.EAST);
	}

	public void setConstraints(int x, int y, int width, int height,
			int weightx, int weighty) {
		constraints.gridx = x;
		constraints.gridy = y;
		constraints.gridwidth = width;
		constraints.gridheight = height;
		constraints.weightx = weightx;
		constraints.weighty = weighty;

	}

	public void setColor(Color color) {
		super.setBackground(color);
		contents.setBackground(color);

	}

	public void actionPerformed(ActionEvent evt) {
		final ProgressRun r = new ProgressRun();
		r.start();
		AncestorFrame acestor = null;
		if (evt.getSource() == commit) {
			AbstractDataBaseCTR obj = null;
			if (multiple) {
				acestor = parent.getChiled();
				obj = acestor.loadPersistentObject();
			} else {
				obj = parent.loadPersistentObject();
			}
			try {
				CommandManager.getInstance().invokeCommandByName(
						CommandsConstants.INSERT, obj);
			} catch (Exception e) {
				e.printStackTrace();
				JOptionPane.showConfirmDialog(this, e.getMessage());
			}
		} else if (evt.getSource() == delete) {
			AbstractDataBaseCTR obj = null;
			if (multiple) {
				acestor = parent.getChiled();
				obj = acestor.loadDeleteObject();
			} else {
				obj = parent.loadDeleteObject();
			}
			try {
				CommandManager.getInstance().invokeCommandByName(
						CommandsConstants.REMOVE, obj);
			} catch (Exception e) {
				e.printStackTrace();
				JOptionPane.showConfirmDialog(this, e.getMessage());
			}
		}

		final AncestorFrame aux = acestor;

		Thread t = new Thread("Notifing") {
			public void run() {
				MainFrame.notifyChanges(aux);
				r.setRun(false);
			}
		};
		t.start();

	}

	public void updateGUI() {
		progressBar.setVisible(false);
		progressBar.paintImmediately(progressBar.bounds());
		this.validate();
		this.repaint();
	}

	class ProgressRun extends Thread {

		private boolean run;

		public void run() {
			progressBar.setVisible(true);
			int val = progressBar.getValue();
			while (run) {
				val = ++val;
				if (val < 99) {
					progressBar.setString(val + "%");
					progressBar.setValue(val);
					try {
						Thread.sleep(2000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					progressBar.paintImmediately(progressBar.bounds());
				}
			}
			progressBar.setValue(100);
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			progressBar.setValue(0);
		}

		public void setRun(boolean b) {
			this.run = b;
		}

	}

}
