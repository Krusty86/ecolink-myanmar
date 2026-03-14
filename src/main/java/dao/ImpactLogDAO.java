package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.ImpactLog;
import entity.User;
import util.DBConnection;

public class ImpactLogDAO {

    // Helper to map ResultSet to ImpactLog with User data
    private static ImpactLog mapImpactLog(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("user_id"));
        user.setUsername(rs.getString("username")); // Joined from users table
        user.setBusiness_name(rs.getString("business_name"));

        return new ImpactLog(
            rs.getLong("id"),
            user,
            rs.getInt("total_plastic_saved"),
            rs.getInt("total_orders"),
            rs.getTimestamp("last_updated")
        );
    }

    // 1. Create (Save)
    public static ImpactLog save(ImpactLog log) {
        String sql = "INSERT INTO impact_logs (user_id, total_plastic_saved, total_orders, last_updated) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, log.getUser().getId());
            ps.setInt(2, log.getTotal_plastic_saved());
            ps.setInt(3, log.getTotal_orders());
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // Auto-set current time

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) log.setId(rs.getLong(1));
                return log;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 2. Read (Find All) - Best for Leaderboards
    public static List<ImpactLog> findAll() {
        List<ImpactLog> list = new ArrayList<>();
        String sql = "SELECT il.*, u.username, u.business_name FROM impact_logs il " +
                     "JOIN users u ON il.user_id = u.id ORDER BY il.total_plastic_saved DESC";
        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapImpactLog(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Read (Find by User ID)
    public static ImpactLog findByUserId(Long userId) {
        String sql = "SELECT il.*, u.username, u.business_name FROM impact_logs il " +
                     "JOIN users u ON il.user_id = u.id WHERE il.user_id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapImpactLog(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 4. Update (General Update)
    public static ImpactLog update(Long id, ImpactLog log) {
        String sql = "UPDATE impact_logs SET total_plastic_saved = ?, total_orders = ?, last_updated = ? WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, log.getTotal_plastic_saved());
            ps.setInt(2, log.getTotal_orders());
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ps.setLong(4, id);
            
            if (ps.executeUpdate() > 0) return log;
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 5. Delete
    public static boolean delete(Long id) {
        String sql = "DELETE FROM impact_logs WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
    
    // 6. Increment method
    public static boolean incrementImpact(Long userId, int plasticToAdd) {
        String sql = "UPDATE impact_logs SET total_plastic_saved = total_plastic_saved + ?, " +
                     "total_orders = total_orders + 1, last_updated = NOW() WHERE user_id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, plasticToAdd);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}