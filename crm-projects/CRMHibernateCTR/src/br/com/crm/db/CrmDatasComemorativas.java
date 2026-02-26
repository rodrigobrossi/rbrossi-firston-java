package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmDatasComemorativas extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer lazIdFk;

    /** persistent field */
    private Integer espIdFk;

    /** persistent field */
    private Integer crcIdFk;

    /** persistent field */
    private Integer cclIdFk;

    /** persistent field */
    private Integer pfcIdFk;

    /** nullable persistent field */
    private String dcmTitulo;

    /** nullable persistent field */
    private String dcmDataComemoracao;

    /** nullable persistent field */
    private String dcmSaudacao;

    /** nullable persistent field */
    private String dcmIniciarSaudacao;

    /** nullable persistent field */
    private String dcmTerminarSaudacao;

    /** nullable persistent field */
    private String dcmPerfilSexo;

    /** nullable persistent field */
    private String dcmPerfilFilhos;

    /** nullable persistent field */
    private String dcmPerfilNetos;

    /** nullable persistent field */
    private String dcmProfissao;

    /** nullable persistent field */
    private String dcmLazer;

    /** nullable persistent field */
    private String dcmEsporte;

    /** nullable persistent field */
    private String dcmClube;

    /** nullable persistent field */
    private String dcmCrenca;

    /** full constructor */
    public CrmDatasComemorativas(Integer lazIdFk, Integer espIdFk, Integer crcIdFk, Integer cclIdFk, Integer pfcIdFk, String dcmTitulo, String dcmDataComemoracao, String dcmSaudacao, String dcmIniciarSaudacao, String dcmTerminarSaudacao, String dcmPerfilSexo, String dcmPerfilFilhos, String dcmPerfilNetos, String dcmProfissao, String dcmLazer, String dcmEsporte, String dcmClube, String dcmCrenca) {
        this.lazIdFk = lazIdFk;
        this.espIdFk = espIdFk;
        this.crcIdFk = crcIdFk;
        this.cclIdFk = cclIdFk;
        this.pfcIdFk = pfcIdFk;
        this.dcmTitulo = dcmTitulo;
        this.dcmDataComemoracao = dcmDataComemoracao;
        this.dcmSaudacao = dcmSaudacao;
        this.dcmIniciarSaudacao = dcmIniciarSaudacao;
        this.dcmTerminarSaudacao = dcmTerminarSaudacao;
        this.dcmPerfilSexo = dcmPerfilSexo;
        this.dcmPerfilFilhos = dcmPerfilFilhos;
        this.dcmPerfilNetos = dcmPerfilNetos;
        this.dcmProfissao = dcmProfissao;
        this.dcmLazer = dcmLazer;
        this.dcmEsporte = dcmEsporte;
        this.dcmClube = dcmClube;
        this.dcmCrenca = dcmCrenca;
    }

    /** default constructor */
    public CrmDatasComemorativas() {
    }

    /** minimal constructor */
    public CrmDatasComemorativas(Integer lazIdFk, Integer espIdFk, Integer crcIdFk, Integer cclIdFk, Integer pfcIdFk) {
        this.lazIdFk = lazIdFk;
        this.espIdFk = espIdFk;
        this.crcIdFk = crcIdFk;
        this.cclIdFk = cclIdFk;
        this.pfcIdFk = pfcIdFk;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getLazIdFk() {
        return this.lazIdFk;
    }

    public void setLazIdFk(Integer lazIdFk) {
        this.lazIdFk = lazIdFk;
    }

    public Integer getEspIdFk() {
        return this.espIdFk;
    }

    public void setEspIdFk(Integer espIdFk) {
        this.espIdFk = espIdFk;
    }

    public Integer getCrcIdFk() {
        return this.crcIdFk;
    }

    public void setCrcIdFk(Integer crcIdFk) {
        this.crcIdFk = crcIdFk;
    }

    public Integer getCclIdFk() {
        return this.cclIdFk;
    }

    public void setCclIdFk(Integer cclIdFk) {
        this.cclIdFk = cclIdFk;
    }

    public Integer getPfcIdFk() {
        return this.pfcIdFk;
    }

    public void setPfcIdFk(Integer pfcIdFk) {
        this.pfcIdFk = pfcIdFk;
    }

    public String getDcmTitulo() {
        return this.dcmTitulo;
    }

    public void setDcmTitulo(String dcmTitulo) {
        this.dcmTitulo = dcmTitulo;
    }

    public String getDcmDataComemoracao() {
        return this.dcmDataComemoracao;
    }

    public void setDcmDataComemoracao(String dcmDataComemoracao) {
        this.dcmDataComemoracao = dcmDataComemoracao;
    }

    public String getDcmSaudacao() {
        return this.dcmSaudacao;
    }

    public void setDcmSaudacao(String dcmSaudacao) {
        this.dcmSaudacao = dcmSaudacao;
    }

    public String getDcmIniciarSaudacao() {
        return this.dcmIniciarSaudacao;
    }

    public void setDcmIniciarSaudacao(String dcmIniciarSaudacao) {
        this.dcmIniciarSaudacao = dcmIniciarSaudacao;
    }

    public String getDcmTerminarSaudacao() {
        return this.dcmTerminarSaudacao;
    }

    public void setDcmTerminarSaudacao(String dcmTerminarSaudacao) {
        this.dcmTerminarSaudacao = dcmTerminarSaudacao;
    }

    public String getDcmPerfilSexo() {
        return this.dcmPerfilSexo;
    }

    public void setDcmPerfilSexo(String dcmPerfilSexo) {
        this.dcmPerfilSexo = dcmPerfilSexo;
    }

    public String getDcmPerfilFilhos() {
        return this.dcmPerfilFilhos;
    }

    public void setDcmPerfilFilhos(String dcmPerfilFilhos) {
        this.dcmPerfilFilhos = dcmPerfilFilhos;
    }

    public String getDcmPerfilNetos() {
        return this.dcmPerfilNetos;
    }

    public void setDcmPerfilNetos(String dcmPerfilNetos) {
        this.dcmPerfilNetos = dcmPerfilNetos;
    }

    public String getDcmProfissao() {
        return this.dcmProfissao;
    }

    public void setDcmProfissao(String dcmProfissao) {
        this.dcmProfissao = dcmProfissao;
    }

    public String getDcmLazer() {
        return this.dcmLazer;
    }

    public void setDcmLazer(String dcmLazer) {
        this.dcmLazer = dcmLazer;
    }

    public String getDcmEsporte() {
        return this.dcmEsporte;
    }

    public void setDcmEsporte(String dcmEsporte) {
        this.dcmEsporte = dcmEsporte;
    }

    public String getDcmClube() {
        return this.dcmClube;
    }

    public void setDcmClube(String dcmClube) {
        this.dcmClube = dcmClube;
    }

    public String getDcmCrenca() {
        return this.dcmCrenca;
    }

    public void setDcmCrenca(String dcmCrenca) {
        this.dcmCrenca = dcmCrenca;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmDatasComemorativas) ) return false;
        CrmDatasComemorativas castOther = (CrmDatasComemorativas) other;
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
