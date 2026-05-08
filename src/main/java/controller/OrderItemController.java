package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Optional;
import dao.*;
import entity.*;
import enums.OrderStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/order-items")
public class OrderItemController extends HttpServlet {
    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String mode = req.getParameter("mode");
        if ("ADDITEM".equals(mode)) {
            addItemToOrder(req, resp);
        }
    }

    private void addItemToOrder(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        Long pid = Long.parseLong(req.getParameter("pid"));
        Integer qty = Integer.parseInt(req.getParameter("qty"));
        Long oid = Long.parseLong(req.getParameter("oid"));

        Optional<Product> productOpt = Optional.ofNullable(productDAO.findById(pid));
        Order order = orderDAO.findById(oid);

        if (productOpt.isPresent() && order != null) {
            Product p = productOpt.get();
            
            // 1. Save the item
            java.util.List<OrderItem> items = new java.util.ArrayList<>();
            // Note: Assuming your OrderItem constructor or entity now accepts BigDecimal for price
            items.add(new OrderItem(null, order, p, qty.longValue()));
            orderItemDAO.saveAll(items);

            // 2. Update Order Totals using BigDecimal Math
            // Subtotal = Price * Quantity
            BigDecimal unitPrice = p.getPrice(); // This is a BigDecimal
            BigDecimal quantity = new BigDecimal(qty);
            BigDecimal subTotal = unitPrice.multiply(quantity);

            // New Total = Current Total + Subtotal
            // order.getTotal_amount() must return a BigDecimal
            BigDecimal currentTotal = order.getTotal_amount() != null ? order.getTotal_amount() : BigDecimal.ZERO;
            BigDecimal newTotal = currentTotal.add(subTotal);
            
            // Optional: Scale to 0 decimal places for MMK (e.g., 1500.00 -> 1500)
            order.setTotal_amount(newTotal.setScale(0, java.math.RoundingMode.HALF_UP));
            
            // 3. Persist change to Database
            orderDAO.update(oid, order); 
            
            resp.sendRedirect("orders?mode=VIEW&oid=" + oid);
        } else {
            resp.sendRedirect("home?error=orderfail");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}