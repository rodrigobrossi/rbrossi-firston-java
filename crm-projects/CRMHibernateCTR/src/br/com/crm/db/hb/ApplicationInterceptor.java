package br.com.crm.db.hb;

import org.hibernate.EmptyInterceptor;
import org.hibernate.type.StandardBasicTypes;
import org.hibernate.type.Type;
import org.hibernate.type.descriptor.java.StringJavaType;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Iterator;
import org.hibernate.Transaction;

/**
 * Not utilized By FirstOn Relationship
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public class ApplicationInterceptor extends EmptyInterceptor {
	private static final long serialVersionUID = 1L;

	/** Creates a new instance of ApplicationInterceptor */
	public ApplicationInterceptor() {
	}

	public int[] findDirty(Object obj, Serializable serializable,
			Object[] obj2, Object[] obj3, String[] str, Type[] type) {
		return null;
	}

	public Object instantiate(Class clazz, Serializable serializable) {
		return null;
	}

	public Boolean isUnsaved(Object obj) {
		return null;
	}

	public void onDelete(Object obj, Serializable serializable, Object[] obj2,
			String[] str, Type[] type) {
	}

	public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, Object[] previousState,
			String[] propertyNames, Type[] types) {
		if (entity instanceof PersistentObject) {
			for (int i = 0; i < propertyNames.length; i++) {
				if (types[i] instanceof StringJavaType) {
					if (currentState[i] != null) {
						currentState[i] = ((String) currentState[i]).trim();
					}
				}
			}
		}
		return false;
	}

	public boolean onLoad(Object obj, Serializable serializable, Object[] obj2,
			String[] str, Type[] type) {
		return false;
	}

	public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types) {
		if (entity instanceof PersistentObject) {
			for (int i = 0; i < propertyNames.length; i++) {
				if (types[i] instanceof StringJavaType) {
					if (state[i] != null) {
						state[i] = ((String) state[i]).trim();
					}
				}
			}
		}
		return false;
	}

	public void postFlush(Iterator iterator) {
	}

	public void preFlush(Iterator iterator) {
	}

	public void afterTransactionBegin(Transaction arg0) {
		// TODO Auto-generated method stub
		
	}

	public void afterTransactionCompletion(Transaction arg0) {
		// TODO Auto-generated method stub
		
	}

	public void beforeTransactionCompletion(Transaction arg0) {
		// TODO Auto-generated method stub
		
	}

	public Boolean isTransient(Object arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public void onCollectionRecreate(Object arg0, Serializable arg1) {
		// TODO Auto-generated method stub
		
	}

	public void onCollectionRemove(Object arg0, Serializable arg1) {
		// TODO Auto-generated method stub
		
	}

	public void onCollectionUpdate(Object arg0, Serializable arg1) {
		// TODO Auto-generated method stub
		
	}

	public String onPrepareStatement(String arg0) {
		return null;
	}
}
