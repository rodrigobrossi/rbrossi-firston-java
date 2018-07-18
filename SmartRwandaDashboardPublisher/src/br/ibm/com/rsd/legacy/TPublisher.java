package br.ibm.com.rsd.legacy;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.jms.JMSException;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnection;
import javax.jms.TopicConnectionFactory;
import javax.jms.TopicPublisher;
import javax.jms.TopicSession;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.swing.JTextArea;

/**
 * Topic Publisher application.
 * 
 * This application is responsible to connect and publish the data through the
 * ESB (Enterprise service Buss) This application is Thread to ensure the
 * performance during the exchange message process.
 * 
 * @author Rodrigo Luis Nolli Brossi
 *
 */
public class TPublisher implements Runnable {

	/**
	 * Topic connection Factory
	 */
	private TopicConnectionFactory factory;
	/**
	 * Topic Instance
	 */
	private Topic topic;
	/**
	 * Topic Connection
	 */
	private TopicConnection connection;
	/**
	 * Topic Session
	 */
	private TopicSession session;
	/**
	 * Topic Publisher (IO connection support)
	 */
	private TopicPublisher publisher;
	/**
	 * IO Connection
	 */
	private BufferedReader reader;
	/**
	 * Text Area for ready the information exchange during the communication
	 */
	private JTextArea tStatus;

	/**
	 * TPublisher constructor
	 * 
	 * @param tStatus
	 */
	public TPublisher(JTextArea tStatus) {
		this.tStatus = tStatus;

	}

	/**
	 * This method is responsible to publish the data (KPIs through messages)
	 * 
	 * @param tStatus JTextArea from the view application
	 */
	public void publish(JTextArea tStatus) {

		reader = new BufferedReader(new InputStreamReader(System.in));
		try {
			// Strings for JNDI names
			String factoryName = "jms/RemoteConnectionFactory";
			String topicName = "jms/topic/rsd";
			// Create an initial context.
			Properties props = new Properties();
			props.put(Context.INITIAL_CONTEXT_FACTORY,
					"org.jboss.naming.remote.client.InitialContextFactory");
			props.put(Context.PROVIDER_URL, "remote://"+getProperty("esb_host")+":"+getProperty("esb_port"));
			props.put(Context.SECURITY_PRINCIPAL, getProperty("user"));
			props.put(Context.SECURITY_CREDENTIALS,getProperty("password"));
			props.put("jboss.naming.client.ejb.context", true);
			InitialContext context = new InitialContext(props);

			factory = (TopicConnectionFactory) context.lookup(factoryName);
			topic = (Topic) context.lookup(topicName);
			context.close();
			connection = factory.createTopicConnection("user", "guest");
			session = connection.createTopicSession(false,
					Session.AUTO_ACKNOWLEDGE);
			publisher = session.createPublisher(topic);
			// Send messages
			tStatus.setText("Enter message to send or 'quit' to quit");

		} catch (Exception e) {
			tStatus.append("ERRO:" + e.getStackTrace());
			tStatus.append("ERRO CAUSE:" + e.getCause());
			tStatus.append("ERRO MESSAGE:" + e.getLocalizedMessage());
			e.printStackTrace();
		}
	}

	/**
	 * This method is responsible to change the send the message 
	 * @param messageText Receives the text message to be sent
	 */
	public void sendMessage(String messageText) {
		TextMessage message;
		try {
			message = session.createTextMessage(messageText);
			publisher.publish(message);
		} catch (JMSException e) {
			e.printStackTrace();
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Runnable#run()
	 */
	@Override
	public void run() {
		publish(tStatus);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#finalize()
	 */
	@Override
	protected void finalize() throws Throwable {
		// Close the IO connections

		reader.close();
		connection.close();
		System.out.println("Goodbye!");
		super.finalize();
	}
	
	/**
	 * Get the properties from the properties file
	 * 
	 * @param property
	 *            Property ID
	 * @return Property value
	 */
	private String getProperty(String property) {
		Properties prop = new Properties();
		InputStream input = null;

		try {

			input = new FileInputStream("config.properties");

			// load a properties file
			prop.load(input);

			String strProp = prop.getProperty(property);
			// get the property value and print it out
			System.out.println(strProp);

			return strProp;

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
		return null;
	}

}