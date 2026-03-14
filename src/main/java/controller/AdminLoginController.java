package controller;

import dao.UserDAO;
import entity.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/login")
public class AdminLoginController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/admin-login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	// get form data
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = UserDAO.login(email, password);
        System.out.println("Do Post Success");
        System.out.println(email + password);
        if (user != null && "ADMIN".equals(user.getRole())) {
        	System.out.println("Inside True Condition");
            HttpSession session = req.getSession();
            session.setAttribute("loggedUser", user);
            // go to admin dashboard controller
            // admin/dashboard	=> login (admin/dashboard) => admin/admin/dashboard
            resp.sendRedirect("home");

        } else {
        	System.out.println("user");
        	System.out.println("Inside False Condition");
        	// not login or not admin => go to adminLogin.jsp
            req.setAttribute("error", "Invalid Admin Credentials!");
            req.getRequestDispatcher("/admin-login.jsp").forward(req, resp);
        }
    }
}