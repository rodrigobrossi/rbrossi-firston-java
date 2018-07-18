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

package br.com.crm.components.agenda;

import java.awt.Color;
import java.awt.Component;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.ToolTipManager;
import javax.swing.table.DefaultTableCellRenderer;

import br.com.crm.components.agenda.tasks.TaskForAgenda;

/**
 * This class is responsable to renderer a view for the UICT's Asset.
 * 
 * @author wrb051
 * @see javax.swing.table.DefaultTableCellRenderer
 */
public class AgendaTableCellRenderer extends DefaultTableCellRenderer implements MouseListener{

	private static final Color BUSY_COLOR = new Color(250,250,161);

	private static final Color RELEX_COLOR = new Color(204,204,0);

	private static final long serialVersionUID = -310593118726135369L;
	
	private JTable table;

	// Custom table header.
	private AgendaTableModel agendaModel;

	/**
	 * Creates a new AssetTableCR object.
	 * 
	 * @param agendaModel
	 *            UICTResourceModel is custom model for the UICTResource's
	 *            Asset!
	 * @param table
	 *            JTable!
	 */
	AgendaTableCellRenderer(JTable table) {
		this.agendaModel = (AgendaTableModel) table.getModel();
		this.table = table;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableCellRenderer#getTableCellRendererComponent(javax.swing.JTable,
	 *      java.lang.Object, boolean, boolean, int, int)
	 */
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {
		if (agendaModel.getRowCount() == 0) {
			return null;
		}


		int id = table.getColumnModel().getColumn(column).getModelIndex();

		
		switch (id) {
		case 0:
			setColor(row);
			if (isSelected) {
				this.setBackground(table.getSelectionBackground());
				this.setForeground(table.getSelectionForeground());
			}
			
			this.setText((String) table.getModel().getValueAt(row,column));
			return this;
		case 1:
			TaskForAgenda task = (TaskForAgenda) agendaModel.getValueAt(row, column);
			return setFirstHeader(task, row, isSelected);
		default:
			return null;
		}
	}

	private void setColor(int row) {
		if(row >= 8 && row <=18 ){
			this.setBackground(BUSY_COLOR);
			this.setForeground(Color.BLACK);
		}else{
			this.setBackground(RELEX_COLOR);
			this.setForeground(Color.DARK_GRAY);
		}
	}

	/**
	 * Create the customized header to the Asset's table view.
	 * 
	 * @param asset
	 *            Element
	 * @param row
	 *            selected
	 */
	private Component setFirstHeader(TaskForAgenda agenda, int row,
			boolean isSelected) {
		String strType = agenda.getSchedule();
		
		final JTable cell = new JTable(2, 1);
		cell.setAutoscrolls(false);
		cell.addMouseListener(this);
		cell.setEditingColumn(1);
		cell.setEditingRow(row);
		cell.getComponent(0).addMouseListener(this);
		JTextArea textArea = (JTextArea) cell.getEditorComponent();
		if(textArea!=null)
			textArea.setEditable(true);
		//cell.getComponent(1).addMouseListener(this);
		//cell.getComponent(2).addMouseListener(this);
		
		if(row >= 8 && row <=18 ){
			cell.setBackground(BUSY_COLOR);
			cell.setForeground(Color.BLACK);
		}else{
			cell.setBackground(RELEX_COLOR);
			cell.setForeground(Color.DARK_GRAY);
		}

		cell.getModel().setValueAt(strType, 0, 0);
		cell.getModel().setValueAt("Teste complemento ( Localidade )", 1, 0);


		if (isSelected) {
			cell.setBackground(cell.getSelectionBackground());
			cell.setForeground(cell.getSelectionForeground());
		}
		cell.setToolTipText(strType);
		return cell;
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

	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub
		System.out.println("Clicked event");
		
	}

	public void mouseEntered(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void mouseExited(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void mousePressed(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

	public void mouseReleased(MouseEvent e) {
		// TODO Auto-generated method stub
		
	}

}
