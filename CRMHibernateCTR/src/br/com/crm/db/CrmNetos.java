package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmNetos extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer cntIdFk;

    /** nullable persistent field */
    private String netNome;

    /** nullable persistent field */
    private String netDataAniversario;

    /** nullable persistent field */
    private String netIdade;

    /** full constructor */
    public CrmNetos(Integer cntIdFk, String netNome, String netDataAniversario, String netIdade) {
        this.cntIdFk = cntIdFk;
        this.netNome = netNome;
        this.netDataAniversario = netDataAniversario;
        this.netIdade = netIdade;
    }

    /** default constructor */
    public CrmNetos() {
    }

    /** minimal constructor */
    public CrmNetos(Integer cntIdFk) {
        this.cntIdFk = cntIdFk;
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

    public String getNetNome() {
        return this.netNome;
    }

    public void setNetNome(String netNome) {
        this.netNome = netNome;
    }

    public String getNetDataAniversario() {
        return this.netDataAniversario;
    }

    public void setNetDataAniversario(String netDataAniversario) {
        this.netDataAniversario = netDataAniversario;
    }

    public String getNetIdade() {
        return this.netIdade;
    }

    public void setNetIdade(String netIdade) {
        this.netIdade = netIdade;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmNetos) ) return false;
        CrmNetos castOther = (CrmNetos) other;
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
