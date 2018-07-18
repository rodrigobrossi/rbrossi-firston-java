/*
 * @(#)AssetTableModel.java
 *
 * (c) COPYRIGHT 2005 BROSSI INC.
 * BROSSI CONFIDENTIAL PROPRIETARY
 * BROSSI Advanced Technology and Software Operations
 *
 * REVISION HISTORY:
 * Author        Date       CR Number         Brief Description
 * ------------- ---------- ----------------- ------------------------------
 * wrb051        05/12/13   LIBhh15088        Intial version.
 * wrb051        05/12/16   LIBhh15088        Inspection LX033555 rework: Rename variable.  
 * wrb051        06/04/07   LIBii90181        Added theme elements to the Assets View.
 * wrb051        06/07/03   LIBii90181        Changed reference from ProjectConstants.TYPE_PROJECT_THEME to ProjectConstants.TYPE_PROJECT_THEME_ID
 * wrb051        06/07/13   LIBii90181        Inspection LX077663 rework: corrected spelling error on getRuleData method and 
 *                                              removed unecessary javadoc of private methods
 */

package br.com.crm.components.search;

import java.awt.Component;
import java.io.InvalidObjectException;

import javax.swing.table.AbstractTableModel;

/**
 * This is the AssetTable Model, this class represent the model.
 * 
 * @author wrb051
 * @see javax.swing.table.AbstractTableModel
 */
public class SearchTableModel extends AbstractTableModel {

	private static final long serialVersionUID = -2456099679973851172L;

	private String[][] elements; // List represent UICTResource Model

	/**
	 * Creates a new AssetTableModel object.
	 * 
	 * @param categoryModel
	 *            Asset Model !
	 */
	public SearchTableModel(String[][] assets) {

		this.elements = assets;
	}

	/**
	 * Return a List of assets present in the AssetTableModel
	 * 
	 * @return List!
	 */
	public String[][] getAssets() {
		return elements;
	}

	/**
	 * Set a group of asset through a List into the Table's model.
	 * 
	 * @param List
	 *            of assets
	 */
	public void setAssets(String[][] assets) {
		this.elements = assets;
		this.fireTableDataChanged();
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

		return "Other information";

	}

	/**
	 * Return the current name for a Column
	 * 
	 * @return Name of the column.
	 */
	private String returnColumn0Name() {

		return "Resultados da pesquisa";

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getColumnCount()
	 */
	public int getColumnCount() {
		return 1;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getRowCount()
	 */
	public int getRowCount() {
		return elements.length;
	}

	/**
	 * Return the model size.
	 * 
	 * @return int model size!
	 */
	public int getModelSize() {
		return elements.length;
	}

	
	@Override
	public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
		if (columnIndex == 0) {
			elements[rowIndex][0] =(String) aValue;
		} else if (columnIndex ==1) {
			elements[rowIndex][1]= (String) aValue;
		}
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableModel#getValueAt(int, int)
	 */
	public Object getValueAt(int rowIndex, int columnIndex) {
		if (columnIndex == 0) {
			return elements[rowIndex][0];
		} else if (columnIndex ==1) {
			return elements[rowIndex][1];
		}
		else{
			return "NULL";
		}
	}

	/**
	 * Return a Asset by the index of the row
	 * 
	 * @param rowIndex!
	 * @return Asset!
	 */
	public String getAssetAt(int rowIndex) {
		if (elements.length > 0) {
			return (String) elements[rowIndex][1];
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
	public int getIndexOf(Object selection) throws InvalidObjectException {
		for (int i = 0; i < elements.length; i++) {
			if (elements[i].equals(selection)) {
				return i;
			}
		}
		throw new InvalidObjectException("Selection: " + selection);
	}

	/**
	 * Add a new row into the Table model, usuly this operation is done by
	 * UICTResourceModel
	 * 
	 * @param asset
	 */
	public void addRow(String[] element) {
		for (int i = 0; i < elements.length; i++) {
			if (elements[i].equals(element)) {
				return;
			}
		}
		String[][] aux = new String[elements.length + 1][2];
		for (int i = 0; i < aux.length; i++) {
			aux[i] = elements[i];
		}
		aux[elements.length] = element;
		elements = aux;
		fireTableDataChanged();
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
			return JSearchLabel.class;
		default:
			return Component.class;
		}
	}

	/**
	 * Should remove the elements and listeners before continue adding elements.
	 */
	public void removeAll() {
		//FIXME change this method to remove all elements.		
		
	}
}
