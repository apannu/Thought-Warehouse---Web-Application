package com.iit.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

public class IITSessionFilter implements Filter{

private static final Logger LOGGER = Logger.getLogger(IITSessionFilter.class);
	
	public void init(FilterConfig config) throws ServletException { }

	public void destroy() {	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
		final HttpServletRequest req = (HttpServletRequest) request;
		final HttpServletResponse resp = (HttpServletResponse) response;
		
		final String uri = req.getRequestURI();
		LOGGER.info("uri is: "+uri);
		HttpSession httpSession = req.getSession(false);
		if(httpSession!=null)
		LOGGER.info("username: "+httpSession.getAttribute("username"));
		if(uri.endsWith("logout"))
		{
			LOGGER.info("Entered the logout");
			
			if(httpSession!=null)
			{
				LOGGER.info("inside logout session expiry");
				httpSession.removeAttribute("username");
				httpSession.removeAttribute("firstName");
	    		httpSession.removeAttribute("lastName");
	    		httpSession.removeAttribute("userId");
	    		httpSession.removeAttribute("fbUserId");
	    		httpSession.removeAttribute("imageFlag");
	    		httpSession.removeAttribute("fbUsername");
				httpSession.invalidate();
//				resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
//		        resp.setHeader("Pragma", "no-cache"); // HTTP 1.0.
//		        resp.setDateHeader("Expires", 0); // Proxies.
			}
			try {
				chain.doFilter(request, response);
//				resp.sendRedirect("show");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
//		else if(httpSession==null && uri.endsWith("checkLogin"))
//		{
//			try {
//				resp.sendRedirect("login");
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
		else
		{
			LOGGER.info("Entered the normal flow");
			// pass the request along the filter chain
			try {
				chain.doFilter(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
	}
	
}
