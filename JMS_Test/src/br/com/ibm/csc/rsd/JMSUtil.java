package br.com.ibm.csc.rsd;
import java.rmi.Naming;
import java.util.Properties;

import javax.jms.ConnectionFactory;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class JMSUtil {
	
	
   public static void ListRMIServices() throws Exception {
	   
	   System.out.println("List RMI Services");
   
	   String[] s = Naming.list("rmi://127.0.0.1:9999");
	   
	   System.out.println("Naming"+s[0]);
	   System.out.println("Naming"+s[1]);

   }
   
   public static ConnectionFactory getJMSConnectionFactory() {
		Context ctx;
		ConnectionFactory cf = null;
		try {
			// Set environment properties

			Properties env = new Properties();

			env.put("java.naming.factory.initial",		"org.jnp.interfaces.NamingContextFactory");
			env.put("java.naming.provider.url", 
					"jnp://localhost:4447");
			env.put("java.naming.factory.url.pkgs",
					"org.jboss.naming:org.jnp.interfaces");

			ctx = new InitialContext(env);
			cf = (ConnectionFactory) ctx.lookup("/RemoteConnectionFactory");

		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return cf;
	}
}