package controller;

import java.io.IOException;
import java.util.List;

import dao.ProductDAO;
import dao.UserDAO;
import entity.Product;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
@WebServlet("/login")
public class LoginController extends HttpServlet{
	private final UserDAO userDAO = new UserDAO();	// class level
	private final ProductDAO productDAO = new ProductDAO();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mode = req.getParameter("mode");
		if(mode==null)	mode = "LOGIN";
		System.out.println("MODE: "+mode);
		switch (mode) {
		case "LOGIN": showLoginForm(req, resp); break;	// show login form as default
		case "CHECK": loginUser(req, resp); break;	// check login info
		case "LOGOUT": logoutUser(req, resp); break;
		default:
			break;
		}
	}

	private void logoutUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// clear data in session
		HttpSession session = req.getSession(false); // get existing session
		session.invalidate(); // all clear
		// go to home page
		resp.sendRedirect("home"); // controller switch, code reused
		
	}

	private void loginUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// get data from login form
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		User user = userDAO.login(email, password);
		if(user==null) {
			req.setAttribute("loginError", true);
			req.setAttribute("pageTitle", "Login: Onlne Shop");
			req.setAttribute("pageContent", "login.jsp");
			req.getRequestDispatcher("layout.jsp").forward(req, resp);
		}else {
			HttpSession session = req.getSession();	// create new session
			session.setAttribute("loginUser", user);
			// call product dao to get  all products from db
			List<Product> products = productDAO.findAll();
			req.setAttribute("products", products);
			req.setAttribute("pageTitle", "Home: Online Shop");
			req.setAttribute("pageContent", "home.jsp");
			req.getRequestDispatcher("layout.jsp").forward(req, resp);
		}
	}

	private void showLoginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String mode = req.getParameter("mode");
		if(mode!=null) {
			req.setAttribute("mode", mode);
		}
		req.setAttribute("pageTitle", "Login: Online Shop");
		req.setAttribute("pageContent", "login.jsp");
		req.getRequestDispatcher("layout.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
