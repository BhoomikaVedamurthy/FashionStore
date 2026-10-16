package com.fashionstore.dao.impl;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.model.Cart;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartDAOImpl implements CartDAO {

    @Override
    public Cart getCartByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM cart WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    return cart;
                }
            }
        }

        return null;
    }

    @Override
    public Cart createCart(int userId) throws SQLException {
        String sql = "INSERT INTO cart (user_id) VALUES (?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, userId);

            if (ps.executeUpdate() > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        Cart cart = new Cart();
                        cart.setCartId(rs.getInt(1));
                        cart.setUserId(userId);
                        return cart;
                    }
                }
            }
        }

        return null;
    }

    @Override
    public boolean deleteCart(int cartId) throws SQLException {
        String sql = "DELETE FROM cart WHERE cart_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        }
    }
}