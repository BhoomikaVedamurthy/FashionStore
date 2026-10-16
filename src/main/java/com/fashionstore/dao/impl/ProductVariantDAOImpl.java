package com.fashionstore.dao.impl;

import com.fashionstore.dao.ProductVariantDAO;
import com.fashionstore.model.ProductVariant;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductVariantDAOImpl implements ProductVariantDAO {

    @Override
    public boolean addVariant(ProductVariant variant) throws SQLException {
        String sql = "INSERT INTO product_variants "
                + "(product_id, size, stock_quantity) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, variant.getProductId());
            ps.setString(2, variant.getSize());
            ps.setInt(3, variant.getStockQuantity());

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public ProductVariant getVariantById(int variantId) throws SQLException {
        String sql = "SELECT * FROM product_variants WHERE variant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, variantId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapVariant(rs);
                }
            }
        }

        return null;
    }

    @Override
    public List<ProductVariant> getVariantsByProductId(int productId)
            throws SQLException {

        List<ProductVariant> variants = new ArrayList<>();

        String sql = "SELECT * FROM product_variants WHERE product_id = ? ORDER BY size";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    variants.add(mapVariant(rs));
                }
            }
        }

        return variants;
    }

    @Override
    public boolean updateVariant(ProductVariant variant) throws SQLException {
        String sql = "UPDATE product_variants "
                + "SET size = ?, stock_quantity = ? WHERE variant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, variant.getSize());
            ps.setInt(2, variant.getStockQuantity());
            ps.setInt(3, variant.getVariantId());

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean updateStock(int variantId, int quantity) throws SQLException {
        if (quantity < 0) {
            throw new IllegalArgumentException("Stock cannot be negative.");
        }

        String sql = "UPDATE product_variants "
                + "SET stock_quantity = ? WHERE variant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, variantId);

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean reduceStock(int variantId, int quantity) throws SQLException {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than zero.");
        }

        String sql = "UPDATE product_variants "
                + "SET stock_quantity = stock_quantity - ? "
                + "WHERE variant_id = ? AND stock_quantity >= ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, variantId);
            ps.setInt(3, quantity);

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteVariant(int variantId) throws SQLException {
        String sql = "DELETE FROM product_variants WHERE variant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, variantId);

            return ps.executeUpdate() > 0;
        }
    }

    private ProductVariant mapVariant(ResultSet rs) throws SQLException {
        ProductVariant variant = new ProductVariant();

        variant.setVariantId(rs.getInt("variant_id"));
        variant.setProductId(rs.getInt("product_id"));
        variant.setSize(rs.getString("size"));
        variant.setStockQuantity(rs.getInt("stock_quantity"));

        return variant;
    }
}