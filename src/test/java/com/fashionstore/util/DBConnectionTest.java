package com.fashionstore.util;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnectionTest {

    public static void main(String[] args) {

        try (Connection connection = DBConnection.getConnection()) {

            if (connection.isValid(5)) {

                System.out.println("Database connection successful!");

                System.out.println(
                        "Connected database: " + connection.getCatalog()
                );
            }

        } catch (SQLException e) {

            System.out.println("Database connection failed!");

            e.printStackTrace();
        }
    }
}