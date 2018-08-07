package br.com.ibm.csc.rsd;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.MessageConsumer;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.TextMessage;

public class JMSConsumer {

	public String jmsClientConsumer() throws JMSException {

		ConnectionFactory factory = JMSUtil.getJMSConnectionFactory();
		Connection connection = factory.createConnection();
		// points of synchronization (Transient is false, and the Middleware
		// answer the requests).
		Session session = connection.createSession(false,
				Session.AUTO_ACKNOWLEDGE);// ISO/OSI Session control
		Queue queue = session.createQueue("testQueue");
		MessageConsumer consumer = session.createConsumer(queue);
		connection.start();// Start
		TextMessage message = (TextMessage) consumer.receive();
		connection.close();
		return (message==null)?null:message.getText();
	}

	

	public static void main(String args[]) {
		JMSConsumer t = new JMSConsumer();
		try {
			boolean hasMsg=true;
			while (hasMsg){
				String msg = t.jmsClientConsumer();
				if(msg==null)
					hasMsg = false;
				System.out.println("MSG:"+msg);
			}

		} catch (JMSException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}



}
