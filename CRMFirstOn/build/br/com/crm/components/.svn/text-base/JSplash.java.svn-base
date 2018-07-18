package br.com.crm.components;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JWindow;
import javax.swing.Timer;

import br.com.crm.util.CRMComponentsUtils;

/**
 * This class implements a splash window 
 */
public class JSplash extends JWindow implements ActionListener {

   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

/**
    * Creates the splash window  
    * @param filename - The image filename to be showed in the splash 
    * @param timeout - The time that this splash will be visible
    */
    public JSplash(String filename, int timeout) {
        Dimension size = Toolkit.getDefaultToolkit().getScreenSize();
        displaySplash(filename, timeout, new Point(0,0), size);
    }

    /**
     * Creates the splash window
     * @param parent - the graphical component that the splash is associated with  
     * @param filename - The image filename to be showed in the splash 
     * @param timeout - The time that this splash will be visible
     */
    public JSplash(JFrame parent, String filename, int timeout) {
        super(parent);
        Dimension size = parent.getSize();
        Point location = parent.getLocation();

        parent.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent event) {
                close();
            } 
        });
        displaySplash(filename, timeout, location, size);
    } 

    private void displaySplash(String filename, int timeout, Point location, Dimension size) {
        ImageIcon image = new ImageIcon(CRMComponentsUtils.class.getResource(filename)); 
        int w = image.getIconWidth(); 
        int h = image.getIconHeight(); 
                
        int x = (size.width - w) / 2; 
        int y = (size.height - h) / 2; 
        setBounds(location.x + x, location.y + y, w, h);

        JLabel splash = new JLabel(image); 

        getContentPane().setLayout(new BorderLayout()); 
        getContentPane().add(splash, BorderLayout.CENTER); 

        addKeyListener(new KeyAdapter() {
            public void keyPressed(KeyEvent event) {
                close();
            } 
        });
        
        addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent event) {
                close();
            } 
        });
        
        Timer timer = new Timer(0, this); 
        timer.setInitialDelay(timeout); 
        timer.setRepeats(false); 
        timer.start(); 
    } 

    private void close() {
        setVisible(false); 
        dispose(); 
    }

    public void actionPerformed(ActionEvent event) {
        close();
    } 

}
