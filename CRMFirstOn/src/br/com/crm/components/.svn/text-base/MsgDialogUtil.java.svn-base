package br.com.crm.components;

import java.awt.Component;

import javax.swing.JOptionPane;

/**
 * This class provides utility methods to use dialog message.
 */
public class MsgDialogUtil
{

    /**
     * Utility method to open a standard error dialog. The dialog will be a modal dialog.
     *
     * @param parent the parent shell of the dialog, or <code>null</code> if none
     * @param title the dialog's title, or <code>null</code> if none
     * @param message the message
     * 
     */
    public static void openErrorDialog(Component parent, String title, String message)
    {
        JOptionPane.showMessageDialog(parent, message, title, JOptionPane.ERROR_MESSAGE);
    }

    /**
     * Utility method to open a simple Yes/No question dialog.  The dialog will be a modal dialog.
     *
     * @param parent the parent shell of the dialog, or <code>null</code> if none
     * @param title the dialog's title, or <code>null</code> if none
     * @param message the message
     * @return <code>true</code> if the user presses the OK button, <code>false</code> otherwise
     */
    public static boolean openQuestionDialog(Component parent, Object message, String title)
    {
        int userChoice = JOptionPane.showConfirmDialog(parent, message, title,
                                           JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE);
        return userChoice == JOptionPane.YES_OPTION;
    }

    /**
     * Utility method to open a standard warning dialog. The dialog will be a modal dialog.
     *
     * @param parent the parent shell of the dialog, or <code>null</code> if none
     * @param title the dialog's title, or <code>null</code> if none
     * @param message the message
     */
    public static void openWarningDialog(Component parent, String title, String message)
    {
       JOptionPane.showMessageDialog(parent, message, title, JOptionPane.WARNING_MESSAGE);
    }

    /**
     * Utility method to open a standard warning dialog. The dialog will be a modal dialog.
     *
     * @param parent the parent shell of the dialog, or <code>null</code> if none
     * @param title the dialog's title, or <code>null</code> if none
     * @param message the message
     */
    public static void openInfoDialog(Component parent, String title, String message)
    {
       JOptionPane.showMessageDialog(parent, message, title, JOptionPane.INFORMATION_MESSAGE);
    }
    
    /**
     * Utility method to open a custom Option Dialog. The dialog will be a modal dialog.
     * @param parent the parent shell of the dialog, or <code>null</code> if none
     * @param title the dialog's title, or <code>null</code> if none
     * @param message the message
     * @param options String containing answers to message. the first item will be the default one.
     */
    public static int openOptionDialog(Component parent, Object message, String title, String[] options)
    {
        int userChoice = JOptionPane.showOptionDialog(parent, message, title,
                                JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.QUESTION_MESSAGE, null, options, options[0]);
        return userChoice;
    }
    
}
