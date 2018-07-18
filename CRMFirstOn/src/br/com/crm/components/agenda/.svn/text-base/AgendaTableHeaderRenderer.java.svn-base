/*
 * @(#)AssetTableHeaderRenderer.java
 *
 * (c) COPYRIGHT 2005 MOTOROLA INC.
 * MOTOROLA CONFIDENTIAL PROPRIETARY
 * MOTOROLA Advanced Technology and Software Operations
 *
 * REVISION HISTORY:
 * Author        Date       CR Number         Brief Description
 * ------------- ---------- ----------------- ------------------------------
 * wrb051        05/12/13   LIBhh15088        Initial version.
 * wrb051        05/12/19   LIBhh15088        Inspection LX033555 rework: Rename file name
 *                                            change loca variable name and explain the default
 *                                            value of whoIsSelected.
 * wpl020        06/02/20   LIBhh65570        Initialization of sort variables.                                            
 */

package br.com.crm.components.agenda;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import javax.swing.JLabel;
import javax.swing.JTable;
import javax.swing.SwingConstants;
import javax.swing.border.EmptyBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.JTableHeader;


/**
 * This class is responsable to implement a custon cell editor for the Asset's view.
 * This must be set into a table view.
 * 
 * @author wrb51
 * @see javax.swing.table.DefaultTableCellRenderer
 */
public class AgendaTableHeaderRenderer extends DefaultTableCellRenderer implements MouseListener, MouseMotionListener {
    
 
	private static final long serialVersionUID = -8995915595120157531L;

	private static boolean isPathSortAsc = true;          //Path sorted, static to accessed by a static context        

    private static boolean isSizeSortAsc = true;          //Size sorted, static to accessed by a static context 

    private boolean rendererToXP;                  //Set a Windows XP look & feel  

    private int whoIsSelected;                     //Show who coumn is selected to the moment. Default is 0, for the first visible column. 

    private JTableHeader header;                   //JTable's header 

    private DefaultTableCellRenderer oldRenderer;  //Reffers to the older one to recover the main header is necessary. 

    private int rolloverColumn = -1;               //Offset

   /**
    * Creates a new AssetTableHR object.
    * The constructor is defaul to limit the access only for member of the same package.
    * @param header The original one.
    */
   AgendaTableHeaderRenderer(JTableHeader header) {
      this.header      = header;
      this.oldRenderer = ( DefaultTableCellRenderer )header.getDefaultRenderer();
      header.addMouseListener(this);
      header.addMouseMotionListener(this);
      header.setUpdateTableInRealTime(true);
      header.setResizingAllowed(true);
   }

   /*
    * (non-Javadoc)
    * 
    * @see java.awt.Component#paint(java.awt.Graphics)
    */
    public void paint(Graphics g) {
        super.paint(g);
    }

 
   /*
    * (non-Javadoc)
    * 
    * @see javax.swing.table.TableCellRenderer#getTableCellRendererComponent(javax.swing.JTable,
    *      java.lang.Object, boolean, boolean, int, int)
    */
    public Component getTableCellRendererComponent(JTable table, Object value,
            boolean isSelected, boolean hasFocus, int row, int column) {
      JLabel component = null;

      if (oldRenderer != null) {
         component = ( JLabel )oldRenderer.getTableCellRendererComponent(table, value, isSelected, hasFocus || (column == rolloverColumn), row, column);
      }

      if (rendererToXP) {
         component.setOpaque(true);
         //params used to simule the XP headers 
         component.setBorder(new EmptyBorder(3, 8, 4, 8));
         
      }
      
      
      int id = table.getColumnModel().getColumn(column).getModelIndex();

      if (whoIsSelected == id) {
         component.setHorizontalTextPosition(SwingConstants.LEFT);
         /*
          * Default clause is not present couse the table only has two 
          * columns. By default, there is at least one column and a max of 
          * two columns to renderer.
          * */
         switch (id) {
            case 0:
                if (isPathSortAsc) {
                    component.setIcon(null);
                } else {
                    component.setIcon(null);
                }
                break;
            case 1:
                if (isSizeSortAsc) {
                    component.setIcon(null);
                } else {
                    component.setIcon(null);
                }
                break;
            }
      } else {
         component.setIcon(null);
      }
      return component;
   }

