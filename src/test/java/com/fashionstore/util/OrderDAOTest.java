package com.fashionstore.util;

import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.model.Order;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class OrderDAOTest {

    public static void main(String[] args) {

        OrderDAOImpl orderDAO = new OrderDAOImpl();

        int testUserId = 5;
        int testOrderId = -1;

        try {
            System.out.println("========== ORDER DAO TESTING ==========");

            // 1. Test placeOrder()
            System.out.println("\n1. Testing placeOrder()");

            Order order = new Order();

            order.setUserId(testUserId);
            order.setTotalAmount(new BigDecimal("1499.00"));
            order.setPaymentMethod("COD");
            order.setOrderStatus("PLACED");
            order.setDeliveryName("Test User");
            order.setDeliveryPhone("9876543211");
            order.setDeliveryAddressLine1("123 Test Street");
            order.setDeliveryAddressLine2("Near Test Park");
            order.setDeliveryCity("Bengaluru");
            order.setDeliveryState("Karnataka");
            order.setDeliveryPincode("560001");
            order.setDeliveryCountry("India");

            boolean placed = orderDAO.placeOrder(order);

            if (placed) {
                System.out.println("PASS: Order placed successfully.");

                // Find the newly created order
                List<Order> userOrders =
                        orderDAO.getOrdersByUserId(testUserId);

                for (Order userOrder : userOrders) {
                    if ("Test User".equals(userOrder.getDeliveryName())
                            && "PLACED".equals(userOrder.getOrderStatus())
                            && new BigDecimal("1499.00")
                                .compareTo(userOrder.getTotalAmount()) == 0) {
                        testOrderId = userOrder.getOrderId();
                        break;
                    }
                }
            } else {
                System.out.println("FAIL: Order placement failed.");
                return;
            }

            if (testOrderId == -1) {
                System.out.println(
                    "Could not identify the new test order. "
                    + "Stopping to avoid modifying another order."
                );
                return;
            }

            System.out.println("Test Order ID: " + testOrderId);

            // 2. Test getOrderById()
            System.out.println("\n2. Testing getOrderById()");

            Order retrievedOrder = orderDAO.getOrderById(testOrderId);

            if (retrievedOrder != null) {
                System.out.println("PASS: Order retrieved successfully.");
                System.out.println("Order ID: "
                        + retrievedOrder.getOrderId());
                System.out.println("Amount: "
                        + retrievedOrder.getTotalAmount());
                System.out.println("Status: "
                        + retrievedOrder.getOrderStatus());
            } else {
                System.out.println("FAIL: Order not found.");
            }

            // 3. Test getOrdersByUserId()
            System.out.println("\n3. Testing getOrdersByUserId()");

            List<Order> orders =
                    orderDAO.getOrdersByUserId(testUserId);

            boolean found = false;

            for (Order userOrder : orders) {
                if (userOrder.getOrderId() == testOrderId) {
                    found = true;
                    break;
                }
            }

            if (found) {
                System.out.println(
                    "PASS: Test order found in user's order history."
                );
                System.out.println("Total orders for user: "
                        + orders.size());
            } else {
                System.out.println("FAIL: Test order not found.");
            }

            // 4. Test updateOrderStatus()
            System.out.println("\n4. Testing updateOrderStatus()");

            boolean updated = orderDAO.updateOrderStatus(
                    testOrderId, "CONFIRMED");

            Order updatedOrder = orderDAO.getOrderById(testOrderId);

            if (updated && updatedOrder != null
                    && "CONFIRMED".equals(updatedOrder.getOrderStatus())) {
                System.out.println(
                    "PASS: Order status updated to CONFIRMED."
                );
            } else {
                System.out.println("FAIL: Order status update failed.");
            }

            // Restore PLACED status so cancelOrder() can be tested
            boolean restored = orderDAO.updateOrderStatus(
                    testOrderId, "PLACED");

            if (!restored) {
                System.out.println(
                    "Could not restore PLACED status for cancellation test."
                );
                return;
            }

            // 5. Test cancelOrder()
            System.out.println("\n5. Testing cancelOrder()");

            boolean cancelled = orderDAO.cancelOrder(testOrderId);

            Order cancelledOrder = orderDAO.getOrderById(testOrderId);

            if (cancelled && cancelledOrder != null
                    && "CANCELLED".equals(
                            cancelledOrder.getOrderStatus())) {
                System.out.println("PASS: Test order cancelled successfully.");
            } else {
                System.out.println("FAIL: Order cancellation failed.");
            }

            System.out.println("\n========== TESTING COMPLETED ==========");

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}