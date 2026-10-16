package com.fashionstore.util;

import com.fashionstore.dao.impl.OrderItemDAOImpl;
import com.fashionstore.model.OrderItem;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class OrderItemDAOTest {

    public static void main(String[] args) {

        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();

        int testOrderId = 13;
        int testVariantId = 1;
        int testOrderItemId = -1;

        try {
            System.out.println("========== ORDER ITEM DAO TESTING ==========");

            // 1. Test addOrderItem()
            System.out.println("\n1. Testing addOrderItem()");

            OrderItem newItem = new OrderItem();
            newItem.setOrderId(testOrderId);
            newItem.setVariantId(testVariantId);
            newItem.setQuantity(2);
            newItem.setPrice(new BigDecimal("599.00"));

            boolean added = orderItemDAO.addOrderItem(newItem);

            if (added) {
                System.out.println("PASS: Order item added successfully.");
            } else {
                System.out.println("FAIL: Could not add order item.");
                return;
            }

            // Retrieve items and identify the newly added item
            List<OrderItem> items =
                    orderItemDAO.getOrderItems(testOrderId);

            for (OrderItem item : items) {
                if (item.getVariantId() == testVariantId
                        && item.getQuantity() == 2
                        && item.getPrice().compareTo(
                                new BigDecimal("599.00")) == 0) {

                    testOrderItemId = item.getOrderItemId();
                    break;
                }
            }

            if (testOrderItemId == -1) {
                System.out.println("Could not identify the test item.");
                return;
            }

            System.out.println("Test Order Item ID: " + testOrderItemId);

            // 2. Test getOrderItems()
            System.out.println("\n2. Testing getOrderItems()");

            items = orderItemDAO.getOrderItems(testOrderId);

            boolean found = false;

            for (OrderItem item : items) {
                if (item.getOrderItemId() == testOrderItemId) {
                    found = true;
                    break;
                }
            }

            if (found) {
                System.out.println(
                        "PASS: Order items retrieved successfully.");
                System.out.println("Total items in order: " + items.size());
            } else {
                System.out.println("FAIL: Test item not found.");
            }

            // 3. Test getOrderItemById()
            System.out.println("\n3. Testing getOrderItemById()");

            OrderItem retrievedItem =
                    orderItemDAO.getOrderItemById(testOrderItemId);

            if (retrievedItem != null) {
                System.out.println(
                        "PASS: Order item retrieved by ID.");
                System.out.println("Order ID: "
                        + retrievedItem.getOrderId());
                System.out.println("Variant ID: "
                        + retrievedItem.getVariantId());
                System.out.println("Quantity: "
                        + retrievedItem.getQuantity());
                System.out.println("Price: "
                        + retrievedItem.getPrice());
            } else {
                System.out.println("FAIL: Could not retrieve order item.");
            }

            // 4. Test deleteOrderItem()
            System.out.println("\n4. Testing deleteOrderItem()");

            boolean deleted =
                    orderItemDAO.deleteOrderItem(testOrderItemId);

            if (deleted) {
                OrderItem deletedItem =
                        orderItemDAO.getOrderItemById(testOrderItemId);

                if (deletedItem == null) {
                    System.out.println(
                            "PASS: Test order item deleted successfully.");
                } else {
                    System.out.println(
                            "FAIL: Order item still exists after deletion.");
                }
            } else {
                System.out.println("FAIL: Could not delete order item.");
            }

            System.out.println(
                    "\n========== TESTING COMPLETED ==========");

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}