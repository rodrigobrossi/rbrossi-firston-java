package br.com.crm.components.navigator;



import java.awt.Color;
import java.awt.Font;
import java.awt.Insets;

/**
 * This class contains the constants used by the Navigator related classes
 */
public interface NavigatorConstants {
   
   public static final byte LARGE_ICONS = 0;
   public static final byte SMALL_ICONS = 1;
   public static final short LARGE_ICON_SIZE            = 36;
   public static final short SMALL_ICON_SIZE            = 20;
   public static final short DEFAULT_LARGE_ICON_SPACING = 4;
   public static final short DEFAULT_SMALL_ICON_SPACING = 1;
   public static final Insets LARGE_ICONS_INSETS = new Insets(10, 10, 0, 0);
   public static final Insets SMALL_ICONS_INSETS = new Insets(10, 10, 0, 0);
   public static final byte STATE_STANDARD    = 0;
   public static final byte STATE_HIGHLIGHTED = 1;
   public static final byte STATE_SELECTED    = 2;
   public static final Color HIGHLIGHTED_COLOR = new Color(193, 210, 238);
   public static final Color SELECTED_COLOR = new Color(152, 181, 226);
   public static final Color SELECTED_BORDER_COLOR = new Color(49, 106, 197);
   public static final Font CUSTOMBUTTON_FONT = new Font("SansSerif", Font.PLAIN, 11);
   
}
