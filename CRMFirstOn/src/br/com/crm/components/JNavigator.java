package br.com.crm.components;



import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.swing.Action;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JScrollPane;

import br.com.crm.components.navigator.NavigatorConstants;
import br.com.crm.components.navigator.NavigatorCustomButton;
import br.com.crm.components.navigator.NavigatorModel;
import br.com.crm.util.ViewConstants;



/**
 * DESCRIPTION: This class contains the Navigator graphical elements and
 * specifies its characteristics.
 * 
 * RESPONSIBILITY: Provide the Navigator behavior Contain the Navigator
 * graphical elements
 * 
 * COLABORATORS: NavigatorModel which contains the model of the Navigator (@see
 * com.mot.swingx.navigator.NavigatorModel) USAGE: In order to use this class, a
 * NavigatorModel must be previously defined This model contains the model
 * information to be exhibited by the Navigator. After creating this graphical
 * component, it must be added to a panel in order to be showed. (@see
 * com.mot.uict.gui.navigator.NavigatorPanel)
 */
public class JNavigator extends JComponent implements ActionListener {
 
  

    private class CustomComparable implements Comparable {
        private Action action;

        public CustomComparable(Action action) {
            CustomComparable.this.action = action;
        }

        public Action getAction() {
            return action;
        }

        public int compareTo(Object o) {
            return defaultComparator.compare(action, ((CustomComparable) o).getAction());
        }
    }

    private class CustomComparator implements Comparator {
        /*
         * This method performs the compartion of two objects in order to define
         * if the first object is greater (negative return number), equal (zero
         * return number) or smaller (positive return number) than the second
         * object. This feature is not being currently used, so the method
         * assumes that all objects are equal.
         */
        public int compare(Object o1, Object o2) {
            return 0;
        }
    }

    private class PopupListener extends MouseAdapter {
        public void mousePressed(MouseEvent e) {
            maybeShowPopup(e);
        }

        public void mouseReleased(MouseEvent e) {
            maybeShowPopup(e);
        }

        private void maybeShowPopup(MouseEvent e) {
            if (e.isPopupTrigger()) {
                popupMenu.show(e.getComponent(), e.getX(), e.getY());
            }
        }
    }

    private ArrayList categoryButtons;

    private Comparator defaultComparator;

    private JPopupMenu popupMenu;

    private NavigatorModel model;

    private int activeCategory;

    private int iconSize;

    
   
    //View Objects
    private JPanel panel            = null;
    private JPanel dummyPanel       = null;
    GridBagLayout gridbag           = null;


    //Custom listeners
    private PopupListener popupListener = new PopupListener();
    
    //ActionListener commands 
    private static final String SMALL_CMD  = "MN1";

    private static final String LARGE_CMD  = "MN2";
    
    private static final String BUTTON_CMD = "BT1";

    /**
     * Creates a new JNavigator object.
     * 
     * @param model -
     *            The NavigatorModel containing the information to be displayed
     *            by the JNavigator *
     */
    public JNavigator(NavigatorModel model) {
        JButton button;
        this.model          = model;
        activeCategory      = 0;
        iconSize            = NavigatorConstants.SMALL_ICON_SIZE;
        categoryButtons     = new ArrayList();
        defaultComparator   = new CustomComparator();
        //View Objects
        panel               = new JPanel();
        dummyPanel          = new JPanel();
        gridbag             = new GridBagLayout();
      
        
        

        for (int i = 0; i < model.size(); i++) {
            button = new JButton(model.getCategory(i));
            button.addActionListener(this);
            button.setFocusable(false);
            button.setActionCommand(BUTTON_CMD);
            button.setToolTipText(model.getCategoryToolTip(i));
            categoryButtons.add(button);
        }

        updateLayout();
        popupMenu = new JPopupMenu();

        JMenuItem menuItem = new JMenuItem("Large Icons");
        menuItem.setMnemonic(KeyEvent.VK_G);
        menuItem.setIcon(ViewConstants.LARGE_ICON);
        menuItem.addActionListener(this);
        menuItem.setActionCommand(LARGE_CMD);
        popupMenu.add(menuItem);
        menuItem = new JMenuItem("Small icons");
        menuItem.setMnemonic(KeyEvent.VK_M);
        menuItem.setIcon(ViewConstants.SMALL_ICON);
        menuItem.addActionListener(this);
        menuItem.setActionCommand(SMALL_CMD);
        popupMenu.add(menuItem);
    }

    /**
     * Sets the JNavigator active category, checking if the new value is a valid
     * one
     * 
     * @param activeCategory
     *            the new activeCategory
     * @throws IllegalArgumentException
     *             if the new value is invalid
     */
    public void setActiveCategory(int activeCategory) {
        if ((activeCategory > model.size()) || (activeCategory < 0)) {
            throw new IllegalArgumentException("Invalid category "
                    + activeCategory + ". There are only " + model.size()
                    + " categories.");
        }

        this.activeCategory = activeCategory;
        updateLayout();
    }

    /**
     * Get the current active category of JNavigator
     * 
     * @return int - ActiveCategory index on the Navigator categories list
     */
    public int getActiveCategory() {
        return activeCategory;
    }

