package com.fashionstore.util;

import com.fashionstore.dao.impl.UserDAOImpl;
import java.sql.SQLException;

public class UserDAOTest {

    public static void main(String[] args) {

        UserDAOImpl userDAO = new UserDAOImpl();

        try {
            // Find the test user
            var user = userDAO.findByEmail("testuser2026@example.com");

            if (user != null) {

                // Update the password
                boolean result = userDAO.updatePassword(
                    user.getUserId(),
                    "TestHashedPassword456"
                );

                if (result) {
                    System.out.println("Password updated successfully!");
                    System.out.println("User ID: " + user.getUserId());
                } else {
                    System.out.println("Password update failed.");
                }

            } else {
                System.out.println("Test user not found.");
            }

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}