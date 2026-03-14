package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.Address;
import entity.User;
import enums.AddressType;
import util.DBConnection;

public class AddressDAO {

    // Helper to map ResultSet to Address Object (including User ID)
    private static Address mapAddress(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("user_id"));
        
        return new Address(
            rs.getLong("id"),
            user,
            rs.getString("label"),
            rs.getString("street"),
            rs.getString("township"),
            rs.getString("city"),
            rs.getBoolean("is_default"),
            AddressType.valueOf(rs.getString("address_type"))
        );
    }

    // 1. Save Address
    public static Address save(Address address) {
        String sql = "INSERT INTO addresses (user_id, label, street, township, city, is_default, address_type) VALUES (?,?,?,?,?,?,?)";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setLong(1, address.getUser().getId());
            ps.setString(2, address.getLabel());
            ps.setString(3, address.getStreet());
            ps.setString(4, address.getTownship());
            ps.setString(5, address.getCity());
            ps.setBoolean(6, address.getIs_default());
            ps.setString(7, address.getAddress_type().name());

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) address.setId(rs.getLong(1));
                return address;
            }
        } catch (SQLException e) { e.printStackTrace(); } catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        return null;
    }

    // 2. Find All Addresses for a specific User
    public static List<Address> findAllByUser(Long userId) {
        List<Address> list = new ArrayList<>();
        String sql = "SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapAddress(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); } catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        return list;
    }

    // 3. Update Address Details
    public static Address update(Long id, Address address) {
        String sql = "UPDATE addresses SET label=?, street=?, township=?, city=?, address_type=? WHERE id=?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, address.getLabel());
            ps.setString(2, address.getStreet());
            ps.setString(3, address.getTownship());
            ps.setString(4, address.getCity());
            ps.setString(5, address.getAddress_type().name());
            ps.setLong(6, id);
            
            if (ps.executeUpdate() > 0) {
                address.setId(id);
                return address;
            }
        } catch (SQLException e) { e.printStackTrace(); } catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        return null;
    }

    // 4. Update Default Address (Transaction based)
    public static boolean updateDefault(Long userId, Long addressId) {
        Connection con = null;
        try {
            con = DBConnection.connect();
            con.setAutoCommit(false); // Start Transaction

            // Step 1: Set all addresses for this user to NOT default
            String resetSql = "UPDATE addresses SET is_default = false WHERE user_id = ?";
            try (PreparedStatement ps1 = con.prepareStatement(resetSql)) {
                ps1.setLong(1, userId);
                ps1.executeUpdate();
            }

            // Step 2: Set the specific address to default
            String setSql = "UPDATE addresses SET is_default = true WHERE id = ?";
            try (PreparedStatement ps2 = con.prepareStatement(setSql)) {
                ps2.setLong(1, addressId);
                int result = ps2.executeUpdate();
                
                con.commit(); // Commit both changes
                return result > 0;
            }
        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            try { if (con != null) con.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
    }

    // 5. Delete Address
    public static boolean delete(Long id) {
        String sql = "DELETE FROM addresses WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}