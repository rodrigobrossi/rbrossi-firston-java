package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmContato extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer empIdFk;

    /** persistent field */
    private Integer lazIdFk;

    /** persistent field */
    private Integer espIdFk;

    /** persistent field */
    private Integer cclIdFk;

    /** persistent field */
    private Integer crcIdFk;

    /** persistent field */
    private Integer estIdFk;

    /** persistent field */
    private Integer tirIdFk;

    /** persistent field */
    private Integer pfcIdFk;

    /** nullable persistent field */
    private String cntNome;

    /** nullable persistent field */
    private String cntChamar;

    /** nullable persistent field */
    private String cntSexo;

    /** nullable persistent field */
    private String cntCidadeNascimento;

    /** nullable persistent field */
    private String cntUfNascimento;

    /** nullable persistent field */
    private String cntAniversario;

    /** nullable persistent field */
    private String cntDdd;

    /** nullable persistent field */
    private String cntTelefone;

    /** nullable persistent field */
    private String cntCelular;

    /** nullable persistent field */
    private String cntFax;

    /** nullable persistent field */
    private String cntNextel;

    /** nullable persistent field */
    private String cntEmail;

    /** nullable persistent field */
    private String cntCntEstadoCivil;

    /** nullable persistent field */
    private String cntDataCasamento;

    /** nullable persistent field */
    private String cntFilhos;

    /** nullable persistent field */
    private String cntNetos;

    /** nullable persistent field */
    private String cntEmpresa;

    /** nullable persistent field */
    private String cntCargo;

    /** nullable persistent field */
    private String cntDepartamento;

    /** nullable persistent field */
    private String cntRamal;

    /** nullable persistent field */
    private String cntSecretaria1;

    /** nullable persistent field */
    private String cntSecretaria2;

    /** nullable persistent field */
    private String cntLazer;

    /** nullable persistent field */
    private String cntEsporte;

    /** nullable persistent field */
    private String cntClube;

    /** nullable persistent field */
    private String cntCrenca;

    /** nullable persistent field */
    private String cntEstilo;

    /** nullable persistent field */
    private String cntProfissao;

    /** nullable persistent field */
    private String cntTipoRelacao;

    /** nullable persistent field */
    private String cntLogradouro;

    /** nullable persistent field */
    private String cntNumero;

    /** nullable persistent field */
    private String cntComplemento;

    /** nullable persistent field */
    private String cntBairo;

    /** nullable persistent field */
    private String cntCep;

    /** nullable persistent field */
    private String cntCidade;

    /** nullable persistent field */
    private String cntUf;

    /** full constructor */
    public CrmContato(Integer empIdFk, Integer lazIdFk, Integer espIdFk, Integer cclIdFk, Integer crcIdFk, Integer estIdFk, Integer tirIdFk, Integer pfcIdFk, String cntNome, String cntChamar, String cntSexo, String cntCidadeNascimento, String cntUfNascimento, String cntAniversario, String cntDdd, String cntTelefone, String cntCelular, String cntFax, String cntNextel, String cntEmail, String cntCntEstadoCivil, String cntDataCasamento, String cntFilhos, String cntNetos, String cntEmpresa, String cntCargo, String cntDepartamento, String cntRamal, String cntSecretaria1, String cntSecretaria2, String cntLazer, String cntEsporte, String cntClube, String cntCrenca, String cntEstilo, String cntProfissao, String cntTipoRelacao, String cntLogradouro, String cntNumero, String cntComplemento, String cntBairo, String cntCep, String cntCidade, String cntUf) {
        this.empIdFk = empIdFk;
        this.lazIdFk = lazIdFk;
        this.espIdFk = espIdFk;
        this.cclIdFk = cclIdFk;
        this.crcIdFk = crcIdFk;
        this.estIdFk = estIdFk;
        this.tirIdFk = tirIdFk;
        this.pfcIdFk = pfcIdFk;
        this.cntNome = cntNome;
        this.cntChamar = cntChamar;
        this.cntSexo = cntSexo;
        this.cntCidadeNascimento = cntCidadeNascimento;
        this.cntUfNascimento = cntUfNascimento;
        this.cntAniversario = cntAniversario;
        this.cntDdd = cntDdd;
        this.cntTelefone = cntTelefone;
        this.cntCelular = cntCelular;
        this.cntFax = cntFax;
        this.cntNextel = cntNextel;
        this.cntEmail = cntEmail;
        this.cntCntEstadoCivil = cntCntEstadoCivil;
        this.cntDataCasamento = cntDataCasamento;
        this.cntFilhos = cntFilhos;
        this.cntNetos = cntNetos;
        this.cntEmpresa = cntEmpresa;
        this.cntCargo = cntCargo;
        this.cntDepartamento = cntDepartamento;
        this.cntRamal = cntRamal;
        this.cntSecretaria1 = cntSecretaria1;
        this.cntSecretaria2 = cntSecretaria2;
        this.cntLazer = cntLazer;
        this.cntEsporte = cntEsporte;
        this.cntClube = cntClube;
        this.cntCrenca = cntCrenca;
        this.cntEstilo = cntEstilo;
        this.cntProfissao = cntProfissao;
        this.cntTipoRelacao = cntTipoRelacao;
        this.cntLogradouro = cntLogradouro;
        this.cntNumero = cntNumero;
        this.cntComplemento = cntComplemento;
        this.cntBairo = cntBairo;
        this.cntCep = cntCep;
        this.cntCidade = cntCidade;
        this.cntUf = cntUf;
    }

    /** default constructor */
    public CrmContato() {
    }

    /** minimal constructor */
    public CrmContato(Integer empIdFk, Integer lazIdFk, Integer espIdFk, Integer cclIdFk, Integer crcIdFk, Integer estIdFk, Integer tirIdFk, Integer pfcIdFk) {
        this.empIdFk = empIdFk;
        this.lazIdFk = lazIdFk;
        this.espIdFk = espIdFk;
        this.cclIdFk = cclIdFk;
        this.crcIdFk = crcIdFk;
        this.estIdFk = estIdFk;
        this.tirIdFk = tirIdFk;
        this.pfcIdFk = pfcIdFk;
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

    public Integer getCclIdFk() {
        return this.cclIdFk;
    }

    public void setCclIdFk(Integer cclIdFk) {
        this.cclIdFk = cclIdFk;
    }

    public Integer getCrcIdFk() {
        return this.crcIdFk;
    }

    public void setCrcIdFk(Integer crcIdFk) {
        this.crcIdFk = crcIdFk;
    }

    public Integer getEstIdFk() {
        return this.estIdFk;
    }

    public void setEstIdFk(Integer estIdFk) {
        this.estIdFk = estIdFk;
    }

    public Integer getTirIdFk() {
        return this.tirIdFk;
    }

    public void setTirIdFk(Integer tirIdFk) {
        this.tirIdFk = tirIdFk;
    }

    public Integer getPfcIdFk() {
        return this.pfcIdFk;
    }

    public void setPfcIdFk(Integer pfcIdFk) {
        this.pfcIdFk = pfcIdFk;
    }

    public String getCntNome() {
        return this.cntNome;
    }

    public void setCntNome(String cntNome) {
        this.cntNome = cntNome;
    }

    public String getCntChamar() {
        return this.cntChamar;
    }

    public void setCntChamar(String cntChamar) {
        this.cntChamar = cntChamar;
    }

    public String getCntSexo() {
        return this.cntSexo;
    }

    public void setCntSexo(String cntSexo) {
        this.cntSexo = cntSexo;
    }

    public String getCntCidadeNascimento() {
        return this.cntCidadeNascimento;
    }

    public void setCntCidadeNascimento(String cntCidadeNascimento) {
        this.cntCidadeNascimento = cntCidadeNascimento;
    }

    public String getCntUfNascimento() {
        return this.cntUfNascimento;
    }

    public void setCntUfNascimento(String cntUfNascimento) {
        this.cntUfNascimento = cntUfNascimento;
    }

    public String getCntAniversario() {
        return this.cntAniversario;
    }

    public void setCntAniversario(String cntAniversario) {
        this.cntAniversario = cntAniversario;
    }

    public String getCntDdd() {
        return this.cntDdd;
    }

    public void setCntDdd(String cntDdd) {
        this.cntDdd = cntDdd;
    }

    public String getCntTelefone() {
        return this.cntTelefone;
    }

    public void setCntTelefone(String cntTelefone) {
        this.cntTelefone = cntTelefone;
    }

    public String getCntCelular() {
        return this.cntCelular;
    }

    public void setCntCelular(String cntCelular) {
        this.cntCelular = cntCelular;
    }

    public String getCntFax() {
        return this.cntFax;
    }

    public void setCntFax(String cntFax) {
        this.cntFax = cntFax;
    }

    public String getCntNextel() {
        return this.cntNextel;
    }

    public void setCntNextel(String cntNextel) {
        this.cntNextel = cntNextel;
    }

    public String getCntEmail() {
        return this.cntEmail;
    }

    public void setCntEmail(String cntEmail) {
        this.cntEmail = cntEmail;
    }

    public String getCntCntEstadoCivil() {
        return this.cntCntEstadoCivil;
    }

    public void setCntCntEstadoCivil(String cntCntEstadoCivil) {
        this.cntCntEstadoCivil = cntCntEstadoCivil;
    }

    public String getCntDataCasamento() {
        return this.cntDataCasamento;
    }

    public void setCntDataCasamento(String cntDataCasamento) {
        this.cntDataCasamento = cntDataCasamento;
    }

    public String getCntFilhos() {
        return this.cntFilhos;
    }

    public void setCntFilhos(String cntFilhos) {
        this.cntFilhos = cntFilhos;
    }

    public String getCntNetos() {
        return this.cntNetos;
    }

    public void setCntNetos(String cntNetos) {
        this.cntNetos = cntNetos;
    }

    public String getCntEmpresa() {
        return this.cntEmpresa;
    }

    public void setCntEmpresa(String cntEmpresa) {
        this.cntEmpresa = cntEmpresa;
    }

    public String getCntCargo() {
        return this.cntCargo;
    }

    public void setCntCargo(String cntCargo) {
        this.cntCargo = cntCargo;
    }

    public String getCntDepartamento() {
        return this.cntDepartamento;
    }

    public void setCntDepartamento(String cntDepartamento) {
        this.cntDepartamento = cntDepartamento;
    }

    public String getCntRamal() {
        return this.cntRamal;
    }

    public void setCntRamal(String cntRamal) {
        this.cntRamal = cntRamal;
    }

    public String getCntSecretaria1() {
        return this.cntSecretaria1;
    }

    public void setCntSecretaria1(String cntSecretaria1) {
        this.cntSecretaria1 = cntSecretaria1;
    }

    public String getCntSecretaria2() {
        return this.cntSecretaria2;
    }

    public void setCntSecretaria2(String cntSecretaria2) {
        this.cntSecretaria2 = cntSecretaria2;
    }

    public String getCntLazer() {
        return this.cntLazer;
    }

    public void setCntLazer(String cntLazer) {
        this.cntLazer = cntLazer;
    }

    public String getCntEsporte() {
        return this.cntEsporte;
    }

    public void setCntEsporte(String cntEsporte) {
        this.cntEsporte = cntEsporte;
    }

    public String getCntClube() {
        return this.cntClube;
    }

    public void setCntClube(String cntClube) {
        this.cntClube = cntClube;
    }

    public String getCntCrenca() {
        return this.cntCrenca;
    }

    public void setCntCrenca(String cntCrenca) {
        this.cntCrenca = cntCrenca;
    }

    public String getCntEstilo() {
        return this.cntEstilo;
    }

    public void setCntEstilo(String cntEstilo) {
        this.cntEstilo = cntEstilo;
    }

    public String getCntProfissao() {
        return this.cntProfissao;
    }

    public void setCntProfissao(String cntProfissao) {
        this.cntProfissao = cntProfissao;
    }

    public String getCntTipoRelacao() {
        return this.cntTipoRelacao;
    }

    public void setCntTipoRelacao(String cntTipoRelacao) {
        this.cntTipoRelacao = cntTipoRelacao;
    }

    public String getCntLogradouro() {
        return this.cntLogradouro;
    }

    public void setCntLogradouro(String cntLogradouro) {
        this.cntLogradouro = cntLogradouro;
    }

    public String getCntNumero() {
        return this.cntNumero;
    }

    public void setCntNumero(String cntNumero) {
        this.cntNumero = cntNumero;
    }

    public String getCntComplemento() {
        return this.cntComplemento;
    }

    public void setCntComplemento(String cntComplemento) {
        this.cntComplemento = cntComplemento;
    }

    public String getCntBairo() {
        return this.cntBairo;
    }

    public void setCntBairo(String cntBairo) {
        this.cntBairo = cntBairo;
    }

    public String getCntCep() {
        return this.cntCep;
    }

    public void setCntCep(String cntCep) {
        this.cntCep = cntCep;
    }

    public String getCntCidade() {
        return this.cntCidade;
    }

    public void setCntCidade(String cntCidade) {
        this.cntCidade = cntCidade;
    }

    public String getCntUf() {
        return this.cntUf;
    }

    public void setCntUf(String cntUf) {
        this.cntUf = cntUf;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmContato) ) return false;
        CrmContato castOther = (CrmContato) other;
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
