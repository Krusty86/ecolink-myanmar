package filter;

import java.io.IOException;

import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/admin/*")// * all possible path
public class AdminFilter implements Filter{

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
//		change ServletRequest to HttpServletRequest, same with response
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;

//		get URI	=> unified resource indicator
		String uri = request.getRequestURI();
		HttpSession session = request.getSession(false);
		
		// admin/login => show login form (no security)
		// admin/logout => to logout (no security)
		if(uri.contains("admin/login") || uri.contains("admin/logout") || uri.contains("admin/uploads")) 
			chain.doFilter(request, response);	// no need to check
		else {
			// admin/dashboard
			if(session == null)
				response.sendRedirect("login");
			else if(session != null) {
				User user = (User) session.getAttribute("loggedUser");
				if(user != null && user.getRole().equals("ADMIN"))	chain.doFilter(request, response);
				else response.sendRedirect("login");
			}
		}
			
		
		
	}

}
