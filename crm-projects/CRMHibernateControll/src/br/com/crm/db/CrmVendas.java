package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmVendas extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer cntIdFk;

    /** persistent field */
    private Integer usrIdFk;

    /** persistent field */
    private Integer prdIdFk;

    /** nullable persistent field */
    private String vndVendedor;

    /** nullable persistent field */
    private String vndContato;

    /** nullable persistent field */
    private String vndProduto;

    /** nullable persistent field */
    private String vndNumeroVidas;

    /** nullable persistent field */
    private String vndClassificacao;

    /** nullable persistent field */
    private String vndUsuario;

    /** full constructor */
    public CrmVendas(Integer cntIdFk, Integer usrIdFk, Integer prdIdFk, String vndVendedor, String vndContato, String vndProduto, String vndNumeroVidas, String vndClassificacao, String vndUsuario) {
        this.cntIdFk = cntIdFk;
        this.usrIdFk = usrIdFk;
        this.prdIdFk = prdIdFk;
        this.vndVendedor = vndVendedor;
        this.vndContato = vndContato;
        this.vndProduto = vndProduto;
        this.vndNumeroVidas = vndNumeroVidas;
        this.vndClassificacao = vndClassificacao;
        this.vndUsuario = vndUsuario;
    }

    /** default constructor */
    public CrmVendas() {
    }

    /** minimal constructor */
    public CrmVendas(Integer cntIdFk, Integer usrIdFk, Integer prdIdFk) {
        this.cntIdFk = cntIdFk;
        this.usrIdFk = usrIdFk;
        this.prdIdFk = prdIdFk;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getCntIdFk() {
        return this.cntIdFk;
    }

    public void setCntIdFk(Integer cntIdFk) {
        this.cntIdFk = cntIdFk;
    }

    public Integer getUsrIdFk() {
        return this.usrIdFk;
    }

    public void setUsrIdFk(Integer usrIdFk) {
        this.usrIdFk = usrIdFk;
    }

    public Integer getPrdIdFk() {
        return this.prdIdFk;
    }

    public void setPrdIdFk(Integer prdIdFk) {
        this.prdIdFk = prdIdFk;
    }

    public String getVndVendedor() {
        return this.vndVendedor;
    }

    public void setVndVendedor(String vndVendedor) {
        this.vndVendedor = vndVendedor;
    }

    public String getVndContato() {
        return this.vndContato;
    }

    public void setVndContato(String vndContato) {
        this.vndContato = vndContato;
    }

    public String getVndProduto() {
        return this.vndProduto;
    }

    public void setVndProduto(String vndProduto) {
        this.vndProduto = vndProduto;
    }

    public String getVndNumeroVidas() {
        return this.vndNumeroVidas;
    }

    public void setVndNumeroVidas(String vndNumeroVidas) {
        this.vndNumeroVidas = vndNumeroVidas;
    }

    public String getVndClassificacao() {
        return this.vndClassificacao;
    }

    public void setVndClassificacao(String vndClassificacao) {
        this.vndClassificacao = vndClassificacao;
    }

    public String getVndUsuario() {
        return this.vndUsuario;
    }

    public void setVndUsuario(String vndUsuario) {
        this.vndUsuario = vndUsuario;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmVendas) ) return false;
        CrmVendas castOther = (CrmVendas) other;
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
