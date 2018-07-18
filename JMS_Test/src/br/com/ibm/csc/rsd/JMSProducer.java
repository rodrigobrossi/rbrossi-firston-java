package br.com.ibm.csc.rsd;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.Session;

public class JMSProducer {

	public void jmsClientProducer(String msg) throws JMSException {
		// Send a message
		ConnectionFactory factory = JMSUtil.getJMSConnectionFactory();
		Connection connection = factory.createConnection();
		// points of synchronization (Transient is false, and the Middleware
		// answer the requests).
		Session session = connection.createSession(false,
				Session.AUTO_ACKNOWLEDGE); // ISO/OSI Session control
		Queue queue = session.createQueue("brossiQueue");
		MessageProducer producer = session.createProducer(queue);
		producer.setDeliveryMode(DeliveryMode.PERSISTENT);
		connection.start();// Start
		Message message = session.createTextMessage(msg);
		producer.send(message);
		connection.close();
	}

	public static void main(String args[]) {

		

		Thread producerT = new Thread() {
			JMSProducer t = new JMSProducer();

			@Override
			public void run() {
				for (int i = 0; i < 10; i++) {
					try {
						t.jmsClientProducer("Hello World Brossi" + i);
						System.out.println("MSG "+i+" Sent!");
					} catch (JMSException e) {
						e.printStackTrace();
					}
				}

			}
		};
		
		producerT.start();

	}

}
