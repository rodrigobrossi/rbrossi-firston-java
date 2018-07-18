package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmProfissaoCliente extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** nullable persistent field */
    private String pfcTitulo;

    /** nullable persistent field */
    private String pfcDiaComemorativo;

    /** nullable persistent field */
    private String pfcMesComemorativo;

    /** nullable persistent field */
    private String pfcObservacao;

    /** nullable persistent field */
    private String pfcDcaRelacionamento;

    /** full constructor */
    public CrmProfissaoCliente(String pfcTitulo, String pfcDiaComemorativo, String pfcMesComemorativo, String pfcObservacao, String pfcDcaRelacionamento) {
        this.pfcTitulo = pfcTitulo;
        this.pfcDiaComemorativo = pfcDiaComemorativo;
        this.pfcMesComemorativo = pfcMesComemorativo;
        this.pfcObservacao = pfcObservacao;
        this.pfcDcaRelacionamento = pfcDcaRelacionamento;
    }

    /** default constructor */
    public CrmProfissaoCliente() {
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPfcTitulo() {
        return this.pfcTitulo;
    }

    public void setPfcTitulo(String pfcTitulo) {
        this.pfcTitulo = pfcTitulo;
    }

    public String getPfcDiaComemorativo() {
        return this.pfcDiaComemorativo;
    }

    public void setPfcDiaComemorativo(String pfcDiaComemorativo) {
        this.pfcDiaComemorativo = pfcDiaComemorativo;
    }

    public String getPfcMesComemorativo() {
        return this.pfcMesComemorativo;
    }

    public void setPfcMesComemorativo(String pfcMesComemorativo) {
        this.pfcMesComemorativo = pfcMesComemorativo;
    }

    public String getPfcObservacao() {
        return this.pfcObservacao;
    }

    public void setPfcObservacao(String pfcObservacao) {
        this.pfcObservacao = pfcObservacao;
    }

    public String getPfcDcaRelacionamento() {
        return this.pfcDcaRelacionamento;
    }

    public void setPfcDcaRelacionamento(String pfcDcaRelacionamento) {
        this.pfcDcaRelacionamento = pfcDcaRelacionamento;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmProfissaoCliente) ) return false;
        CrmProfissaoCliente castOther = (CrmProfissaoCliente) other;
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
