package dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import entity.*;
import util.DBConnection;

public class UserDAO {
	public static User save(User user) {
		String sql = "INSERT INTO users (`username`, `email`, `password`, `role`, `business_name`, `status`, `joined_date`) VALUES (?,?,?,?,?,?,?)";
		try(Connection con = DBConnection.connect();
			PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPassword());
			ps.setString(4, user.getRole());
			ps.setString(5, user.getBusiness_name());
			ps.setBoolean(6, true);
			ps.setTimestamp(7, new Timestamp(user.getJoined_date().getTime()));
			if(ps.executeUpdate()>0) {
				ResultSet rs = ps.getGeneratedKeys();
				if(rs.next())
					user.setId(rs.getLong(1));
				return user;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public static User updatePoints(Long id, User user, Long pts) {
	    String updateSql = "UPDATE `users` SET `loyalty_points` = ? WHERE `id` = ?";
	    String selectSql = "SELECT * FROM `users` WHERE `id` = ?";
	    
	    try (Connection con = DBConnection.connect()) {
	        // 1. Perform the Update
	        try (PreparedStatement psUpdate = con.prepareStatement(updateSql)) {
	            psUpdate.setLong(1, pts);
	            psUpdate.setLong(2, id);
	            psUpdate.executeUpdate();
	        }

	        // 2. Immediately Fetch the Updated Data
	        try (PreparedStatement psSelect = con.prepareStatement(selectSql)) {
	            psSelect.setLong(1, id);
	            try (ResultSet rs = psSelect.executeQuery()) {
	                if (rs.next()) {
	                    // update existing user data
	                    user.setLoyalty_points(rs.getLong("loyalty_points"));
	                }
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	public static boolean softDelete(Long id) {
		
	    String sql = "UPDATE `users` SET `status` = ? WHERE `id` = ?";
	    
	    try (Connection con = DBConnection.connect();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setBoolean(1, false);
	        ps.setLong(2, id);
	        
	        return ps.executeUpdate() > 0;
	        
	    } catch (SQLException e) {
	        System.err.println("Error deactivating user with ID " + id + ": " + e.getMessage());
	        e.printStackTrace();
	    } catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	    return false;
	}
	public static User login(String email, String password) {
	    // We check for status = true to ensure deactivated accounts cannot log in
	    String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND status = ?";
	    
	    try (Connection con = DBConnection.connect();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setString(1, email);
	        ps.setString(2, password);
	        ps.setBoolean(3, true); 
	        
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) { 
	            // Mapping the full User object based on your project's fields
	            User user = new User();
	            user.setId(rs.getLong("id"));
	            user.setUsername(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            user.setRole(rs.getString("role")); // e.g., 'SUPPLIER' or 'CUSTOMER'
	            user.setBusiness_name(rs.getString("business_name"));
	            user.setStatus(rs.getBoolean("status"));
	            
	            // If you have a loyalty points system for EcoLink:
	            // user.setPoints(rs.getLong("points")); 
	            
	            return user;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null; // Login failed (wrong credentials or in account)
	}
	// 1. Find ONLY active users (active = true)
    public static List<User> findActiveUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE status = true";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs)); // Assuming you have a mapUser helper
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    /**
     * Fetches all users from the database, regardless of role or status.
     * Useful for master admin reports.
     */
    public static List<User> findAll() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id DESC";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            System.err.println("Error fetching all users: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }
    // 2. Find All Users EXCEPT Admin
    // This is useful for the Admin's "User Management" view
    public static List<User> findAllExceptAdmin() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role != 'ADMIN' ORDER BY id DESC";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 // 1. Find all Sellers (Suppliers)
    public static List<User> findSellers() {
        List<User> list = new ArrayList<>();
        // Filtering by role 'SUPPLIER'
        String sql = "SELECT * FROM users WHERE role = 'SUPPLIER' ORDER BY id DESC";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Find all Buyers (Customers)
    public static List<User> findBuyers() {
        List<User> list = new ArrayList<>();
        // Filtering by role 'CUSTOMER'
        String sql = "SELECT * FROM users WHERE role = 'CUSTOMER' ORDER BY id DESC";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapUser(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static boolean updateUserStatus(Long id, Boolean status) {
        String sql = "UPDATE `users` SET `status` = ? WHERE `id` = ?";
        
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setBoolean(1, status);
            ps.setLong(2, id);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating status for user ID " + id + ": " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public static Map<String, Integer> countUsersByRole() {
        Map<String, Integer> counts = new HashMap<>();
        String sql = "SELECT role, COUNT(*) as total FROM users GROUP BY role";
        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                counts.put(rs.getString("role"), rs.getInt("total"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return counts;
    }
    // Private helper used by the methods above
    private static User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getLong("id"));
        u.setUsername(rs.getString("username"));
        u.setEmail(rs.getString("email"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getBoolean("status"));
        u.setBusiness_name(rs.getString("business_name"));
        u.setJoined_date(rs.getTimestamp("joined_date"));
        u.setLoyalty_points(rs.getLong("loyalty_points"));
        return u;
    }
}
