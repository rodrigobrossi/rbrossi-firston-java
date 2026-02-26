package br.com.crm.gui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.beans.PropertyVetoException;
import java.util.ArrayList;
import java.util.Comparator;

import javax.swing.AbstractAction;
import javax.swing.Action;

import br.com.crm.components.JNavigator;
import br.com.crm.components.navigator.NavigatorModel;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.core.ApplicationConstants;
import br.com.crm.core.ApplicationContext;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.util.ViewConstants;

/**
 * Navigator view.
 * 
 * <pre>
 *      CLASS:
 *      This class represents a custom component responsible to construct the navigator view.
 *     
 *      RESPONSIBILITIES:
 *      -) List all the elements available to use in the tool.
 *      -) Show the screen view
 *      -) List all screen widgets
 *     
 *      COLABORATORS:
 *      -) WidgetIconFactory.java
 *     
 *      USAGE:
 *      NavigatorPanel navigatorPanel = new NavigatorPanel();
 *      FIXME Create the Pojos to verify the elements present here.
 * 
 */
public class NavigatorPanel extends AncestorFrame {

	private static final long serialVersionUID = 2971539437736484031L;

	private CustomComparator comparator;

	private static int i;

	private class CustomAction extends AbstractAction {
		private static final long serialVersionUID = 8014283561615765973L;

		private Integer displayId;

		private Integer elementId;

		private Integer elementTypeId;

		public CustomAction(Integer widgetId, Integer displayId,
				Integer elementTypeId) {
			this.elementId = widgetId;
			this.displayId = displayId;
			this.elementTypeId = elementTypeId;
		}

		
		/* (non-Javadoc)
		 * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
		 */
		public void actionPerformed(ActionEvent e) {
			/* Call from the navigator Panel */
			System.out.println("Clicaram em mim!" + e.getActionCommand() +" "+e.getID() + " "+ e.getSource());
			try {
				if (e.getActionCommand().equals("Agenda")) {
					ApplicationContext.getInstance().launchApplication(
							ApplicationConstants.CORE_APP_AGENDA);
				}
			} catch (PropertyVetoException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

	/**
	 * Compare objects to arrange it
	 * 
	 * @author wgi006
	 */
	private class CustomComparator implements Comparator {
		public int compare(Object o1, Object o2) {
			String actionA = (String) ((Action) o1).getValue(Action.NAME);
			String actionB = (String) ((Action) o2).getValue(Action.NAME);
			return actionA.compareTo(actionB);
		}
	}

	/**
	 * Constructor for NavigatorPanel
	 */
	public NavigatorPanel() {
		MainFrame.addFisrstOnListener(this);
		comparator = new CustomComparator();
		init();
	}

	/**
	 * Create a list with all common widgets for the display passed by parameter
	 * 
	 * @param displayId
	 * @return List
	 */
	private ArrayList getLinksActions() {
		ArrayList actions = new ArrayList(1);
		Action action;
		String[] linkNames = new String[]{
				"Agenda",
				"Analise KPI",
				"Avaliação",
				"Bar",
				"Cadastro",
				"Clube Client",
				"Combrança",
				"Plano",
				"Relatórios",
				"Resultados"
		};
		
		for (int i = 0; i < 10; i++) {
			action = new CustomAction(i, i, i);
			action.putValue(Action.SMALL_ICON, ViewConstants.IMAGE_MURAL);
			action.putValue(Action.NAME, linkNames[i] );
			actions.add(action);	
		}
		return actions;
	}
	
	/**
	 * Create a list with all common widgets for the display passed by parameter
	 * 
	 * @param displayId
	 * @return List
	 */
	private ArrayList getResearchActions() {
		ArrayList actions = new ArrayList(1);
		Action action;
		for (int i = 0; i < 10; i++) {
			action = new CustomAction(i, i, i);
			action.putValue(Action.SMALL_ICON, ViewConstants.IMAGE_MURAL);
			action.putValue(Action.NAME, "Consult " + i);
			actions.add(action);	
		}
		return actions;
	}

	/**
	 * Create a list with all specific widgets for the display passed by
	 * parameter
	 * 
	 * @param displayId
	 * @return List
	 */
	private ArrayList getProductsActions() {
		ArrayList actions = new ArrayList(1);
		Action action;
		for (int i = 0; i < 10; i++) {
			action = new CustomAction(i, i, i);
			action.putValue(Action.SMALL_ICON, ViewConstants.IMAGE_MURAL);
			action.putValue(Action.NAME, "Other Element " + i);
			actions.add(action);	
		}
		return actions;
	}


	/**
	 * Build the default view of navigator
	 */
	private void init() {
		this.removeAll();
		
		this.setLayout(new BorderLayout());
		NavigatorModel navigatorModel = new NavigatorModel();
		navigatorModel.addCategoryPanel("Categoria 1", "Produto",getProductsActions());
		navigatorModel.addCategoryPanel("Categoria 2", "Links",getLinksActions());
		navigatorModel.addCategoryPanel("Categoria 3", "Consultas",getResearchActions());
		
		
		JNavigator jNavigator = new JNavigator(navigatorModel);
		jNavigator.setBackground(Color.WHITE);
		this.add(jNavigator, BorderLayout.CENTER);
		this.setVisible(true);
		this.validate();
	}

	public void createGUI() {
		//FIXME See if its necessary
	}

	public void updateGUI() {
		// TODO Auto-generated method stub

	}

	public AbstractDataBaseCTR loadPersistentObject() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setColor(Color color) {
		// TODO Auto-generated method stub

	}
}
