package com.fashionstore.dao;

import com.fashionstore.model.Product;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public interface ProductDAO {

    boolean addProduct(Product product) throws SQLException;

    Product getProductById(int productId) throws SQLException;

    List<Product> getAllProducts() throws SQLException;

    List<Product> getProductsByCategory(int categoryId)
            throws SQLException;

    List<Product> searchProducts(String keyword)
            throws SQLException;

    List<Product> getProductsByPriceRange(
            BigDecimal minPrice, BigDecimal maxPrice)
            throws SQLException;

    boolean updateProduct(Product product) throws SQLException;

    boolean deleteProduct(int productId) throws SQLException;
}