package controller;

import java.io.IOException;
import java.util.List;

import dao.CategoryDAO;
import dao.ProductDAO;
import entity.Category;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/products")
public class ProductController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String mode = req.getParameter("mode");
		if(mode == null) mode = "";
		switch(mode) {
		case "LIST": showProductList(req, resp); break;
		case "VIEWDETAIL": showProductDetail(req, resp); break;
		default: showProductList(req, resp); break;
		}
	}

	private void showProductList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Product> pList = ProductDAO.findAllPublished();
		List<Category> cList = CategoryDAO.findAll();
		
		req.setAttribute("products", pList);
		req.setAttribute("category", cList);
		req.setAttribute("pageTitle", "Products | EcoLink Myanmar");
		req.setAttribute("pageContent", "buyer-products.jsp");
		req.getRequestDispatcher("layout.jsp").forward(req, resp);
	}

	private void showProductDetail(HttpServletRequest req, HttpServletResponse resp) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

}
