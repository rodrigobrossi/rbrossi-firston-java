/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.connection;

import java.util.HashMap;
import java.util.Map;

public final class NamingService {

	private NamingService() {
		nameValuePairs = new HashMap();
	}

	public static NamingService getInstance() {
		return theObject;
	}

	public Object getAttribute(String name) {
		return nameValuePairs.get(name);
	}

	public void setAttribute(String name, Object object) {
		if (nameValuePairs.get(name) == null)
			nameValuePairs.put(name, object);
		else
			throw new IllegalArgumentException("Objeto j\341 foi armazenado: "
					+ name);
	}

	public void removeAttribute(String name) {
		nameValuePairs.remove(name);
	}

	private static NamingService theObject = new NamingService();
	private Map nameValuePairs;

}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/util/NamingService.class Total
 * time: 16 ms Jad reported messages/errors: Exit status: 0 Caught exceptions:
 */