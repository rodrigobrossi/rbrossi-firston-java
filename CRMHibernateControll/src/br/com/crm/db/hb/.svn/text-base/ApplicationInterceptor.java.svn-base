package br.com.crm.db.hb;

import java.io.Serializable;
import java.util.Iterator;

import org.hibernate.CallbackException;
import org.hibernate.EntityMode;
import org.hibernate.Interceptor;
import org.hibernate.Transaction;
import org.hibernate.type.StringType;
import org.hibernate.type.Type;



/**
 * Not utilized By FirstOn Relationship
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public class ApplicationInterceptor implements Interceptor {

	/** Creates a new instance of ApplicationInterceptor */
	public ApplicationInterceptor() {
	}

	public int[] findDirty(Object obj, Serializable serializable,
			Object[] obj2, Object[] obj3, String[] str, Type[] type) {
		return null;
	}

	public Object instantiate(Class clazz, Serializable serializable)
			throws CallbackException {
		return null;
	}

	public Boolean isUnsaved(Object obj) {
		return null;
	}

	public void onDelete(Object obj, Serializable serializable, Object[] obj2,
			String[] str, Type[] type) throws CallbackException {
	}

	public boolean onFlushDirty(Object obj, Serializable serializable,
			Object[] obj2, Object[] obj3, String[] str, Type[] type)
			throws CallbackException {
		return false;
	}

	public boolean onLoad(Object obj, Serializable serializable, Object[] obj2,
			String[] str, Type[] type) throws CallbackException {
		return false;
	}

	public boolean onSave(Object obj, Serializable serializable, Object[] obj2,
			String[] str, Type[] type) throws CallbackException {
		boolean modified = false;
		for (int index = 0; index < type.length; index++) {
			if (type[index] instanceof StringType) {
				if (obj2[index] != null) {
					if (!str[index].equalsIgnoreCase("husSenha")
							&& !str[index].equalsIgnoreCase("fsiQuery")) {
						obj2[index] = ((String) obj2[index]).toUpperCase();
						modified = true;
					}
				}
			}
		}

		return modified;
	}

	public void postFlush(Iterator iterator) throws CallbackException {
	}

	public void preFlush(Iterator iterator) throws CallbackException {
	}

	@Override
	public void afterTransactionBegin(Transaction arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterTransactionCompletion(Transaction arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void beforeTransactionCompletion(Transaction arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Object getEntity(String arg0, Serializable arg1)
			throws CallbackException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getEntityName(Object arg0) throws CallbackException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object instantiate(String arg0, EntityMode arg1, Serializable arg2)
			throws CallbackException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Boolean isTransient(Object arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void onCollectionRecreate(Object arg0, Serializable arg1)
			throws CallbackException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onCollectionRemove(Object arg0, Serializable arg1)
			throws CallbackException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onCollectionUpdate(Object arg0, Serializable arg1)
			throws CallbackException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String onPrepareStatement(String arg0) {
		return null;
	}
}
