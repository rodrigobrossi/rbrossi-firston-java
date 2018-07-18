package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmRamoAtividade extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String ratTitulo;

    /** nullable persistent field */
    private String ratObservacao;

    /** full constructor */
    public CrmRamoAtividade(String ratTitulo, String ratObservacao) {
        this.ratTitulo = ratTitulo;
        this.ratObservacao = ratObservacao;
    }

    /** default constructor */
    public CrmRamoAtividade() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRatTitulo() {
        return this.ratTitulo;
    }

    public void setRatTitulo(String ratTitulo) {
        this.ratTitulo = ratTitulo;
    }

    public String getRatObservacao() {
        return this.ratObservacao;
    }

    public void setRatObservacao(String ratObservacao) {
        this.ratObservacao = ratObservacao;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmRamoAtividade) ) return false;
        CrmRamoAtividade castOther = (CrmRamoAtividade) other;
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
