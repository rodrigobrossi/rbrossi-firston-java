package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmProvidencias extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer usrIdFk;

    /** persistent field */
    private Integer cntIdFk;

    /** nullable persistent field */
    private String prvProvidenciar;

    /** nullable persistent field */
    private String prvParaQuando;

    /** nullable persistent field */
    private String prvQuemDeveProvidenciar;

    /** nullable persistent field */
    private String prvQuemEstaNotando;

    /** nullable persistent field */
    private String prvQuemEstaAguardando;

    /** full constructor */
    public CrmProvidencias(Integer usrIdFk, Integer cntIdFk, String prvProvidenciar, String prvParaQuando, String prvQuemDeveProvidenciar, String prvQuemEstaNotando, String prvQuemEstaAguardando) {
        this.usrIdFk = usrIdFk;
        this.cntIdFk = cntIdFk;
        this.prvProvidenciar = prvProvidenciar;
        this.prvParaQuando = prvParaQuando;
        this.prvQuemDeveProvidenciar = prvQuemDeveProvidenciar;
        this.prvQuemEstaNotando = prvQuemEstaNotando;
        this.prvQuemEstaAguardando = prvQuemEstaAguardando;
    }

    /** default constructor */
    public CrmProvidencias() {
    }

    /** minimal constructor */
    public CrmProvidencias(Integer usrIdFk, Integer cntIdFk) {
        this.usrIdFk = usrIdFk;
        this.cntIdFk = cntIdFk;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getUsrIdFk() {
        return this.usrIdFk;
    }

    public void setUsrIdFk(Integer usrIdFk) {
        this.usrIdFk = usrIdFk;
    }

    public Integer getCntIdFk() {
        return this.cntIdFk;
    }

    public void setCntIdFk(Integer cntIdFk) {
        this.cntIdFk = cntIdFk;
    }

    public String getPrvProvidenciar() {
        return this.prvProvidenciar;
    }

    public void setPrvProvidenciar(String prvProvidenciar) {
        this.prvProvidenciar = prvProvidenciar;
    }

    public String getPrvParaQuando() {
        return this.prvParaQuando;
    }

    public void setPrvParaQuando(String prvParaQuando) {
        this.prvParaQuando = prvParaQuando;
    }

    public String getPrvQuemDeveProvidenciar() {
        return this.prvQuemDeveProvidenciar;
    }

    public void setPrvQuemDeveProvidenciar(String prvQuemDeveProvidenciar) {
        this.prvQuemDeveProvidenciar = prvQuemDeveProvidenciar;
    }

    public String getPrvQuemEstaNotando() {
        return this.prvQuemEstaNotando;
    }

    public void setPrvQuemEstaNotando(String prvQuemEstaNotando) {
        this.prvQuemEstaNotando = prvQuemEstaNotando;
    }

    public String getPrvQuemEstaAguardando() {
        return this.prvQuemEstaAguardando;
    }

    public void setPrvQuemEstaAguardando(String prvQuemEstaAguardando) {
        this.prvQuemEstaAguardando = prvQuemEstaAguardando;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmProvidencias) ) return false;
        CrmProvidencias castOther = (CrmProvidencias) other;
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
