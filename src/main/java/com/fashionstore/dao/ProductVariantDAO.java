package com.fashionstore.dao;

import com.fashionstore.model.ProductVariant;
import java.sql.SQLException;
import java.util.List;

public interface ProductVariantDAO {

    boolean addVariant(ProductVariant variant) throws SQLException;

    ProductVariant getVariantById(int variantId) throws SQLException;

    List<ProductVariant> getVariantsByProductId(int productId) throws SQLException;

    boolean updateVariant(ProductVariant variant) throws SQLException;

    boolean updateStock(int variantId, int quantity) throws SQLException;

    boolean reduceStock(int variantId, int quantity) throws SQLException;

    boolean deleteVariant(int variantId) throws SQLException;
}