package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmEmpresas extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private String empNome;

    /** nullable persistent field */
    private String empCaixaPostal;

    /** nullable persistent field */
    private String empDdd;

    /** nullable persistent field */
    private String empTelefone1;

    /** nullable persistent field */
    private String empTelefone2;

    /** nullable persistent field */
    private String empFax;

    /** nullable persistent field */
    private String empEmail;

    /** nullable persistent field */
    private String empWebsite;

    /** nullable persistent field */
    private String empCondicaoPagamento;

    /** nullable persistent field */
    private String empObservacao;

    /** nullable persistent field */
    private String empNumBenefciarios;

    /** nullable persistent field */
    private String empProduto;

    /** nullable persistent field */
    private String empDataContrato;

    /** nullable persistent field */
    private String empBeneficiciosAgregados;

    /** nullable persistent field */
    private String empPreco;

    /** nullable persistent field */
    private String empSubsidiaParaFuncionario;

    /** nullable persistent field */
    private String empValorFatura;

    /** nullable persistent field */
    private String empQualificacaoMargem;

    /** nullable persistent field */
    private String empDataUltimoReajuste;

    /** nullable persistent field */
    private String empPorcentagemUltimoReajuste;

    /** full constructor */
    public CrmEmpresas(String empNome, String empCaixaPostal, String empDdd, String empTelefone1, String empTelefone2, String empFax, String empEmail, String empWebsite, String empCondicaoPagamento, String empObservacao, String empNumBenefciarios, String empProduto, String empDataContrato, String empBeneficiciosAgregados, String empPreco, String empSubsidiaParaFuncionario, String empValorFatura, String empQualificacaoMargem, String empDataUltimoReajuste, String empPorcentagemUltimoReajuste) {
        this.empNome = empNome;
        this.empCaixaPostal = empCaixaPostal;
        this.empDdd = empDdd;
        this.empTelefone1 = empTelefone1;
        this.empTelefone2 = empTelefone2;
        this.empFax = empFax;
        this.empEmail = empEmail;
        this.empWebsite = empWebsite;
        this.empCondicaoPagamento = empCondicaoPagamento;
        this.empObservacao = empObservacao;
        this.empNumBenefciarios = empNumBenefciarios;
        this.empProduto = empProduto;
        this.empDataContrato = empDataContrato;
        this.empBeneficiciosAgregados = empBeneficiciosAgregados;
        this.empPreco = empPreco;
        this.empSubsidiaParaFuncionario = empSubsidiaParaFuncionario;
        this.empValorFatura = empValorFatura;
        this.empQualificacaoMargem = empQualificacaoMargem;
        this.empDataUltimoReajuste = empDataUltimoReajuste;
        this.empPorcentagemUltimoReajuste = empPorcentagemUltimoReajuste;
    }

    /** default constructor */
    public CrmEmpresas() {
    }

    /** minimal constructor */
    public CrmEmpresas(String empNome) {
        this.empNome = empNome;
    }

    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmpNome() {
        return this.empNome;
    }

    public void setEmpNome(String empNome) {
        this.empNome = empNome;
    }

    public String getEmpCaixaPostal() {
        return this.empCaixaPostal;
    }

    public void setEmpCaixaPostal(String empCaixaPostal) {
        this.empCaixaPostal = empCaixaPostal;
    }

    public String getEmpDdd() {
        return this.empDdd;
    }

    public void setEmpDdd(String empDdd) {
        this.empDdd = empDdd;
    }

    public String getEmpTelefone1() {
        return this.empTelefone1;
    }

    public void setEmpTelefone1(String empTelefone1) {
        this.empTelefone1 = empTelefone1;
    }

    public String getEmpTelefone2() {
        return this.empTelefone2;
    }

    public void setEmpTelefone2(String empTelefone2) {
        this.empTelefone2 = empTelefone2;
    }

    public String getEmpFax() {
        return this.empFax;
    }

    public void setEmpFax(String empFax) {
        this.empFax = empFax;
    }

    public String getEmpEmail() {
        return this.empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getEmpWebsite() {
        return this.empWebsite;
    }

    public void setEmpWebsite(String empWebsite) {
        this.empWebsite = empWebsite;
    }

    public String getEmpCondicaoPagamento() {
        return this.empCondicaoPagamento;
    }

    public void setEmpCondicaoPagamento(String empCondicaoPagamento) {
        this.empCondicaoPagamento = empCondicaoPagamento;
    }

    public String getEmpObservacao() {
        return this.empObservacao;
    }

    public void setEmpObservacao(String empObservacao) {
        this.empObservacao = empObservacao;
    }

    public String getEmpNumBenefciarios() {
        return this.empNumBenefciarios;
    }

    public void setEmpNumBenefciarios(String empNumBenefciarios) {
        this.empNumBenefciarios = empNumBenefciarios;
    }

    public String getEmpProduto() {
        return this.empProduto;
    }

    public void setEmpProduto(String empProduto) {
        this.empProduto = empProduto;
    }

    public String getEmpDataContrato() {
        return this.empDataContrato;
    }

    public void setEmpDataContrato(String empDataContrato) {
        this.empDataContrato = empDataContrato;
    }

    public String getEmpBeneficiciosAgregados() {
        return this.empBeneficiciosAgregados;
    }

    public void setEmpBeneficiciosAgregados(String empBeneficiciosAgregados) {
        this.empBeneficiciosAgregados = empBeneficiciosAgregados;
    }

    public String getEmpPreco() {
        return this.empPreco;
    }

    public void setEmpPreco(String empPreco) {
        this.empPreco = empPreco;
    }

    public String getEmpSubsidiaParaFuncionario() {
        return this.empSubsidiaParaFuncionario;
    }

    public void setEmpSubsidiaParaFuncionario(String empSubsidiaParaFuncionario) {
        this.empSubsidiaParaFuncionario = empSubsidiaParaFuncionario;
    }

    public String getEmpValorFatura() {
        return this.empValorFatura;
    }

    public void setEmpValorFatura(String empValorFatura) {
        this.empValorFatura = empValorFatura;
    }

    public String getEmpQualificacaoMargem() {
        return this.empQualificacaoMargem;
    }

    public void setEmpQualificacaoMargem(String empQualificacaoMargem) {
        this.empQualificacaoMargem = empQualificacaoMargem;
    }

    public String getEmpDataUltimoReajuste() {
        return this.empDataUltimoReajuste;
    }

    public void setEmpDataUltimoReajuste(String empDataUltimoReajuste) {
        this.empDataUltimoReajuste = empDataUltimoReajuste;
    }

    public String getEmpPorcentagemUltimoReajuste() {
        return this.empPorcentagemUltimoReajuste;
    }

    public void setEmpPorcentagemUltimoReajuste(String empPorcentagemUltimoReajuste) {
        this.empPorcentagemUltimoReajuste = empPorcentagemUltimoReajuste;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmEmpresas) ) return false;
        CrmEmpresas castOther = (CrmEmpresas) other;
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
