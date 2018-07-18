package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmEstiloCliente extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String estTitulo;

    /** nullable persistent field */
    private String estOservacao;

    /** nullable persistent field */
    private String estDicaRelacionamento;

    /** full constructor */
    public CrmEstiloCliente(String estTitulo, String estOservacao, String estDicaRelacionamento) {
        this.estTitulo = estTitulo;
        this.estOservacao = estOservacao;
        this.estDicaRelacionamento = estDicaRelacionamento;
    }

    /** default constructor */
    public CrmEstiloCliente() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEstTitulo() {
        return this.estTitulo;
    }

    public void setEstTitulo(String estTitulo) {
        this.estTitulo = estTitulo;
    }

    public String getEstOservacao() {
        return this.estOservacao;
    }

    public void setEstOservacao(String estOservacao) {
        this.estOservacao = estOservacao;
    }

    public String getEstDicaRelacionamento() {
        return this.estDicaRelacionamento;
    }

    public void setEstDicaRelacionamento(String estDicaRelacionamento) {
        this.estDicaRelacionamento = estDicaRelacionamento;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmEstiloCliente) ) return false;
        CrmEstiloCliente castOther = (CrmEstiloCliente) other;
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
