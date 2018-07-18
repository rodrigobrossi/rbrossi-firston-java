package br.com.crm.components.navigator;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.Action;
import javax.swing.ImageIcon;
import javax.swing.JComponent;

/**
 * This class defines the custom button used by the JNavigator in order to
 * exhibit the its model information
 */
public class NavigatorCustomButton extends JComponent {

	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = 4426162127351539097L;

	private final Action action;

	private final int iconSize;

	private int state;

	public NavigatorCustomButton(Action action, int iconSize) {
		this.action = action;
		this.iconSize = iconSize;
		state = NavigatorConstants.STATE_STANDARD;
		this.setFont(NavigatorConstants.CUSTOMBUTTON_FONT);

		FontMetrics fontMetrics = this.getFontMetrics(this.getFont());
		String label = (String) action.getValue(Action.NAME);
		ImageIcon icon = (ImageIcon) action.getValue(Action.SMALL_ICON);
		int fontWidth = fontMetrics.charsWidth(label.toCharArray(), 0, label
				.length());
		int fontHeight = fontMetrics.getHeight();

		if (iconSize == NavigatorConstants.LARGE_ICONS) {
			this.setPreferredSize(new Dimension(Math.max(
					NavigatorConstants.LARGE_ICON_SIZE, fontWidth),
					NavigatorConstants.LARGE_ICON_SIZE
							+ NavigatorConstants.DEFAULT_LARGE_ICON_SPACING
							+ fontHeight));
		} else {
			this.setPreferredSize(new Dimension(
					NavigatorConstants.SMALL_ICON_SIZE
							+ NavigatorConstants.DEFAULT_SMALL_ICON_SPACING
							+ fontWidth, Math.max(
							NavigatorConstants.SMALL_ICON_SIZE, fontHeight)));
		}

		this.addMouseListener(new MouseAdapter() {
			public void mouseEntered(MouseEvent e) {
				state = NavigatorConstants.STATE_HIGHLIGHTED;
				repaint();
			}

			public void mouseExited(MouseEvent e) {
				state = NavigatorConstants.STATE_STANDARD;
				repaint();
			}

			public void mouseReleased(MouseEvent e) {
				if (((NavigatorCustomButton) e.getSource()).getState() == NavigatorConstants.STATE_SELECTED) {
					state = NavigatorConstants.STATE_HIGHLIGHTED;
				} else {
					state = NavigatorConstants.STATE_STANDARD;
				}

				repaint();
			}

			public void mousePressed(MouseEvent e) {
				state = NavigatorConstants.STATE_SELECTED;

				Action action = ((NavigatorCustomButton) e.getSource()).getAction();
				action.actionPerformed(new ActionEvent(e.getSource(),1001, (String) action.getValue(Action.NAME)));
				repaint();
			}
		});
	}

	/**
	 * Get the current action performed in the Navigator
	 * 
	 * @return Action
	 */
	public Action getAction() {
		return action;
	}

	/**
	 * Get the current state on the Navigator
	 * 
	 * @return int
	 */
	public int getState() {
		return state;
	}

	/**
	 * Paint the Navigator accordingly to the Icons Size mode (Large or Small
	 * size)
	 */
	public void paint(Graphics g) {
		final int paintSize;

		int width = this.getPreferredSize().width;
		int height = this.getPreferredSize().height;
		String label = (String) action.getValue(Action.NAME);
		ImageIcon icon = (ImageIcon) action.getValue(Action.SMALL_ICON);
		int fontWidth = g.getFontMetrics().charsWidth(label.toCharArray(), 0,
				label.length());
		int fontDescend = g.getFontMetrics().getDescent();
		int iconWidth = icon.getIconWidth();
		int iconHeight = icon.getIconHeight();

		int maxImageSize;
		int posX;
		int posY;
		int labelWidth;
		int labelHeight;

		if (iconSize == NavigatorConstants.LARGE_ICONS) {
			paintSize = NavigatorConstants.LARGE_ICON_SIZE;
			maxImageSize = paintSize - 1;

			if ((state == NavigatorConstants.STATE_HIGHLIGHTED)
					|| (state == NavigatorConstants.STATE_SELECTED)) {
				g.setColor(NavigatorConstants.SELECTED_BORDER_COLOR);
				g.drawRect((width - paintSize) / 2, 0, paintSize - 1,
						paintSize - 1);
			}

			g.setColor(getColor(state));
			g.fillRect(((width - paintSize) / 2) + 1, 1, paintSize - 2,
					paintSize - 2);

			if ((iconWidth > maxImageSize) || (iconHeight > maxImageSize)) {
				if (iconWidth > iconHeight) {
					iconHeight = (iconHeight * (paintSize - 1)) / iconWidth;
					iconWidth = paintSize - 1;
				} else {
					iconWidth = (iconWidth * (paintSize - 1)) / iconHeight;
					iconHeight = paintSize - 1;
				}
			}

			posX = (((width - paintSize) / 2) + (paintSize / 2))
					- (iconWidth / 2);
			posY = (paintSize / 2) - (iconHeight / 2);

			g.drawImage(icon.getImage(), posX, posY, icon.getIconWidth(), icon
					.getIconHeight(), null);
			g.setColor(Color.BLACK);
			g.drawChars(label.toCharArray(), 0, label.length(),
					(width - fontWidth) / 2, height - fontDescend);

		} else {
			paintSize = NavigatorConstants.SMALL_ICON_SIZE;
			maxImageSize = paintSize - 1;

			if ((state == NavigatorConstants.STATE_HIGHLIGHTED)
					|| (state == NavigatorConstants.STATE_SELECTED)) {
				g.setColor(NavigatorConstants.SELECTED_BORDER_COLOR);
				g.drawRect(0,
						(height - NavigatorConstants.SMALL_ICON_SIZE) / 2,
						NavigatorConstants.SMALL_ICON_SIZE - 1,
						NavigatorConstants.SMALL_ICON_SIZE - 1);
			}

			g.setColor(getColor(state));
			g.fillRect(1, ((height - paintSize) / 2) + 1, paintSize - 2,
					paintSize - 2);

			if ((iconWidth > maxImageSize) || (iconHeight > maxImageSize)) {
				if (iconWidth > iconHeight) {
					iconHeight = (iconHeight * (paintSize - 1)) / iconWidth;
					iconWidth = paintSize - 1;
				} else {
					iconWidth = (iconWidth * (paintSize - 1)) / iconHeight;
					iconHeight = paintSize - 1;
				}
			}

			posX = (paintSize / 2) - (iconWidth / 2);
			posY = (((height - paintSize) / 2) + (paintSize / 2))
					- (iconHeight / 2);

			g.drawImage(icon.getImage(), posX, posY, icon.getIconWidth(), icon
					.getIconHeight(), null);
			g.setColor(Color.BLACK);
			g.drawChars(label.toCharArray(), 0, label.length(), width
					- fontWidth, (height / 2) + fontDescend + 1);
		}

	}

	/**
	 * Gets the CustomButton background color. It depends on its state.
	 */
	private Color getColor(int state) {
		Color color = Color.WHITE;

		if (state == NavigatorConstants.STATE_HIGHLIGHTED) {
			color = NavigatorConstants.HIGHLIGHTED_COLOR;
		} else if (state == NavigatorConstants.STATE_SELECTED) {
			color = NavigatorConstants.SELECTED_COLOR;
		}

		return color;
	}

}
