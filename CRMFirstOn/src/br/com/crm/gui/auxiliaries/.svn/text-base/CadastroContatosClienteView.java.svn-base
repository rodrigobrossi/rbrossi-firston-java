package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.util.Map;

import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.ClubeClienteCRT;
import br.com.crm.control.ContatoCTR;
import br.com.crm.control.CrencaClienteCTR;
import br.com.crm.control.EmpresasCTR;
import br.com.crm.control.EsporteClienteCTR;
import br.com.crm.control.EstiloClienteCTR;
import br.com.crm.control.LazerContatosCTR;
import br.com.crm.control.ProfissaoClienteCTR;
import br.com.crm.control.TipoRelacaoCTR;
import br.com.crm.db.CrmClubeCliente;
import br.com.crm.db.CrmContato;
import br.com.crm.db.CrmCrencaCliente;
import br.com.crm.db.CrmEmpresas;
import br.com.crm.db.CrmEsporteCliente;
import br.com.crm.db.CrmEstiloCliente;
import br.com.crm.db.CrmLazerCliente;
import br.com.crm.db.CrmProfissaoCliente;
import br.com.crm.db.CrmTipoRelacao;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.util.CRMComponentsUtils;

/**
 * Rodrigo Luis Nolli Brossi
 * FIXME Create the fields that was finished.
 * @author wrb051
 * @version 1.0
 */
public class CadastroContatosClienteView extends AncestorFrame {

	private static final long serialVersionUID = -7384172944530564139L;

	private Map emepresas, lazer, esportes, clubecliente,

	estilos, tipos, profissoes, crencas;

	private JComboBox empresaCombo, lazeCombo, esportesCombo, clubeCombo,
			estilosCobo, tipoCombo, profissoesCombo, crencasCombo;

	private JPanel prerequirements;

	private JPanel mainPanel;

	public CadastroContatosClienteView() {

		createGUI();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#createGUI()
	 */
	public void createGUI() {
		updateMaps();

		mainPanel = new JPanel();
		mainPanel.setLayout(new BorderLayout());
		prerequirements = new JPanel(new GridBagLayout());
		empresaCombo = new JComboBox(getStringArray(emepresas));
		lazeCombo = new JComboBox(getStringArray(lazer));
		esportesCombo = new JComboBox(getStringArray(esportes));
		clubeCombo = new JComboBox(getStringArray(clubecliente));
		estilosCobo = new JComboBox(getStringArray(estilos));
		tipoCombo = new JComboBox(getStringArray(tipos));
		profissoesCombo = new JComboBox(getStringArray(profissoes));
		crencasCombo = new JComboBox(getStringArray(crencas));

		// Create pre-requirement Panel
		addCombo(0, 0, "Empresas:", empresaCombo);
		addCombo(2, 0, "Lazer:", lazeCombo);
		addCombo(0, 2, "Esportes:", esportesCombo);
		addCombo(2, 2, "Clube:", clubeCombo);
		addCombo(0, 4, "Estilo:", estilosCobo);
		addCombo(2, 4, "Tipo Relação:", tipoCombo);
		addCombo(0, 6, "Porfissoes:", profissoesCombo);
		addCombo(2, 6, "Crenças:", crencasCombo);
		prerequirements.setBorder(new TitledBorder(new LineBorder(Color.BLACK,
				1), "Pre requiremets"));

		mainPanel.add(prerequirements, BorderLayout.NORTH);
		putComponent(mainPanel);
	}

	private void addCombo(int x, int y, String title, JComboBox combo) {
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.NONE;
		constraints.weightx = 0.0;
		constraints.gridx = x;
		constraints.gridy = y;
		prerequirements.add(new JLabel(title, JLabel.LEFT), constraints);
		constraints.anchor = GridBagConstraints.WEST;
		constraints.fill = GridBagConstraints.HORIZONTAL;
		constraints.weightx = 1.0;
		constraints.gridx = x ;
		constraints.gridy = y+1;
		prerequirements.add(combo, constraints);
	}

	private String[] getStringArray(Map maps) {
		return CRMComponentsUtils.getElementsFrom(maps.keySet().iterator(),	maps.size());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#loadPersistentObject()
	 */
	public AbstractDataBaseCTR loadPersistentObject() {
		ContatoCTR ctr = new ContatoCTR();
		CrmContato contato = new CrmContato();
		// FIXME Update object
		ctr.setObject(contato);
		return ctr;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#setColor(java.awt.Color)
	 */
	public void setColor(Color color) {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see br.com.crm.gui.app.AncestorFrame#updateGUI()
	 */
	public void updateGUI() {
		this.removeAll();
		this.createGUI();
		this.updateUI();
		this.validate();
		this.repaint();
	}

	public void updateMaps() {
		// Empresas
		EmpresasCTR empcrt = new EmpresasCTR();
		CrmEmpresas empresa = new CrmEmpresas();
		empcrt.setObject(empresa);
		emepresas = CRMComponentsUtils.getMapFrom(empcrt.getData(),
				"EmpObservacao");
		// Lazer
		LazerContatosCTR lazercrt = new LazerContatosCTR();
		CrmLazerCliente lazerCli = new CrmLazerCliente();
		lazercrt.setObject(lazerCli);
		lazer = CRMComponentsUtils.getMapFrom(lazercrt.getData(), "LazTitulo");
		// Esporte
		EsporteClienteCTR esporteCtr = new EsporteClienteCTR();
		CrmEsporteCliente esporte = new CrmEsporteCliente();
		esporteCtr.setObject(esporte);
		esportes = CRMComponentsUtils.getMapFrom(esporteCtr.getData(),
				"EspTitulo");

		// Clube Cliente
		ClubeClienteCRT clubeCtr = new ClubeClienteCRT();
		CrmClubeCliente clube = new CrmClubeCliente();
		clubeCtr.setObject(clube);
		clubecliente = CRMComponentsUtils.getMapFrom(clubeCtr.getData(),
				"CclTitulo");

		// Estilo
		EstiloClienteCTR estiloCtr = new EstiloClienteCTR();
		CrmEstiloCliente estilo = new CrmEstiloCliente();
		estiloCtr.setObject(estilo);
		estilos = CRMComponentsUtils.getMapFrom(estiloCtr.getData(),
				"EstTitulo");
		// Tipo Relacao
		TipoRelacaoCTR tipoCtr = new TipoRelacaoCTR();
		CrmTipoRelacao tipo = new CrmTipoRelacao();
		tipoCtr.setObject(tipo);
		tipos = CRMComponentsUtils.getMapFrom(tipoCtr.getData(), "TirTipoRelacao");

		// Profissoes

		ProfissaoClienteCTR profissaoCtr = new ProfissaoClienteCTR();
		CrmProfissaoCliente profissao = new CrmProfissaoCliente();
		profissaoCtr.setObject(profissao);
		profissoes = CRMComponentsUtils.getMapFrom(profissaoCtr.getData(),
				"PfcTitulo");

		// Crenças Cliente

		CrencaClienteCTR crencaCtr = new CrencaClienteCTR();
		CrmCrencaCliente crenca = new CrmCrencaCliente();
		crencaCtr.setObject(crenca);
		crencas = CRMComponentsUtils.getMapFrom(crencaCtr.getData(),
				"CrcTitulo");
	}

}
