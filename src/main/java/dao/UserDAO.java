package dao;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

import entity.ImpactLog;
import entity.User;
import util.DBConnection;

public class UserDAO {

    // ================= SAVE =================
    public static boolean save(User user) {

        String sql = "INSERT INTO users (username, email, password, role, status, loyalty_points, joined_date) VALUES (?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setBoolean(5, user.getStatus());
            ps.setLong(6, user.getLoyaltyPoints());
            ps.setTimestamp(7, Timestamp.valueOf(user.getJoinedDate()));

            if (ps.executeUpdate() > 0) {
            	return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
 // ================= UPDATE USER PROFILE =================
    public static boolean update(User user) {
        String sql = "UPDATE users SET username = ?, email = ?, password = ? WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setLong(4, user.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    // ================= LOGIN =================
    public static User login(String email, String password) {

        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND status = true";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapUser(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= UPDATE LOYALTY =================
    public static boolean updatePoints(Long id, Long points) {

        String sql = "UPDATE users SET loyalty_points = ? WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, points);
            ps.setLong(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= SOFT DELETE =================
    public static boolean softDelete(Long id) {

        String sql = "UPDATE users SET status = false WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= FIND ALL =================
    public static List<User> findAll() {

        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id DESC";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapUser(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= FIND ACTIVE =================
    public static List<User> findActiveUsers() {

        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE status = true";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapUser(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================= FIND BY ID =================
    public static User findById(Long id) {

        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapUser(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // ================= UPDATE STATUS =================
    public static boolean updateUserStatus(Long id, Boolean status) {

        String sql = "UPDATE users SET status = ? WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            ps.setLong(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // ================= COUNT BY ROLE =================
    public static Map<String, Integer> countUsersByRole() {

        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT role, COUNT(*) as total FROM users GROUP BY role";

        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                map.put(rs.getString("role"), rs.getInt("total"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return map;
    }
    
    public static ImpactLog getPlasticImpactByUserId(Long userId) {
        String sql = "SELECT * FROM impact_logs WHERE user_id = ?";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapImpactLog(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= IMPACT LOG MAPPER =================
    private static ImpactLog mapImpactLog(ResultSet rs) throws SQLException {
        ImpactLog log = new ImpactLog();
        
        log.setId(rs.getLong("id"));
        log.setTotal_plastic_saved(rs.getInt("total_plastic_saved"));
        log.setTotal_orders(rs.getInt("total_orders"));
        log.setLast_updated(rs.getTimestamp("last_updated"));
        
        Long userId = rs.getLong("user_id");
        log.setUser(findById(userId)); 
        
        return log;
    }
    
    // ================= MAPPER =================
    private static User mapUser(ResultSet rs) throws SQLException {

        User u = new User();

        u.setId(rs.getLong("id"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getBoolean("status"));
        u.setLoyaltyPoints(rs.getLong("loyalty_points"));

        Timestamp ts = rs.getTimestamp("joined_date");
        if (ts != null) {
            u.setJoinedDate(ts.toLocalDateTime());
        }

        return u;
    }
}