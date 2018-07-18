package br.com.crm.core;

import java.beans.PropertyVetoException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JPanel;

import br.com.crm.components.agenda.AgendaPanel;
import br.com.crm.gui.MainFrame;

/**
 * @author rbrossi
 * @version 1.0
 * 
 * The Core application context maintain the general state of this application
 * where the state is defined by the contact information. 
 * The system works focusing just on contact select by time. 
 * it means that you must working focusing on client at time. 
 * Any doubts about these process, please get in touch with our labs.
 */
public class ApplicationContext implements ApplicationConstants {
	
	
	private ContactInfo contactInfo;
	private static MainFrame mainFrame;
	
	private static Map<String,JPanel> applications;
	
	private static List<String> applicationNames;
	
	static{
		//Core applications
		applicationNames = new ArrayList<String>();
		applicationNames.add(0,CORE_APP_AGENDA);
		
		//Core applications
		applications = new HashMap<String,JPanel >();
		applications.put(applicationNames.get(0), new AgendaPanel());
		
	}
		
	public MainFrame getMainFrame() {
		return mainFrame;
	}

	public void setMainFrame(MainFrame mainFrame) {
		this.mainFrame = mainFrame;
	}

	private static ApplicationContext appcontext = null;
	
	private ApplicationContext() {
		// TODO Auto-generated constructor stub
	}
	
	public static ApplicationContext getInstance()
	{
		
		if(appcontext==null){
			appcontext = new ApplicationContext();
		}
		return appcontext;
		
	}

	/**
	 * Return the current contact information
	 * @return
	 */
	public ContactInfo getContatcInfo() {
		return contactInfo;
	}

	/**
	 * set the current contact information
	 * @param contactInfo
	 */
	public void setContatcInfo(ContactInfo contactInfo) {
		this.contactInfo = contactInfo;
		this.mainFrame.fireContactChange();
	}
	
	
	public void launchApplication(String applicationName) throws PropertyVetoException   {
			mainFrame.launchIFrame(applications.get(ApplicationConstants.CORE_APP_AGENDA));
	}
	
	
	
	
}