   /**
    * Verify if the path issorter or not. In fact, the boolean represents the order direction. 
    * @return path order!
    */
   public static boolean isPathSortAsc() {
      return isPathSortAsc;
   }

   /**
    * Set order direction
    *
    * @param boolean isPathSortAsc 
    */
   public void setPathSortAsc(boolean isPathSortAsc) {
      AgendaTableHeaderRenderer.isPathSortAsc = isPathSortAsc;
   }

   /**
    * Verify if the size issorter or not. In fact, the boolean represents the order direction.
    *
    * @return size order
    */
   public static boolean isSizeSortAsc() {
      return isSizeSortAsc;
   }

   /**
    * Set order direction
    *
    * @param boolean isSizeSortAsc 
    */    
   public void setSizeSortAsc(boolean isSizeSortAsc) {
      AgendaTableHeaderRenderer.isSizeSortAsc = isSizeSortAsc;
   }

   /**
    * Return the older table header renderer
    *
    * @return oldRenderer.
    */
   DefaultTableCellRenderer getOldRenderer() {
      return oldRenderer;
   }


   /**
    * Return if the renderer respect the windowsXP look & feel.
    *
    * @return boolean rendererToXP
    */
   boolean isRendererToXP() {
      return rendererToXP;
   }

   /**
    * Set the XP Renderer activated.
    *
    * @param true= use XP Renderer, false = dismiss the XP renderer
    */
   void setRendererToXP(boolean rendererToXP) {
      this.rendererToXP = rendererToXP;
   }


   /**
    * Return who is selected
    *
    * @return row index!
    */
   public int getWhoIsSelected() {
      return whoIsSelected;
   }

   /**
    * Determines who is seleceted
    *
    * @param whoIsSelected int = row index. 
    */
   public void setWhoIsSelected(int whoIsSelected) {
      this.whoIsSelected = whoIsSelected;
   }

   
   /*
    * (non-Javadoc)
    * 
    * @see java.awt.event.MouseMotionListener#mouseMoved(java.awt.event.MouseEvent)
    */
    public void mouseMoved(MouseEvent e) {
        updateRolloverColumn(e);
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.awt.event.MouseListener#mouseEntered(java.awt.event.MouseEvent)
     */
    public void mouseEntered(MouseEvent e) {
        updateRolloverColumn(e);
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.awt.event.MouseListener#mouseExited(java.awt.event.MouseEvent)
     */
    public void mouseExited(MouseEvent e) {
        rolloverColumn = -1;
        header.repaint();
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.awt.event.MouseListener#mousePressed(java.awt.event.MouseEvent)
     */
    public void mousePressed(MouseEvent e) {
        rolloverColumn = -1;
        header.repaint();
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.awt.event.MouseListener#mouseReleased(java.awt.event.MouseEvent)
     */
    public void mouseReleased(MouseEvent e) {
        updateRolloverColumn(e);
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.awt.event.MouseListener#mouseClicked(java.awt.event.MouseEvent)
     */
    public void mouseClicked(MouseEvent e) {
    	System.out.println("Clicked");
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.awt.event.MouseMotionListener#mouseDragged(java.awt.event.MouseEvent)
     */
    public void mouseDragged(MouseEvent e) {
    	System.out.println("Dragged");
    }

   /**
    * Update the Header view.
    *
    * @param Event from the mouse!
    */
   private void updateRolloverColumn(MouseEvent e) {
      int col = header.columnAtPoint(e.getPoint());

      if (col != rolloverColumn) {
         rolloverColumn = col;
         header.repaint();
      }
   }
}
