package controller;

import dao.CategoryDAO;
import dao.*;
import entity.*;
import enums.OrderStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/home")
public class AdminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	String mode = req.getParameter("mode");
    	if(mode==null)	mode = "";
    	
    	switch (mode) {
		case "ORDERS":	showOrders(req, resp);break;
		case "PRODUCTS": showProducts(req, resp);break;
		case "USERS":	showUsers(req, resp);break;
		case "EDITU": editUserStatus(req, resp);break;
		case "EDIT_CAT": editCategory(req, resp);break;
		case "EDITP": editProduct(req, resp);break;
		case "UPDATE_STATUS": updateProductStatus(req, resp); break;
		case "EDITO": updateOrderStatus(req, resp); break;
		case "ADDP": addProduct(req, resp); break;
		default: showAdminDashboard(req, resp);break;
		}

    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Gather all raw variables from your Bootstrap Modal form entries
            String name = req.getParameter("name");
            String categoryIdStr = req.getParameter("categoryId");
            String priceStr = req.getParameter("price");
            String qtyStr = req.getParameter("qty");
            String materialType = req.getParameter("material_type");
            String plasticSavedStr = req.getParameter("plastic_saved");

            // 2. Safely parse the form values into strongly-typed objects
            Long categoryId = Long.parseLong(categoryIdStr);
            BigDecimal price = new BigDecimal(priceStr);
            Long qty = Long.parseLong(qtyStr);

            // Fallback safely to zero if optional environmental metrics are submitted blank
            BigDecimal plasticSaved = BigDecimal.ZERO;
            if (plasticSavedStr != null && !plasticSavedStr.trim().isEmpty()) {
                plasticSaved = new BigDecimal(plasticSavedStr);
            }

            // 3. Assemble Entity Data Payloads
            Category category = new Category();
            category.setId(categoryId);

            Product product = new Product();
            product.setName(name);
            product.setCategory(category);
            product.setMaterial_type(materialType);
            product.setPlastic_saved_per_unit(plasticSaved);
            product.setQty(qty);
            product.setPrice(price); // Set price for the second SQL execution inside the DAO
            
            // Match status definitions depending on your project structure (e.g., Draft vs Published)
            // If your enum looks like ProductStatus.DRAFT / ProductStatus.PUBLISHED:
            try {
                product.setStatus(enums.ProductStatus.valueOf("DRAFT")); 
            } catch (Exception ex) {
                // Fallback default catch-all if your enum structure varies
                product.setStatus(enums.ProductStatus.values()[0]); 
            }

            // 4. Persistence pipeline execution
            Product savedProduct = ProductDAO.save(product);

            if (savedProduct != null && savedProduct.getId() != null) {
                // Success! Send clean query signals back to the main management grid view interface
                resp.sendRedirect("home?mode=PRODUCTS&status=success");
            } else {
                resp.sendRedirect("home?mode=PRODUCTS&status=db_error");
            }

        } catch (NumberFormatException | NullPointerException e) {
            e.printStackTrace();
            resp.sendRedirect("home?mode=PRODUCTS&status=invalid_input");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("home?mode=PRODUCTS&status=execution_failed");
        }
    }


	private void updateOrderStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// Update Order Status
		Long id = Long.parseLong(req.getParameter("id"));
		String status = req.getParameter("status");
		if(OrderDAO.updateStatus(id, OrderStatus.valueOf(status))) {
			resp.sendRedirect("home?mode=ORDERS");
		}
	}

	private void editUserStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// User Status Only
		Long id = Long.parseLong(req.getParameter("id"));
		Boolean status = Boolean.parseBoolean(req.getParameter("status"));
		if(UserDAO.updateUserStatus(id, status))
			resp.sendRedirect("home?mode=USERS");
	}

	private void updateProductStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// Update Product Status Only
		Long id = Long.parseLong(req.getParameter("id"));
		String status = req.getParameter("status");
		if(ProductDAO.updateProductStatus(id, status))
			resp.sendRedirect("home?mode=PRODUCTS");
	}

	private void editProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// Product Edit (price, etc...)
		Long Pid = Long.parseLong(req.getParameter("id"));
		String name = req.getParameter("name");
		BigDecimal price = new BigDecimal(req.getParameter("price"));
		Long qty = Long.parseLong(req.getParameter("qty"));
		String material = req.getParameter("material_type");
		BigDecimal plastic_saved = new BigDecimal(req.getParameter("plastic_saved"));
		Product pro = new Product(Pid, name, material, plastic_saved, qty, price);
		if(ProductDAO.updateProduct(pro))
			resp.sendRedirect("home?mode=PRODUCTS");
		
	}

	private void editCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// Category Edit 
		Long Pid = Long.parseLong(req.getParameter("id"));
		Long Cid = Long.parseLong(req.getParameter("categoryId"));
		if(ProductDAO.updateCategory(Pid, Cid))
			resp.sendRedirect("home?mode=PRODUCTS");
	}

	private void showAdminDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// --- 1️. Statistic Cards ---
        req.setAttribute("orderCount", OrderDAO.findAll().size());
        req.setAttribute("productCount", ProductDAO.findAllPublished().size());
        req.setAttribute("userCount", UserDAO.findAll().size());

        // --- 2️. Recent Orders ---
        List<Order> recentOrders = OrderDAO.getRecentOrders(10);
        req.setAttribute("recentOrders", recentOrders);
    	// --- 3. Monthly Filter Logic ---
        java.time.LocalDate now = java.time.LocalDate.now();
        
        String monthParam = req.getParameter("month"); // Format: "2026-05"
        int selectedMonth = now.getMonthValue();
        int selectedYear = now.getYear();

        if (monthParam != null && monthParam.contains("-")) {
            String[] parts = monthParam.split("-");
            selectedYear = Integer.parseInt(parts[0]);
            selectedMonth = Integer.parseInt(parts[1]);
        }

        Map<String, Integer> salesTrend = OrderDAO.getMonthlySalesData(selectedMonth, selectedYear);
        
        req.setAttribute("selectedMonth", String.format("%04d-%02d", selectedYear, selectedMonth));
        req.setAttribute("salesLabels", salesTrend.keySet());
        req.setAttribute("salesValues", salesTrend.values());
        // --- 5. go to JSP ---
        req.setAttribute("pageTitle", "Admin Dashboard | EcoLink Myanmar");
        req.setAttribute("pageContent", "/dashboard.jsp");
        req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}


	private void showUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Admin UAC
		List<User> users = UserDAO.findAll();
       
		req.setAttribute("users", users);
		req.setAttribute("pageTitle", "Users | EcoLink Myanmar");
		req.setAttribute("pageContent", "/users.jsp");
		req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}

	private void showProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Admin Product Control
		List<Product> products = ProductDAO.findAllPublished();
		List<Product> uproducts = ProductDAO.findAllUnPublished();
		
		List<Category> category = CategoryDAO.findAll();
		
        req.setAttribute("categories", category);
		req.setAttribute("products", products);
		req.setAttribute("uproducts", uproducts);
		req.setAttribute("pageTitle", "Products | EcoLink Myanmar");
		req.setAttribute("pageContent", "/admin-product.jsp");
		req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}

	private void showOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Admin Order Control
		List<Order> orders = OrderDAO.findAll();
		req.setAttribute("orders", orders);
		req.setAttribute("pageTitle", "Orders | EcoLink Myanmar");
		req.setAttribute("pageContent", "/orders.jsp");
		req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req, resp);
	}
    
}