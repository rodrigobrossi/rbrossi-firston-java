package br.com.crm.components;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Event;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import javax.swing.JDialog;
import javax.swing.JPanel;

public class JBanner extends JPanel implements Runnable {

	private HashMap parameter = new HashMap();

	/**
	 * Serial Version ID
	 */
	private static final long serialVersionUID = -1234036662792729070L;

	/** ************************* */
	/* public integer variables */
	/** ************************* */
	public int width=520;

	public int height=38;

	public int y = 0; // current position y

	public int j = 0; // counter

	public int i = 0; // counter

	public int fheight = 35 ; // font height

	public int xstart = 0; // position at which x starts

	public int ystart = 0; // position at which y starts

	public int xstop = 0; // position at which x stops

	public int ystop = 34; // position at which y stops

	public int msgwidth; // width of msg window

	/** ******************** */
	/* public integer arrays */
	/** ******************** */

	public int[] catfwidth = new int[]{40,40,40}; // integer array of font widths for the category

	// strings

	public int[] msgfwidth = new int[]{470,470,470}; // integer array of font widths for the message

	// strings

	public int[] msgx= new int[]{150,150,150}; // integer array of the center of message

	public int[] catx = new int[]{0,0,0}; // integer array of the center of category

	boolean slept = false;

	// Other control variables

	/** ********************** */
	/* static object variables */
	/** ********************** */
	protected static FontMetrics metrics;

	protected static Graphics gc = null;

	protected static Graphics g;

	
	/** ***************************************** */
	/* protected static variables parsed in ParseArgs class */
	/** ***************************************** */
	protected static String fontname = "Arial";

	protected static int fontsize = 32;

	protected static int fontstyle = Font.BOLD;

	protected static Font font = new Font(fontname,fontstyle,fontsize);

	protected static Color msgbgcolor = Color.yellow; // message area backgroud color

	protected static Color[] catbgcolor = new Color[]{Color.WHITE,Color.BLUE,Color.GREEN} ; // category area background color

	protected static Color tempColor = Color.BLACK;

	protected static Color linkColor = Color.BLUE; // color of msgtext when mouse enter

	protected static Color msgtextcolor = Color.PINK; // message text color

	protected static Color[] cattextcolor= new Color[]{Color.black,Color.black,Color.black} ; // category text color

	protected static int totalmessages =3 ; // total number of messages

	protected static String[] msgtext = new String[]{"Olha!!", "Não é que", "Deu certo (First ON)"}; // array of message strings

	protected static String[] cattext = new String[]{"FirstON","FirstON","FirstON"}; // array of category strings

	protected static String[] textURL = new String[]{"http://www.google.com.br","http://www.google.com.br","http://www.google.com.br"}; // array of URL strings

	protected static String valign= "Left";

	protected static String align = "Center";

	protected static String direction ="TopBottom";

	protected static int delay=50; // what does this do?

	//protected int speed= 1000; // what does this do?

	protected static int catwidth = 130; // width of the category space

	protected static int pauseDelay=1000; // amount of time of delay(milliseconds)
	

	protected static int xdelta = 1; // change in x

	protected static int ydelta = 1; // change in y

	private Thread juicer; // our thread

	private BufferedImage bufferedDisplayImage;

	public JBanner(Graphics graphics) {
		this.g =graphics;
		init();
	}
	public JBanner() {
		init();
	}
	/** ********** */
	/* init method */
	/** ********** */
	public void init() {
		this.setSize(width, height);
		//tempColor = msgtextcolor;

		// initialize the arrays
		catfwidth = new int[totalmessages];
		catx = new int[totalmessages];
		msgfwidth = new int[totalmessages];
		msgx = new int[totalmessages];
		msgfwidth = new int[totalmessages];

		// instantiate the font object
		font = new Font(fontname, fontstyle, fontsize);
		
		if(g ==null){
			this.setVisible(true);
			g = this.getGraphics(); 
		}
		
		if(g!=null){
		
		metrics = g.getFontMetrics(font);
		fheight = metrics.getMaxAscent() - metrics.getMaxDescent() + 2;

		msgwidth = width - catwidth;

		for (i = 0; i < totalmessages; i++) {
			catfwidth[i] = metrics.stringWidth(cattext[i]);
			catx[i] = ((catwidth - catfwidth[i]) / 2);

			msgfwidth[i] = metrics.stringWidth(msgtext[i]);
			msgx[i] = ((msgwidth - msgfwidth[i]) / 2 + catwidth);
		}
		i = 0;

		try {
			if (direction.equalsIgnoreCase("BottomTop")) {
				ystart = y = height + fheight;
				ystop = -fheight;
				int dist = Math.abs(ystop - ystart);
				if (dist % ydelta != 0)
					ystop -= ydelta - (dist % ydelta);
				xstart = msgx[0];
				xstop = xdelta = 0;
				ydelta = -ydelta;
			}

			else if (direction.equalsIgnoreCase("TopBottom")) {
				ystart = y = -fheight;
				ystop = height + fheight;
				int dist = Math.abs(ystop - ystart);
				if (dist % ydelta != 0)
					ystop += ydelta - (dist % ydelta);
				xstart = msgx[0];
				xstop = xdelta = 0;
			}
		} catch (Exception e) {
			ystart = y = -fheight;
			ystop = height + fheight;
			int dist = Math.abs(ystop - ystart);
			if (dist % ydelta != 0)
				ystop += ydelta - (dist % ydelta);
			xstart = msgx[0];
			xstop = xdelta = 0;
		}
		}
	}

