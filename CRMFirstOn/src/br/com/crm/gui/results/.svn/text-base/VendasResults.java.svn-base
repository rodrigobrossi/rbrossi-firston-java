package br.com.crm.gui.results;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.border.BevelBorder;
import javax.swing.border.LineBorder;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableModel;

import br.com.crm.control.AbstractDataBaseCTR;
import br.com.crm.control.VendasCTR;
import br.com.crm.db.CrmVendas;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.log.Logger;
import br.com.crm.util.CRMComponentsUtils;
import br.com.crm.util.ViewConstants;

import com.ctreber.aclib.image.ico.BitmapDescriptor;
import com.ctreber.aclib.image.ico.ICOFile;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 *
 */
public class VendasResults extends AncestorFrame {

	private static final long serialVersionUID = 10001L;

	private static final String SEARCH_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_RESULT_SEARCH_IMAGE);

	private JTable table;

	private VendasTableModel model;

	public VendasResults() {
		createGUI();

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

	}

	public void createGUI() {
		this.setLayout(new BorderLayout());
		table = new JTable(model = new VendasTableModel());
		this.add(createHeader("Resultados da Pesquisa",
				ViewConstants.CRM_HEADER_SUB_TITLE), BorderLayout.NORTH);
		this.add(new JScrollPane(table), BorderLayout.CENTER);
	}

	private JPanel createFilterPanel() {
		JPanel panel = new JPanel();
		JTextField f = new JTextField(15);
		JTextField g = new JTextField(15);
		
		f.setToolTipText("Razão Social" );
		g.setToolTipText("CPF");
		panel.setLayout(new FlowLayout(1));
		panel.add(f);
		panel.add(g);
		panel.setBorder(new TitledBorder(new LineBorder(Color.BLACK,1),"Pesquisa"));
		return panel;
		
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

		ICOFile icon = null;

		try {
			icon = new ICOFile(CRMComponentsUtils.class.getResource(SEARCH_IMAGE));
		} catch (IOException e) {
			Logger.getLogger().error(
					"Nao foi possivel carregar o icone: " + SEARCH_IMAGE, e);
		}

		BitmapDescriptor bitmapDescriptor = icon.getDescriptor(0);

		lable.setIcon(new ImageIcon(bitmapDescriptor.getImageRGB()));

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

}

class VendasTableModel extends DefaultTableModel {

	/**
	 * Serial version ID for this classe
	 */
	private static final long serialVersionUID = 1L;

	private List model = new Vector(10);

	public VendasTableModel() {
		loadModel();

	}

	public void loadModel() {
		if (model != null) {
			model.clear();
		}

VendasCTR ctr = new VendasCTR();
		ctr.setObject(new CrmVendas());
		Iterator it = ctr.getData().iterator();
		while (it.hasNext()) {
			CrmVendas element = (CrmVendas) it.next();
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
			return "Observação";

		case 2:
			return "Título";

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
			return ((CrmVendas) model.get(column)).getId();

		case 1:
			return ((CrmVendas) model.get(column)).getVndProduto();

		case 2:
			return ((CrmVendas) model.get(column)).getVndUsuario();
		case 3:
			return "Time:" + System.currentTimeMillis();

		default:
			return "Não encontrado";
		}

	}

}
