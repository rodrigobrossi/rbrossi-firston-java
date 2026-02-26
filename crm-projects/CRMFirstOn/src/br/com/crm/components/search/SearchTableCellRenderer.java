/*
 * @(#)AssetTableCellRenderer.java
 *
 * (c) COPYRIGHT 2005 MOTOROLA INC.
 * MOTOROLA CONFIDENTIAL PROPRIETARY
 * MOTOROLA Advanced Technology and Software Operations
 *
 * REVISION HISTORY:
 * Author        Date       CR Number         Brief Description
 * ------------- ---------- ----------------- ------------------------------
 * wrb051        05/11/21   LIBhh15088        Initial Version.
 * wrb051        05/12/13   LIBhh15088        Update coments.
 * wrb051        05/12/16   LIBhh15088        Inspection LX033555 rework: Rename file name
 *                                            clarify local varuble's name.  
 * wpl020        06/02/20   LIBhh65570        Added decoration on non skinnable property.                                           
 * wrs066        06/04/07   LIBii90181        Added theme elements to the Assets View.
 * wrs066        06/04/07   LIBii90181        Fix creation of Sound icon preview.
 * wjc083        06/07/03   LIBii90181        Changed reference from ProjectConstants.TYPE_PROJECT_THEME to ProjectConstants.TYPE_PROJECT_THEME_ID
 * wjc083        06/07/13   LIBii90181        Inspection LX077663 rework: removed unused variable table and corrected javadocs
 */

package br.com.crm.components.search;

import java.awt.Color;
import java.awt.Component;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JTable;
import javax.swing.ToolTipManager;
import javax.swing.table.DefaultTableCellRenderer;

import br.com.crm.util.ViewConstants;

/**
 * This class is responsible to renderer a view for the UICT's Asset.
 * 
 * @author wrb051
 * @see javax.swing.table.DefaultTableCellRenderer
 */
public class SearchTableCellRenderer extends DefaultTableCellRenderer  {

	private static final long serialVersionUID = 7193565895958292828L;

	/**
	 * Creates a new AssetTableCR object.
	 * 
	 * @param categoryModel
	 *            UICTResourceModel is custom model for the UICTResource's
	 *            Asset!
	 * @param table
	 *            JTable!
	 */
	SearchTableCellRenderer() {
		
		//addMouseListener(this);
	}

	private JMenu getPopupMenu() {
		JMenu menu = new JMenu();
		menu.add(new JMenuItem("Open record"));
		return menu;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.swing.table.TableCellRenderer#getTableCellRendererComponent(javax
	 * .swing.JTable, java.lang.Object, boolean, boolean, int, int)
	 */
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {

		this.setAlignmentX(JLabel.RIGHT_ALIGNMENT);

		/*
		 * Asset represents a resource, whatever it be.
		 */
		Object asset = (Object) table.getModel().getValueAt(row, 1);

		// int id = table.getColumnModel().getColumn(column).getModelIndex();

		/*
		 * the code below represents the behavior of columns.
		 */
		this.add(this.getPopupMenu());
			
		if (isSelected) {
			setBackground(table.getSelectionBackground());
			setForeground(table.getSelectionForeground());
			this.add(new JButton("GO."));
		
		} else {
			setBackground(table.getBackground());
			setForeground(table.getForeground());
		}
		if (asset != null && asset.toString().length() >= 2) {
			// this.setAutoscrolls(false);
			this.setAlignmentX(JLabel.RIGHT);
			ImageIcon img = ViewConstants.SEARCH_PERSON_ICON;
			this.setIcon(this.createIconPreviewWithoutScaling(img.getImage()));
			this.setText(asset.toString());
			StringBuffer b = new StringBuffer();
			b.append("<html>");
			b.append("<table bgcolor='#EBEBEB' celspacing=0>");
			b.append("<tr><td align='right'><b>Nome:</b></td><td>"
					+ asset.toString() + "</td></tr>");
			b
					.append("<tr><td align='right'><b>Idade:</b></td><td>27</td></tr>");
			b
					.append("<tr><td align='right'><b>Telefone:</b></td><td>32337093</td></tr>");
			b
					.append("<tr><td align='right'><b>email:</b></td><td><a href='mailto:t@t.com'>rodrigobrossi@hotmail.com</a></td></tr>");
			b.append("</table>");
			b.append("</html>");
			this.setToolTipText(b.toString());
			this.setEnabled(true);
			//this.addMouseListener(this);
			return this;
		} else {
			this.setText("");
			this.setAlignmentX(JLabel.CENTER);
			this.setIcon(null);
			this.setEnabled(false);
			return this;

		}

	}

	/**
	 * This could be a sample to how overload the setToolTipText to be
	 * customized.
	 * 
	 * @param text
	 *            to be set!
	 */
	public void setToolTipText(String text) {
		String oldText = getToolTipText();
		putClientProperty(TOOL_TIP_TEXT_KEY, text);

		ToolTipManager toolTipManager = ToolTipManager.sharedInstance();

		if (text != null) {
			if (oldText == null) {
				toolTipManager.registerComponent(this);
			}
		} else {
			toolTipManager.unregisterComponent(this);
		}
	}

	private ImageIcon createIconPreviewWithoutScaling(Image img) {
		BufferedImage bf = new BufferedImage(32, 32,
				BufferedImage.TYPE_4BYTE_ABGR);
		Graphics g = (Graphics) bf.createGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, 31, 31);
		g.drawImage(img, 0, 0, null, null);
		g.setColor(Color.BLACK);
		g.drawRect(0, 0, 31, 31);
		return new ImageIcon(bf);
	}

	@Override
	protected void firePropertyChange(String s, Object obj, Object obj1) {
		// TODO Auto-generated method stub
		super.firePropertyChange(s, obj, obj1);
		System.out.println("Propertie changes "+obj);
		
	}

	public void mouseClicked(MouseEvent e) {
		System.out.println("ROW SELECTED 1 " + e.getSource());

	}

	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("ROW SELECTED 2 " + e.getSource());
	}

	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("ROW SELECTED 3 " + e.getSource());
	}

	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("ROW SELECTED 4 " + e.getSource());
	}

	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("ROW SELECTED 5 " + e.getSource());
	}

}
