package br.ibm.com.jms.queue;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;

public class QSender {
	public static void main(String[] args) {
		new QSender().send();
	}

	public void send() {
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				System.in));
		try {
			// Strings for JNDI names
			String factoryName = "jms/RemoteConnectionFactory";
			String queueName = "jms/queue/brossi";
			// Create an initial context.
			Properties props = new Properties();
			props.put(Context.INITIAL_CONTEXT_FACTORY,
					"org.jboss.naming.remote.client.InitialContextFactory");
			props.put(Context.PROVIDER_URL, "remote://localhost:4447");
			props.put(Context.SECURITY_PRINCIPAL, "user");
			props.put(Context.SECURITY_CREDENTIALS, "guest");
			InitialContext context = new InitialContext(props);

			QueueConnectionFactory factory = (QueueConnectionFactory) context
					.lookup(factoryName);
			Queue queue = (Queue) context.lookup(queueName);
			context.close();
			// Create JMS objects
			QueueConnection connection = factory.createQueueConnection("user",
					"guest");
			QueueSession session = connection.createQueueSession(false,
					Session.AUTO_ACKNOWLEDGE);
			QueueSender sender = session.createSender(queue);

			System.out.println("Enter message to send or 'quit' to quit.");
			String messageText = null;
			while (true) {
				messageText = reader.readLine();
				if ("quit".equalsIgnoreCase(messageText)) {
					break;
				}
				TextMessage message = session.createTextMessage(messageText);
				sender.send(message);
			}
			// Exit
			reader.close();
			System.out.println("Exiting...");
			connection.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}