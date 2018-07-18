package br.com.crm.components;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Toolkit;
import java.util.HashMap;

import javax.swing.JDesktopPane;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;

import br.com.crm.gui.app.AncestorFrame;
import br.com.crm.gui.auxiliaries.CadastroAuxiliaresView;
import br.com.crm.gui.i18N.I18NGUIMessage;
import br.com.crm.gui.juridic.CadastroPessoaJuridicaView;
import br.com.crm.gui.person.ContactApplication;
import br.com.crm.gui.user.UserApplication;
import br.com.crm.i18n.Messages;

public final class LoadViews extends JFrame {

	private static final LoadViews instance = new LoadViews();

	private static HashMap views;

	public static final String CADASTRO_PESSOA_FISICA = ContactApplication.class
			.getName();

	public static final String CADASTRO_PESSOA_JURIDICA = CadastroPessoaJuridicaView.class
			.getName();

	public static final String CADASTRO_AUXILIARES = CadastroAuxiliaresView.class
			.getName();

	public static final String CADASTRO_USUARIOS = UserApplication.class
			.getName();

	static {
		views = new HashMap();

		views.put(CADASTRO_PESSOA_FISICA,
				createFrame(new ContactApplication()));
		views.put(CADASTRO_PESSOA_JURIDICA,
				createFrame(new CadastroPessoaJuridicaView()));
		views.put(CADASTRO_AUXILIARES,
				createFrame(new CadastroAuxiliaresView()));

	}

	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = -1862498345611979222L;

	private final String TITLE_IMAGE = Messages
			.getString(I18NGUIMessage.COMMON_MAIN_TITLE_IMAGE);

	private LoadViews() {

		setTitle(Messages.getString(I18NGUIMessage.GUI_MAINFRAME_TITLE));

	}

	private static JInternalFrame createFrame(String view) {
		AncestorFrame frame = null;

		if (frame == null) {
			System.out.println(view);
			try {
				frame = (AncestorFrame) (Class.forName(view).newInstance());
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				// return;
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				// return;
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				// return;
			} catch (ClassCastException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				// return;
			}

		}
		JInternalFrame iframe = new JInternalFrame(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_CADASTRO)
				+ " " + Messages.getString(I18NGUIMessage.GUI_MAINFRAME_PF),
				true, true, true, true) {
			{
				setLayout(new BorderLayout());

				setSize(800, 600);
			}
		};
		iframe.add(frame, BorderLayout.CENTER);
		return iframe;

	}

	private static JInternalFrame createFrame(final AncestorFrame frame) {

		JInternalFrame iframe = new JInternalFrame(Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_CADASTRO)
				+ " " + Messages.getString(I18NGUIMessage.GUI_MAINFRAME_PF),
				true, true, true, true) {
			{
				setLayout(new BorderLayout());
				add(frame, BorderLayout.CENTER);
				setSize(800, 600);
			}
		};
		return iframe;
	}

	/**
	 * Load Cadastro Usuario
	 * 
	 * @param user
	 * 
	 */
	public void loadCadastroUsuario(String user) {
		JDialog d = new JDialog(this, Messages
				.getString(I18NGUIMessage.GUI_MAINFRAME_CADASTRO)
				+ " " + Messages.getString(I18NGUIMessage.GUI_MAINFRAME_PF),
				true);
		d.setLayout(new BorderLayout());
		d.add(new UserApplication(user), BorderLayout.CENTER);
		d.setSize(340, 200);

		Dimension size = Toolkit.getDefaultToolkit().getScreenSize();
		Point location = new Point(0, 0);

		int w = d.getWidth();
		int h = d.getHeight();
		int x = (size.width - w) / 2;
		int y = (size.height - h) / 2;

		d.setBounds(location.x + x, location.y + y, w, h);

		d.setVisible(true);
	}

	/**
	 * This method is responsible to launch the Internal frames into the desktop
	 * pane. see this documentation for more information this method should
	 * evolves through the time.
	 */
	public static void loadWindow(final String view, final JDesktopPane desktop) {
		Thread show = new Thread(new Runnable() {
			public void run() {
				JInternalFrame frame = (JInternalFrame) views.get(view);
				if (frame == null)
				{
					frame = createFrame(view);
					
				}
				
				if (frame == null)
					return;

				desktop.add(frame);
				frame.setVisible(true);
			}
		}, "[View]:" + view);
		show.start();
	}

}
