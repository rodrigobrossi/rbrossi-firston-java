package br.com.crm.util;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import java.awt.Image;

public class ImageLoaderTest {
    
    @Test
    public void testLoadSplashScreen() {
        Image image = ImageLoader.loadSplashScreen();
        assertNotNull(image, "Splash screen image should not be null");
    }
    
    @Test
    public void testLoadAboutImage() {
        Image image = ImageLoader.loadAboutImage();
        assertNotNull(image, "About image should not be null");
    }
    
    @Test
    public void testLoadTitleImage() {
        Image image = ImageLoader.loadTitleImage();
        assertNotNull(image, "Title image should not be null");
    }
    
    @Test
    public void testLoadLoginImage() {
        Image image = ImageLoader.loadLoginImage();
        assertNotNull(image, "Login image should not be null");
    }
    
    @Test
    public void testLoadLogoImage() {
        Image image = ImageLoader.loadLogoImage();
        assertNotNull(image, "Logo image should not be null");
    }
    
    @Test
    public void testLoadSearchImage() {
        Image image = ImageLoader.loadSearchImage();
        assertNotNull(image, "Search image should not be null");
    }

    @Test
    public void testLoadRelationshipIcon() {
        Image image = ImageLoader.loadImage("crm_relationship.png");
        assertNotNull(image, "Relationship icon should not be null");
    }

    @Test
    public void testLoadSearchIcon() {
        Image image = ImageLoader.loadImage("crm_search.png");
        assertNotNull(image, "Search icon should not be null");
    }

    @Test
    public void testLoadMuralIcon() {
        Image image = ImageLoader.loadImage("ico_mural.gif");
        assertNotNull(image, "Mural icon should not be null");
    }

    @Test
    public void testLoadPersonIcon() {
        Image image = ImageLoader.loadImage("person.gif");
        assertNotNull(image, "Person icon should not be null");
    }

    @Test
    public void testLoadSmallIcons() {
        Image image = ImageLoader.loadImage("SmallIcons.gif");
        assertNotNull(image, "Small icons should not be null");
    }

    @Test
    public void testLoadLargeIcons() {
        Image image = ImageLoader.loadImage("LargeIcons.gif");
        assertNotNull(image, "Large icons should not be null");
    }
} 