	/** *********** */
	/* start method */
	/** *********** */
	public void start() {
		if (juicer == null) {
			juicer = new Thread(this);
			juicer.start();
		}
	}

	/** ********** */
	/* stop method */
	/** ********** */
	public void stop() {
		if ((juicer != null) && (juicer.isAlive())) {
			juicer.stop();
			juicer = null;
		}
	}

	/** ********* */
	/* run method */
	/** ********* */
	public void run() {
		while (juicer != null) {
			update(g);
			try {
				juicer.sleep(delay);
			} catch (InterruptedException e) {
				System.out.println("something wrong with juicer");
			}

			// test for middle
			if ((y == (height - fheight) / 2 + fheight - 1) && slept == false) {
				try {
					juicer.sleep(pauseDelay);
				} catch (InterruptedException e) {
					System.out.println("juicer pauseDelay");
				}
				slept = true;
			}

			// haven't reached the top
			if (y != ystop)
				y += ydelta;

			// have reached the top
			else {
				y = ystart; // reset y

				// go back to first message if necessary
				if (i == (totalmessages - 1)) {
					i = 0;
					slept = false;
				}

				// go to next message
				else {
					i++;
					slept = false;
				}
			}
		}
	}

	/** ************** */
	/* update method */
	/** ************** */
	public void update(Graphics g) {
		paint(g);
	}
	
	

	/** *********** */
	/* paint method */
	/** *********** */
	public void paint(Graphics g) {
		g = this.getGraphics();
		Dimension size = new Dimension(width,height);
		if (bufferedDisplayImage == null) {
			bufferedDisplayImage = new BufferedImage(size.width, size.height,BufferedImage.TYPE_USHORT_565_RGB);
		} else {
			bufferedDisplayImage = resizeBufferedImage(bufferedDisplayImage, size.width, size.height);
		}
		gc = bufferedDisplayImage.getGraphics();
	
		gc.setFont(font);

		// draw and fill the category rectangle
		gc.setColor(catbgcolor[i]);
		gc.fillRect(2, 2, catwidth - 4, height - 4);

		// draw the category string
		gc.setColor(cattextcolor[i]);
		gc.drawString(cattext[i], catx[i], y);
		
		// draw and fill the message rectangle
		gc.setColor(msgbgcolor);
		gc.fillRect(catwidth - 2, 2, width - 4, height - 4);

		// draw the message text centered at msgx
		gc.setColor(tempColor);
		gc.drawString(msgtext[i], msgx[i], y);
		

		// paint the black rectangle
		gc.setColor(Color.black);
		gc.drawRect(0, 0, width - 1, height - 1);

		// paint the white rectangle
		gc.setColor(Color.white);
		gc.drawRect(1, 1, width - 3, height - 3);
		gc.drawRect(2,2, width -5, height -5);
		bufferedDisplayImage.flush();
		
		g.drawImage(bufferedDisplayImage, 0, 0, size.width, size.height,null);
		gc.dispose();
	}

	public boolean mouseUp(Event evt, int x, int y) {
		try {
			URL thingee = new URL(textURL[i]);
			Runtime.getRuntime().exec("iexplorer " + thingee);
		} catch (MalformedURLException e) {
			System.out.println("hey I caught it!!!");
		} catch (IOException e) {
			System.out.println("And I caught it!!!");
		}
		return true;
	}

	public boolean mouseEnter(Event evt, int x, int y) {
		tempColor = linkColor;
		update(g);
		return true;
	}

	public boolean mouseExit(Event evt, int x, int y) {
		tempColor = msgtextcolor;
		update(g);
		return true;
	}

	/**
	 * Return all the Parameters
	 * 
	 * @param string
	 * @return
	 */
	public String getParameter(String string) {
		return (String) parameter.get(string);
	}

	public static BufferedImage resizeBufferedImage(BufferedImage src,
			int width, int height) {
		if (src == null) {
			return null;
		}
		src.coerceData(true);
		int transparency = src.getColorModel().getTransparency();
		GraphicsConfiguration gc = getDefaultConfiguration();
		BufferedImage dest = gc.createCompatibleImage(width, height,
				transparency);
		return dest;
	}

	private static GraphicsConfiguration getDefaultConfiguration() {
		GraphicsEnvironment ge = GraphicsEnvironment
				.getLocalGraphicsEnvironment();
		GraphicsDevice gd = ge.getDefaultScreenDevice();
		return gd.getDefaultConfiguration();
	}
	
	public static void main(String args[]){
		JDialog notices  = new JDialog();
		notices.setSize(520,400);
		notices.setLayout(new BorderLayout());
		JBanner banner = new JBanner();
		notices.add(banner,BorderLayout.CENTER);
		notices.setVisible(true);
		banner.start();
	}
}
