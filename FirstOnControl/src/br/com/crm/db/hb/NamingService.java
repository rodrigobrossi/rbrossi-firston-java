package br.com.crm.db.hb;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 *
 */
public final class NamingService {

	private NamingService() {
		nameValuePairs = new HashMap();
	}

	public static NamingService getInstance() {
		return theObject;
	}

	public Object getAttribute(String s) {
		return nameValuePairs.get(s);
	}

	public void setAttribute(String s, Object obj) {
		if (nameValuePairs.get(s) == null)
			nameValuePairs.put(s, obj);
		else
			throw new IllegalArgumentException("Object not found: " + s);
	}

	public void removeAttribute(String s) {
		nameValuePairs.remove(s);
	}

	private static NamingService theObject = new NamingService();

	private Map nameValuePairs;

}
