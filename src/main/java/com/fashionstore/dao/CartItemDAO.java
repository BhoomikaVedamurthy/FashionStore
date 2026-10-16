package com.fashionstore.dao;

import java.sql.Connection;
import com.fashionstore.model.CartItem;
import java.sql.SQLException;
import java.util.List;

public interface CartItemDAO {

    boolean addCartItem(int cartId, int variantId, int quantity) throws SQLException;

    List<CartItem> getCartItems(int cartId) throws SQLException;

    boolean clearCart(Connection con, int cartId) throws SQLException;
    
    CartItem getCartItemById(int cartItemId) throws SQLException;

    boolean updateQuantity(int cartItemId, int quantity) throws SQLException;

    boolean removeCartItem(int cartItemId) throws SQLException;

    boolean clearCart(int cartId) throws SQLException;
}