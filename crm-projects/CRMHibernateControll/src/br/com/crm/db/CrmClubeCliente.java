package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmClubeCliente extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private String cclTitulo;

    /** nullable persistent field */
    private String cclObservacao;

    /** full constructor */
    public CrmClubeCliente(String cclTitulo, String cclObservacao) {
        this.cclTitulo = cclTitulo;
        this.cclObservacao = cclObservacao;
    }

    /** default constructor */
    public CrmClubeCliente() {
    }

    /** minimal constructor */
    public CrmClubeCliente(String cclTitulo) {
        this.cclTitulo = cclTitulo;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCclTitulo() {
        return this.cclTitulo;
    }

    public void setCclTitulo(String cclTitulo) {
        this.cclTitulo = cclTitulo;
    }

    public String getCclObservacao() {
        return this.cclObservacao;
    }

    public void setCclObservacao(String cclObservacao) {
        this.cclObservacao = cclObservacao;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmClubeCliente) ) return false;
        CrmClubeCliente castOther = (CrmClubeCliente) other;
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
