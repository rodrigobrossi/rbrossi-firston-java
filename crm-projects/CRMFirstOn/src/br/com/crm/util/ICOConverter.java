package br.com.crm.util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

public class ICOConverter {
    public static Image loadICOImage(URL url) throws IOException {
        try (InputStream is = url.openStream()) {
            BufferedImage image = ImageIO.read(is);
            if (image == null) {
                throw new IOException("Failed to load image from: " + url);
            }
            return image;
        }
    }

    public static Image loadICOImage(String resourcePath) throws IOException {
        URL url = ICOConverter.class.getResource(resourcePath);
        if (url == null) {
            throw new IOException("Resource not found: " + resourcePath);
        }
        return loadICOImage(url);
    }
} 