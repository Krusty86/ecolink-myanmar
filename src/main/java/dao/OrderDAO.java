package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import entity.*;
import enums.AddressType;
import enums.OrderStatus;
import util.DBConnection;

public class OrderDAO {

	// find order details by id
	public static Order findById(Long id) {
	    String sql = "SELECT o.*, u.username, a.label, a.street, a.township, a.city, a.address_type " +
	                 "FROM orders o " +
	                 "JOIN users u ON o.buyer_id = u.id " +
	                 "JOIN addresses a ON o.shipping_address_id = a.id " +
	                 "WHERE o.id = ?";
	    
	    try (Connection con = DBConnection.connect();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setLong(1, id);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            return mapOrder(rs); 
	        }
	    } catch (Exception e) {
	        System.err.println("Error finding order by ID: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return null;
	}
    // Helper to map ResultSet to a fully populated Order object
    private static Order mapOrder(ResultSet rs) throws Exception {
        User user = new User();
        user.setId(rs.getLong("buyer_id"));
        user.setUsername(rs.getString("username"));


        Address addr = new Address();
        addr.setId(rs.getLong("shipping_address_id"));
        addr.setLabel(rs.getString("label"));
        addr.setStreet(rs.getString("street"));
        addr.setTownship(rs.getString("township"));
        addr.setCity(rs.getString("city"));
        addr.setAddress_type(AddressType.valueOf(rs.getString("address_type")));

        return new Order(
            rs.getLong("id"),
            user,
            addr,
            rs.getBigDecimal("total_amount"),
            OrderStatus.valueOf(rs.getString("status")),
            rs.getTimestamp("order_date"),
            rs.getLong("points_spent"),
            rs.getBigDecimal("discount_amount_from_points")
        );
    }

    // Create Order
    public static Order save(Order order) {
        String sql = "INSERT INTO orders (buyer_id, shipping_address_id, total_amount, status, order_date, points_spent, discount_amount_from_points) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, order.getUser().getId());
            ps.setLong(2, order.getAddress().getId());
            ps.setBigDecimal(3, order.getTotal_amount());
            ps.setString(4, order.getStatus().name());
            ps.setTimestamp(5, new Timestamp(order.getOrder_date().getTime()));
            ps.setLong(6, order.getPoints_spent());
            ps.setBigDecimal(7, order.getDiscount_amount_from_points());

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) order.setId(rs.getLong(1));
                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Find All Orders (Admin View)
    public static List<Order> findAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username, a.label, a.street, a.township, a.city, a.address_type " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "JOIN addresses a ON o.shipping_address_id = a.id ORDER BY o.order_date DESC";
        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Find Orders by User ID (Customer History)
    public static List<Order> findOrderByUserId(Long userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username, a.label, a.street, a.township, a.city, a.address_type " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "JOIN addresses a ON o.shipping_address_id = a.id " +
                     "WHERE o.buyer_id = ? ORDER BY o.order_date DESC";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapOrder(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Update Order Status
    public static boolean updateStatus(Long id, OrderStatus status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status.name());
            ps.setLong(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update Full Order (General CRUD)
    public static Order update(Long id, Order order) {
        String sql = "UPDATE orders SET shipping_address_id=?, total_amount=?, status=?, points_spent=?, discount_amount_from_points=? WHERE id=?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, order.getAddress().getId());
            ps.setBigDecimal(2, order.getTotal_amount());
            ps.setString(3, order.getStatus().name());
            ps.setLong(4, order.getPoints_spent());
            ps.setBigDecimal(5, order.getDiscount_amount_from_points());
            ps.setLong(6, id);
            
            if (ps.executeUpdate() > 0) return order;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Delete Order
    public static boolean delete(Long id) {
        String sql = "DELETE FROM orders WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static Map<String, Integer> getSalesTrendData() {
        Map<String, Integer> trendData = new LinkedHashMap<>();
        String sql = "SELECT DATE(order_date) as date, COUNT(id) as count " +
                     "FROM orders " +
                     "WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) " +
                     "GROUP BY DATE(order_date) " +
                     "ORDER BY DATE(order_date) ASC";

        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                trendData.put(rs.getString("date"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trendData;
    }
    
    // get monthly sales data with month and year as condition
    public static Map<String, Integer> getMonthlySalesData(int month, int year) {
        Map<String, Integer> trendData = new LinkedHashMap<>();
        
        String sql = "SELECT DATE(order_date) as date, COUNT(id) as count " +
                     "FROM orders " +
                     "WHERE MONTH(order_date) = ? AND YEAR(order_date) = ? " +
                     "GROUP BY DATE(order_date) " +
                     "ORDER BY DATE(order_date) ASC";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, month);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                trendData.put(rs.getString("date"), rs.getInt("count"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return trendData;
    }
    
    // get recent orders
    public static List<Order> getRecentOrders(int limit) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, u.username, a.label, a.city , a.street, a.township, a.address_type " +
                     "FROM orders o " +
                     "JOIN users u ON o.buyer_id = u.id " +
                     "JOIN addresses a ON o.shipping_address_id = a.id " +
                     "ORDER BY o.order_date DESC LIMIT ?";
                     
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, limit);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(OrderDAO.mapOrder(rs)); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}