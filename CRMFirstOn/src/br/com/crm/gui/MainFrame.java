package br.com.crm.gui;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.Point;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

import javax.swing.JDesktopPane;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.KeyStroke;

import br.com.crm.components.LoadViews;
import br.com.crm.components.search.SearchFrame;
import br.com.crm.control.listeners.FisrtOnChangeListener;
import br.com.crm.core.ApplicationConstants;
import br.com.crm.core.ApplicationContext;
import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.auxiliaries.CadastroProutosView;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.i18n.Messages;
import br.com.crm.log.Logger;
import br.com.crm.main.Main;
import br.com.crm.util.CRMComponentsUtils;

import com.ctreber.aclib.image.ico.BitmapDescriptor;
import com.ctreber.aclib.image.ico.ICOFile;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * 
 */
public class MainFrame extends JFrame implements ActionListener,
		FisrtOnChangeListener {

	/**
	 * generated serial version
	 */
	private static final long serialVersionUID = 7337611333747386124L;

	private final static Vector<AncestorFrame> listeners = new Vector<AncestorFrame>(
			4, 1);

	private final String TITLE_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_MAIN_TITLE_IMAGE);

	/**
	 * FIXME Will be used after
	 */
	private final String LOGIN_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_MAIN_LOGIN_IMAGE);

	/**
	 * View for agenda
	 */
	private JDesktopPane desktop;

	private JMenuItem agendaContato;
	private final Map<String, JMenuItem> auxiliaryMenuItems;

	/**
	 * Constructor of this application.
	 */
	public MainFrame() {
		super();

		// FIXME load this dynamically through a XML file
		auxiliaryMenuItems = new HashMap<String, JMenuItem>(10);
		auxiliaryMenuItems.put("Produto", new JMenuItem("Produto"));
		auxiliaryMenuItems.put("Clube", new JMenuItem("Clube"));
		auxiliaryMenuItems.put("Empresa", new JMenuItem("Empresa"));
		auxiliaryMenuItems.put("Dependentes", new JMenuItem("Dependentes"));
		auxiliaryMenuItems.put("Profiss�es", new JMenuItem("Profiss�o"));
		auxiliaryMenuItems.put("Relacionamento",new JMenuItem("Relacionamento"));
		auxiliaryMenuItems.put("Usuarios", new JMenuItem("Usuarios"));
		auxiliaryMenuItems.put("Vendas", new JMenuItem("Vendas"));
		auxiliaryMenuItems.put("Vendedores", new JMenuItem("Vendedores"));

		createGUI();
	}

	/**
	 * Start the application through the login view.
	 * 
	 * @throws HeadlessException
	 */
	private void createGUI() throws HeadlessException {

		if (login()) {
			// FIXME Solve the problem with the login view
			this.addWindowListener(new WindowAdapter() {
				public void windowClosing(WindowEvent e) {
					Main.shutDown();
				}
			});

			super.setJMenuBar(createJMenuBar()); // Set the menu to the
													// software.

			setTitle(Messages.getString(I18NGUIMessage.GUI_MAINFRAME_TITLE)); // i18N

			ICOFile icon = null;

			try {
				icon = new ICOFile(CRMComponentsUtils.class.getResource(TITLE_IMAGE));

				BitmapDescriptor bitmapDescriptor = icon.getDescriptor(3);

				setIconImage(bitmapDescriptor.getImageRGB());

				this.setSize(1024, 780);
				this.getContentPane().setLayout(new BorderLayout());
				desktop = new JDesktopPane();

				SearchFrame searchFrame = new SearchFrame();
				JSplitPane sp = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT,	searchFrame, desktop);
				sp.setDividerLocation(220);
				this.add(sp, BorderLayout.CENTER);

			} catch (IOException e) {
				Logger.getLogger().error(
						"Inpossible load the icon: " + TITLE_IMAGE, e);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			JOptionPane.showConfirmDialog(this, "Iconrrect login","Loggin error!", JOptionPane.ERROR_MESSAGE);
			System.out.println("Ops! ...running from you ");
			System.exit(0);
		}
	}

	private JMenuBar createJMenuBar() {

		JMenuBar mb = new JMenuBar();

		// Arquivo
		JMenu file = new JMenu(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_FILE));
		file.setMnemonic('A');

		JMenuItem close = new JMenuItem(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_CLOSE));
		close.setMnemonic('F');
		close.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Main.shutDown();
			}
		});

		file.addSeparator();
		file.add(close);

		mb.add(file);

		// Cadastro
		JMenu cadastro = new JMenu(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_CADASTRO));
		cadastro.setMnemonic('C');

		JMenuItem cadastroPF = new JMenuItem(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_PF), KeyEvent.VK_F);
		cadastroPF.setMnemonic('F');
		cadastroPF.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F,
				InputEvent.CTRL_MASK));
		cadastroPF.addActionListener(this);

		JMenuItem cadastroPJ = new JMenuItem(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_PJ), KeyEvent.VK_J);
		cadastroPJ.setMnemonic('J');
		cadastroPJ.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_J,
				InputEvent.CTRL_MASK));
		cadastroPJ.addActionListener(this);

		JMenu cadastroAuxiliar = new JMenu(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_AUX));
		cadastroAuxiliar.setMnemonic('A');
		// cadastroAuxiliar.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_A,
		// InputEvent.CTRL_MASK));
		cadastroAuxiliar.addActionListener(this);

		createAxiliaryMenu(cadastroAuxiliar);

		JMenuItem cadastroContatos = new JMenuItem("Contatos", KeyEvent.VK_C);
		cadastroContatos.setMnemonic('C');
		cadastroContatos.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_C,
				InputEvent.CTRL_MASK));
		cadastroContatos.addActionListener(this);

		cadastro.add(cadastroPF);
		cadastro.add(cadastroPJ);
		cadastro.add(cadastroContatos);
		cadastro.addSeparator();
		cadastro.add(cadastroAuxiliar);

		mb.add(cadastro);

		// Ferramentas
		JMenu ferramentas = new JMenu(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_TOOLS));
		ferramentas.setMnemonic('F');

		JMenu idiomas = new JMenu(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_IDIOMS));
		idiomas.setMnemonic('I');

		JMenuItem item1 = new JMenuItem(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_PTG));
		item1.addActionListener(this);
		item1.setAccelerator(KeyStroke.getKeyStroke('P'));
		JMenuItem item2 = new JMenuItem(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_ENG));
		item2.setAccelerator(KeyStroke.getKeyStroke('E'));
		item2.addActionListener(this);
		idiomas.add(item1);
		idiomas.add(item2);
		/* Initialize Menu contato */
		agendaContato = new JMenuItem("Agenda", KeyEvent.VK_A) {
			{
				setMnemonic('A');
				setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_A,
						InputEvent.CTRL_MASK));
				addActionListener(MainFrame.this);

			}
		};

		ferramentas.add(idiomas);
		ferramentas.add(agendaContato);

		mb.add(ferramentas);

		// Ajuda
		JMenu help = new JMenu(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_ABOUT));
		help.setMnemonic('A');

		JMenuItem aboutCRM = new JMenuItem(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_ABOUT_TEXT));
		aboutCRM.setMnemonic('S');

		aboutCRM.addActionListener(this);

		help.add(aboutCRM);

		mb.add(help);

		return mb;
	}

	private void createAxiliaryMenu(JMenu cadastroAuxiliar) {

		Iterator it = auxiliaryMenuItems.values().iterator();
		for (; it.hasNext();) {
			JMenuItem menu = (JMenuItem) it.next();
			System.out.println(menu);
			if (menu != null) {
				menu.addActionListener(this);
				cadastroAuxiliar.add(menu);
			}
		}
	}

	public void actionPerformed(ActionEvent evt) {
		String command = evt.getActionCommand();
		try {
			if (evt.getSource().equals(agendaContato)) {
				ApplicationContext.getInstance().launchApplication(	ApplicationConstants.CORE_APP_AGENDA);
			}

			if (command.length() > 0) {

				if (command.equals(Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_PF))) {
					LoadViews.loadWindow(LoadViews.CADASTRO_PESSOA_FISICA,
							desktop);
				} else if (command.equals(Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_PJ))) {
					LoadViews.loadWindow(LoadViews.CADASTRO_PESSOA_JURIDICA,
							desktop);
				} else if (command.equals(Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_AUX))) {
					LoadViews
							.loadWindow(LoadViews.CADASTRO_AUXILIARES, desktop);
				} else if (command.equals(Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_PTG))) {
					// TODO Implement this view
				} else if (command.equals(Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_ENG))) {
					// TODO Implement this view
				} else if (command.equals(Messages
						.getString(I18NGUIMessage.GUI_MAINFRAME_ABOUT_TEXT))) {
					loadAbout();
				} else if (auxiliaryMenuItems.containsValue(evt.getSource())) {
					String menuItemName = ((JMenuItem) evt.getSource())
							.getActionCommand();
					LoadViews.loadWindow(getView(menuItemName), desktop);

				}
			}

		} catch (IllegalArgumentException e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(this, "[ERRO]:"
					+ e.getLocalizedMessage(), "UI Configuration fault!",
					JOptionPane.ERROR_MESSAGE);

		} catch (NullPointerException e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(this, "[ERRO]:" + e.getCause(),
					"UI missing instantiate fault!", JOptionPane.ERROR_MESSAGE);
		} catch (PropertyVetoException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * This method should do this dynamically
	 * 
	 * @param menuItemName
	 * @return
	 */
	private String getView(String menuItemName) {
		// TODO Auto-generated method stub

		if (menuItemName.equals("Produto"))
			return CadastroProutosView.class.getName();
		else
			return null;
	}

	public void launchIFrame(JPanel app) throws PropertyVetoException {
		
		JInternalFrame d = new JInternalFrame("Agenda", true, true, true, true);
		d.setSize(new Dimension(800, 600));
		d.setLayout(new BorderLayout());
		d.add(app, BorderLayout.CENTER);
		d.setVisible(true);
		d.setFocusable(true);
		desktop.add(d);
		d.setMaximum(true);
	}

	/**
	 * Load about dialog
	 */
	private void loadAbout() {
		new AboutView(this);

	}

	/**
	 * Validate the user through the login.
	 */
	private boolean login() {

		if (false) { // FIXME fix the login process.
			JFrame loginFrame = new JFrame();

			ICOFile icon = null;

			try {
				icon = new ICOFile(CRMComponentsUtils.class
						.getResource(LOGIN_IMAGE));
			} catch (IOException e) {
				Logger.getLogger().error(
						"Nao foi possivel carregar o icone: " + LOGIN_IMAGE, e);
			}

			BitmapDescriptor bitmapDescriptor = icon.getDescriptor(0);

			loginFrame.setTitle(Messages
					.getString(I18NGUIMessage.GUI_MAINFRAME_LOGIN));
			loginFrame.setIconImage(bitmapDescriptor.getImageRGB());
			loginFrame.setLayout(new BorderLayout());

			JDialog d = new JDialog(loginFrame, Messages
					.getString(I18NGUIMessage.GUI_MAINFRAME_LOGIN), true);
			d.setLayout(new BorderLayout());

			LoginView loginView = new LoginView(d);
			d.add(loginView, BorderLayout.CENTER);
			d.setSize(300, 140);

			Dimension size = Toolkit.getDefaultToolkit().getScreenSize();
			Point location = new Point(0, 0);

			int w = d.getWidth();
			int h = d.getHeight();
			int x = (size.width - w) / 2;
			int y = (size.height - h) / 2;

			d.setBounds(location.x + x, location.y + y, w, h);
			d.setVisible(true);

			return loginView.getLoginResult();
		}
		return true;
	}

	/**
	 * Adiciona um obejto o qual deve ser ouvido, ou todos os ancestor frames
	 * que fazem parte da aplica�ao.
	 * 
	 * @param obj
	 */
	public static void addFisrstOnListener(AncestorFrame obj) {
		listeners.add(obj);
	}

	/**
	 * Remove um determinado obejto do listener.
	 * 
	 * @param obj
	 */
	public static void removeFisrstOnListener(AncestorFrame obj) {
		listeners.remove(obj);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * br.com.crm.control.listeners.FisrtOnChangeListener#fireChange(br.com.
	 * crm.gui.app.AncestorFrame)
	 */
	public void fireChange(AncestorFrame source) {
		Iterator list = listeners.iterator();
		while (list.hasNext()) {
			AncestorFrame obj = (AncestorFrame) list.next();
			if (!source.equals(obj)) {
				obj.updateGUI();
			}
		}
	}
	
	/**
	 * Just to update the contact info into de applications
	 */
	public void fireContactChange() {
		Iterator list = listeners.iterator();
		while (list.hasNext()) {
			AncestorFrame obj = (AncestorFrame) list.next();
			obj.updateGUI();
		}
	}

	/**
	 * Notifica a todos os liteners que houve alter��o nos modelos Views ou etc.
	 * 
	 * @param source
	 */
	public static synchronized void notifyChanges(AncestorFrame source) {
		Iterator list = ((Vector) listeners.clone()).iterator();
		while (list.hasNext()) {
			AncestorFrame obj = (AncestorFrame) list.next();
			if (source != obj)
				obj.updateGUI();
		}
	}
}
