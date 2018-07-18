package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmTipoRelacao extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String tirTipoRelacao;

    /** nullable persistent field */
    private String tirObservacao;

    /** full constructor */
    public CrmTipoRelacao(String tirTipoRelacao, String tirObservacao) {
        this.tirTipoRelacao = tirTipoRelacao;
        this.tirObservacao = tirObservacao;
    }

    /** default constructor */
    public CrmTipoRelacao() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTirTipoRelacao() {
        return this.tirTipoRelacao;
    }

    public void setTirTipoRelacao(String tirTipoRelacao) {
        this.tirTipoRelacao = tirTipoRelacao;
    }

    public String getTirObservacao() {
        return this.tirObservacao;
    }

    public void setTirObservacao(String tirObservacao) {
        this.tirObservacao = tirObservacao;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmTipoRelacao) ) return false;
        CrmTipoRelacao castOther = (CrmTipoRelacao) other;
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
