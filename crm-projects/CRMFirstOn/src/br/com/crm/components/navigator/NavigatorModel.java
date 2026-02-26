package br.com.crm.components.navigator;

import java.util.ArrayList;
import java.util.List;

/**
 * DESCRIPTION: This class contains the Navigator Model with its categories
 * information
 * 
 * RESPONSIBILITY: Hold the Navigator Model categories and actions.
 * 
 * COLABORATORS: None USAGE: This class must be instantiated in order to give
 * the JNavigator the information needed to show the Navigator
 */
public class NavigatorModel {
	private ArrayList actions;

	private ArrayList categories;

	private ArrayList categoriesToolTips;

	/**
	 * Creates a new NavigatorModel object.
	 */
	public NavigatorModel() {
		categories = new ArrayList(1);
		categoriesToolTips = new ArrayList(1);
		actions = new ArrayList(1);
	}

	/**
	 * Get the Navigator Actions based on the category position
	 * 
	 * @param pos -
	 *            Position of the category on the category list of the Navigator
	 */
	public List getActions(int pos) {
		List returnValue;

		if (pos < categories.size()) {
			returnValue = (List) actions.get(pos);
		} else {
			returnValue = null;
		}

		return returnValue;
	}

	/**
	 * Get the Navigator category placed on the specified position
	 * 
	 * @param pos -
	 *            Position of the category on the category list of the Navigator
	 * 
	 * @return - The category placed on the specified position
	 */
	public String getCategory(int pos) {
		String returnValue;

		if (pos < categories.size()) {
			returnValue = categories.get(pos).toString();
		} else {
			returnValue = null;
		}

		return returnValue;
	}

	/**
	 * Get the position of the category accordingly to its name
	 * 
	 * @param category -
	 *            The category name
	 * 
	 * @return int - The position of the category on the Navigator category list
	 */
	public int getCategory(String category) {
		return categories.indexOf(category);
	}

	/**
	 * Get the tooltip related to a specific Navigator category
	 * 
	 * @param pos -
	 *            Position of the category on the category list of the Navigator
	 * 
	 * @return String - The tooltip related to the category placed on the
	 *         specified position
	 */
	public String getCategoryToolTip(int pos) {
		String returnValue;

		if (pos < categoriesToolTips.size()) {
			returnValue = categoriesToolTips.get(pos).toString();
		} else {
			returnValue = null;
		}

		return returnValue;
	}

	/**
	 * Add a new category to the Navigator
	 * 
	 * @param tooltips
	 *            The tooltip related by the new category
	 * @param category
	 *            The new category name
	 * @param actions
	 *            The actions associated to the new category
	 */
	public void addCategoryPanel(String tooltips, String category, ArrayList actions) {
		categories.add(category);
		categoriesToolTips.add(tooltips);
		this.actions.add(actions);
	}

	/**
	 * Get the number of the categories of the Navigator
	 * 
	 * @return int
	 */
	public int size() {
		return categories.size();
	}
}
