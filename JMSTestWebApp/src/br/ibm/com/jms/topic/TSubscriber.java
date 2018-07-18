package br.ibm.com.jms.topic;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnection;
import javax.jms.TopicConnectionFactory;
import javax.jms.TopicSession;
import javax.jms.TopicSubscriber;
import javax.naming.Context;
import javax.naming.InitialContext;

public class TSubscriber implements MessageListener {
	private boolean stop = false;

	public static void main(String[] args) {
		new TSubscriber().subscribe();
	}

	public void subscribe() {
		BufferedReader reader = new BufferedReader(new InputStreamReader(
				System.in));
		try {
			// Strings for JNDI names
			String factoryName = "jms/RemoteConnectionFactory";
			String topicName = "jms/topic/brossi";
			// Create an initial context.
			Properties props = new Properties();
			props.put(Context.INITIAL_CONTEXT_FACTORY,
					"org.jboss.naming.remote.client.InitialContextFactory");
			props.put(Context.PROVIDER_URL, "remote://localhost:4447");
			props.put(Context.SECURITY_PRINCIPAL, "user");
			props.put(Context.SECURITY_CREDENTIALS, "guest");
			props.put("jboss.naming.client.ejb.context", true);
			InitialContext context = new InitialContext(props);

			TopicConnectionFactory factory = (TopicConnectionFactory) context
					.lookup(factoryName);
			Topic topic = (Topic) context.lookup(topicName);
			context.close();
			// Create JMS objects
			TopicConnection connection = factory.createTopicConnection("user",
					"guest");
			TopicSession session = connection.createTopicSession(false,
					Session.AUTO_ACKNOWLEDGE);
			TopicSubscriber subscriber = session.createSubscriber(topic);
			subscriber.setMessageListener(this);
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