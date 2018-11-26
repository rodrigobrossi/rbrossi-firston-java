package br.com.crm.db;

import br.com.crm.db.hb.PersistentObject;
import java.io.Serializable;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

/** @author Hibernate CodeGenerator */
public class CrmUsuarios extends PersistentObject implements Serializable {

    /** identifier field */
    private Long id;

    /** persistent field */
    private Integer lazIdFk;

    /** persistent field */
    private Integer espIdFk;

    /** persistent field */
    private Integer crcIdFk;

    /** persistent field */
    private Integer tirIdFk;

    /** persistent field */
    private Integer pfcIdFk;

    /** nullable persistent field */
    private String usrNomeUsuario;

    /** nullable persistent field */
    private String usrBeneficiarioDesde;

    /** nullable persistent field */
    private String usrIsAdministrador;

    /** nullable persistent field */
    private String usrOpcadusuarios;

    /** nullable persistent field */
    private String usrOpcadcontatos;

    /** nullable persistent field */
    private String usrOpcadempresas;

    /** nullable persistent field */
    private String usrOpcadramosatividades;

    /** nullable persistent field */
    private String usrOpcadestilosclientes;

    /** nullable persistent field */
    private String usrOpcadcrencas;

    /** nullable persistent field */
    private String usrOpcadesportes;

    /** nullable persistent field */
    private String usrOpcadclubes;

    /** nullable persistent field */
    private String usrOpcadlazares;

    /** nullable persistent field */
    private String usrOpcadprofissoes;

    /** nullable persistent field */
    private String usrOpcaddatascomemorativas;

    /** nullable persistent field */
    private String usrOpcadmensrelacionamento;

    /** nullable persistent field */
    private String usrOpcadtiporelacao;

    /** nullable persistent field */
    private String usrUltimoacesso;

    /** nullable persistent field */
    private String usrAniversario;

    /** nullable persistent field */
    private String usrSexo;

    /** nullable persistent field */
    private String usrFilhos;

    /** nullable persistent field */
    private String usrLazer;

    /** nullable persistent field */
    private String usrEsporte;

    /** nullable persistent field */
    private String usrProfissao;

    /** nullable persistent field */
    private String usrCargoFuncao;

    /** nullable persistent field */
    private String usrDataAdmissao;

    /** nullable persistent field */
    private String usrSenhaUsuario;

    /** nullable persistent field */
    private String usrRefazerSenha;

    /** full constructor */
    public CrmUsuarios(Integer lazIdFk, Integer espIdFk, Integer crcIdFk, Integer tirIdFk, Integer pfcIdFk, String usrNomeUsuario, String usrBeneficiarioDesde, String usrIsAdministrador, String usrOpcadusuarios, String usrOpcadcontatos, String usrOpcadempresas, String usrOpcadramosatividades, String usrOpcadestilosclientes, String usrOpcadcrencas, String usrOpcadesportes, String usrOpcadclubes, String usrOpcadlazares, String usrOpcadprofissoes, String usrOpcaddatascomemorativas, String usrOpcadmensrelacionamento, String usrOpcadtiporelacao, String usrUltimoacesso, String usrAniversario, String usrSexo, String usrFilhos, String usrLazer, String usrEsporte, String usrProfissao, String usrCargoFuncao, String usrDataAdmissao, String usrSenhaUsuario, String usrRefazerSenha) {
        this.lazIdFk = lazIdFk;
        this.espIdFk = espIdFk;
        this.crcIdFk = crcIdFk;
        this.tirIdFk = tirIdFk;
        this.pfcIdFk = pfcIdFk;
        this.usrNomeUsuario = usrNomeUsuario;
        this.usrBeneficiarioDesde = usrBeneficiarioDesde;
        this.usrIsAdministrador = usrIsAdministrador;
        this.usrOpcadusuarios = usrOpcadusuarios;
        this.usrOpcadcontatos = usrOpcadcontatos;
        this.usrOpcadempresas = usrOpcadempresas;
        this.usrOpcadramosatividades = usrOpcadramosatividades;
        this.usrOpcadestilosclientes = usrOpcadestilosclientes;
        this.usrOpcadcrencas = usrOpcadcrencas;
        this.usrOpcadesportes = usrOpcadesportes;
        this.usrOpcadclubes = usrOpcadclubes;
        this.usrOpcadlazares = usrOpcadlazares;
        this.usrOpcadprofissoes = usrOpcadprofissoes;
        this.usrOpcaddatascomemorativas = usrOpcaddatascomemorativas;
        this.usrOpcadmensrelacionamento = usrOpcadmensrelacionamento;
        this.usrOpcadtiporelacao = usrOpcadtiporelacao;
        this.usrUltimoacesso = usrUltimoacesso;
        this.usrAniversario = usrAniversario;
        this.usrSexo = usrSexo;
        this.usrFilhos = usrFilhos;
        this.usrLazer = usrLazer;
        this.usrEsporte = usrEsporte;
        this.usrProfissao = usrProfissao;
        this.usrCargoFuncao = usrCargoFuncao;
        this.usrDataAdmissao = usrDataAdmissao;
        this.usrSenhaUsuario = usrSenhaUsuario;
        this.usrRefazerSenha = usrRefazerSenha;
    }

