package br.ibm.com.rsd;

import java.awt.Color;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Properties;
import java.util.StringTokenizer;

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
import javax.swing.JTextArea;

/**
 * Subscribe and persist the data for the Rwanda Smart Dashboard
 * 
 * @author Rodrigo Luis Nolli Brossis
 */
public class TSubscriber implements MessageListener {
	/**
	 * Boolean stop processing
	 */
	private boolean stop = false;
	/**
	 * Topic channel
	 */
	private TopicConnection connection;
	/**
	 * Log Area
	 */
	private JTextArea tStatus;

	/**
	 * Method to subscribe the application to ESBs
	 * 
	 * @param tStatus
	 */
	public void subscribe(final JTextArea tStatus) {
		this.tStatus = tStatus;

	    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
		try {
			// Strings for JNDI names
			String factoryName = "jms/RemoteConnectionFactory";
			String topicName = "jms/topic/rsd";
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
			connection = factory.createTopicConnection("user", "guest");
			TopicSession session = connection.createTopicSession(false,
					Session.AUTO_ACKNOWLEDGE);
			TopicSubscriber subscriber = session.createSubscriber(topic);
			subscriber.setMessageListener(TSubscriber.this);
			connection.start();
			// Wait for stop
			while (!stop) {
				Thread.sleep(1000);
			}
			// Exit
			tStatus.setText("Exiting...");
			connection.close();
			tStatus.setText("Goodbye!");
		} catch (Exception e) {
			System.out.println("[LOG]:" + e.getLocalizedMessage());
			try {
				Thread.sleep(2000);
				subscribe(tStatus);
			} catch (InterruptedException e1) {
				e1.printStackTrace();

			}

		}

	}

