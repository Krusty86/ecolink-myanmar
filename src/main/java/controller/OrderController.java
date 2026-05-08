package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import dao.*;
import entity.*;
import enums.OrderStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/orders")
public class OrderController extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();
    private final AddressDAO addressDAO = new AddressDAO(); // Needed for Order save

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

     // 2. Address Selection Logic (Dropdown with Default Fallback)
        String addressIdStr = req.getParameter("addressId");
        Address selectedAddress = null;

        if (addressIdStr != null && !addressIdStr.isEmpty()) {
            // Option A: User selected a specific address from the dropdown
            selectedAddress = AddressDAO.findById(Long.parseLong(addressIdStr));
        } 
        
        if (selectedAddress == null) {
            // Option B: Nothing selected or ID was invalid, fallback to Default
            selectedAddress = AddressDAO.findDefaultByUserId(user.getId());
        }

        // Final check: If still null, the user has NO addresses at all
        if (selectedAddress == null) {
            req.setAttribute("error", "Please add a shipping address in your profile before checking out.");
            req.setAttribute("userAddresses", AddressDAO.findAllByUser(user.getId()));
            req.setAttribute("pageContent", "cart.jsp");
            req.getRequestDispatcher("layout.jsp").forward(req, resp);
            return;
        }

        // 3. Prepare Order object
        Order order = new Order();
        order.setUser(user);
        order.setAddress(selectedAddress);
        
        BigDecimal totalAmount = cart.getTotal();
        
        // --- START POINTS LOGIC ---
        String usePointsParam = req.getParameter("usePoints");
        long pointsToSpend = 0;
        BigDecimal discount = BigDecimal.ZERO;

        if ("true".equals(usePointsParam) && user.getLoyaltyPoints() >= 100) {
            // Logic: Spend all points in blocks of 100
            pointsToSpend = (user.getLoyaltyPoints() / 100) * 100; 
            
            // Logic: 100 points = 1000 MMK discount
            discount = new BigDecimal((pointsToSpend / 100) * 1000);
            
            // Ensure discount doesn't exceed total amount
            if (discount.compareTo(totalAmount) > 0) {
                discount = totalAmount; 
            }
            
            totalAmount = totalAmount.subtract(discount);
        }
        
        order.setPoints_spent(pointsToSpend);
        order.setDiscount_amount_from_points(discount); // Matches your DB column name
        order.setTotal_amount(totalAmount);
        // --- END POINTS LOGIC ---

        order.setStatus(OrderStatus.PENDING);
        order.setOrder_date(new java.util.Date());

        Order savedOrder = OrderDAO.save(order);

        if (savedOrder != null) {
            // After saving the order, your MySQL Trigger will automatically 
            // subtract the points from the User record based on order.points_spent!
            
            java.util.List<OrderItem> orderItems = new java.util.ArrayList<>();
            for (CartItem ci : cart.getItems()) {
                OrderItem oi = new OrderItem();
                oi.setOrder(savedOrder);
                oi.setProduct(ci.getProduct());
                oi.setQuantity((long) ci.getQuantity());
                orderItems.add(oi);
            }

            boolean itemsSaved = OrderItemDAO.saveAll(orderItems);

            if (itemsSaved) {
                // Update the local session user object so the UI shows new point balance
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
            Order order = orderDAO.findById(oid); // Ensure this method exists in your DAO
            List<OrderItem> items = orderItemDAO.findByOrderId(oid);

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
        // Direct "Order Now" Logic
        Long productId = Long.parseLong(req.getParameter("pid"));
        Integer qty = Integer.parseInt(req.getParameter("qty"));
        
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("loginUser");
        Address address = addressDAO.findDefaultByUserId(user.getId());

        Order order = new Order();
        order.setUser(user);
        order.setAddress(address);
        order.setTotal_amount(BigDecimal.ZERO); // Item controller will update this
        order.setStatus(OrderStatus.PENDING);
        order.setOrder_date(new Date());

        Order savedOrder = orderDAO.save(order);
        
        // Hand off to OrderItemController to attach the product
        resp.sendRedirect("order-items?mode=ADDITEM&oid=" + savedOrder.getId() + "&pid=" + productId + "&qty=" + qty);
    }

    private void viewUserOrders(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loginUser");
        List<Order> orders = orderDAO.findOrderByUserId(user.getId());
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