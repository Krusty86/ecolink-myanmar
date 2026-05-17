package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import entity.*;
import enums.ProductStatus;
import util.DBConnection;

public class ProductDAO {

    private static Product mapFullProduct(ResultSet rs) throws SQLException {

        Category cat = new Category();
        cat.setId(rs.getLong("category_id"));
        cat.setName(rs.getString("cat_name"));
        cat.setDescription(rs.getString("cat_des"));
        
        Product p = new Product(
                rs.getLong("id"),
                cat,
                rs.getString("name"),
                rs.getString("material_type"),
                rs.getBigDecimal("plastic_saved_per_unit"),
                ProductStatus.valueOf(rs.getString("status")),
                rs.getLong("qty")
        );

        p.setPrice(rs.getBigDecimal("current_price"));
        return p;
    }

    public static boolean updateCategory(Long productId, Long categoryId) {
        String sql = "UPDATE products SET category_id = ? WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, categoryId);
            ps.setLong(2, productId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 1. Save Product + Initial Price
    public static Product save(Product product) {

        String prodSql = "INSERT INTO products (category_id, name, material_type, plastic_saved_per_unit, status, qty) VALUES (?,?,?,?,?,?)";
        String priceSql = "INSERT INTO product_prices (product_id, price, effective_date, is_current) VALUES (?,?,?,?)";

        Connection con = null;

        try {
            con = DBConnection.connect();
            con.setAutoCommit(false);

            // Insert Product
            try (PreparedStatement ps = con.prepareStatement(prodSql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setLong(1, product.getCategory().getId());
                ps.setString(2, product.getName());
                ps.setString(3, product.getMaterial_type());
                ps.setBigDecimal(4, product.getPlastic_saved_per_unit());
                ps.setString(5, product.getStatus().name());
                ps.setLong(6, product.getQty());

                if (ps.executeUpdate() > 0) {
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next()) product.setId(rs.getLong(1));
                }
            }

            // Insert Price
            try (PreparedStatement psPrice = con.prepareStatement(priceSql)) {
                psPrice.setLong(1, product.getId());
                psPrice.setBigDecimal(2, product.getPrice());
                psPrice.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                psPrice.setBoolean(4, true);
                psPrice.executeUpdate();
            }

            con.commit();
            return product;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (SQLException se) { se.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (SQLException se) { se.printStackTrace(); }
        }
        return null;
    }

    // 2. Find All
    public static List<Product> findAll() {

        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, c.name as cat_name, c.description as cat_des, pp.price as current_price " +
                "FROM products p " +
                "JOIN categories c ON p.category_id = c.id " +
                "LEFT JOIN product_prices pp ON p.id = pp.product_id AND pp.is_current = true";

        try (Connection con = DBConnection.connect();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) list.add(mapFullProduct(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 3. Find Published
    public static List<Product> findAllPublished() {

        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, c.name as cat_name,  c.description as cat_des, pp.price as current_price " +
                "FROM products p " +
                "JOIN categories c ON p.category_id = c.id " +
                "LEFT JOIN product_prices pp ON p.id = pp.product_id AND pp.is_current = true " +
                "WHERE p.status != 'DRAFT' AND p.status != 'ARCHIVED' " +
                "ORDER BY p.id DESC";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapFullProduct(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 4. Find Unpublished
    public static List<Product> findAllUnPublished() {

        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, c.name as cat_name, c.description as cat_des, pp.price as current_price " +
                "FROM products p " +
                "JOIN categories c ON p.category_id = c.id " +
                "LEFT JOIN product_prices pp ON p.id = pp.product_id AND pp.is_current = true " +
                "WHERE p.status = 'DRAFT' OR p.status = 'ARCHIVED' " +
                "ORDER BY p.id DESC";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapFullProduct(rs));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 5. Find By ID
    public static Product findById(Long id) {

        String sql = "SELECT p.*, c.name as cat_name, c.description as cat_des, pp.price as current_price " +
                "FROM products p " +
                "JOIN categories c ON p.category_id = c.id " +
                "LEFT JOIN product_prices pp ON p.id = pp.product_id AND pp.is_current = true " +
                "WHERE p.id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapFullProduct(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // 6. Update Status
    public static boolean updateProductStatus(Long id, String status) {

        String sql = "UPDATE products SET status = ? WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setLong(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 7. Update Stock
    public static Product updateStock(Long id, Long qty) {

        String sql = "UPDATE products SET qty = ? WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, qty);
            ps.setLong(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return findById(id);
    }

    // 8. Update Product + Price
    public static boolean updateProduct(Product product) {

        String updateProdSql = "UPDATE products SET name = ?, material_type = ?, plastic_saved_per_unit = ?, qty = ? WHERE id = ?";
        String deactivatePriceSql = "UPDATE product_prices SET is_current = false WHERE product_id = ? AND is_current = true";
        String insertPriceSql = "INSERT INTO product_prices (product_id, price, effective_date, is_current) VALUES (?, ?, ?, true)";

        Connection con = null;

        try {
            con = DBConnection.connect();
            con.setAutoCommit(false);

            // Update product
            try (PreparedStatement ps = con.prepareStatement(updateProdSql)) {

                ps.setString(1, product.getName());
                ps.setString(2, product.getMaterial_type());
                ps.setBigDecimal(3, product.getPlastic_saved_per_unit());
                ps.setLong(4, product.getQty());
                ps.setLong(5, product.getId());
                ps.executeUpdate();
            }

            // Check price change safely
            Product currentDbProduct = findById(product.getId());

            if (currentDbProduct != null &&
                currentDbProduct.getPrice() != null &&
                product.getPrice() != null &&
                currentDbProduct.getPrice().compareTo(product.getPrice()) != 0) {

                // deactivate old price
                try (PreparedStatement ps = con.prepareStatement(deactivatePriceSql)) {
                    ps.setLong(1, product.getId());
                    ps.executeUpdate();
                }

                // insert new price
                try (PreparedStatement ps = con.prepareStatement(insertPriceSql)) {
                    ps.setLong(1, product.getId());
                    ps.setBigDecimal(2, product.getPrice());
                    ps.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                    ps.executeUpdate();
                }
            }

            con.commit();
            return true;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (SQLException se) { se.printStackTrace(); }
            e.printStackTrace();
            return false;
        } finally {
            try { if (con != null) con.close(); } catch (SQLException se) { se.printStackTrace(); }
        }
    }

    // 9. Delete
    public static boolean delete(Long id) {

        String sql = "DELETE FROM products WHERE id = ?";

        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setLong(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}