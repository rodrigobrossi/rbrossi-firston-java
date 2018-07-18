package br.ibm.com.jms.queue;

import java.util.Properties;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueReceiver;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;

public class QReceiver implements MessageListener {
	private boolean stop = false;

	public static void main(String[] args) {
		new QReceiver().receive();
	}

	public void receive() {
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
			QueueReceiver receiver = session.createReceiver(queue);
			receiver.setMessageListener(this);
			connection.start();
			// Wait for stop
			while (!stop) {
				Thread.sleep(1000);
			}
			// Exit
			System.out.println("Exiting...");
			connection.close();
			System.out.println("Goodbye!");
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}

	public void onMessage(Message message) {
		try {
			String msgText = ((TextMessage) message).getText();
			System.out.println(msgText);
			if ("stop".equals(msgText))
				stop = true;
		} catch (JMSException e) {
			e.printStackTrace();
			stop = true;
		}
	}
}