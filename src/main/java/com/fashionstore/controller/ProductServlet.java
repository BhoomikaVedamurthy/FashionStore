package com.fashionstore.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import com.fashionstore.dao.ProductVariantDAO;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.dao.impl.ProductVariantDAOImpl;
import com.fashionstore.model.Product;
import com.fashionstore.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ProductDAOImpl productDAO = new ProductDAOImpl();

    private final ProductVariantDAO productVariantDAO =
            new ProductVariantDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String category = request.getParameter("category");
        String search = request.getParameter("search");

        try {
            // Display an individual product when an ID is provided.
            if (id != null && !id.trim().isEmpty()) {

                int productId = Integer.parseInt(id);

                if (productId <= 0) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid product ID.");
                    return;
                }

                Product product = productDAO.getProductById(productId);

                if (product == null || !product.isActive()) {
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Product not found.");
                    return;
                }

                List<ProductVariant> variants =
                        productVariantDAO.getVariantsByProductId(productId);

                request.setAttribute("product", product);
                request.setAttribute("variants", variants);

                request.getRequestDispatcher(
                        "/WEB-INF/views/product.jsp")
                        .forward(request, response);

                return;
            }

            // Display products by category, search, or show all products.
            List<Product> products;

            if (category != null && !category.trim().isEmpty()) {

                int categoryId = Integer.parseInt(category);

                if (categoryId < 1 || categoryId > 5) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid category ID.");
                    return;
                }

                products = productDAO.getProductsByCategory(categoryId);

            } else if (search != null && !search.trim().isEmpty()) {

                products = productDAO.searchProducts(search.trim());

            } else {

                products = productDAO.getAllProducts();
            }

            Map<Integer, List<ProductVariant>> variantsMap =
                    new HashMap<>();

            for (Product product : products) {

                if (product.isActive()) {

                    List<ProductVariant> variants =
                            productVariantDAO.getVariantsByProductId(
                                    product.getProductId());

                    variantsMap.put(
                            product.getProductId(), variants);
                }
            }

            request.setAttribute("products", products);
            request.setAttribute("variantsMap", variantsMap);

            request.getRequestDispatcher(
                    "/WEB-INF/views/product.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID or category.");

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to retrieve products or their variants.", e);
        }
    }
}