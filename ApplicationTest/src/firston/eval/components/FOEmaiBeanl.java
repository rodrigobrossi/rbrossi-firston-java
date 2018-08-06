/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

import java.io.PrintStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;


// Referenced classes of package ser.comum.email:
//            Autentica

public class FOEmaiBeanl {

	public FOEmaiBeanl() {
		passou1 = 0;
		passou2 = 0;
		mai_cod = 0;
		smtp = "";
		port = "";
		rem = "";
		user = "";
		senha = "";
		cc = "";
	}

	public void pegaConf(String smtp, String rem, String user, String senha,
			String cc) {
		this.smtp = smtp;
		this.rem = rem;
		this.user = user;
		this.senha = senha;
		this.cc = cc;
	}

	public void sendMail(String dest, String assunto, String mensagem,
			String tipo) {
		try {
			javax.mail.Address remetente = new InternetAddress(rem);
			javax.mail.Address destinatario = new InternetAddress(dest);
			javax.mail.Address copia = new InternetAddress(cc);
			Properties props = new Properties();
			props.put("mail.smtp.host", smtp);
			javax.mail.Authenticator aut = new FOAuthenticateBean(user, senha);
			Session session = Session.getDefaultInstance(props, aut);
			MimeMessage message = new MimeMessage(session);
			message.setFrom(remetente);
			message.setRecipient(javax.mail.Message.RecipientType.TO,
					destinatario);
			message.setRecipient(javax.mail.Message.RecipientType.CC, copia);
			message.setSubject(assunto);
			message.setContent(mensagem, tipo);
			Transport.send(message);
		} catch (AddressException ae) {
			passou1 = 1;
			System.out.println(ae);
		} catch (MessagingException me) {
			passou2 = 1;
			System.out.println(me);
		}
	}

	public boolean envio() {
		return passou1 != 1 && passou2 != 1;
	}

	public int passou1;
	public int passou2;
	public int mai_cod;
	String smtp;
	String port;
	String rem;
	String user;
	String senha;
	String cc;
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/email/Email.class Total
 * time: 16 ms Jad reported messages/errors: Exit status: 0 Caught exceptions:
 */