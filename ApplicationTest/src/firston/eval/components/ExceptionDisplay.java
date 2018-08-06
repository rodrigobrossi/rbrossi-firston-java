/*jadclipse*/// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
package firston.eval.components;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public final class ExceptionDisplay extends HttpServlet {

	public ExceptionDisplay() {
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		generateResponse(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		generateResponse(request, response);
	}

	public void generateResponse(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher responsePage = null;
		Throwable exception = (Throwable) request
				.getAttribute("javax.servlet.error.exception");
		String expTypeFullName = exception.getClass().getName();
		String expTypeName = expTypeFullName.substring(expTypeFullName
				.lastIndexOf(".") + 1);
		int oi = exception.hashCode();
		String request_uri = (String) request
				.getAttribute("javax.servlet.error.request_uri");
		responsePage = request.getRequestDispatcher("../erro/erro.jsp");
		responsePage.forward(request, response);
	}
}

/*
 * DECOMPILATION REPORT
 * 
 * Decompiled from:
 * C:\eclipseWTC\onix\Oregon\ImportedClasses/ser/error/ExceptionDisplay.class
 * Total time: 31 ms Jad reported messages/errors: Exit status: 0 Caught
 * exceptions:
 */