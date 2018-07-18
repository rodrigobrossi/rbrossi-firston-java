package br.com.crm.util;

import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.BevelBorder;

import br.com.crm.gui.auxiliaries.CadastroAuxiliaresView;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public final class CRMComponentsUtils implements ViewConstants {

	private static final String GET = "get";

	/**
	 * To isntantiate all CTRs
	 */
	private static final HashMap controls = new HashMap();

	static {

	}

	public static Component createHeader(String title, int type) {
		Font headerTile;
		switch (type) {
		case CRM_HEADER_TITLE:
			headerTile = new Font("Verdana", Font.BOLD, 26);
			break;
		case CRM_HEADER_SUB_TITLE:
			headerTile = new Font("Verdana", Font.PLAIN, 24);
			break;
		default:
			headerTile = new Font("Arial", Font.PLAIN, 10);
			break;
		}

		JLabel lable = new JLabel(title);
		lable.setFont(headerTile);
		lable.setIcon(IMAGE_ICON);
		JPanel complete = new JPanel();
		complete.setBackground(Color.WHITE);
		complete.setBorder(new BevelBorder(2, Color.GRAY, Color.LIGHT_GRAY));
		complete.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.NONE;
		c.weightx = 1.0;
		c.weighty = 0.0;
		c.anchor = GridBagConstraints.FIRST_LINE_START;
		c.insets = new Insets(0, 5, 0, 0);
		c.gridx = 0;
		c.gridy = 0;
		complete.add(lable, c);
		return complete;
	}

	/**
	 * 
	 * @param title
	 * @param type
	 * @param iconPath
	 *            a specific image
	 * @return
	 */
	public static Component createHeader(String title, int type, String iconPath) {
		Font headerTile;
		switch (type) {
		case CRM_HEADER_TITLE:
			headerTile = new Font("Verdana", Font.BOLD, 26);
			break;
		case CRM_HEADER_SUB_TITLE:
			headerTile = new Font("Verdana", Font.PLAIN, 24);
			break;
		default:
			headerTile = new Font("Arial", Font.PLAIN, 10);
			break;
		}

		JLabel lable = new JLabel(title);
		lable.setFont(headerTile);
		if (iconPath != null)
			try {
				lable.setIcon(new ImageIcon(CadastroAuxiliaresView.class
						.getResource(iconPath)));
			} catch (NullPointerException e) {
				//
			}
		JPanel complete = new JPanel();
		complete.setBackground(Color.WHITE);
		complete.setBorder(new BevelBorder(2, Color.GRAY, Color.LIGHT_GRAY));
		complete.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.NONE;
		c.weightx = 1.0;
		c.weighty = 0.0;
		c.anchor = GridBagConstraints.FIRST_LINE_START;
		c.insets = new Insets(0, 5, 0, 0);
		c.gridx = 0;
		c.gridy = 0;
		complete.add(lable, c);
		return complete;
	}

	/**
	 * Returns All elements of a list (Persistent object) via reflection
	 * 
	 * @param l
	 *            List of objects
	 * @param field
	 *            Filed name stating with Capital letter plus usual name.
	 * @return List of String Elements
	 */
	public static String[][] getElementsFrom(List l, String field,String field2) {

		if (l == null || l.size() == 0)
			return new String[][] {{ "!EMPTY FIELD - CHECK DATA!","!EMPTY FIELD - CHECK DATA!"}};

		String[][] elements = new String[l.size()][2];
		Iterator i = l.iterator();
		int c = 0;
		int c2 = 0;
		while (i.hasNext()) {
			try {
				Object obj = i.next();
				Class origin = obj.getClass();
				Class[] theArgTypes = new Class[0];
				Method method  = origin.getDeclaredMethod(GET + field,theArgTypes);
				Method method2 = origin.getDeclaredMethod(GET + field2,theArgTypes);
				
				Object[] theArgs = new Object[0];
				if (method != null)
					elements[c++][0] = ((Long)method.invoke(obj, theArgs)).toString();
				if (method2 != null)
					elements[c2++][1] = (String) method2.invoke(obj, theArgs);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			}
		}
		return elements;
	}
	
	public static String[] getElementsFrom(List l, String field) {

		if (l == null || l.size() == 0)
			return new String[] { "!EMPTY FIELD - CHECK DATA!" };

		String[] elements = new String[l.size()];
		Iterator i = l.iterator();
		int c = 0;
		while (i.hasNext()) {
			try {
				Object obj = i.next();
				Class origin = obj.getClass();
				Class[] theArgTypes = new Class[0];
				Method method = origin.getDeclaredMethod(GET + field,theArgTypes);
				Object[] theArgs = new Object[0];
				if (method != null)
					elements[c++] = (String) method.invoke(obj, theArgs);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			}
		}
		return elements;
	}

	/**
	 * Returns All elements of a list (Persistent object) via reflection
	 * 
	 * @param l
	 *            List of objects
	 * @param field
	 *            Filed name stating with Capital letter plus usual name.
	 * @return List of String Elements
	 */
	public static List getElementsListFrom(List l, String field) {

		if (l == null || l.size() == 0) {
			l = new ArrayList();
			l.add("!EMPTY FIELD - CHECK DATA!");
			return l;
		}

		/* New Results Values */
		List results = new ArrayList();
		/* New iterator values */
		Iterator i = l.iterator();
		while (i.hasNext()) {
			try {
				Object obj = i.next();
				Class origin = obj.getClass();
				Class[] theArgTypes = new Class[0];
				Method method = origin.getDeclaredMethod(GET + field,
						theArgTypes);
				Object[] theArgs = new Object[0];
				if (method != null)
					results.add((String) method.invoke(obj, theArgs));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			}
		}
		return results;
	}

	/**
	 * Return a map for this elements
	 * 
	 * @param l
	 * @param field
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map<String,String> getMapFrom(List l, String field) {

		Map<String,String> objectsUtil = new HashMap<String,String>();

		if (l == null || l.size() == 0)
			return objectsUtil;

		Iterator i = l.iterator();

		while (i.hasNext()) {
			try {
				Object obj = i.next();
				Class origin = obj.getClass();
				Class[] theArgTypes = new Class[0];
				Method method = origin.getDeclaredMethod(GET + field,theArgTypes);
				Method methodGetId = origin.getDeclaredMethod("getId",	theArgTypes);
				Object[] theArgs = new Object[0];
				if (method != null)
					objectsUtil.put((String) method.invoke(obj, theArgs),Long.toString((Long)methodGetId.invoke(obj, theArgs)));
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			}
		}
		return objectsUtil;
	}

	public static String[] getElementsFrom(Iterator i, int size) {
		if (i == null || size == 0)
			return new String[] { "!EMPTY FIELD - CHECK DATA!" };

		String[] elements = new String[size];

		int c = 0;
		while (i.hasNext()) {

			Object obj = i.next();

			if (obj != null)
				elements[c++] = (String) obj;

		}
		return elements;
	}

	/**
	 * Search Elements into a list
	 * 
	 * @param maps
	 * @param name
	 * @return String[] with elements filtered
	 */
	public static Object[] searchElement(List l, String name,
			final int op_filter) {

		List<String> list = new ArrayList<String>();
		name = name.toLowerCase();
		search: for (int i = 0; i < l.size(); i++) {
			String element = ((String) l.get(i)).toLowerCase();
			element = element.toLowerCase();
			switch (op_filter) {
			// case SearchFrame.START_WITH:
			// if (element.startsWith(name))
			// list.add(element);
			// continue search;
			// case SearchFrame.ENDS_WITH:
			// if (element.endsWith(name))
			// list.add(element);
			// continue search;
			// case SearchFrame.CONTAINS:
			// if (element.contains(name.subSequence(0,name.length())))
			// list.add(element);
			// continue search;
			default:
				break;
			}

		}
		return list.toArray();
	}
}
