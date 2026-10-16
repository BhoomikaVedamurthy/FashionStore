package com.fashionstore.dao;

import com.fashionstore.model.OrderItemDetails;
import com.fashionstore.model.OrderItem;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;

public interface OrderItemDAO {

    boolean addOrderItem(OrderItem orderItem) throws SQLException;

    List<OrderItem> getOrderItems(int orderId) throws SQLException;

    boolean addOrderItem(Connection con, OrderItem orderItem)
            throws SQLException;
    OrderItem getOrderItemById(int orderItemId) throws SQLException;

    boolean deleteOrderItem(int orderItemId) throws SQLException;
    
    List<OrderItemDetails> getOrderItemDetails(int orderId)
            throws SQLException;
}