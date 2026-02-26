package br.com.crm.gui.results;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.border.BevelBorder;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.TipoRelacaoCTR;
import br.com.crm.db.CrmTipoRelacao;
import br.com.crm.db.hb.PersistentObject;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.log.Logger;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public class TipoRelacaoResults extends AncestorFrame {

	private static final long serialVersionUID = 10001L;

	private static final String SEARCH_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_RESULT_SEARCH_IMAGE);

	private JTable table;

	private TipoRelacaoTableModel model;

	public TipoRelacaoResults() {
		createGUI();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

	}

	public void createGUI() {
		this.setLayout(new BorderLayout());
		table = new JTable(model = new TipoRelacaoTableModel());
		table.getColumnModel().getColumn(0).setCellRenderer(new TipoRelacaoCH(table));
		table.getColumnModel().getColumn(0).setMaxWidth(60);
		table.setGridColor(Color.LIGHT_GRAY);
		JScrollPane sp = new JScrollPane(table);
		sp.getViewport().setBackground(Color.LIGHT_GRAY);
		this.add(createHeader("Resultados da Pesquisa",ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);
		this.add(createFilterPanel(), BorderLayout.NORTH);
		this.add(sp, BorderLayout.CENTER);
		this.add(createControPanel(), BorderLayout.SOUTH);
	}

	private JPanel createControPanel() {
		final JPanel content = new JPanel(new BorderLayout());
		JButton filtrar = new JButton("Excluir/Alterar");
		filtrar.setBorder(new LineBorder(Color.BLACK,1));
		filtrar.setFocusable(false);
		filtrar.setBorder(new LineBorder(Color.BLACK,1));
		final JPanel panel = new JPanel();
		
		filtrar.addActionListener(new ActionListener() {
		
			public void actionPerformed(ActionEvent e) {
				panel.setVisible(!panel.isVisible());
				content.validate();
				content.repaint();
			}
		
		});
		panel.setBackground(Color.WHITE);
		filtrar.setBackground(Color.WHITE);
		panel.setLayout(new FlowLayout(1));
		panel.add(new JButton("Alterar"));
		panel.add(new JButton("Excluir"));
		panel.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),"Comandos"));
		panel.setVisible(false);
		content.add(filtrar,BorderLayout.NORTH);
		content.add(panel,BorderLayout.CENTER);
		return content;
	}

	private JPanel createFilterPanel() {
		
		final JPanel content = new JPanel(new BorderLayout());
		final JPanel panel = new JPanel(new GridBagLayout());
		panel.setBackground(Color.WHITE);
		
		JButton filtrar = new JButton("Filtro avançado");
		filtrar.setBorder(new LineBorder(Color.BLACK,1));
		filtrar.setFocusable(false);
		filtrar.setBackground(Color.WHITE);
		
		filtrar.addActionListener(new ActionListener() {
		
			public void actionPerformed(ActionEvent e) {
				panel.setVisible(!panel.isVisible());
				content.validate();
				content.repaint();
			}
		
		});
		GridBagConstraints c = new GridBagConstraints();
		c.anchor = GridBagConstraints.PAGE_START;
		c.fill = GridBagConstraints.BOTH;
		c.insets = new Insets(0,5,0,0);
		c.gridx = 0;
		c.gridy = 0;
		panel.add(new JLabel("Titulo:"),c);
		c.gridx = 1;
		c.gridy = 0;
		JTextField f = new JTextField(15);
		f.setToolTipText("Título");
		panel.add(f,c);
		
		
		c.gridx = 0;
		c.gridy = 1;
		panel.add(new JLabel("Descrição:"),c);
		c.gridx = 1;
		c.gridy = 1;
		JTextField g = new JTextField(15);
		g.setToolTipText("Descrição");
		panel.add(g,c);
		
		JButton pesquisar = new JButton("Pesquisar");
		c.gridx = 1;
		c.gridy = 3;
		panel.add(pesquisar,c);
		ButtonGroup bg = new ButtonGroup();
		
		JCheckBox startsWith = new JCheckBox("Começa com");
		startsWith.setOpaque(false);
		JCheckBox endsWith = new JCheckBox("Termina com");
		endsWith.setOpaque(false);
		JCheckBox contain = new JCheckBox("Contem");
		contain.setOpaque(false);
		bg.add(startsWith);
		bg.add(endsWith);
		bg.add(contain);
		c.gridx = 2;
		c.gridy = 0;
		panel.add(startsWith,c);
		c.gridx = 2;
		c.gridy = 1;
		panel.add(endsWith,c);
		c.gridx = 2;
		c.gridy = 2;
		panel.add(contain,c);
		
		panel.setBorder(new TitledBorder(new LineBorder(Color.BLACK, 1),"Pesquisa"));
		panel.setVisible(false);
		content.add(filtrar,BorderLayout.NORTH);
		content.add(panel,BorderLayout.CENTER);
		return content;

	}

	public void updateGUI() {
		model.loadModel();
	}

	public AbstractDataBaseCTR loadPersistentObject() {
		return null;

	}

	public void setColor(Color color) {

	}

	private static Component createHeader(String title, int type) {
		Font headerTile;
		switch (type) {
		case ViewConstants.CRM_HEADER_TITLE:
			headerTile = new Font("Verdana", Font.BOLD, 26);
			break;
		case ViewConstants.CRM_HEADER_SUB_TITLE:
			headerTile = new Font("Verdana", Font.PLAIN, 24);
			break;
		default:
			headerTile = new Font("Arial", Font.PLAIN, 10);
			break;
		}

		JLabel lable = new JLabel(title);
		lable.setFont(headerTile);

		// Exemplo: BitmapDescriptor descriptor = new BitmapDescriptor();
		// Exemplo: ICOFile icoFile = new ICOFile();

		// ICOFile icon = null;
		// try {
		//     icon = new ICOFile(CRMComponentsUtils.class.getResource(SEARCH_IMAGE));
		// } catch (IOException e) {
		//     Logger.getLogger().error(
		//             "Nao foi possivel carregar o icone: " + SEARCH_IMAGE, e);
		// }

		// Exemplo: BitmapDescriptor bitmapDescriptor = icon.getDescriptor(0);

		lable.setIcon(null);

		JPanel complete = new JPanel();
		complete.setBackground(Color.WHITE);
		complete.setBorder(new BevelBorder(2, Color.GRAY, Color.LIGHT_GRAY));
		complete.setLayout(new GridBagLayout());
		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.NONE;
		c.weightx = 1.0;
		c.weighty = 0.0;
		c.anchor = GridBagConstraints.FIRST_LINE_START;
		c.insets = new Insets(0, 5, 0, 0);
		c.gridx = 0;
		c.gridy = 0;
		complete.add(lable, c);
		return complete;
	}

	public PersistentObject getSelectedBean() {
		return model.getSelectedBean(table.getSelectedRow());
	}

}

