package br.com.ibm.csc.rsd;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueReceiver;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.TextMessage;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * A complete JMS client example program that sends a TextMessage to a Queue and
 * asynchronously receives the message from the same Queue.
 * 
 * @author rbrossi
 *  */
public class SendRecvClient {

	QueueConnection conn;
	QueueSession session;
	Queue que;

	public static class ExListener implements MessageListener {
		public void onMessage(Message msg) {
			TextMessage tm = (TextMessage) msg;
			try {
				System.out.println("onMessage, recv text=" + tm.getText());
			} catch (Throwable t) {
				t.printStackTrace();
			}
		}
	}

	public void setupPTP() throws JMSException, NamingException {
		InitialContext iniCtx = new InitialContext();
		Object tmp = iniCtx.lookup("RemoteConnectionFactory");
		QueueConnectionFactory qcf = (QueueConnectionFactory) tmp;
		conn = qcf.createQueueConnection();
		que = (Queue) iniCtx.lookup("queue/testQueue");
		session = conn.createQueueSession(false, QueueSession.AUTO_ACKNOWLEDGE);
		conn.start();
	}

	public void sendRecvAsync(String text) throws JMSException, NamingException {
		System.out.println("Begin sendRecvAsync");
		// Setup the PTP connection, session
		setupPTP();

		// Set the async listener
		QueueReceiver recv = session.createReceiver(que);
		recv.setMessageListener(new ExListener());

		// Send a text msg
		QueueSender send = session.createSender(que);
		TextMessage tm = session.createTextMessage(text);
		send.send(tm);
		System.out.println("sendRecvAsync, sent text=" + tm.getText());
		send.close();
		System.out.println("End sendRecvAsync");
	}

	public void stop() throws JMSException {
		conn.stop();
		session.close();
		conn.close();
	}

	public static void main(String args[]) throws Exception {

		System.out.println("Begin SendRecvClient, now="
				+ System.currentTimeMillis());
		SendRecvClient client = new SendRecvClient();
		client.sendRecvAsync("A text msg");
		client.stop();
		System.out.println("End SendRecvClient");
		System.exit(0);
	}
}