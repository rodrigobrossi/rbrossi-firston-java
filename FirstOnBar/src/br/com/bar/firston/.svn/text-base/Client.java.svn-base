package br.com.bar.firston;

import java.io.IOException;
import java.sql.Statement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.bar.firston.dbbeans.ClientDAO;

/**
 * Servlet implementation class Insert
 */
public class Client extends AbstractServletControl {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Client() {
        super();
    }
	
    /* (non-Javadoc)
     * @see br.com.bar.firston.AbstractServletControl#processRequest(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    protected void processRequest(HttpServletRequest request,HttpServletResponse response) throws IOException {
		super.processRequest(request, response);
		String operation 	= request.getParameter("op");
		
		if(operation==null){
			response.sendRedirect("/Error?code=1");
		}
		else if(operation.equalsIgnoreCase("i")){
			insert(request);
		}else if(operation.equalsIgnoreCase("d")){
			delete(request);
		}
	}

	private void delete(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * This method will insert an Element into the Client table
	 * @param request
	 */
	private void insert(HttpServletRequest request) {
		String name 	= request.getParameter("name");
		String phone 	= request.getParameter("phone");
		String email 	= request.getParameter("email");
		String cep 		= request.getParameter("cep");
		
		ClientDAO clientDAO = new ClientDAO(name,phone,email,cep);
		int result  = clientDAO.insert();
		out.print("<html>");
		out.print("<body>");
		out.print("<tt><b>Confirmation page</b></tt>");
		out.print("<form action='ui/incs/inc_client.jsp'>");
		if(result != Statement.EXECUTE_FAILED){
			out.print("<tt><br>&nbsp;You have inserted the following values: ");
			out.print("<br>&nbsp;<b>Name:</b>"+name);
			out.print("<br>&nbsp;<b>Phone:</b>"+phone);
			out.print("<br>&nbsp;<b>Email:</b>"+email);
			out.print("<br>&nbsp;<b>CEP:</b>"+cep);
			
		}else{
			out.print("<br> <font fance='Arial' color='RED' size='8'>The insert action fails for any reason!</font> ");
		}
		out.print("<br><input type='submit' value='OK' /></tt>");
		out.print("</form>");
		out.print("</body>");
		out.print("</html>");
		out.close();
	}

}
