package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmProduto extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private String prdTitulo;

    /** nullable persistent field */
    private String prdDescricao;

    /** nullable persistent field */
    private String prdPrecoUnidade;

    /** full constructor */
    public CrmProduto(String prdTitulo, String prdDescricao, String prdPrecoUnidade) {
        this.prdTitulo = prdTitulo;
        this.prdDescricao = prdDescricao;
        this.prdPrecoUnidade = prdPrecoUnidade;
    }

    /** default constructor */
    public CrmProduto() {
    }

    /** minimal constructor */
    public CrmProduto(String prdTitulo) {
        this.prdTitulo = prdTitulo;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPrdTitulo() {
        return this.prdTitulo;
    }

    public void setPrdTitulo(String prdTitulo) {
        this.prdTitulo = prdTitulo;
    }

    public String getPrdDescricao() {
        return this.prdDescricao;
    }

    public void setPrdDescricao(String prdDescricao) {
        this.prdDescricao = prdDescricao;
    }

    public String getPrdPrecoUnidade() {
        return this.prdPrecoUnidade;
    }

    public void setPrdPrecoUnidade(String prdPrecoUnidade) {
        this.prdPrecoUnidade = prdPrecoUnidade;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmProduto) ) return false;
        CrmProduto castOther = (CrmProduto) other;
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
