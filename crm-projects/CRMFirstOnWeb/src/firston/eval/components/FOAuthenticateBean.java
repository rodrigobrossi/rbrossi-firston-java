/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.

package firston.eval.components;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;

public class FOAuthenticateBean extends Authenticator
{
    public String nome_user;
    public String senha_user;

    FOAuthenticateBean(String s, String s1)
    {
        nome_user = s;
        senha_user = s1;
        getPasswordAuthentication();
    }

    public PasswordAuthentication getPasswordAuthentication()
    {
        return new PasswordAuthentication(nome_user, senha_user);
    }
}


/*
	DECOMPILATION REPORT

	Decompiled from: C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/email/Autentica.class
	Total time: 16 ms
	Jad reported messages/errors:
	Exit status: 0
	Caught exceptions:
*/