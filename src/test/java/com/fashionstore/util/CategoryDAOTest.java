package com.fashionstore.util;

import com.fashionstore.dao.impl.CategoryDAOImpl;
import com.fashionstore.model.Category;
import java.sql.SQLException;
import java.util.List;

public class CategoryDAOTest {

    public static void main(String[] args) {

        CategoryDAOImpl categoryDAO = new CategoryDAOImpl();

        try {
            List<Category> categories = categoryDAO.getAllCategories();

            if (categories.isEmpty()) {
                System.out.println("No categories found.");
            } else {
                System.out.println("Categories retrieved successfully!");
                System.out.println("--------------------------------");

                for (Category category : categories) {
                    System.out.println("ID: " + category.getCategoryId());
                    System.out.println("Name: " + category.getCategoryName());
                    System.out.println("--------------------------------");
                }

                System.out.println("Total categories: " + categories.size());
            }

        } catch (SQLException e) {
            System.out.println("Database error occurred:");
            e.printStackTrace();
        }
    }
}