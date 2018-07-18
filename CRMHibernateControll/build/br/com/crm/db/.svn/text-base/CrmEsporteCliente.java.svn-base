package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmEsporteCliente extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String espTitulo;

    /** nullable persistent field */
    private String espObservacao;

    /** full constructor */
    public CrmEsporteCliente(String espTitulo, String espObservacao) {
        this.espTitulo = espTitulo;
        this.espObservacao = espObservacao;
    }

    /** default constructor */
    public CrmEsporteCliente() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEspTitulo() {
        return this.espTitulo;
    }

    public void setEspTitulo(String espTitulo) {
        this.espTitulo = espTitulo;
    }

    public String getEspObservacao() {
        return this.espObservacao;
    }

    public void setEspObservacao(String espObservacao) {
        this.espObservacao = espObservacao;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmEsporteCliente) ) return false;
        CrmEsporteCliente castOther = (CrmEsporteCliente) other;
        return new EqualsBuilder()
            .append(this.getId(), castOther.getId())
            .isEquals();
    }

    public int hashCode() {
        return new HashCodeBuilder()
            .append(getId())
            .toHashCode();
    }

}
