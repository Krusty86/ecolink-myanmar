package controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import dao.AddressDAO;
import dao.ProductDAO;
import entity.Address;
import entity.Cart;
import entity.Product;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/carts")
public class CartController extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        if (mode == null) mode = "VIEW";

        switch (mode) {
            case "ADD":     addToCart(req, resp); break;
            case "VIEW":    viewCart(req, resp); break;
            case "REMOVE":  removeFromCart(req, resp); break;
            case "ORDER":   orderNowItem(req, resp); break;
            default:        viewCart(req, resp); break;
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        
        // 1. Safety Check: Login
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect("login?mode=ALERT");
            return;
        }

        // 2. Extract parameters
        try {
            Long productId = Long.parseLong(req.getParameter("productId"));
            // Fallback to 1 if qty isn't passed from the product grid
            String qtyStr = req.getParameter("quantity");
            int qty = (qtyStr != null) ? Integer.parseInt(qtyStr) : 1;

            // 3. Find Product and update Session Cart
            Optional<Product> productOpt = Optional.ofNullable(ProductDAO.findById(productId));
            if (productOpt.isPresent()) {
                Cart cart = (Cart) session.getAttribute("cart");
                if (cart == null) {
                    cart = new Cart();
                }
                
                cart.addItem(productOpt.get(), qty);
                session.setAttribute("cart", cart); // Store back in session
                
                // 4. Redirect back to list with success msg
                resp.sendRedirect("products?mode=LIST&msg=added");
            } else {
                resp.sendRedirect("products?mode=LIST&error=notfound");
            }
        } catch (Exception e) {
            resp.sendRedirect("products?mode=LIST&error=invalid");
        }
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loginUser") : null;
        if (session == null || session.getAttribute("loginUser") == null) {
            resp.sendRedirect("login?mode=ALERT");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            
            session.setAttribute("cart", cart);
        }
        List<Address> userAddresses = AddressDAO.findAllByUser(user.getId());
        for(Address a: userAddresses){
        	System.out.println(a.getLabel()+a.getStreet());
        }
        req.setAttribute("userAddresses", userAddresses);
        req.setAttribute("pageTitle", "Your Cart | EcoLink");
        req.setAttribute("pageContent", "cart.jsp");
        req.getRequestDispatcher("layout.jsp").forward(req, resp);
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart != null) {
                Long productId = Long.parseLong(req.getParameter("productId"));
                cart.removeItem(productId);
                session.setAttribute("cart", cart);
            }
        }
        resp.sendRedirect("carts?mode=VIEW");
    }

    private void orderNowItem(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Direct checkout for a single item
        String productId = req.getParameter("productId");
        String qty = req.getParameter("qty");
        resp.sendRedirect("orders?mode=CREATE&pid=" + productId + "&qty=" + qty);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}