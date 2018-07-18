package br.com.crm.components.banner;

import java.awt.Color;

import br.com.crm.components.JBanner;

public class BannerModel extends JBanner{

	public BannerModel() {
//		String t = b.getParameter("MessageNo");
//
//		try {
//			totalmessages = Integer.parseInt(t);
//		} catch (Exception e) {
//			totalmessages = 0;
//		}
//		catbgcolor = new Color[totalmessages];
//		cattextcolor = new Color[totalmessages];
//		msgtext = new String[totalmessages];
//		cattext = new String[totalmessages];
//		textURL = new String[totalmessages];
//		for (j = 0; j < totalmessages; j++) {
//			msgtext[j] = b.getParameter("msgtext" + j);
//			cattext[j] = b.getParameter("cattext" + j);
//			textURL[j] = b.getParameter("TextURL" + j);
//		}
//
//		fontname = b.getParameter("font");
//
//		if (fontname == null) {
//			fontname = new String("Arial");
//		}
//
//		String s = b.getParameter("fontsize");
//		try {
//			fontsize = Integer.parseInt(s);
//		} catch (Exception e) {
//			fontsize = 36;
//		}
//
//		s = b.getParameter("catwidth");
//		try {
//			catwidth = Integer.parseInt(s);
//		} catch (Exception e) {
//			catwidth = 50;
//		}
//
//		s = b.getParameter("fontstyle");
//		try {
//			if (s.equalsIgnoreCase("Plain"))
//				fontstyle = Font.PLAIN;
//			else if (s.equalsIgnoreCase("Italic"))
//				fontstyle = Font.ITALIC;
//			else if (s.equalsIgnoreCase("BoldItalic")
//					|| s.equalsIgnoreCase("ItalicBold"))
//				fontstyle = Font.ITALIC | Font.BOLD;
//			else
//				fontstyle = Font.BOLD;
//		} catch (Exception e) {
//			fontstyle = Font.BOLD;
//		}
//
//		s = b.getParameter("delay");
//		try {
//			delay = Integer.parseInt(s);
//		} catch (Exception e) {
//			delay = 50;
//		}
//
//		s = b.getParameter("pauseDelay");
//		try {
//			pauseDelay = Integer.parseInt(s);
//		} catch (Exception e) {
//			pauseDelay = 1000;
//		}
//
//		s = b.getParameter("dist");
//		try {
//			ydelta = xdelta = Integer.parseInt(s);
//		} catch (Exception e) {
//			ydelta = xdelta = 5;
//		}
//
//		s = b.getParameter("speed");
//		try {
//			speed = Integer.parseInt(s);
//		} catch (Exception e) {
//			speed = 10;
//		}
//
//		for (j = 0; j < totalmessages; j++) {
//			catbgcolor[j] = parseColor(b.getParameter("catbgcolor" + j));
//			if (catbgcolor[j] == null)
//				catbgcolor[j] = Color.black;
//
//			cattextcolor[j] = parseColor(b.getParameter("cattextcolor" + j));
//			if (cattextcolor[j] == null)
//				cattextcolor[j] = Color.black;
//		}
//
//		msgbgcolor = parseColor(b.getParameter("msgbgcolor"));
//		if (msgbgcolor == null)
//			msgbgcolor = Color.yellow;
//
//		msgtextcolor = parseColor(b.getParameter("msgtextcolor"));
//		if (msgtextcolor == null)
//			msgtextcolor = Color.white;
//
//		linkColor = parseColor(b.getParameter("linkcolor"));
//		if (linkColor == null)
//			linkColor = Color.red;
//
//		/*
//		 * tempColor = parseColor(b.getParameter("tempcolor")); if(tempColor ==
//		 * null) tempColor = Color.blue;
//		 */
//		valign = b.getParameter("valign");
//		align = b.getParameter("align");
//		direction = b.getParameter("direction");
	}

	private Color parseColor(String s) {
		try {
			if (s.equalsIgnoreCase("Yellow"))
				return Color.yellow;
			else if (s.equalsIgnoreCase("Blue"))
				return Color.blue;
			else if (s.equalsIgnoreCase("Black"))
				return Color.black;
			else if (s.equalsIgnoreCase("Red"))
				return Color.red;
			else if (s.equalsIgnoreCase("White"))
				return Color.white;
			else if (s.equalsIgnoreCase("Green"))
				return Color.green;
			else if (s.equalsIgnoreCase("Pink"))
				return Color.pink;
			else if (s.equalsIgnoreCase("Orange"))
				return Color.orange;
			else {
				int off1 = s.indexOf(',');
				int r = Integer.parseInt(s.substring(0, off1));
				int off2 = s.indexOf(',', off1 + 1);
				int g = Integer.parseInt(s.substring(off1 + 1, off2));
				int b = Integer.parseInt(s.substring(off2 + 1));
				return new Color(r, g, b);
			}
		} catch (Exception e) {
			return null;
		}
	}
}
