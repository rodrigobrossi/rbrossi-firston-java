package br.com.crm.db;

import java.io.PrintWriter;

import org.hsqldb.Server;

public class ServerStart  implements Runnable{
	
	
	private final static Server server = new Server();
	
	private Application application;
	
	ServerStart(Application application){
		this.application= application;
		
	}

	private boolean serverRunning;

	public boolean isServerRunning() {
		return serverRunning;
	}

	public void setServerRunning(boolean serverRunning) {
		this.serverRunning = serverRunning;
	}

	public Server getServer() {
		return server;
	}

	public void run() {
		
		server.setPort(9199);
		server.setNoSystemExit(true);
		server.setDatabaseName(0, "firston");
		server.setDatabasePath(0,"/home/rbrossi/FIRSTON/CRMDB");
		//server.setDatabasePath(0,".");
		server.setErrWriter(new PrintWriter(System.out));
		server.setLogWriter(new PrintWriter(System.out));
		server.setAddress("127.0.0.1");
		System.out.println("Command start:"+server.start());
		serverRunning = true;
		
		synchronized (application) {
			application.notifyAll();
			System.out.println("[BROSSI]: Free to use");
		}
		while(serverRunning){
			try {
				Thread.sleep(1000);
				server.checkRunning(true);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
	}

}
