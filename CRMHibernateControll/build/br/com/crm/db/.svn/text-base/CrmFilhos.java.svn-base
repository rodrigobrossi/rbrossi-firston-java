package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmFilhos extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer cntIdFk;

    /** nullable persistent field */
    private String filNome;

    /** nullable persistent field */
    private String filDataAniversario;

    /** nullable persistent field */
    private String filIdade;

    /** full constructor */
    public CrmFilhos(Integer cntIdFk, String filNome, String filDataAniversario, String filIdade) {
        this.cntIdFk = cntIdFk;
        this.filNome = filNome;
        this.filDataAniversario = filDataAniversario;
        this.filIdade = filIdade;
    }

    /** default constructor */
    public CrmFilhos() {
    }

    /** minimal constructor */
    public CrmFilhos(Integer cntIdFk) {
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

    public String getFilNome() {
        return this.filNome;
    }

    public void setFilNome(String filNome) {
        this.filNome = filNome;
    }

    public String getFilDataAniversario() {
        return this.filDataAniversario;
    }

    public void setFilDataAniversario(String filDataAniversario) {
        this.filDataAniversario = filDataAniversario;
    }

    public String getFilIdade() {
        return this.filIdade;
    }

    public void setFilIdade(String filIdade) {
        this.filIdade = filIdade;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmFilhos) ) return false;
        CrmFilhos castOther = (CrmFilhos) other;
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