    /**
     * Set the background of the JNavigator (for all categories)
     * 
     * @param color -
     *            the new background color
     */
    public void setBackground(Color color) {
        super.setBackground(color);
        updateLayout();
    }

    /**
     * Set the compator that will be used by the JNavigator in order to compare
     * the performed actions
     * 
     * @param defaultComparator
     */
    public void setDefaultComparator(Comparator defaultComparator) {
        this.defaultComparator = defaultComparator;
        updateLayout();
    }

    private void setIconSize(int iconSize) {
        this.iconSize = iconSize;
        updateLayout();
    }

    /**
     * This method defines the behavior of JNavigator for the changing of
     * categories
     * 
     * @param e -
     *            The event created when an category is selected
     */
    public void actionPerformed(ActionEvent e) {
        String command = e.getActionCommand();
        if (command.equals(LARGE_CMD)) {
            JNavigator.this.setIconSize(NavigatorConstants.LARGE_ICONS);
        } else if (command.equals(SMALL_CMD)) {
            JNavigator.this.setIconSize(NavigatorConstants.SMALL_ICONS);
        } else if (command.equals(BUTTON_CMD)){
            JButton button = (JButton) e.getSource();
            String pressedCategory = button.getText();
            int newCategory = model.getCategory(pressedCategory);
            if (newCategory != -1) {
                activeCategory = newCategory;
                updateLayout();
            }
        }
    }
    
   

    private JPanel getActionsPanel(List actions) {
        
        panel.removeAll();
        panel.removeMouseListener(popupListener);
        panel.setBackground(this.getBackground());

        GridBagConstraints c    = new GridBagConstraints();
        panel.setLayout(gridbag);
        
        
        int rowCount = 0;
        NavigatorCustomButton customButtom;
        
        Iterator it = actions.iterator();

        while (it.hasNext()) {
            c.fill = GridBagConstraints.NONE;
            c.weightx = 0.0;
            c.weighty = 0.0;
            c.gridx = 0;
            c.gridy = rowCount;

            if (iconSize == NavigatorConstants.LARGE_ICONS) {
                c.insets = NavigatorConstants.LARGE_ICONS_INSETS;
                c.anchor = GridBagConstraints.CENTER;
            } else {
                c.insets = NavigatorConstants.SMALL_ICONS_INSETS;
                c.anchor = GridBagConstraints.FIRST_LINE_START;
            }

            rowCount++;
            customButtom = new NavigatorCustomButton(((CustomComparable) it.next()).getAction(), iconSize);
            gridbag.setConstraints(customButtom, c);
            panel.add(customButtom);
        }

        c.fill = GridBagConstraints.BOTH;
        c.weightx = 1.0;
        c.weighty = 1.0;
        c.gridx = 0;
        c.gridy = rowCount;
        c.anchor = GridBagConstraints.FIRST_LINE_START;
        rowCount++;
        
        //Configure dummyPanel 
        dummyPanel.removeAll();
        dummyPanel.setBackground(this.getBackground());
        gridbag.setConstraints(dummyPanel, c);
        dummyPanel.validate();
        
        //Reconfigure main panel
        panel.add(dummyPanel);
        panel.addMouseListener(popupListener);
        panel.validate();
        return panel;
    }

    
    private List sort(List list) {
        ArrayList sortedList = new ArrayList();
        Iterator it = list.iterator();
        while (it.hasNext()) {
            sortedList.add(new CustomComparable((Action)it.next()));
        }
        Collections.sort(sortedList);
        return sortedList;
    }
    

    private void updateLayout() {
        this.removeAll();
        
        
        GridBagConstraints c              = new GridBagConstraints();
        this.setLayout(gridbag);
        JButton button;
        JPanel panel1;
        List actionList;
        int rowCount = 0;

        for (int i = 0; i < model.size(); i++) {
            button = (JButton) categoryButtons.get(i);
            c.fill = GridBagConstraints.HORIZONTAL;
            c.weightx = 1.0;
            c.weighty = 0.0;
            c.gridx = 0;
            c.gridy = rowCount;
            c.anchor = GridBagConstraints.CENTER;
            rowCount++;
            ((GridBagLayout) this.getLayout()).setConstraints(button, c);

            gridbag.setConstraints(button, c);
            this.add(button);

            if (i == activeCategory) {
                panel1 = getActionsPanel(sort(model.getActions(i)));
                c.fill = GridBagConstraints.BOTH;
                c.weightx = 0.0;
                c.weighty = 1.0;
                c.gridx = 0;
                c.gridy = rowCount;
                c.anchor = GridBagConstraints.FIRST_LINE_START;
                rowCount++;

                
                JScrollPane scrollPane  = new JScrollPane(panel1);
                scrollPane.getVerticalScrollBar().setUnitIncrement(15);
                scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
                scrollPane.setBackground(this.getBackground());

                ((GridBagLayout) this.getLayout()).setConstraints(scrollPane, c);
                gridbag.setConstraints(scrollPane, c);
                this.add(scrollPane);
            }
        }
        this.validate();
    }
}
