package com.fashionstore.dao;

import com.fashionstore.model.Cart;
import java.sql.SQLException;

public interface CartDAO {

    Cart getCartByUserId(int userId) throws SQLException;

    Cart createCart(int userId) throws SQLException;

    boolean deleteCart(int cartId) throws SQLException;
}