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

    private void showRegisterForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// user register
    	req.getRequestDispatcher("register.jsp").forward(req, resp);
    }

    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setRole("CUSTOMER"); // default role for user
        newUser.setStatus(true);

        try {
            boolean isSaved = UserDAO.save(newUser); 
            if (isSaved) {
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
                resp.sendRedirect("home");
            } 
            else if ("ADMIN".equals(user.getRole())) {
                // Redirect to admin dashboard
            	System.out.println("Inside Admin Role Confirmed");
                resp.sendRedirect("home?mode=DASHBOARD");
            } 
            else {
                resp.sendRedirect("home");
            }
        }
    }

    private void showLoginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String alertMode = req.getParameter("mode");
        if (alertMode != null) {
            req.setAttribute("mode", alertMode);
        }
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}