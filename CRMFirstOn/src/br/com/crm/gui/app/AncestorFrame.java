package br.com.crm.gui.app;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.LineBorder;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.db.hb.PersistentObject;
import br.com.crm.exceptions.gui.CRMException;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;
import br.com.crm.validation.ValidatorDecorator;

public abstract class AncestorFrame extends JPanel implements Serializable {

	/**
	 * Default Serial version Id
	 */
	private static final long serialVersionUID = 1L;

	protected GridBagConstraints constraints;

	protected AncestorFrame chield;

	protected Insets insets;

	protected AbstractDataBaseCTR controller;

	protected JScrollPane mainPanel = null;

	protected HashMap<String, Map> valuesForCombos;

	public AbstractDataBaseCTR getPersistentObject() {
		return controller;
	}

	public void setAbstractDataBaseCTR(AbstractDataBaseCTR controller) {
		this.controller = controller;
	}

	public AbstractDataBaseCTR loadDeleteObject() {
		return null;
	}

	protected AncestorFrame() {
		super.setLayout(new BorderLayout());
		insets = new Insets(2, 5, 1, 1);
		constraints = new GridBagConstraints();
		constraints.anchor = GridBagConstraints.FIRST_LINE_START;
		constraints.fill = GridBagConstraints.NONE;
		constraints.insets = insets;
		valuesForCombos = new HashMap<String, Map>();
	}

	/**
	 * @param component
	 * @deprecated Should be removed
	 */
	public void putComponent(JComponent component) {
		component.setOpaque(false);
		add(mainPanel = new JScrollPane(component), BorderLayout.CENTER);
	}

	public void putComponent(JComponent component, boolean useScroll) {
		component.setOpaque(false);
		if (useScroll)
			add(mainPanel = new JScrollPane(component), BorderLayout.CENTER);
		else
			add(component, BorderLayout.CENTER);
	}

	public void setConstraints(int x, int y, int width, int height, int anchor,
			int fill) {
		constraints.gridx = x;
		constraints.gridy = y;
		constraints.gridwidth = width;
		constraints.gridheight = height;
		constraints.anchor = anchor;
		constraints.fill = fill;
	}

	/**
	 * Create the UI for a First One Application
	 * @param title
	 */
	public void createGUI(String title) {
		if (title == null && title.equals(""))
			title = "First One - Application";

		add(CRMComponentsUtils.createHeader(title,ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);
	}

	public abstract void updateGUI();

	public void cleaupUI() {
		valuesForCombos.clear();
	}

	public abstract AbstractDataBaseCTR loadPersistentObject();

	public abstract void setColor(Color color);

	public AncestorFrame getChiled() {
		return chield;
	}

	/**
	 * Create the ComboBox
	 */
	protected JComboBox createValuesForACombo(AbstractDataBaseCTR ctr,
			PersistentObject pojo, String fieldName) {
		if (!valuesForCombos.containsKey(fieldName)) {
			registerMap(ctr, pojo, fieldName, fieldName);

		} else {
			throw new CRMException("The combo box for the " + fieldName
					+ " controller already exists!");
		}
		Map<String, String> maps = this.valuesForCombos.get(fieldName);
		return new JComboBox(getStringArray(maps));
	}

	/**
	 * 
	 * Create the Values on the map Value
	 * 
	 * @param ctr
	 * @param pojo
	 * @param fieldName
	 */
	protected void createValues(AbstractDataBaseCTR ctr, PersistentObject pojo,
			String fieldName) {

		if (!valuesForCombos.containsKey(fieldName)) {
			registerMap(ctr, pojo, fieldName, fieldName);
		} else {
			throw new CRMException("The map for the " + fieldName
					+ " controller already exists!");
		}
	}

	/**
	 * This method will register the value into the map
	 * 
	 * @param ctr
	 * @param pojo
	 * @param fieldName
	 * @param ctrStringClassName
	 */
	private void registerMap(AbstractDataBaseCTR ctr, PersistentObject pojo,
			String fieldName, String ctrStringClassName) {
		ctr.setObject(pojo);
		Map<String, String> comboValues = CRMComponentsUtils.getMapFrom(ctr
				.getData(), fieldName);
		this.valuesForCombos.put(ctrStringClassName, comboValues);
	}

	/**
	 * This method is responsible to return an array within the info necessary
	 * to print to the view the information of the tables.
	 * 
	 * @param maps
	 * @return Object[] containing the keys of the maps (which are de
	 *         description in fact).
	 */
	private Object[] getStringArray(Map<String, String> maps) {
		return maps.keySet().toArray();
	}

	protected String getValueForField(String field, String selectedValue) {
		Map<String, Long> value = valuesForCombos.get(field);
		return "" + value.get(selectedValue);
	}

	protected void setBorder(JComponent component){
		component.setBorder(new LineBorder(Color.BLACK,1,true));
	}
	

	/**
	 * @return
	 */
	protected ValidatorDecorator getValidatorComponent(JComponent component, boolean isMandatory,int validation) {
		ValidatorDecorator vCepField = new ValidatorDecorator(component,isMandatory, validation);
		return vCepField;
	}
}
