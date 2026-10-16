package com.fashionstore.util;

import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.model.Cart;
import java.sql.SQLException;

public class CartDAOTest {

    public static void main(String[] args) {

        CartDAOImpl cartDAO = new CartDAOImpl();

        try {
            // Find the cart created for user ID 5
            Cart cart = cartDAO.getCartByUserId(5);

            if (cart != null) {

                boolean result = cartDAO.deleteCart(cart.getCartId());

                if (result) {
                    System.out.println("Cart deleted successfully!");
                    System.out.println("Deleted Cart ID: " + cart.getCartId());
                } else {
                    System.out.println("Cart deletion failed.");
                }

            } else {
                System.out.println("No cart found for user ID 5.");
            }

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}