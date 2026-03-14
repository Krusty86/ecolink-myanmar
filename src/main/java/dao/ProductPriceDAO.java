package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entity.*;
import util.DBConnection;

public class ProductPriceDAO {

    public static ProductPrice save(ProductPrice pp) {
        String sql = "INSERT INTO product_prices (product_id, price, effective_date, is_current) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, pp.getProduct().getId());
            ps.setBigDecimal(2, pp.getPrice());
            ps.setTimestamp(3, new Timestamp(pp.getEffective_date().getTime()));
            ps.setBoolean(4, pp.getIs_current());

            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) pp.setId(rs.getLong(1));
                return pp;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public static List<ProductPrice> findAll(ProductPrice filter) {
        List<ProductPrice> list = new ArrayList<>();
        String sql = "SELECT pp.*, p.name as prod_name FROM product_prices pp " +
                     "JOIN products p ON pp.product_id = p.id WHERE pp.product_id = ? ORDER BY effective_date DESC";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, filter.getProduct().getId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductPrice pp = new ProductPrice();
                pp.setId(rs.getLong("id"));
                pp.setPrice(rs.getBigDecimal("price"));
                pp.setEffective_date(rs.getTimestamp("effective_date"));
                pp.setIs_current(rs.getBoolean("is_current"));
                pp.setProduct(filter.getProduct()); // reuse product object
                list.add(pp);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public static ProductPrice updatePrice(ProductPrice newPrice, ProductPrice oldPrice) {
        Connection con = null;
        try {
            con = DBConnection.connect();
            con.setAutoCommit(false); // Start Transaction

            // 1. Mark old price as not current
            String updateOld = "UPDATE product_prices SET is_current = false WHERE id = ?";
            try (PreparedStatement ps1 = con.prepareStatement(updateOld)) {
                ps1.setLong(1, oldPrice.getId());
                ps1.executeUpdate();
            }

            // 2. Insert new current price
            String insertNew = "INSERT INTO product_prices (product_id, price, effective_date, is_current) VALUES (?,?,?,?)";
            try (PreparedStatement ps2 = con.prepareStatement(insertNew, Statement.RETURN_GENERATED_KEYS)) {
                ps2.setLong(1, newPrice.getProduct().getId());
                ps2.setBigDecimal(2, newPrice.getPrice());
                ps2.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                ps2.setBoolean(4, true);
                ps2.executeUpdate();
                ResultSet rs = ps2.getGeneratedKeys();
                if (rs.next()) newPrice.setId(rs.getLong(1));
            }

            con.commit();
            newPrice.setIs_current(true);
            return newPrice;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (SQLException se) { se.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { if (con != null) con.close(); } catch (SQLException se) { se.printStackTrace(); }
        }
        return null;
    }

    public static boolean delete(ProductPrice pp) {
        String sql = "DELETE FROM product_prices WHERE id = ?";
        try (Connection con = DBConnection.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, pp.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }
}