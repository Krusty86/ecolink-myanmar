package controller;

import java.io.IOException;
import java.math.*;
import java.util.*;
import dao.*;
import entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/order-items")
public class OrderItemController extends HttpServlet {
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

        Optional<Product> productOpt = Optional.ofNullable(ProductDAO.findById(pid));
        Order order = OrderDAO.findById(oid);

        if (productOpt.isPresent() && order != null) {
            Product p = productOpt.get();
            
            List<OrderItem> items = new ArrayList<>();
            items.add(new OrderItem(null, order, p, qty.longValue()));
            OrderItemDAO.saveAll(items);

            BigDecimal unitPrice = p.getPrice(); 
            BigDecimal quantity = new BigDecimal(qty);
            BigDecimal subTotal = unitPrice.multiply(quantity);
            BigDecimal currentTotal = order.getTotal_amount() != null ? order.getTotal_amount() : BigDecimal.ZERO;
            BigDecimal newTotal = currentTotal.add(subTotal);
            order.setTotal_amount(newTotal.setScale(0, RoundingMode.HALF_UP));
            
            OrderDAO.update(oid, order); 
            
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