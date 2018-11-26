package br.com.crm.db.hb;

/**
 * 
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */
public class Filter {

	/**
	 * Holds value of property variavel.
	 */
	private String variavel;

	/**
	 * Holds value of property campo.
	 */
	private String campo;

	/**
	 * Holds value of property operador.
	 */
	private String operador;

	private Object variavelObj;

	/** Creates a new instance of Filtro */
	public Filter() {
	}

	public Filter(String campo, String operador, String variavel) {
		setCampo(campo);
		setOperador(operador);
		setVariavel(variavel);
	}

	/**
	 * Getter for property variavel.
	 * 
	 * @return Value of property variavel.
	 */
	public String getVariavel() {
		return this.variavel;
	}

	/**
	 * Setter for property variavel.
	 * 
	 * @param variavel
	 *            New value of property variavel.
	 */
	public void setVariavel(String variavel) {
		this.variavel = variavel;
	}

	/**
	 * Getter for property campo.
	 * 
	 * @return Value of property campo.
	 */
	public String getCampo() {
		return this.campo;
	}

	/**
	 * Setter for property campo.
	 * 
	 * @param campo
	 *            New value of property campo.
	 */
	public void setCampo(String campo) {
		this.campo = campo;
	}

	/**
	 * Getter for property operador.
	 * 
	 * @return Value of property operador.
	 */
	public String getOperador() {
		return this.operador;
	}

	/**
	 * Setter for property operador.
	 * 
	 * @param operador
	 *            New value of property operador.
	 */
	public void setOperador(String operador) {
		this.operador = operador;
	}

	public Object getVariavelObj() {
		return this.variavelObj;
	}

	public void setVariavelObj(Object variavelObj) {
		this.variavelObj = variavelObj;
	}

}
