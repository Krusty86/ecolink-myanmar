package filter;

import java.io.IOException;

import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter("/orders/*")// * all possible path
public class OrderFilter implements Filter{

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
		
			// user login or not
			if(session == null)
				response.sendRedirect("login?mode=LOGIN&error="+"Login First to Order");
			else if(session != null) {
				User user = (User) session.getAttribute("loginUser");
				if(user != null && user.getRole().equals("CUSTOMER"))	chain.doFilter(request, response);
				else response.sendRedirect("login?mode=LOGIN");
			}
		
			
		
		
	}

}
