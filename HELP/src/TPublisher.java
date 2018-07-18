


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnection;
import javax.jms.TopicConnectionFactory;
import javax.jms.TopicPublisher;
import javax.jms.TopicSession;
import javax.naming.Context;
import javax.naming.InitialContext;

public class TPublisher {
	public static void main(String[] args) {
		new TPublisher().publish();
	}

	public void publish() {
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
			TopicPublisher publisher = session.createPublisher(topic);
			// Send messages
			System.out.println("Enter message to send or 'quit' to quit");
			String messageText = null;
			while (true) {
				messageText = reader.readLine();
				if ("quit".equalsIgnoreCase(messageText)) {
					break;
				}
				TextMessage message = session.createTextMessage(messageText);
				publisher.publish(message);
			}
			// Exit
			System.out.println("Exiting...");
			reader.close();
			connection.close();
			System.out.println("Goodbye!");
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}