package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmPremiacoes extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String prmDescricao;

    /** nullable persistent field */
    private String prmQuantidade;

    /** nullable persistent field */
    private String prmQualificacaoVendao;

    /** nullable persistent field */
    private String prmFormaPagamento;

    /** nullable persistent field */
    private String prmData1;

    /** nullable persistent field */
    private String prmData2;

    /** nullable persistent field */
    private String prmMensagem;

    /** full constructor */
    public CrmPremiacoes(String prmDescricao, String prmQuantidade, String prmQualificacaoVendao, String prmFormaPagamento, String prmData1, String prmData2, String prmMensagem) {
        this.prmDescricao = prmDescricao;
        this.prmQuantidade = prmQuantidade;
        this.prmQualificacaoVendao = prmQualificacaoVendao;
        this.prmFormaPagamento = prmFormaPagamento;
        this.prmData1 = prmData1;
        this.prmData2 = prmData2;
        this.prmMensagem = prmMensagem;
    }

    /** default constructor */
    public CrmPremiacoes() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPrmDescricao() {
        return this.prmDescricao;
    }

    public void setPrmDescricao(String prmDescricao) {
        this.prmDescricao = prmDescricao;
    }

    public String getPrmQuantidade() {
        return this.prmQuantidade;
    }

    public void setPrmQuantidade(String prmQuantidade) {
        this.prmQuantidade = prmQuantidade;
    }

    public String getPrmQualificacaoVendao() {
        return this.prmQualificacaoVendao;
    }

    public void setPrmQualificacaoVendao(String prmQualificacaoVendao) {
        this.prmQualificacaoVendao = prmQualificacaoVendao;
    }

    public String getPrmFormaPagamento() {
        return this.prmFormaPagamento;
    }

    public void setPrmFormaPagamento(String prmFormaPagamento) {
        this.prmFormaPagamento = prmFormaPagamento;
    }

    public String getPrmData1() {
        return this.prmData1;
    }

    public void setPrmData1(String prmData1) {
        this.prmData1 = prmData1;
    }

    public String getPrmData2() {
        return this.prmData2;
    }

    public void setPrmData2(String prmData2) {
        this.prmData2 = prmData2;
    }

    public String getPrmMensagem() {
        return this.prmMensagem;
    }

    public void setPrmMensagem(String prmMensagem) {
        this.prmMensagem = prmMensagem;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmPremiacoes) ) return false;
        CrmPremiacoes castOther = (CrmPremiacoes) other;
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
