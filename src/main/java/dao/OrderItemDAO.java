package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.*;
import enums.ProductStatus;
import util.DBConnection;

public class OrderItemDAO {

    // Helper to map ResultSet to OrderItem with joined Product data
    private static OrderItem mapOrderItem(ResultSet rs) throws Exception {
        // We only need the Order ID for the reference
        Order order = new Order();
        order.setId(rs.getLong("order_id"));

        // Populate the Product object with details for the UI
        Product product = new Product();
        product.setId(rs.getLong("product_id"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setName(rs.getString("name"));
        product.setMaterial_type(rs.getString("material_type"));
        product.setQty(rs.getLong("product_qty")); // Current stock qty
        product.setStatus(ProductStatus.valueOf(rs.getString("status")));

        return new OrderItem(
            rs.getLong("id"),
            order,
            product,
            rs.getLong("quantity")
        );
    }

    // 1. Save Multiple Items (Batch Insert)
    public static boolean saveAll(List<OrderItem> items) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity) VALUES (?, ?, ?)";
        Connection con = null;
        try {
            con = DBConnection.connect();
            con.setAutoCommit(false); // Start Transaction
            
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                for (OrderItem item : items) {
                    ps.setLong(1, item.getOrder().getId());
                    ps.setLong(2, item.getProduct().getId());
                    ps.setLong(3, item.getQuantity());
                    ps.addBatch();
                }
                ps.executeBatch();
                con.commit();
                return true;
            } catch (Exception e) {
                if (con != null) con.rollback();
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    // 2. Find All items for a specific Order (with Product Details)
    public static List<OrderItem> findByOrderId(Long orderId) {
        List<OrderItem> list = new ArrayList<>();
        // Added JOIN to product_prices to get the active price
        String sql = "SELECT oi.*, p.name, p.material_type, p.qty as product_qty, p.status, pp.price " +
                     "FROM order_items oi " +
                     "JOIN products p ON oi.product_id = p.id " +
                     "LEFT JOIN product_prices pp ON p.id = pp.product_id AND pp.is_current = 1 " +
                     "WHERE oi.order_id = ?";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setLong(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapOrderItem(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Delete items by Order ID
    public static boolean deleteByOrderId(Long orderId) {
        String sql = "DELETE FROM order_items WHERE order_id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}