package br.com.crm.db.hb;

import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.swing.JDialog;
import javax.swing.JOptionPane;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.QueryException;
import org.hibernate.ReplicationMode;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.SelectionQuery;
import org.hibernate.type.StandardBasicTypes;
import org.hibernate.query.Query;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;

/**
 * Esta a superclasse dos Pojos gerados pelo middle-gen, ela
 * responsavlpelos metodos que abrangem a persistencia dos dados.
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public class PersistentObject {

	/** Creates a new instance of PersistentObject */
	public PersistentObject() {
	}

	/**
	 * Delete varios objetos ao mesmo tempo
	 * 
	 * @return Boolean de confirmao
	 */
	public Object deleteAll() throws HibernateException {
		// TODO: Tocar o nome do metodo
		Session s = HibernateUtil.getCurrentSession();
		s.delete("from " + this.getClass().getName());
		return "noTable";
	}

	/**
	 * Deleta e caso exista um relacionamento, retorna o nome da classe. Object
	 * Se conseguir deletar, ento retorna uma String com valor noTable. Se no
	 * conseguir deletar retorna uma String com o nome da tabela onde ocorreu o
	 * erro
	 * 
	 * @return Boolean de confirmaconfirmaao
	 */
	public Object deleteCascade() throws HibernateException {
		// TODO: Tocar o nome do mtodo
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		s.delete(this);
		return "noTable";
	}

	/**
	 * Deleta um Objeto
	 * 
	 * @return Boolean de confirmaao
	 */
	public Boolean delete() throws HibernateException {
		Session s = null;
		String cName = this.getClass().getName();
		System.out.println(cName);
		s = HibernateUtil.getCurrentSession();
		s.delete(this);
		return Boolean.TRUE;
	}

	/**
	 * Salva um Objeto
	 * 
	 * @return Boolean de confirmaao
	 */
	public Boolean update() throws HibernateException {
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		s.update(this);
		return Boolean.TRUE;
	}

	/**
	 * Recupera um Lista de Objetos
	 * 
	 * @return Retorna uma Lista com os Obejtos
	 */
	public synchronized List getAll() {
		try {
			if (this.resultList == null) {
				String cName = this.getClass().getName();
				System.out.println(cName);
				Session s = HibernateUtil.getCurrentSession();
				Query query;
				/** MONTA A QUERY */
				StringBuffer stbQuery = new StringBuffer();
				/** QUERY DEFAULT */
				stbQuery.append("from ").append(cName).append(" as f ");

				int index = 0;
				Filter filter = new Filter();
				if (getListOfFilters() != null) {

					for (index = 0; index < listafilter.size(); index++) {
						filter = (Filter) listafilter.get(index);
						if (index == 0) {
							stbQuery.append(" where ");
						} else {
							stbQuery.append(" and ");
						}
						stbQuery.append(" f.").append(filter.getCampo());
						stbQuery.append(" ").append(filter.getOperador());
						stbQuery.append(" :filter").append(index);
						// stbQuery.append(" ").append(filter.getVariavel());
					}
				} else if (getFilter() != null) {
					/** CASO EXISTA UM filter */
					stbQuery.append(" where f.").append(getColunafilter())
							.append(" >= :filter");
				}

				// if (getfilter() != null) {
				/** CASO EXISTA UM filter */
				// stbQuery.append(" where
				// f.").append(getColunafilter()).append(" >= :filter");
				// }
				if (getOrderName() != null) {
					/** CASO QUERIA ORDENAR */
					stbQuery.append(" order by f.").append(getOrderName());
				}
				/** CRIA O OBJETO QUERY COM O STRINGBUFFER */
				query = s.createQuery(stbQuery.toString());

				if (getListOfFilters() != null) {
					for (index = 0; index < listafilter.size(); index++) {
						filter = (Filter) listafilter.get(index);
						query.setParameter("filter" + index, filter
								.getVariavel());
						// stbQuery.append(" ").append(filter.getVariavel());
					}
				} else if (getFilter() != null) {
					query.setParameter("filter", getFilter());
				}

				List result = query.list();
				return result;
			} else {
				return this.resultList;
			}
		} catch (QueryException qe) {
			JOptionPane
					.showMessageDialog(new JDialog(), "Error:"
							+ qe.getMessage(), "Query Error",
							JOptionPane.ERROR_MESSAGE);
		} catch (HibernateException he) {
			JOptionPane.showMessageDialog(new JDialog(), "Error:"
					+ he.getMessage(), "Hibernate Error",
					JOptionPane.ERROR_MESSAGE);
		} catch (Throwable t) {
			JOptionPane
					.showMessageDialog(new JDialog(),
							"Error:" + t.getMessage(), "Kernel Panic",
							JOptionPane.ERROR_MESSAGE);
			System.exit(0);
		}
		return null;
	}

	/**
	 * Copia um Objeto
	 * 
	 * @return tenta copiar um objeto, caso contr�rio volta atr�s e encerra a
	 *         sess�o
	 */
	public Boolean copy() throws HibernateException {
		Session s = null;
		String cName = this.getClass().getName();
		System.out.println(cName);
		s = HibernateUtil.getCurrentSession();
		s.replicate(this, ReplicationMode.IGNORE);
		return Boolean.TRUE;
	}

	/**
	 * Insere um Objeto
	 * 
	 * @return Boolean de confirma�ao
	 */
	public Boolean insert() throws HibernateException {
		Session s = null;
		String cName = this.getClass().getName();
		System.out.println(cName);
		s = HibernateUtil.getCurrentSession();
		s.save(this);
		return Boolean.TRUE;
	}

	/**
	 * Insere um Objeto e limpa a se��o
	 * 
	 * @return Boolean de confirma�ao
	 */
	public Boolean insertClear() throws HibernateException {
		Session s = null;
		String cName = this.getClass().getName();
		System.out.println(cName);
		s = HibernateUtil.getCurrentSession();
		s.save(this);
		s.clear();
		return Boolean.TRUE;
	}

	/**
	 * Salva um Objeto e limpa a se��o
	 * 
	 * @return Boolean de confirma�ao
	 */
	public Boolean updateClear() throws HibernateException {
		Session s = null;
		s = HibernateUtil.getCurrentSession();
		s.update(this);
		s.clear();
		return Boolean.TRUE;
	}

	/**
	 * Insere quando necess�rio, e sava quando necess�rio
	 * 
	 * @return Boolean de confirma�ao
	 */
	public Boolean insertOrUpdate() throws HibernateException {
		String cName = this.getClass().getName();
		System.out.println(cName);
		Session s = HibernateUtil.getCurrentSession();
		s.saveOrUpdate(this);
		return Boolean.TRUE;
	}

	/**
	 * Recupera um Objeto atraves da chave
	 * 
	 * @param chave
	 *            Cheve de valor primitivo int
	 * @return Objeto desejado
	 */
	public Object getObject(int chave) {
		try {
			Session s = HibernateUtil.getCurrentSession();
			Object result = null;
			// FIXME: melhorar o tratamento
			try {
				result = s.load(this.getClass(), new BigDecimal(chave));
			} catch (ClassCastException c) {
				result = s.load(this.getClass(), new Long(chave));
			}
			// HibernateUtil.closeSession();
			return result;
		} catch (HibernateException he) {
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return null;
	}

	/**
	 * Recupera um Objeto atrav�s da chave selecionada.
	 * 
	 * @param chave
	 *            Cheve do Objeto
	 * @return Retorna um boolean
	 */
	public Object getObject(Long chave) {
		try {

			Session s = HibernateUtil.getCurrentSession();
			Object result = null;
			// FIXME: melhorar o tratamento
			result = s.load(this.getClass(), chave);

			// HibernateUtil.closeSession();
			return result;
		} catch (HibernateException he) {
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return null;
	}

	/**
	 * Recupera um objeto e insere ao mesmo tempo
	 * 
	 * @param chave
	 *            a chave do objeto , tipo Long
	 * @param initialize
	 *            indica se o cache deve ser alimentado com os dados desse
	 *            objeto
	 * @return O objeto corresponde a chave
	 */
	public Object getObject(Long chave, boolean initialize) {
		if (!initialize) {
			return getObject(chave);
		}
		try {
			Session s = HibernateUtil.getCurrentSession();
			Object result = null;
			// FIXME: melhorar o tratamento
			result = s.load(this.getClass(), chave);
			Hibernate.initialize(this.getClass());
			// HibernateUtil.closeSession();
			return result;
		} catch (HibernateException he) {
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return null;
	}

	/**
	 * Recupera uma Lista vazia
	 * 
	 * @return Lista instanciada
	 */
	public List getEmptyList() {
		return new ArrayList();
	}

	private String filter = null;

	/**
	 * Seta um filter para a Select HQL
	 * 
	 * @param filter
	 *            Este filter pode ser composto, mas o Alias para ele deve
	 *            serguir o padrao de implementa��o para o m�todo getAll()
	 */
	public void setFilter(String filter) {
		this.filter = filter;
	}

	/**
	 * Este M�todo retorana o filter selecionado
	 * 
	 * @return filter
	 */
	public String getFilter() {
		return filter;
	}

	String columnName = null;

	/**
	 * Seta a coluna para um filter composto
	 * 
	 * @param columnName
	 *            Nome da coluna/atributo de uma tabela/Pojo
	 */
	public void setColunafilter(String columnName) {
		this.columnName = columnName;
	}

	/**
	 * Recupera a coluna do filter
	 * 
	 * @return Nome da coluna/atributo de uma tabela/Pojo
	 */
	public String getColunafilter() {
		return columnName;
	}

	String orderName = null;

	/**
	 * Seta uma ordem de pesquisa
	 * 
	 * @param orderName
	 *            Nome do campo que deve ser setado
	 */
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}

	/**
	 * Recupera a ordem selecionada.
	 * 
	 * @return Campo selekcionado para a Ordena��o
	 */
	public String getOrderName() {
		return this.orderName;
	}

	/**
	 * Realiza uma lista de opera�\u00f5es de tamanho arbitr�rio
	 * 
	 * @param ops
	 *            Array de opera�\u00f5es desejadas
	 * @return Boolean de confirma��o
	 */
	public static Boolean performOperations(HibernateOperation[] ops) {
		Session s = null;
		try {
			s = HibernateUtil.getCurrentSession();
			Transaction tx = s.beginTransaction();
			for (int i = 0; i < ops.length; i++) {
				PersistentObject objeto = ops[i].getObject();
				switch (ops[i].getOperacao()) {
				case HibernateOperation.INSERT:
					s.save(objeto);
					break;
				case HibernateOperation.UPDATE:
					s.update(objeto);
					break;
				case HibernateOperation.DELETE:
					s.delete(objeto);
					break;
				}
			}
			tx.commit();
			return Boolean.TRUE;
		} catch (HibernateException he) {
			if (s != null) {
				s.clear();
			}
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return Boolean.FALSE;
	}

	/**
	 * Realiza uma lista de opera�\u00f5es de tamanho vari�vel
	 * 
	 * @param ops
	 *            List com as opera�\u00f5es
	 * @return Boolean de confirma�ao
	 */
	public static Boolean performOperations(List ops) {
		Session s = null;
		try {
			s = HibernateUtil.getCurrentSession();
			Transaction tx = s.beginTransaction();
			Iterator it = ops.iterator();
			while (it.hasNext()) {
				HibernateOperation op = (HibernateOperation) it.next();
				PersistentObject objeto = op.getObject();
				switch (op.getOperacao()) {
				case HibernateOperation.INSERT:
					s.save(objeto);
					break;
				case HibernateOperation.UPDATE:
					s.update(objeto);
					break;
				case HibernateOperation.DELETE:
					s.delete(objeto);
					break;
				}
			}
			tx.commit();
			return Boolean.TRUE;
		} catch (HibernateException he) {
			if (s != null) {
				s.clear();
			}
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return Boolean.FALSE;
	}

	List listafilter = null;

	private List resultList = null;

	/**
	 * Recupera a lista de filters
	 * 
	 * @return Boolean de confirma�ao
	 */
	public List getListOfFilters() {
		return this.listafilter;
	}

	/**
	 * Carrega um objeto do tipo List que possui outros objetos do tipo filter.
	 * 
	 * @param listafilter
	 *            List com os filters desejados.
	 */
	public void setListOfFilters(List listafilter) {
		this.listafilter = listafilter;
	}

	/**
	 * Setter for property all.
	 * 
	 * @param all
	 *            New value of property all.
	 */
	public void setAll(List all) {
		this.resultList = all;
	}

	/** Select scrollable */
	private int index = 0;

	public void setFetchSize(String strIndex) {
		this.index = Integer.parseInt(strIndex);
	}

	public int getIndexFetchSize() {
		return this.index;
	}

	private int total;

	private String clazz;

	public void setClazz(String classe) {
		this.clazz = classe;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getTotal() {
		return this.total;
	}

	public List getAllPopUp() {
		try {
			if (this.resultList == null) {
				// String cName = this.getClass().getName();
				// String cName = this.clazz.getClass().getName();
				String cName = this.clazz;
				Session s = HibernateUtil.getCurrentSession();
				Query query;
				Query querySize;
				StringBuffer stbQuery = new StringBuffer();
				stbQuery.append("from ").append(cName).append(" as f ");
				/** count */
				StringBuffer stbQuerySize = new StringBuffer();
				stbQuerySize.append("select count(f) ");
				/***/
				int index = 0;
				Filter filter;
				if (getListOfFilters() != null) {
					for (index = 0; index < listafilter.size(); index++) {
						filter = (Filter) listafilter.get(index);
						if (index == 0) {
							stbQuery.append(" where ");
						} else {
							stbQuery.append(" and ");
						}
						stbQuery.append(" f.").append(filter.getCampo());
						stbQuery.append(" ").append(filter.getOperador());
						stbQuery.append(" :filter").append(index);
					}
				} else if (getFilter() != null) {
					/** CASO EXISTA UM filter */
					stbQuery.append(" where f.").append(getColunafilter())
							.append(" >= :filter");
				}
				stbQuerySize.append(stbQuery);
				if (getOrderName() != null) {
					/** CASO QUERIA ORDENAR */
					stbQuery.append(" order by f.").append(getOrderName());
				}
				/** CRIA O OBJETO QUERY COM O STRINGBUFFER */
				// System.out.println("QUERY: "+stbQuery.toString());
				query = s.createQuery(stbQuery.toString());
				querySize = s.createQuery(stbQuerySize.toString());

				if (getListOfFilters() != null) {
					for (index = 0; index < listafilter.size(); index++) {
						filter = (Filter) listafilter.get(index);
						query.setParameter("filter" + index, filter
								.getVariavel());
						querySize.setParameter("filter" + index, filter
								.getVariavel());
					}
				} else if (getFilter() != null) {
					query.setParameter("filter", getFilter());
					querySize.setParameter("filter", getFilter());
				}

				/** configura��o */
				query.setMaxResults(7);
				query.setFirstResult(this.index);
				/***/
				// this.total = ((Integer)querySize.uniqueResult()).intValue();
				this.setTotal(((Integer) querySize.uniqueResult()).intValue());

				List result = query.list();
				return result;
			} else {
				return this.resultList;
			}
		} catch (HibernateException he) {
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return null;
	}

	public String getFieldObject(String chave, String campoResultado,
			String campoChave) {
		try {
			Session s = HibernateUtil.getCurrentSession();
			StringBuffer stb = new StringBuffer();
			stb.append("select f.").append(campoResultado).append(" from ")
					.append(this.clazz).append(" as f ");
			stb.append(" where f.").append(campoChave).append("=")
					.append(chave);
			Query query = s.createQuery(stb.toString());
			return query.uniqueResult().toString();
		} catch (HibernateException he) {
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return null;
	}

	public List executeQueryPage(Query query) {
		try {
			System.out.println("QUERY BASIC: " + query.getQueryString());
			query.setFirstResult(this.index);
			return query.list();
		} catch (HibernateException he) {
			he.printStackTrace();
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return null;
	}

	/**
	 * @param lista:
	 *            Lista com os dados a serem ordenador
	 * @param metodo:
	 *            Nome do m�todo que retorna o valor a ser comparado
	 */
	public List ordena(List lista, final String metodo) {
		List result = new ArrayList();
		try {
			result.addAll(lista);
			final Class[] c = { new String().getClass() };
				Collections.sort(lista, new Comparator() {
				public int compare(Object a, Object b) {
					int result = 0;
					try {
						Method mtA = null;
						Method mtB = null;
						mtA = a.getClass().getMethod(metodo, c);
						mtB = b.getClass().getMethod(metodo, c);
						result = ((String) mtA.invoke(a, null))
								.compareToIgnoreCase((String) mtB.invoke(b,
										null));
					} catch (Exception e) {
						e.printStackTrace();
					}
					return result;
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
