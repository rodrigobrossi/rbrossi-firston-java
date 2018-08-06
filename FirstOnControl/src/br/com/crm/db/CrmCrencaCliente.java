package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmCrencaCliente extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private String crcTitulo;

    /** nullable persistent field */
    private String crcObservacao;

    /** nullable persistent field */
    private String crcDicaRelacionamento;

    /** full constructor */
    public CrmCrencaCliente(String crcTitulo, String crcObservacao, String crcDicaRelacionamento) {
        this.crcTitulo = crcTitulo;
        this.crcObservacao = crcObservacao;
        this.crcDicaRelacionamento = crcDicaRelacionamento;
    }

    /** default constructor */
    public CrmCrencaCliente() {
    }

    /** minimal constructor */
    public CrmCrencaCliente(String crcTitulo) {
        this.crcTitulo = crcTitulo;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCrcTitulo() {
        return this.crcTitulo;
    }

    public void setCrcTitulo(String crcTitulo) {
        this.crcTitulo = crcTitulo;
    }

    public String getCrcObservacao() {
        return this.crcObservacao;
    }

    public void setCrcObservacao(String crcObservacao) {
        this.crcObservacao = crcObservacao;
    }

    public String getCrcDicaRelacionamento() {
        return this.crcDicaRelacionamento;
    }

    public void setCrcDicaRelacionamento(String crcDicaRelacionamento) {
        this.crcDicaRelacionamento = crcDicaRelacionamento;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmCrencaCliente) ) return false;
        CrmCrencaCliente castOther = (CrmCrencaCliente) other;
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
