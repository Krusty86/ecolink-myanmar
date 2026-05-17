package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.Category;
import util.DBConnection;

public class CategoryDAO {

    // 1. Save Category and return with generated ID
    public static Category save(Category category) {
        String sql = "INSERT INTO categories (name, description) VALUES (?, ?)";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            
            if (ps.executeUpdate() > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        category.setId(rs.getLong(1));
                    }
                }
                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. Find All Categories
    public static List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        
        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                Category cat = new Category(
                    rs.getLong("id"),
                    rs.getString("name"),
                    rs.getString("description")
                );
                list.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        return list;
    }

    // 3. Delete Category (Hard Delete)
    public static boolean delete(Long id) {
        String sql = "DELETE FROM categories WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setLong(1, id);
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            //  fail if products are still linked to this category
            e.printStackTrace();
            return false;
        }
    }

    // 4. Update Category
    public static Category update(Long id, Category category) {
        String sql = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());
            ps.setLong(3, id);
            
            if (ps.executeUpdate() > 0) {
                category.setId(id); 
                return category;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}