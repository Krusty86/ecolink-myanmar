package controller;

import java.io.IOException;
import java.util.List;

import dao.ProductDAO;
import dao.ProductImageDAO;
import entity.Product;
import entity.ProductImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//show home.jsp
		//1. get all products from db
		List<Product> products = ProductDAO.findAll();
		java.util.Map<Long, String> imageMap = new java.util.HashMap<>();
        for (Product p : products) {
            // Find images for this specific product
            List<ProductImage> pImages = ProductImageDAO.findByProductId(p.getId());
            if (pImages != null && !pImages.isEmpty()) {
                imageMap.put(p.getId(), pImages.get(0).getImage_path());
            }
        }
		//add data into req
		req.setAttribute("productImages", imageMap);
		req.setAttribute("products", products);
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
