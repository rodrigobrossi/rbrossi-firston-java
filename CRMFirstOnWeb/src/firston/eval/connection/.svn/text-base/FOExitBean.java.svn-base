/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.connection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;

// Referenced classes of package ser.comum.conexao:
//            Conexao

public final class FOExitBean extends HttpServlet {

	public FOExitBean() {
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void destroy() {
	}

	protected void processRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		Connection conn = (Connection) session.getAttribute("Conn");
		FODBConnectionBean conn2 = new FODBConnectionBean();
		conn2.finalizaBD(conn);
		session.invalidate();
		out.println("<html>");
		out.println("<head>");
		out.println("<title>Servlet</title>");
		out.println("</head>");
		out.println("<body>");
		out
				.println("<table width='100%' height='100%'><tr><td><center><tt>Aplica\347ao Finalizada</tt></center></td></tr>");
		out
				.println("<tr><td><center><tt><input type='button' value='close' onclick='javascript:window.close();' ></tt></center></td></tr></table>");
		out.println("</body>");
		out.println("</html>");
		out.close();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

	public String getServletInfo() {
		return "Short description";
	}
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/comum/conexao/Sair.class Total
 * time: 15 ms Jad reported messages/errors: Exit status: 0 Caught exceptions:
 */