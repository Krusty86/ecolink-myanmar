package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.ProductDAO;
import dao.UserDAO;
import entity.Cart;
import entity.Product;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final ProductDAO productDAO = new ProductDAO();
   
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        if (mode == null) mode = "LOGIN";

        switch (mode) {
	        case "REGISTER":
	            showRegisterForm(req, resp);
	            break;
	        case "SAVE":
	            registerUser(req, resp);
	            break;
            case "LOGIN":
                showLoginForm(req, resp);
                break;
            case "CHECK":
                loginUser(req, resp);
                break;
            case "LOGOUT":
                logoutUser(req, resp);
                break;
            default:
                showLoginForm(req, resp);
                break;
        }
    }

 // 1. DISPLAYS THE REGISTRATION PAGE
    private void showRegisterForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.setAttribute("pageTitle", "Register | EcoLink");
//        req.setAttribute("pageContent", "register.jsp"); // The JSP we created earlier
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    // 2. PROCESSES THE FORM SUBMISSION
    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Create User Object
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setRole("CUSTOMER"); // Default role for web registration
        newUser.setStatus(true);

        try {
            // Call your DAO to save to database
            boolean isSaved = userDAO.save(newUser); 

            if (isSaved) {
                // Redirect to login with a success message
                req.setAttribute("save", true);
                showLoginForm(req, resp);
            } else {
                req.setAttribute("error", "Registration failed. Email might already exist.");
                showRegisterForm(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "An error occurred: " + e.getMessage());
            showRegisterForm(req, resp);
        }
    }
    private void logoutUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect("home");
    }

    private void loginUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = UserDAO.login(email, password);

        if (user == null) {
            // Login Failed
            req.setAttribute("error", "Invalid email or password!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        } else {
            // Login Success
            HttpSession session = req.getSession(true);
            session.setAttribute("loginUser", user);

            // Initialize Cart for CUSTOMERs only
            if ("CUSTOMER".equals(user.getRole())) {
                if (session.getAttribute("cart") == null) {
                    session.setAttribute("cart", new Cart());
                }
                // Redirect to homepage for buyers
                resp.sendRedirect("home");
            } 
            else if ("ADMIN".equals(user.getRole())) {
                // Redirect to admin dashboard
                resp.sendRedirect("home?mode=DASHBOARD");
            } 
            else {
                // Default fallback
                resp.sendRedirect("home");
            }
        }
    }

    private void showLoginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String alertMode = req.getParameter("mode");
        if (alertMode != null) {
            req.setAttribute("mode", alertMode);
        }
        
//        req.setAttribute("pageTitle", "Login | EcoLink");
//        req.setAttribute("pageContent", "login.jsp");
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}