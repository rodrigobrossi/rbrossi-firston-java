package br.com.crm.util;

import br.com.crm.log.LoggerFactory;
import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import br.com.crm.log.Logger;

public class ImageLoader {
    private static final Logger logger = LoggerFactory.getLogger(ImageLoader.class);
    
    // Common image paths (now using PNGs)
    public static final String SPLASH_SCREEN = "resources/images/medicamp_splash_screen.png";
    public static final String ABOUT_IMAGE = "resources/images/medicamp_about.png";
    public static final String TITLE_IMAGE = "resources/images/crm_relationship.png";
    public static final String LOGIN_IMAGE = "resources/images/crm_relationship.png";
    public static final String LOGO_IMAGE = "resources/images/medicamp_about.png";
    public static final String SEARCH_IMAGE = "resources/images/crm_search.png";

    public static Image loadImage(String path) {
        try {
            InputStream is = ImageLoader.class.getClassLoader().getResourceAsStream(path);
            if (is != null) {
                return ImageIO.read(is);
            } else {
                logger.log("Image not found: " + path);
            }
        } catch (IOException e) {
            logger.log("Error loading image: " + path + ", exception: " + e.getMessage());
        }
        return null;
    }

    public static Image loadSplashScreen() {
        return loadImage(SPLASH_SCREEN);
    }

    public static Image loadAboutImage() {
        return loadImage(ABOUT_IMAGE);
    }

    public static Image loadTitleImage() {
        return loadImage(TITLE_IMAGE);
    }

    public static Image loadLoginImage() {
        return loadImage(LOGIN_IMAGE);
    }

    public static Image loadLogoImage() {
        return loadImage(LOGO_IMAGE);
    }

    public static Image loadSearchImage() {
        return loadImage(SEARCH_IMAGE);
    }

    public static void loadImages() {
        try {
            // Load application icon
            URL iconUrl = ImageLoader.class.getResource("/br/com/crm/util/resources/images/crm_relationship.ico");
            if (iconUrl != null) {
                Image icon = ICOConverter.loadICOImage(iconUrl);
                if (icon != null) {
                    // Set application icon
                    Taskbar.getTaskbar().setIconImage(icon);
                }
            }
        } catch (IOException e) {
            logger.log("Error loading images");
        }
    }

    public static ImageIcon loadImageIcon(String path) {
        try {
            URL url = ImageLoader.class.getResource(path);
            if (url != null) {
                Image image = ICOConverter.loadICOImage(url);
                return new ImageIcon(image);
            }
        } catch (IOException e) {
            logger.log("Error loading image: " + path);
        }
        return null;
    }
} 