class TipoRelacaoTableModel extends DefaultTableModel {

	/**
	 * Serial version ID for this classe
	 */
	private static final long serialVersionUID = 1L;

	private List model = new Vector(10);

	public TipoRelacaoTableModel() {
		loadModel();

	}
	public PersistentObject getSelectedBean(int index){
		
		return (PersistentObject)model.get(index);
	}
	
	public Class getColumnClass(int columnIndex) {
		switch (columnIndex) {
		case 0:
			return JCheckBox.class;
		case 1:
			return JLabel.class;
		case 2:
			return JLabel.class;
		default:
			return Component.class;
		}
	}

	public void loadModel() {
		if (model != null) {
			model.clear();
		}

		TipoRelacaoCTR ctr = new TipoRelacaoCTR();
		ctr.setObject(new CrmTipoRelacao());
		Iterator it = ctr.getData().iterator();
		while (it.hasNext()) {
			CrmTipoRelacao element = (CrmTipoRelacao) it.next();
			boolean add = model.add(element);
			if (!add) {
				System.out.println("[Model]: could not read :"
						+ element.getId());
			}
		}
		this.fireTableDataChanged();
	}

	public int getColumnCount() {
		return 3;
	}

	public String getColumnName(int column) {
		switch (column) {
		case 0:
			return "ID";

		case 1:
			return "Título";

		case 2:
			return "Observação";

		default:
			return "Não encontrado";
		}

	}

	public Vector getDataVector() {
		return (Vector) model;
	}

	public int getRowCount() {
		if (model != null) {
			return model.size();
		} else {
			return super.getRowCount();

		}

	}

	public Object getValueAt(int column, int row) {

		switch (row) {
		case 0:
			return ((CrmTipoRelacao) model.get(column)).getId();

		case 1:
			return ((CrmTipoRelacao) model.get(column)).getTirTipoRelacao();

		case 2:
			return ((CrmTipoRelacao) model.get(column)).getTirObservacao();
		case 3:
			return "Time:" + System.currentTimeMillis();

		default:
			return "Não encontrado";
		}

	}

}

class TipoRelacaoCH extends DefaultTableCellRenderer {

	private static final long serialVersionUID = -310593118726135369L;

	private JTable table;

	// Custom table header.
	private TipoRelacaoTableModel tpModel;

	TipoRelacaoCH(JTable table) {
		this.tpModel = (TipoRelacaoTableModel) table.getModel();
		this.table = table;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.swing.table.TableCellRenderer#getTableCellRendererComponent(javax.swing.JTable,
	 *      java.lang.Object, boolean, boolean, int, int)
	 */
	public Component getTableCellRendererComponent(JTable table, Object value,
			boolean isSelected, boolean hasFocus, int row, int column) {
		if (tpModel.getRowCount() == 0) {
			return null;
		}
		int id = table.getColumnModel().getColumn(column).getModelIndex();
		
		switch (id) {
		case 0:
			return configureComponent(row, column, isSelected);
		case 1:
			return this;
		default:
			return this;
		}
	}

	private Component configureComponent(int row, int column, boolean isSelected) {
		JCheckBox x  = new JCheckBox("ID:" +table.getModel().getValueAt(row, column));
		x.setBackground(Color.WHITE);
		x.setFocusable(true);
		if(isSelected){
			x.setSelected(!x.isSelected());
			x.setBackground(table.getSelectionBackground());
			x.setForeground(table.getSelectionForeground());
		}
		return x;
	}

}
