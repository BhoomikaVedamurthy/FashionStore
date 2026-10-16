package com.fashionstore.dao;

import java.sql.Connection;
import com.fashionstore.model.Order;
import java.sql.SQLException;
import java.util.List;

public interface OrderDAO {

    boolean placeOrder(Order order) throws SQLException;

    Order getOrderById(int orderId) throws SQLException;

    List<Order> getOrdersByUserId(int userId) throws SQLException;
    
    boolean placeOrder(Connection con, Order order) throws SQLException;

    boolean updateOrderStatus(int orderId, String status) throws SQLException;

    boolean cancelOrder(int orderId) throws SQLException;
}