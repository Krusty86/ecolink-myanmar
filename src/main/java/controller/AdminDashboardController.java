package controller;

import dao.CategoryDAO;
import dao.*;
import entity.*;
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
		case "BUYERS":	showBuyers(req, resp);break;
		case "SELLERS":	showSellers(req, resp);break;
		case "EDITU": editUserStatus(req, resp);break;
		case "EDIT_CAT": editCategory(req, resp);break;
		case "EDITP": editProduct(req, resp);break;
		case "UPDATE_STATUS": updateProductStatus(req, resp); break;
		default: showAdminDashboard(req, resp);break;
		}

    }

	private void editUserStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// TODO Auto-generated method stub
		Long id = Long.parseLong(req.getParameter("id"));
		Boolean status = Boolean.parseBoolean(req.getParameter("status"));
		if(UserDAO.updateUserStatus(id, status))
			resp.sendRedirect("home?mode=SELLERS");
	}

	private void updateProductStatus(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		Long id = Long.parseLong(req.getParameter("id"));
		String status = req.getParameter("status");
		if(ProductDAO.updateProductStatus(id, status))
			resp.sendRedirect("home?mode=PRODUCTS");
	}

	private void editProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		// TODO Auto-generated method stub
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
		Long Pid = Long.parseLong(req.getParameter("id"));
		Long Cid = Long.parseLong(req.getParameter("categoryId"));
		if(ProductDAO.updateCategory(Pid, Cid))
			resp.sendRedirect("home?mode=PRODUCTS");
	}

	private void showAdminDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// --- 1️. Statistic Cards ---
        req.setAttribute("orderCount", OrderDAO.findAll().size());
        req.setAttribute("productCount", ProductDAO.findAllPublished().size());
        req.setAttribute("userCount", UserDAO.findAllExceptAdmin().size());

        // --- 2️. Recent Orders ---
        List<Order> recentOrders = OrderDAO.getRecentOrders(10);
        req.setAttribute("recentOrders", recentOrders);

//        // --- 3️. Orders Per Product (Bar Chart) ---
//        Map<String, Integer> ordersPerProduct = orderDAO.getOrdersPerProduct();
//        //key list is the productNames list ${prouductNames}
//        req.setAttribute("productNames", new ArrayList<>(ordersPerProduct.keySet()));
//        //value list is the orderCounts => ${orderCounts}
//        req.setAttribute("orderCounts", new ArrayList<>(ordersPerProduct.values()));
//
//        // --- 4️. Order Status Distribution (Pie Chart) ---
//        Map<String, Integer> statusData = orderDAO.getOrderStatusCounts();
//        req.setAttribute("statusLabels", new ArrayList<>(statusData.keySet()));
//        req.setAttribute("statusCounts", new ArrayList<>(statusData.values()));

        // --- 5. go to JSP ---
        req.setAttribute("pageTitle", "Admin Dashboard | EcoLink Myanmar");
        req.setAttribute("pageContent", "/dashboard.jsp");
        req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}

	private void showSellers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<User> users = UserDAO.findSellers();
		// --- 1️. Statistic Cards ---
        req.setAttribute("orderCount", OrderDAO.findAll().size());
        req.setAttribute("productCount", ProductDAO.findAllPublished().size());
        req.setAttribute("userCount", UserDAO.findAllExceptAdmin().size());

        
		req.setAttribute("users", users);
		for(User u: users)
			System.out.println(u.getJoined_date());
		req.setAttribute("pageTitle", "Suppliers | EcoLink Myanmar");
		req.setAttribute("pageContent", "/sellers.jsp");
		req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}
	
	private void showBuyers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<User> users = UserDAO.findBuyers();
		// --- 1️. Statistic Cards ---
        req.setAttribute("orderCount", OrderDAO.findAll().size());
        req.setAttribute("productCount", ProductDAO.findAllPublished().size());
        req.setAttribute("userCount", UserDAO.findAllExceptAdmin().size());

        
		req.setAttribute("users", users);
		req.setAttribute("pageTitle", "Customers | EcoLink Myanmar");
		req.setAttribute("pageContent", "/buyers.jsp");
		req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}

	private void showProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Product> products = ProductDAO.findAllPublished();
		List<Product> uproducts = ProductDAO.findAllUnPublished();
		
		List<Category> category = CategoryDAO.findAll();
		// --- 1️. Statistic Cards ---
		// --- 1️. Statistic Cards ---
        req.setAttribute("orderCount", OrderDAO.findAll().size());
        req.setAttribute("productCount", ProductDAO.findAllPublished().size());
        req.setAttribute("userCount", UserDAO.findAllExceptAdmin().size());

        req.setAttribute("categories", category);
		req.setAttribute("products", products);
		req.setAttribute("uproducts", uproducts);
		req.setAttribute("pageTitle", "Products | EcoLink Myanmar");
		req.setAttribute("pageContent", "/products.jsp");
		req.getRequestDispatcher("/admin-home.jsp").forward(req, resp);
	}

	private void showOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Order> orders = OrderDAO.findAll();
		
		// --- 1️. Statistic Cards ---
        req.setAttribute("orderCount", OrderDAO.findAll().size());
        req.setAttribute("productCount", ProductDAO.findAllPublished().size());
        req.setAttribute("userCount", UserDAO.findAllExceptAdmin().size());

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