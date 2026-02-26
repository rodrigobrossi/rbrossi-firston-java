/*
 * Email.java
 *
 * Modificado em 05 de Fevereiro de 2003
 */

package br.com.crm.util.email;

import java.util.Properties;

import jakarta.mail.Address;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.AddressException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * @author Rodrigo Luis Nolli Brossi
 * @version 1.0
 */

public class Email {

	private String smtp = "";

	private String rem = "";

	private String user = "";

	private String senha = "";

	private String cc = "";

	private boolean sent;

	public Email() {
	}

	public void loadConfiguration(String smtp, String rem, String user,
			String senha, String cc) {
		this.smtp = smtp;
		this.rem = rem;
		this.user = user;
		this.senha = senha;
		this.cc = cc;
	}

	public void sendMail(String dest, String assunto, String mensagem,
			String tipo) {

		try {
			// Coloca no formato de endereço válido
			Address remetente = new InternetAddress(rem);
			Address destinatario = new InternetAddress(dest);
			Address copia = new InternetAddress(cc);

			Properties props = new Properties();

			props.put("mail.smtp.host", smtp);

			Authenticator aut = new Authentication(user, senha);

			Session session = Session.getDefaultInstance(props, aut);

			MimeMessage message = new MimeMessage(session);

			message.setFrom(remetente);

			// Possíveis tipos de destinatário: TO, CC, BCC
			message.setRecipient(Message.RecipientType.TO, destinatario);
			message.setRecipient(Message.RecipientType.CC, copia);
			message.setSubject(assunto);
			message.setContent(mensagem, tipo);
			Transport.send(message);
		}

		catch (AddressException ae) {
			System.out.println(ae.getMessage());
		}

		catch (MessagingException me) {
			System.out.println(me.getMessage());
		}
	}

	public boolean envio() {
		return sent;
	}
}