    /** default constructor */
    public CrmUsuarios() {
    }

    /** minimal constructor */
    public CrmUsuarios(Integer lazIdFk, Integer espIdFk, Integer crcIdFk, Integer tirIdFk, Integer pfcIdFk) {
        this.lazIdFk = lazIdFk;
        this.espIdFk = espIdFk;
        this.crcIdFk = crcIdFk;
        this.tirIdFk = tirIdFk;
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

    public String getUsrNomeUsuario() {
        return this.usrNomeUsuario;
    }

    public void setUsrNomeUsuario(String usrNomeUsuario) {
        this.usrNomeUsuario = usrNomeUsuario;
    }

    public String getUsrBeneficiarioDesde() {
        return this.usrBeneficiarioDesde;
    }

    public void setUsrBeneficiarioDesde(String usrBeneficiarioDesde) {
        this.usrBeneficiarioDesde = usrBeneficiarioDesde;
    }

    public String getUsrIsAdministrador() {
        return this.usrIsAdministrador;
    }

    public void setUsrIsAdministrador(String usrIsAdministrador) {
        this.usrIsAdministrador = usrIsAdministrador;
    }

    public String getUsrOpcadusuarios() {
        return this.usrOpcadusuarios;
    }

    public void setUsrOpcadusuarios(String usrOpcadusuarios) {
        this.usrOpcadusuarios = usrOpcadusuarios;
    }

    public String getUsrOpcadcontatos() {
        return this.usrOpcadcontatos;
    }

    public void setUsrOpcadcontatos(String usrOpcadcontatos) {
        this.usrOpcadcontatos = usrOpcadcontatos;
    }

    public String getUsrOpcadempresas() {
        return this.usrOpcadempresas;
    }

    public void setUsrOpcadempresas(String usrOpcadempresas) {
        this.usrOpcadempresas = usrOpcadempresas;
    }

    public String getUsrOpcadramosatividades() {
        return this.usrOpcadramosatividades;
    }

    public void setUsrOpcadramosatividades(String usrOpcadramosatividades) {
        this.usrOpcadramosatividades = usrOpcadramosatividades;
    }

    public String getUsrOpcadestilosclientes() {
        return this.usrOpcadestilosclientes;
    }

    public void setUsrOpcadestilosclientes(String usrOpcadestilosclientes) {
        this.usrOpcadestilosclientes = usrOpcadestilosclientes;
    }

    public String getUsrOpcadcrencas() {
        return this.usrOpcadcrencas;
    }

    public void setUsrOpcadcrencas(String usrOpcadcrencas) {
        this.usrOpcadcrencas = usrOpcadcrencas;
    }

    public String getUsrOpcadesportes() {
        return this.usrOpcadesportes;
    }

    public void setUsrOpcadesportes(String usrOpcadesportes) {
        this.usrOpcadesportes = usrOpcadesportes;
    }

    public String getUsrOpcadclubes() {
        return this.usrOpcadclubes;
    }

    public void setUsrOpcadclubes(String usrOpcadclubes) {
        this.usrOpcadclubes = usrOpcadclubes;
    }

    public String getUsrOpcadlazares() {
        return this.usrOpcadlazares;
    }

    public void setUsrOpcadlazares(String usrOpcadlazares) {
        this.usrOpcadlazares = usrOpcadlazares;
    }

    public String getUsrOpcadprofissoes() {
        return this.usrOpcadprofissoes;
    }

    public void setUsrOpcadprofissoes(String usrOpcadprofissoes) {
        this.usrOpcadprofissoes = usrOpcadprofissoes;
    }

    public String getUsrOpcaddatascomemorativas() {
        return this.usrOpcaddatascomemorativas;
    }

    public void setUsrOpcaddatascomemorativas(String usrOpcaddatascomemorativas) {
        this.usrOpcaddatascomemorativas = usrOpcaddatascomemorativas;
    }

    public String getUsrOpcadmensrelacionamento() {
        return this.usrOpcadmensrelacionamento;
    }

    public void setUsrOpcadmensrelacionamento(String usrOpcadmensrelacionamento) {
        this.usrOpcadmensrelacionamento = usrOpcadmensrelacionamento;
    }

    public String getUsrOpcadtiporelacao() {
        return this.usrOpcadtiporelacao;
    }

    public void setUsrOpcadtiporelacao(String usrOpcadtiporelacao) {
        this.usrOpcadtiporelacao = usrOpcadtiporelacao;
    }

    public String getUsrUltimoacesso() {
        return this.usrUltimoacesso;
    }

    public void setUsrUltimoacesso(String usrUltimoacesso) {
        this.usrUltimoacesso = usrUltimoacesso;
    }

    public String getUsrAniversario() {
        return this.usrAniversario;
    }

    public void setUsrAniversario(String usrAniversario) {
        this.usrAniversario = usrAniversario;
    }

    public String getUsrSexo() {
        return this.usrSexo;
    }

    public void setUsrSexo(String usrSexo) {
        this.usrSexo = usrSexo;
    }

    public String getUsrFilhos() {
        return this.usrFilhos;
    }

    public void setUsrFilhos(String usrFilhos) {
        this.usrFilhos = usrFilhos;
    }

    public String getUsrLazer() {
        return this.usrLazer;
    }

    public void setUsrLazer(String usrLazer) {
        this.usrLazer = usrLazer;
    }

    public String getUsrEsporte() {
        return this.usrEsporte;
    }

    public void setUsrEsporte(String usrEsporte) {
        this.usrEsporte = usrEsporte;
    }

    public String getUsrProfissao() {
        return this.usrProfissao;
    }

    public void setUsrProfissao(String usrProfissao) {
        this.usrProfissao = usrProfissao;
    }

    public String getUsrCargoFuncao() {
        return this.usrCargoFuncao;
    }

    public void setUsrCargoFuncao(String usrCargoFuncao) {
        this.usrCargoFuncao = usrCargoFuncao;
    }

    public String getUsrDataAdmissao() {
        return this.usrDataAdmissao;
    }

    public void setUsrDataAdmissao(String usrDataAdmissao) {
        this.usrDataAdmissao = usrDataAdmissao;
    }

    public String getUsrSenhaUsuario() {
        return this.usrSenhaUsuario;
    }

    public void setUsrSenhaUsuario(String usrSenhaUsuario) {
        this.usrSenhaUsuario = usrSenhaUsuario;
    }

    public String getUsrRefazerSenha() {
        return this.usrRefazerSenha;
    }

    public void setUsrRefazerSenha(String usrRefazerSenha) {
        this.usrRefazerSenha = usrRefazerSenha;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("id", getId())
            .toString();
    }

    public boolean equals(Object other) {
        if ( !(other instanceof CrmUsuarios) ) return false;
        CrmUsuarios castOther = (CrmUsuarios) other;
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
