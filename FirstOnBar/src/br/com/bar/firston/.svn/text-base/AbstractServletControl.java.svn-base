package br.com.bar.firston;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public abstract class AbstractServletControl extends HttpServlet{

	/**
	 * Serial version ID
	 */
	private static final long serialVersionUID = -4388809573153367222L;
	
	protected PrintWriter out;
	protected HttpSession session;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		processRequest(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request,response);
	}
	
	/**
	 * Never forget to call the super before start work with this method in you child classes.
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	protected  void processRequest(HttpServletRequest request,HttpServletResponse response) throws IOException{
		out = response.getWriter();	
        session = request.getSession();
		
	}
	
	

}