	/**
	 * @param message
	 * @return
	 * 
	 *         Follow the example of a CVS file to import the data
	 * 
	 *         KPI_sector, KPI_creation_date, KPI_name, KPI_value, KPI_Target,
	 *         KPI_value_type, KPI_max_value, KPI_min_value
	 * 
	 * 
	 */
	public KPI createKPIObject(String message) {

		KPI kpi = new KPI();

		StringTokenizer st = new StringTokenizer(message, ",");

		kpi.setKPI_sector(st.nextToken());
		kpi.setKPI_creation_date(st.nextToken());
		kpi.setKPI_name(st.nextToken());
		kpi.setKPI_value(st.nextToken());
		kpi.setKPI_Target(st.nextToken());
		kpi.setKPI_value_type(st.nextToken());
		kpi.setKPI_max_value(st.nextToken());
		kpi.setKPI_min_value(st.nextToken());
		kpi.setKPI_source(st.nextToken());

		return kpi;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.jms.MessageListener#onMessage(javax.jms.Message)
	 */
	@SuppressWarnings("deprecation")
	public void onMessage(Message message) {
		try {
			String msgText = ((TextMessage) message).getText();
			System.out.println("[MSG]:" + msgText);

			tStatus.append(msgText);

			// Import to database.

			RSDConnection connectionFactory = new RSDConnection();

			Connection conn = connectionFactory.getConnection();

			Statement stm = conn.createStatement();

			KPI kpi = createKPIObject(msgText);

			StringBuffer sql = new StringBuffer(
					"INSERT Into RSD_KPIMAP VALUES(nextval('rsd_kpimap_seq'),'");
			sql.append(kpi.getKPI_sector());
			sql.append("','");
			sql.append(kpi.getKPI_creation_date());
			sql.append("','");
			sql.append(kpi.getKPI_name());
			sql.append("','");
			sql.append(kpi.getKPI_value());
			sql.append("','");
			sql.append(kpi.getKPI_Target());
			sql.append("','");
			sql.append(kpi.getKPI_value_type());
			sql.append("','");
			sql.append(kpi.getKPI_max_value());
			sql.append("','");
			sql.append(kpi.getKPI_min_value());
			sql.append("','");
			sql.append(kpi.getKPI_source());
			sql.append("')");

			stm.executeUpdate(sql.toString());

			stm.close();
			conn.close();

			if ("stop".equals(msgText)) {
				stop = true;
			} else {

				File file = new File("MSG_LOG.bin");

				// if file doesn't exists, then create it
				if (!file.exists()) {
					file.createNewFile();
				}

				// true = append file
				FileWriter fileWritter = new FileWriter(file.getName(), true);
				BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
				
				StringBuffer sb = new StringBuffer();
				sb.append("\n[LOG: " );
				sb.append((new Date()).getDate());
				sb.append( "]");
				sb.append( msgText);
				
				bufferWritter.write(sb.toString());
				bufferWritter.close();

				tStatus.setBackground(Color.green);
				// tStatus.updateUI();
				Thread.sleep(500);
				tStatus.setBackground(Color.white);

			}

		} catch (JMSException e) {
			e.printStackTrace();
			stop = true;
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void closeConnection() {
		tStatus.setText("Exiting...");
		try {
			connection.close();
		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		tStatus.setText("Goodbye!");
	}

	/**
	 * 
	 * Subclass KPI bean representing the CVS File
	 * 
	 * @author Rodrigo Luis Nolli Brossi
	 *
	 */
	public class KPI {

		private String KPI_sector;
		private String KPI_creation_date;
		private String KPI_name;
		private String KPI_value;
		private String KPI_Target;
		private String KPI_value_type;
		private String KPI_source;
		private String KPI_max_value;
		private String KPI_min_value;

		/**
		 * Return the source of information
		 * 
		 * @return String with Agency that informed the data
		 */
		public String getKPI_source() {
			return KPI_source;
		}

		/**
		 * Set the source of information
		 * 
		 * @param kPI_source
		 *            String with the Angency's name that inform the data
		 */
		public void setKPI_source(String kPI_source) {
			KPI_source = kPI_source;
		}

		/**
		 * Return the information Sector
		 * 
		 * @return String with the sector name
		 */
		public String getKPI_sector() {
			return KPI_sector;
		}

		/**
		 * Set the name of the sector information
		 * 
		 * @param kPI_sector
		 *            Strinc with sector name
		 */
		public void setKPI_sector(String kPI_sector) {
			KPI_sector = kPI_sector;
		}

		/**
		 * Get the data of data creation
		 * 
		 * @return String with the creation date
		 */
		public String getKPI_creation_date() {
			return KPI_creation_date;
		}

		/**
		 * Set the data for when the information was created
		 * 
		 * @param kPI_creation_date
		 *            String data of data creation
		 */
		public void setKPI_creation_date(String kPI_creation_date) {
			KPI_creation_date = kPI_creation_date;
		}

		/**
		 * Get the KPI name
		 * 
		 * @return String with the KPI name
		 */
		public String getKPI_name() {
			return KPI_name;
		}

		/**
		 * Set the KPI name
		 * 
		 * @param kPI_name
		 *            String with the KPI name
		 */
		public void setKPI_name(String kPI_name) {
			KPI_name = kPI_name;
		}

		/**
		 * Get the KPI value
		 * 
		 * @return String with the KPI value
		 */
		public String getKPI_value() {
			return KPI_value;
		}

		/**
		 * Set the KPI value
		 * 
		 * @param kPI_value
		 *            String with the KPI value
		 */
		public void setKPI_value(String kPI_value) {
			KPI_value = kPI_value;
		}

		/**
		 * Get the KPI value according with Rwanda Smart Plan (2020)
		 * 
		 * @return String with the KPI value
		 */
		public String getKPI_Target() {
			return KPI_Target;
		}

		/**
		 * Set the KPI Target according wiht Rwanda Smart Plan (2020)
		 * 
		 * @param kPI_Target
		 */
		public void setKPI_Target(String kPI_Target) {
			KPI_Target = kPI_Target;
		}

		/**
		 * Return the calue type
		 * 
		 * @return String with the value type
		 */
		public String getKPI_value_type() {
			return KPI_value_type;
		}

		/**
		 * Set the value type (Number, String, Date, ETC) This can be used in
		 * the future to identify wrappers and instantiate, though reflection,
		 * classes to handle the data
		 * 
		 * @param kPI_value_type
		 */
		public void setKPI_value_type(String kPI_value_type) {
			KPI_value_type = kPI_value_type;
		}

		/**
		 * Return the KPI max value
		 * 
		 * @return KPI String with Max value (Might need a cast)
		 */
		public String getKPI_max_value() {
			return KPI_max_value;
		}

		/**
		 * Set KPI Max value
		 * 
		 * @param kPI_max_value
		 *            String with max value of a KPI
		 */
		public void setKPI_max_value(String kPI_max_value) {
			KPI_max_value = kPI_max_value;
		}

		/**
		 * Get minimum value for a KPI
		 * 
		 * @return String with the information of the KPI minimum value
		 */
		public String getKPI_min_value() {
			return KPI_min_value;
		}

		/**
		 * Set the minimum value for a KPI
		 * 
		 * @param kPI_min_value
		 *            String with the minimum value of a KPI
		 */
		public void setKPI_min_value(String kPI_min_value) {
			KPI_min_value = kPI_min_value;
		}

	}

}