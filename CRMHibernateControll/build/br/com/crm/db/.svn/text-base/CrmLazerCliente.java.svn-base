package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmLazerCliente extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String lazTitulo;

    /** nullable persistent field */
    private String lazObservacao;

    /** nullable persistent field */
    private String lazDicaRelacionamento;

    /** full constructor */
    public CrmLazerCliente(String lazTitulo, String lazObservacao, String lazDicaRelacionamento) {
        this.lazTitulo = lazTitulo;
        this.lazObservacao = lazObservacao;
        this.lazDicaRelacionamento = lazDicaRelacionamento;
    }

    /** default constructor */
    public CrmLazerCliente() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLazTitulo() {
        return this.lazTitulo;
    }

    public void setLazTitulo(String lazTitulo) {
        this.lazTitulo = lazTitulo;
    }

    public String getLazObservacao() {
        return this.lazObservacao;
    }

    public void setLazObservacao(String lazObservacao) {
        this.lazObservacao = lazObservacao;
    }

    public String getLazDicaRelacionamento() {
        return this.lazDicaRelacionamento;
    }

    public void setLazDicaRelacionamento(String lazDicaRelacionamento) {
        this.lazDicaRelacionamento = lazDicaRelacionamento;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmLazerCliente) ) return false;
        CrmLazerCliente castOther = (CrmLazerCliente) other;
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
