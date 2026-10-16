package com.fashionstore.util;

import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.model.CartItem;

import java.sql.SQLException;
import java.util.List;

public class CartItemDAOTest {

    public static void main(String[] args) {

        CartItemDAOImpl cartItemDAO = new CartItemDAOImpl();

        int cartId = 1;
        int variantId = 1;
        int testQuantity = 3;
        int cartItemId = -1;

        try {
            System.out.println("========== CART ITEM DAO TESTING ==========");

            // 1. Test addCartItem()
            System.out.println("\n1. Testing addCartItem()");

            List<CartItem> existingItems = cartItemDAO.getCartItems(cartId);

            for (CartItem item : existingItems) {
                if (item.getVariantId() == variantId) {
                    cartItemId = item.getCartItemId();
                    break;
                }
            }

            if (cartItemId == -1) {
                boolean added = cartItemDAO.addCartItem(
                    cartId, variantId, 1
                );

                if (added) {
                    System.out.println("PASS: Cart item added.");

                    existingItems = cartItemDAO.getCartItems(cartId);

                    for (CartItem item : existingItems) {
                        if (item.getVariantId() == variantId) {
                            cartItemId = item.getCartItemId();
                            break;
                        }
                    }
                } else {
                    System.out.println("FAIL: Could not add cart item.");
                }
            } else {
                System.out.println(
                    "PASS: Test item already exists; reusing it."
                );
            }

            if (cartItemId == -1) {
                System.out.println(
                    "Cannot continue: cart item ID was not found."
                );
                return;
            }

            // 2. Test getCartItems()
            System.out.println("\n2. Testing getCartItems()");

            List<CartItem> items = cartItemDAO.getCartItems(cartId);

            System.out.println("PASS: Retrieved " + items.size()
                    + " cart items.");

            // 3. Test getCartItemById()
            System.out.println("\n3. Testing getCartItemById()");

            CartItem item = cartItemDAO.getCartItemById(cartItemId);

            if (item != null) {
                System.out.println("PASS: Cart item retrieved.");
                System.out.println("Cart Item ID: " + item.getCartItemId());
                System.out.println("Quantity: " + item.getQuantity());
            } else {
                System.out.println("FAIL: Cart item not found.");
                return;
            }

            // 4. Test updateQuantity()
            System.out.println("\n4. Testing updateQuantity()");

            boolean updated = cartItemDAO.updateQuantity(
                cartItemId, testQuantity
            );

            if (updated) {
                CartItem updatedItem =
                    cartItemDAO.getCartItemById(cartItemId);

                if (updatedItem != null
                        && updatedItem.getQuantity() == testQuantity) {
                    System.out.println("PASS: Quantity updated to "
                            + updatedItem.getQuantity());
                } else {
                    System.out.println(
                        "FAIL: Quantity was not updated as expected."
                    );
                }
            } else {
                System.out.println("FAIL: Quantity update failed.");
            }

            // 5. Test removeCartItem()
            System.out.println("\n5. Testing removeCartItem()");

            boolean removed = cartItemDAO.removeCartItem(cartItemId);

            if (removed) {
                System.out.println("PASS: Cart item removed.");
            } else {
                System.out.println("FAIL: Cart item removal failed.");
            }

            // 6. Test clearCart()
            System.out.println("\n6. Testing clearCart()");

            boolean cleared = cartItemDAO.clearCart(cartId);

            if (cleared) {
                List<CartItem> remainingItems =
                    cartItemDAO.getCartItems(cartId);

                if (remainingItems.isEmpty()) {
                    System.out.println("PASS: Cart cleared successfully.");
                } else {
                    System.out.println(
                        "FAIL: Some items remain in the cart."
                    );
                }
            } else {
                System.out.println("FAIL: Cart clearing failed.");
            }

            System.out.println("\n========== TESTING COMPLETED ==========");

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}