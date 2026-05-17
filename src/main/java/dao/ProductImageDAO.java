package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import entity.Product;
import entity.ProductImage;
import util.DBConnection;

public class ProductImageDAO {

    // ================= MAPPER =================
    private static ProductImage mapProductImage(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getLong("product_id"));

        return new ProductImage(
            rs.getLong("id"),
            p,
            rs.getString("image_path")
        );
    }

    // ================= 1. SAVE =================
    public static ProductImage save(ProductImage pi) {
        String sql = "INSERT INTO product_images (product_id, image_path) VALUES (?, ?)";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setLong(1, pi.getProduct().getId());
            ps.setString(2, pi.getImage_path());

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    pi.setId(rs.getLong(1));
                }
                return pi;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= 2. UPDATE =================
    public static boolean update(ProductImage pi) {
        String sql = "UPDATE product_images SET product_id = ?, image_path = ? WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, pi.getProduct().getId());
            ps.setString(2, pi.getImage_path());
            ps.setLong(3, pi.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================= 3. FIND ALL =================
    public static List<ProductImage> findAll() {
        List<ProductImage> list = new ArrayList<>();
        String sql = "SELECT * FROM product_images ORDER BY id DESC";

        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapProductImage(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ================= 4. FIND BY ID =================
    public static Optional<ProductImage> findById(Long id) {
        String sql = "SELECT * FROM product_images WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapProductImage(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    // ================= EXTRA: FIND BY PRODUCT =================
    public static List<ProductImage> findByProductId(Long productId) {
        List<ProductImage> list = new ArrayList<>();
        String sql = "SELECT * FROM product_images WHERE product_id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapProductImage(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}