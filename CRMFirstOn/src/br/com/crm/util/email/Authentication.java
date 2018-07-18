/*
 * Autentica.java
 *
 * Modificado em 06 de Novembro de 2001
 */

package br.com.crm.util.email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 * Responsable for emails authentication 
 */
class Authentication extends Authenticator{
    private String userName = null; 
    private String userPassword = null;

    /**
     * Default constructor to limit the access for 
     * br.com.gcb.crm.util.email 
     * @param user - user name.
     * @param password - password.
     */
    Authentication(String user, String password){
        userName = user;
        userPassword = password;
        getPasswordAuthentication();
    }

    /* (non-Javadoc)
     * @see javax.mail.Authenticator#getPasswordAuthentication()
     */
    public PasswordAuthentication getPasswordAuthentication(){
		return new PasswordAuthentication(userName, userPassword);
    }
}