package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmVendedores extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private String vnrVendedor;

    /** nullable persistent field */
    private String vnrDataAdmissao;

    /** nullable persistent field */
    private String vnrObservacao;

    /** nullable persistent field */
    private String vnrSenhaVenda;

    /** full constructor */
    public CrmVendedores(String vnrVendedor, String vnrDataAdmissao, String vnrObservacao, String vnrSenhaVenda) {
        this.vnrVendedor = vnrVendedor;
        this.vnrDataAdmissao = vnrDataAdmissao;
        this.vnrObservacao = vnrObservacao;
        this.vnrSenhaVenda = vnrSenhaVenda;
    }

    /** default constructor */
    public CrmVendedores() {
    }

    /** minimal constructor */
    public CrmVendedores(String vnrVendedor) {
        this.vnrVendedor = vnrVendedor;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVnrVendedor() {
        return this.vnrVendedor;
    }

    public void setVnrVendedor(String vnrVendedor) {
        this.vnrVendedor = vnrVendedor;
    }

    public String getVnrDataAdmissao() {
        return this.vnrDataAdmissao;
    }

    public void setVnrDataAdmissao(String vnrDataAdmissao) {
        this.vnrDataAdmissao = vnrDataAdmissao;
    }

    public String getVnrObservacao() {
        return this.vnrObservacao;
    }

    public void setVnrObservacao(String vnrObservacao) {
        this.vnrObservacao = vnrObservacao;
    }

    public String getVnrSenhaVenda() {
        return this.vnrSenhaVenda;
    }

    public void setVnrSenhaVenda(String vnrSenhaVenda) {
        this.vnrSenhaVenda = vnrSenhaVenda;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmVendedores) ) return false;
        CrmVendedores castOther = (CrmVendedores) other;
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
