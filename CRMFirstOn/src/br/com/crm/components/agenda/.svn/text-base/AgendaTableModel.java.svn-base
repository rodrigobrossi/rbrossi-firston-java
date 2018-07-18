/*
 * @(#)AssetTableModel.java
 *
 * (c) COPYRIGHT 2005 MOTOROLA INC.
 * MOTOROLA CONFIDENTIAL PROPRIETARY
 * MOTOROLA Advanced Technology and Software Operations
 *
 * REVISION HISTORY:
 * Author        Date       CR Number         Brief Description
 * ------------- ---------- ----------------- ------------------------------
 * wrb051        05/12/13   LIBhh15088        Intial version.
 * wrb051        05/12/16   LIBhh15088        Inspection LX033555 rework: Rename variable.  
 * wrs066        06/04/07   LIBii90181        Added theme elements to the Assets View.
 * wjc083        06/07/03   LIBii90181        Changed reference from ProjectConstants.TYPE_PROJECT_THEME to ProjectConstants.TYPE_PROJECT_THEME_ID
 * wjc083        06/07/13   LIBii90181        Inspection LX077663 rework: corrected spelling error on getRuleData method and 
 *                                              removed unecessary javadoc of private methods
 */

package br.com.crm.components.agenda;

import java.awt.Component;
import java.util.List;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;

/**
 * This is the AssetTable Model, this class represent the model.
 * 
 * @author wrb051
 * @see javax.swing.table.AbstractTableModel
 */
public class AgendaTableModel extends AbstractTableModel {

	private static final long serialVersionUID = 1071332005061092879L;

	private List tasks; // List represent UICTResource Model

	/**
	 * Creates a new AssetTableModel object.
	 * 
	 * @param categoryModel
	 *            Asset Model !
	 */
	public AgendaTableModel(List assets) {

		this.tasks = assets;
	}

	/**
	 * Return a List of assets present in the AssetTableModel
	 * 
	 * @return List!
	 */
	public List getAssets() {
		return tasks;
	}

	/**
	 * Set a group of asset through a List into the Table's model.
	 * 
	 * @param List
	 *            of assets
	 */
	public void setAssets(List assets) {
		this.tasks = assets;
	}

	/**
	 * Return the column name.
	 * 
	 * @param column
	 *            index
	 * @return String column name!
	 */
	public String getColumnName(int column) {
		switch (column) {
		case 0:
			return returnColumn0Name();
		case 1:
			return returnColumn1Name();
		default:
			return "Not found";
		}
	}

	/**
	 * Retrun the current name for a Column
	 * 
	 * @return Name of the column.
	 */
	private String returnColumn1Name() {

		return "Calendar";

	}

	/**
	 * Return the current name for a Column
	 * 
	 * @return Name of the column.
	 */
	private String returnColumn0Name() {

		return "Time";

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getColumnCount()
	 */
	public int getColumnCount() {
		return 2;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getRowCount()
	 */
	public int getRowCount() {
		return tasks.size();
	}

	/**
	 * Return the model size.
	 * 
	 * @return int model size!
	 */
	public int getModelSize() {
		return tasks.size();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getValueAt(int, int)
	 */
	public Object getValueAt(int rowIndex, int columnIndex) {

		switch (columnIndex) {
		case 0:
			if ((rowIndex < tasks.size()) && (rowIndex != -1)) {
				return getHour(rowIndex);
			} else {
				return null;
			}
		case 1:
			if ((rowIndex < tasks.size()) && (rowIndex != -1)) {
				return tasks.get(rowIndex);
			} else {
				return null;
			}
		default:
			return null;
		}

	}

	private String getHour(final int rowIndex) {
		switch (rowIndex) {
		case 0:
			return "00:00";
		case 1:
			return "01:00";
		case 2:
			return "02:00";
		case 3:
			return "03:00";
		case 4:
			return "04:00";
		case 5:
			return "05:00";
		case 6:
			return "06:00";
		case 7:
			return "07:00";
		case 8:
			return "08:00";
		case 9:
			return "09:00";
		case 10:
			return "10:00";
		case 11:
			return "11:00";
		case 12:
			return "12:00";
		case 13:
			return "13:00";
		case 14:
			return "14:00";
		case 15:
			return "15:00";
		case 16:
			return "16:00";
		case 17:
			return "17:00";
		case 18:
			return "18:00";
		case 19:
			return "19:00";
		case 20:
			return "20:00";
		case 21:
			return "21:00";
		case 22:
			return "22:00";
		case 23:
			return "23:00";
		default:
			return null;

		}
		
	}

	/**
	 * Return a Asset by the index of the row
	 * 
	 * @param rowIndex!
	 * @return Asset!
	 */
	public String getAssetAt(int rowIndex) {
		if (tasks.size() > 0) {
			return (String) tasks.get(rowIndex);
		} else {
			return null;
		}
	}

	/**
	 * Return the index of a Asset
	 * 
	 * @param selection
	 *            public name!
	 * @return int = index of the Asset selected
	 */
	public int getIndexOf(Object selection) {
		return tasks.indexOf(selection);
	}

	/**
	 * Add a new row into the Table model, usuly this operation is done by
	 * UICTResourceModel
	 * 
	 * @param asset
	 */
	public void addRow(Object asset) {
		if (!tasks.contains(asset)) {
			tasks.add(asset);
			fireTableDataChanged();
		}
	}

	/**
	 * Replace a row into the Table model.
	 * 
	 * @param oldFile
	 * @param newFile
	 */
	public void replaceRow(Object oldFile, Object newFile) {
		int i = tasks.indexOf(oldFile);
		tasks.remove(i);

		if (!tasks.contains(newFile)) {
			tasks.add(i, newFile);
		}

		fireTableDataChanged();
	}

	/**
	 * Remove a row from the table model by the public asset name.
	 * 
	 * @param asset
	 */
	public void removeRow(Object asset) {
		if (tasks.size() > 0) {
			tasks.remove(asset);
			fireTableDataChanged();
		}
	}

	/**
	 * Update Table view
	 */
	public void updateView() {
		fireTableDataChanged();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getColumnClass(int)
	 */
	public Class getColumnClass(int columnIndex) {
		switch (columnIndex) {
		case 0:
			return JLabel.class;
		case 1:
			return JTable.class;
		default:
			return Component.class;
		}
	}
}
