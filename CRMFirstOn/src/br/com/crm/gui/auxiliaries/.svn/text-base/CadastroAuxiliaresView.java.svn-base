package br.com.crm.gui.auxiliaries;

import java.awt.BorderLayout;
import java.awt.Color;

import javax.swing.JTabbedPane;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import br.com.crm.components.JCommandPanel;
import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.gui.MainFrame;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

public class CadastroAuxiliaresView extends AncestorFrame implements
		ChangeListener {

	private static final long serialVersionUID = 1L;

	private JTabbedPane cadastroTabs;

	private CadastroVendedoresView vendorsPanel;

	private CadastroProfissoesView professionPanel;

	private CadastroVendasView salesPanel;

	private CadastroFilhosView childrenPanel;

	private CadastroClubeClienteView clubePanel;

	private CadastroProutosView productsPanel;

	private CadastroTipoRelacaoView tipoRelacaoPanel;

	private CadastroContatosClienteView contatosPanel;

	private CadastroEmpresaView empresaPanel;
	
	/**
	 * Constructor
	 */
	public CadastroAuxiliaresView() {
		createGUI();
	}

	public void createGUI() {

		vendorsPanel = new CadastroVendedoresView();
		vendorsPanel.setOpaque(false);
		vendorsPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Vendedores"));

		professionPanel = new CadastroProfissoesView();
		professionPanel.setOpaque(false);
		professionPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Profissão"));

		salesPanel = new CadastroVendasView();
		salesPanel.setOpaque(false);
		salesPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Vendas"));

		childrenPanel = new CadastroFilhosView();
		childrenPanel.setOpaque(false);
		childrenPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Filhos"));

		clubePanel = new CadastroClubeClienteView();
		clubePanel.setOpaque(false);
		clubePanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Clubes"));

		productsPanel = new CadastroProutosView();
		productsPanel.setOpaque(false);
		productsPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Produtos"));

		tipoRelacaoPanel = new CadastroTipoRelacaoView();
		tipoRelacaoPanel.setOpaque(false);
		tipoRelacaoPanel.setBorder(new TitledBorder(
				new LineBorder(Color.BLACK), "Tipos de Relações"));

		contatosPanel = new CadastroContatosClienteView();
		contatosPanel.setOpaque(false);
		contatosPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Contatos do Cliente"));

		// Empresas
		empresaPanel = new CadastroEmpresaView();
		empresaPanel.setOpaque(false);
		empresaPanel.setBorder(new TitledBorder(new LineBorder(Color.BLACK),
				"Empresas"));

		// Create Tabs
		cadastroTabs = new JTabbedPane(JTabbedPane.LEFT, JTabbedPane.VERTICAL);

		// Add Scroll panes with current Tabs
		cadastroTabs.addTab("Vendedores", ViewConstants.IMAGE_MURAL,
				vendorsPanel);
		cadastroTabs.addTab("Vendas", ViewConstants.IMAGE_MURAL,
				salesPanel);
		cadastroTabs.addTab("Filhos", ViewConstants.IMAGE_MURAL,
				childrenPanel);
		cadastroTabs.addTab("Clube", ViewConstants.IMAGE_MURAL, 
				clubePanel);
		cadastroTabs.addTab("Profissão Cliente",
				ViewConstants.IMAGE_MURAL, professionPanel);
		cadastroTabs.addTab("Produto", ViewConstants.IMAGE_MURAL,
				productsPanel);
		cadastroTabs.addTab("Tipo Relação", ViewConstants.IMAGE_MURAL,
				tipoRelacaoPanel);
		cadastroTabs.addTab("Contatos", ViewConstants.IMAGE_MURAL,
				contatosPanel);
		cadastroTabs.addTab("Empresas", ViewConstants.IMAGE_MURAL,
				empresaPanel);
		cadastroTabs.addChangeListener(this);

		// Set color for this components
		cadastroTabs.setBackground(Color.WHITE);
		// Add to Observer command
		MainFrame.addFisrstOnListener(this);

		add(CRMComponentsUtils.createHeader("Cadastros Auxiliares",
				ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);
		putComponent(cadastroTabs, false);
		// Create command Panel
		JCommandPanel cp = new JCommandPanel(this, true, true, true, true);
		add(cp, BorderLayout.SOUTH);

	}

	public void updateGUI() {
		this.childrenPanel.updateGUI();
		this.contatosPanel.updateGUI();
		this.empresaPanel.updateGUI();
		this.productsPanel.updateGUI();
		this.professionPanel.updateGUI();
		this.salesPanel.updateGUI();
		this.vendorsPanel.updateGUI();
		this.tipoRelacaoPanel.updateGUI();
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		return null;
	}

	public void setColor(Color color) {

	}

	public void stateChanged(ChangeEvent e) {
		this.chield = (AncestorFrame) this.cadastroTabs
				.getComponentAt(this.cadastroTabs.getModel().getSelectedIndex());
	}
}
