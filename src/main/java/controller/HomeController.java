package controller;

import java.io.IOException;
import java.util.List;

import dao.ProductDAO;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeController extends HttpServlet{
	private final ProductDAO productDAO = new ProductDAO();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//show home.jsp
		//1. get all products from db table
		List<Product> products = productDAO.findAll();
		
		//add data into req
		req.setAttribute("products", products);  // ${products}
		req.setAttribute("pageContent", "home.jsp");
		req.setAttribute("pageTitle", "EcoLink Myanmar | Home");
		req.getRequestDispatcher("layout.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

}
