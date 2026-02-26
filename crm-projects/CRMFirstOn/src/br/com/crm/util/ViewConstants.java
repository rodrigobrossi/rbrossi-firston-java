package br.com.crm.util;

import javax.swing.ImageIcon;

public interface ViewConstants {

	public static final String IMAGE_PATH = "resources/";
	public static final ImageIcon IMAGE_ICON = new ImageIcon(
			CRMComponentsUtils.class.getResource(IMAGE_PATH + "person.gif"));
	public static final ImageIcon ERROR_ICON = new ImageIcon(
			CRMComponentsUtils.class.getResource(IMAGE_PATH
					+ "images/error.jpg"));
	public static final ImageIcon SEARCH_PERSON_ICON = new ImageIcon(
			CRMComponentsUtils.class.getResource(IMAGE_PATH
					+ "images/person.jpg"));
	public static final ImageIcon IMAGE_MURAL = new ImageIcon(
			CRMComponentsUtils.class.getResource(IMAGE_PATH
					+ "images/ico_mural.gif"));
	public static final ImageIcon SMALL_ICON = new ImageIcon(
			CRMComponentsUtils.class.getResource(IMAGE_PATH
					+ "images/SmallIcons.gif"));
	public static final ImageIcon LARGE_ICON = new ImageIcon(
			CRMComponentsUtils.class.getResource(IMAGE_PATH
					+ "images/LargeIcons.gif"));
	public static final int CRM_HEADER_TITLE = 1;
	public static final int CRM_HEADER_SUB_TITLE = 2;

}