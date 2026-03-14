package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.Discount;
import entity.User;
import enums.DiscountTargetType;
import enums.DiscountType;
import util.DBConnection;

public class DiscountDAO {

    // Helper to map ResultSet to Discount Object
    private static Discount mapDiscount(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("user_id"));
        // If you need more user details (like business_name), you'd use a JOIN in the SQL
        
        return new Discount(
            rs.getLong("id"),
            user,
            rs.getString("title"),
            DiscountType.valueOf(rs.getString("type")),
            rs.getBigDecimal("value"),
            rs.getTimestamp("start_date"),
            rs.getTimestamp("end_date"),
            rs.getBigDecimal("min_order_amount"),
            DiscountTargetType.valueOf(rs.getString("target_type")),
            rs.getLong("target_id"),
            rs.getBoolean("is_active")
        );
    }

    // 1. Save Discount
    public static Discount save(Discount discount) {
        String sql = "INSERT INTO discounts (user_id, title, type, value, start_date, end_date, min_order_amount, target_type, target_id, is_active) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, discount.getUser().getId());
            ps.setString(2, discount.getTitle());
            ps.setString(3, discount.getType().name());
            ps.setBigDecimal(4, discount.getValue());
            ps.setTimestamp(5, new Timestamp(discount.getStart_date().getTime()));
            ps.setTimestamp(6, new Timestamp(discount.getEnd_date().getTime()));
            ps.setBigDecimal(7, discount.getMin_order_amount());
            ps.setString(8, discount.getTarget_type().name());
            ps.setLong(9, discount.getTarget_id());
            ps.setBoolean(10, discount.getIs_active());

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) discount.setId(rs.getLong(1));
                return discount;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 2. Find All Discounts (Optionally filter by Supplier/User)
    public static List<Discount> findAll() {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM discounts ORDER BY start_date DESC";
        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapDiscount(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Update Discount
    public static Discount update(Long id, Discount discount) {
        String sql = "UPDATE discounts SET title=?, type=?, value=?, start_date=?, end_date=?, min_order_amount=?, target_type=?, target_id=? WHERE id=?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, discount.getTitle());
            ps.setString(2, discount.getType().name());
            ps.setBigDecimal(3, discount.getValue());
            ps.setTimestamp(4, new Timestamp(discount.getStart_date().getTime()));
            ps.setTimestamp(5, new Timestamp(discount.getEnd_date().getTime()));
            ps.setBigDecimal(6, discount.getMin_order_amount());
            ps.setString(7, discount.getTarget_type().name());
            ps.setLong(8, discount.getTarget_id());
            ps.setLong(9, id);
            
            if (ps.executeUpdate() > 0) {
                discount.setId(id);
                return discount;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 4. Update Active Status (Soft Toggle)
    public static boolean updateActiveStatus(Long id, Boolean isActive) {
        String sql = "UPDATE discounts SET is_active = ? WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, isActive);
            ps.setLong(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // 5. Delete Discount
    public static boolean delete(Long id) {
        String sql = "DELETE FROM discounts WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
    
 // 6. Find ALL discounts created by a specific Supplier (User ID)
    public static List<Discount> findAllBySupplier(Long userId) {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM discounts WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(mapDiscount(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 7. Find ONLY ACTIVE discounts for a specific Supplier
    // Uses the Database's NOW() to ensure the date range is valid
    public static List<Discount> findActiveBySupplier(Long userId) {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM discounts " +
                     "WHERE user_id = ? " +
                     "AND is_active = true " +
                     "AND NOW() BETWEEN start_date AND end_date " +
                     "ORDER BY end_date ASC";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                list.add(mapDiscount(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}