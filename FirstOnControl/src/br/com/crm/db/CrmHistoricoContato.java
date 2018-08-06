package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmHistoricoContato extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer cntIdFk;

    /** persistent field */
    private Integer usrIdFk;

    /** nullable persistent field */
    private String hisResumo;

    /** nullable persistent field */
    private String hisData;

    /** nullable persistent field */
    private String hisPendente;

    /** nullable persistent field */
    private String hisAlerta;

    /** nullable persistent field */
    private String hisFeedbackUsuario;

    /** full constructor */
    public CrmHistoricoContato(Integer cntIdFk, Integer usrIdFk, String hisResumo, String hisData, String hisPendente, String hisAlerta, String hisFeedbackUsuario) {
        this.cntIdFk = cntIdFk;
        this.usrIdFk = usrIdFk;
        this.hisResumo = hisResumo;
        this.hisData = hisData;
        this.hisPendente = hisPendente;
        this.hisAlerta = hisAlerta;
        this.hisFeedbackUsuario = hisFeedbackUsuario;
    }

    /** default constructor */
    public CrmHistoricoContato() {
    }

    /** minimal constructor */
    public CrmHistoricoContato(Integer cntIdFk, Integer usrIdFk) {
        this.cntIdFk = cntIdFk;
        this.usrIdFk = usrIdFk;
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

    public String getHisResumo() {
        return this.hisResumo;
    }

    public void setHisResumo(String hisResumo) {
        this.hisResumo = hisResumo;
    }

    public String getHisData() {
        return this.hisData;
    }

    public void setHisData(String hisData) {
        this.hisData = hisData;
    }

    public String getHisPendente() {
        return this.hisPendente;
    }

    public void setHisPendente(String hisPendente) {
        this.hisPendente = hisPendente;
    }

    public String getHisAlerta() {
        return this.hisAlerta;
    }

    public void setHisAlerta(String hisAlerta) {
        this.hisAlerta = hisAlerta;
    }

    public String getHisFeedbackUsuario() {
        return this.hisFeedbackUsuario;
    }

    public void setHisFeedbackUsuario(String hisFeedbackUsuario) {
        this.hisFeedbackUsuario = hisFeedbackUsuario;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmHistoricoContato) ) return false;
        CrmHistoricoContato castOther = (CrmHistoricoContato) other;
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
