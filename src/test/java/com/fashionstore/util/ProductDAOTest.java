package com.fashionstore.util;

import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Product;
import java.sql.SQLException;
import java.util.List;

public class ProductDAOTest {

    public static void main(String[] args) {

        ProductDAOImpl productDAO = new ProductDAOImpl();

        try {
            List<Product> products = productDAO.getAllProducts();

            if (products.isEmpty()) {
                System.out.println("No active products found.");
            } else {
                System.out.println("Products retrieved successfully!");
                System.out.println("--------------------------------");

                for (Product product : products) {
                    System.out.println("ID: " + product.getProductId());
                    System.out.println("Name: " + product.getProductName());
                    System.out.println("Price: " + product.getPrice());
                    System.out.println("--------------------------------");
                }

                System.out.println("Total products: " + products.size());
            }

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}