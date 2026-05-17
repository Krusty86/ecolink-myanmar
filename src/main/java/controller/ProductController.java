package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductImageDAO;
import entity.Category;
import entity.Product;
import entity.ProductImage;
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

	private void showProductDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String idParam = req.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
        	System.out.println("Inside False Condition");
            resp.sendRedirect("products?mode=LIST");
            return;
        }

        try {
            Long productId = Long.parseLong(idParam);
            Product product = ProductDAO.findById(productId);

            if (product != null) {
                List<ProductImage> images = ProductImageDAO.findByProductId(productId);
                Map<Long, String> productImages = new HashMap<>();
                if (images != null && !images.isEmpty()) {
                    productImages.put(productId, images.get(0).getImage_path());
                }

                req.setAttribute("product", product);
                req.setAttribute("productImages", productImages);
                req.setAttribute("pageTitle", product.getName() + " | EcoLink");
                req.setAttribute("pageContent", "product-detail.jsp");
                req.getRequestDispatcher("layout.jsp").forward(req, resp);
            } else {
                resp.sendRedirect("products?mode=LIST");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("products?mode=LIST");
        }
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}

}
