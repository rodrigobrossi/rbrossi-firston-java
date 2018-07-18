package br.com.bar.firston.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class FilterConnection
 */


public class HttpFilterBar implements Filter {
	private String page = "/WEB-INF/sessionexpired.jsp"; 
	/**
     * Default constructor. 
     */
    public HttpFilterBar() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if (((HttpServletRequest) request).getRequestedSessionId() != null
				&& ((HttpServletRequest) request).isRequestedSessionIdValid() == false) {
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else {
			
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		if (filterConfig.getInitParameter("page") != null) {
			page = filterConfig.getInitParameter("page");
		}
	}

}
