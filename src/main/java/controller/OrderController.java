package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import dao.*;
import entity.*;
import enums.OrderStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/orders")
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        if (mode == null) mode = "";

        switch (mode) {
            case "CREATE":  createOrder(req, resp); break;
            case "VIEW":    viewOrder(req, resp); break;
            case "VIEWALL": viewUserOrders(req, resp); break;
            case "CHECKOUT": checkoutCart(req, resp); break;
            default: resp.sendRedirect("home"); break;
        }
    }

    private void checkoutCart(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loginUser") : null;
        Cart cart = (session != null) ? (Cart) session.getAttribute("cart") : null;

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect("carts?mode=VIEW");
            return;
        }

     // --- 1. PARALLEL CHECKOUT STOCK VALIDATION (NEW CONDITION From Presentation day) ---
        List<String> stockErrors = new ArrayList<>();
        for (CartItem ci : cart.getItems()) {
            // Fetch fresh, live inventory metrics straight from the DB
            Product dbProduct = ProductDAO.findById(ci.getProduct().getId());
            
            if (dbProduct == null) {
                stockErrors.add("Product '" + ci.getProduct().getName() + "' is no longer available.");
            } else if (dbProduct.getQty() < ci.getQuantity()) {
                stockErrors.add("Sorry, '" + dbProduct.getName() + "' only has " + dbProduct.getQty() + " units left in stock.");
            }
        }

        // If any items are out of stock, reject the checkout transaction immediately
        if (!stockErrors.isEmpty()) {
            req.setAttribute("errors", stockErrors); // Passes an array list of issues to the view layer
            req.setAttribute("pageContent", "cart.jsp");
            req.getRequestDispatcher("layout.jsp").forward(req, resp);
            return;
        }
        // cart checkout for default address
        String addressIdStr = req.getParameter("addressId");
        Address selectedAddress = null;

        if (addressIdStr != null && !addressIdStr.isEmpty()) {
            selectedAddress = AddressDAO.findById(Long.parseLong(addressIdStr));
        } 
        
        if (selectedAddress == null) {
            selectedAddress = AddressDAO.findDefaultByUserId(user.getId());
        }

        if (selectedAddress == null) {
            req.setAttribute("error", "Please add a shipping address in your profile before checking out.");
            req.setAttribute("userAddresses", AddressDAO.findAllByUser(user.getId()));
            req.setAttribute("pageContent", "cart.jsp");
            req.getRequestDispatcher("layout.jsp").forward(req, resp);
            return;
        }

        Order order = new Order();
        order.setUser(user);
        order.setAddress(selectedAddress);
        
        BigDecimal totalAmount = cart.getTotal();
        
        // Points Use Logic 
        // Customer needs 100 points minimal to spend points
        // weakpoint, you can't adjust how many points you want to use 🥹🥹🥹
        String usePointsParam = req.getParameter("usePoints");
        long pointsToSpend = 0;
        BigDecimal discount = BigDecimal.ZERO;

        if ("true".equals(usePointsParam) && user.getLoyaltyPoints() >= 100) {
            pointsToSpend = (user.getLoyaltyPoints() / 100) * 100; 
            discount = new BigDecimal((pointsToSpend / 100) * 1000);
            
            // Ensure discount doesn't exceed total amount
            if (discount.compareTo(totalAmount) > 0) {
                discount = totalAmount; 
            }
            
            totalAmount = totalAmount.subtract(discount);
        }
        
        order.setPoints_spent(pointsToSpend);
        order.setDiscount_amount_from_points(discount); 
        order.setTotal_amount(totalAmount);

        order.setStatus(OrderStatus.PENDING);
        order.setOrder_date(new Date());

        Order savedOrder = OrderDAO.save(order);

        if (savedOrder != null) {
            List<OrderItem> orderItems = new ArrayList<>();
            for (CartItem ci : cart.getItems()) {
                OrderItem oi = new OrderItem();
                oi.setOrder(savedOrder);
                oi.setProduct(ci.getProduct());
                oi.setQuantity((long) ci.getQuantity());
                orderItems.add(oi);
            }

            boolean itemsSaved = OrderItemDAO.saveAll(orderItems);

            if (itemsSaved) {
                user.setLoyaltyPoints(user.getLoyaltyPoints() - pointsToSpend);
                session.setAttribute("loginUser", user);

                cart.clear();
                session.setAttribute("cart", cart);
                resp.sendRedirect("orders?mode=VIEW&oid=" + savedOrder.getId());
            } else {
                req.setAttribute("error", "Failed to save order items.");
                req.getRequestDispatcher("carts?mode=VIEW").forward(req, resp);
            }
        } else {
            req.setAttribute("error", "Order placement failed.");
            req.getRequestDispatcher("carts?mode=VIEW").forward(req, resp);
        }
    }

    private void viewOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long oid = Long.parseLong(req.getParameter("oid"));
            Order order = OrderDAO.findById(oid);
            List<OrderItem> items = OrderItemDAO.findByOrderId(oid);

            req.setAttribute("order", order);
            req.setAttribute("items", items);
            req.setAttribute("pageTitle", "Order Invoice | EcoLink");
            req.setAttribute("pageContent", "order-detail.jsp");
            req.getRequestDispatcher("layout.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect("home");
        }
    }

    private void createOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long productId = Long.parseLong(req.getParameter("pid"));
        Integer qty = Integer.parseInt(req.getParameter("qty"));
        
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loginUser");
        Address address = AddressDAO.findDefaultByUserId(user.getId());

        Order order = new Order();
        order.setUser(user);
        order.setAddress(address);
        order.setTotal_amount(BigDecimal.ZERO); 
        order.setStatus(OrderStatus.PENDING);
        order.setOrder_date(new Date());

        Order savedOrder = OrderDAO.save(order);
        
        resp.sendRedirect("order-items?mode=ADDITEM&oid=" + savedOrder.getId() + "&pid=" + productId + "&qty=" + qty);
    }

    private void viewUserOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loginUser");
        List<Order> orders = OrderDAO.findOrderByUserId(user.getId());
        req.setAttribute("orders", orders);
        req.setAttribute("pageTitle", "Order History | EcoLink");
        req.setAttribute("pageContent", "order-history.jsp");
        req.getRequestDispatcher("layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}