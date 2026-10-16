package com.fashionstore.dao.impl;

import com.fashionstore.model.OrderItemDetails;
import com.fashionstore.dao.OrderItemDAO;
import com.fashionstore.model.OrderItem;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public boolean addOrderItem(OrderItem orderItem) throws SQLException {
        String sql = "INSERT INTO order_items "
                + "(order_id, variant_id, quantity, price) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getVariantId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setBigDecimal(4, orderItem.getPrice());

            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();

        String sql = "SELECT * FROM order_items WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(mapOrderItem(rs));
                }
            }
        }

        return items;
    }
    
    public boolean addOrderItem(Connection con, OrderItem orderItem)
            throws SQLException {

        String sql = "INSERT INTO order_items "
                + "(order_id, variant_id, quantity, price) "
                + "VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getVariantId());
            ps.setInt(3, orderItem.getQuantity());
            ps.setBigDecimal(4, orderItem.getPrice());

            return ps.executeUpdate() > 0;
        }
    }
    

    @Override
    public OrderItem getOrderItemById(int orderItemId) throws SQLException {
        String sql = "SELECT * FROM order_items WHERE order_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderItemId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapOrderItem(rs);
                }
            }
        }

        return null;
    }

    @Override
    public boolean deleteOrderItem(int orderItemId) throws SQLException {
        String sql = "DELETE FROM order_items WHERE order_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderItemId);

            return ps.executeUpdate() > 0;
        }
    }

    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();

        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setVariantId(rs.getInt("variant_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPrice(rs.getBigDecimal("price"));

        return item;
    }
    @Override
    public List<OrderItemDetails> getOrderItemDetails(int orderId)
            throws SQLException {

        List<OrderItemDetails> items = new ArrayList<>();

        String sql = "SELECT p.product_name, p.brand, p.image_url, "
                + "pv.size, oi.quantity, oi.price "
                + "FROM order_items oi "
                + "JOIN product_variants pv ON oi.variant_id = pv.variant_id "
                + "JOIN products p ON pv.product_id = p.product_id "
                + "WHERE oi.order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItemDetails item = new OrderItemDetails();

                    item.setProductName(rs.getString("product_name"));
                    item.setBrand(rs.getString("brand"));
                    item.setImageUrl(rs.getString("image_url"));
                    item.setSize(rs.getString("size"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));

                    items.add(item);
                }
            }
        }

        return items;
    }
}