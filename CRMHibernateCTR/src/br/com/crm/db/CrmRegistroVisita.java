package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmRegistroVisita extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer empIdFk;

    /** persistent field */
    private Integer cntIdFk;

    /** nullable persistent field */
    private String rgvTipoVisita;

    /** nullable persistent field */
    private String rgvDataVisita;

    /** nullable persistent field */
    private String rgvQuemVisitou;

    /** nullable persistent field */
    private String rgvMotivo;

    /** nullable persistent field */
    private String rgvResultado;

    /** nullable persistent field */
    private String rgvObservacao;

    /** nullable persistent field */
    private String rgvVisitaRealizada;

    /** nullable persistent field */
    private String rgvVisitaRecebida;

    /** full constructor */
    public CrmRegistroVisita(Integer empIdFk, Integer cntIdFk, String rgvTipoVisita, String rgvDataVisita, String rgvQuemVisitou, String rgvMotivo, String rgvResultado, String rgvObservacao, String rgvVisitaRealizada, String rgvVisitaRecebida) {
        this.empIdFk = empIdFk;
        this.cntIdFk = cntIdFk;
        this.rgvTipoVisita = rgvTipoVisita;
        this.rgvDataVisita = rgvDataVisita;
        this.rgvQuemVisitou = rgvQuemVisitou;
        this.rgvMotivo = rgvMotivo;
        this.rgvResultado = rgvResultado;
        this.rgvObservacao = rgvObservacao;
        this.rgvVisitaRealizada = rgvVisitaRealizada;
        this.rgvVisitaRecebida = rgvVisitaRecebida;
    }

    /** default constructor */
    public CrmRegistroVisita() {
    }

    /** minimal constructor */
    public CrmRegistroVisita(Integer empIdFk, Integer cntIdFk) {
        this.empIdFk = empIdFk;
        this.cntIdFk = cntIdFk;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getEmpIdFk() {
        return this.empIdFk;
    }

    public void setEmpIdFk(Integer empIdFk) {
        this.empIdFk = empIdFk;
    }

    public Integer getCntIdFk() {
        return this.cntIdFk;
    }

    public void setCntIdFk(Integer cntIdFk) {
        this.cntIdFk = cntIdFk;
    }

    public String getRgvTipoVisita() {
        return this.rgvTipoVisita;
    }

    public void setRgvTipoVisita(String rgvTipoVisita) {
        this.rgvTipoVisita = rgvTipoVisita;
    }

    public String getRgvDataVisita() {
        return this.rgvDataVisita;
    }

    public void setRgvDataVisita(String rgvDataVisita) {
        this.rgvDataVisita = rgvDataVisita;
    }

    public String getRgvQuemVisitou() {
        return this.rgvQuemVisitou;
    }

    public void setRgvQuemVisitou(String rgvQuemVisitou) {
        this.rgvQuemVisitou = rgvQuemVisitou;
    }

    public String getRgvMotivo() {
        return this.rgvMotivo;
    }

    public void setRgvMotivo(String rgvMotivo) {
        this.rgvMotivo = rgvMotivo;
    }

    public String getRgvResultado() {
        return this.rgvResultado;
    }

    public void setRgvResultado(String rgvResultado) {
        this.rgvResultado = rgvResultado;
    }

    public String getRgvObservacao() {
        return this.rgvObservacao;
    }

    public void setRgvObservacao(String rgvObservacao) {
        this.rgvObservacao = rgvObservacao;
    }

    public String getRgvVisitaRealizada() {
        return this.rgvVisitaRealizada;
    }

    public void setRgvVisitaRealizada(String rgvVisitaRealizada) {
        this.rgvVisitaRealizada = rgvVisitaRealizada;
    }

    public String getRgvVisitaRecebida() {
        return this.rgvVisitaRecebida;
    }

    public void setRgvVisitaRecebida(String rgvVisitaRecebida) {
        this.rgvVisitaRecebida = rgvVisitaRecebida;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmRegistroVisita) ) return false;
        CrmRegistroVisita castOther = (CrmRegistroVisita) other;
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
