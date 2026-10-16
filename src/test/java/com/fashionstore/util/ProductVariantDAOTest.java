package com.fashionstore.util;

import com.fashionstore.dao.impl.ProductVariantDAOImpl;
import com.fashionstore.model.ProductVariant;

import java.sql.SQLException;
import java.util.List;

public class ProductVariantDAOTest {

    public static void main(String[] args) {

        ProductVariantDAOImpl variantDAO = new ProductVariantDAOImpl();

        try {
            // Retrieve variants for product ID 1
            List<ProductVariant> variants =
                    variantDAO.getVariantsByProductId(1);

            if (variants.isEmpty()) {
                System.out.println("No variants found for this product.");
            } else {
                System.out.println("Product variants retrieved successfully!");
                System.out.println("--------------------------------");

                for (ProductVariant variant : variants) {
                    System.out.println("Variant ID: " + variant.getVariantId());
                    System.out.println("Product ID: " + variant.getProductId());
                    System.out.println("Size: " + variant.getSize());
                    System.out.println("Stock: " + variant.getStockQuantity());
                    System.out.println("--------------------------------");
                }

                System.out.println("Total variants: " + variants.size());
            }

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}