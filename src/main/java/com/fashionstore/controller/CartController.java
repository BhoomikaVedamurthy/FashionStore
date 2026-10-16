package com.fashionstore.controller;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.ProductVariantDAO;

import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.dao.impl.ProductVariantDAOImpl;

import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;
    private ProductVariantDAO productVariantDAO;

    @Override
    public void init() {
        cartDAO = new CartDAOImpl();
        cartItemDAO = new CartItemDAOImpl();
        productVariantDAO = new ProductVariantDAOImpl();
    }

    private Integer getLoggedInUserId(HttpSession session) {

        if (session == null) {
            return null;
        }

        Object userId = session.getAttribute("userId");

        if (userId instanceof Integer) {
            return (Integer) userId;
        }

        return null;
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        try {

            Cart cart = cartDAO.getCartByUserId(userId);

            if (cart == null) {
                cart = cartDAO.createCart(userId);
            }

            if (cart == null) {
                throw new ServletException(
                        "Unable to create or retrieve the cart.");
            }

            request.setAttribute("cart", cart);

            request.setAttribute(
                    "cartItems",
                    cartItemDAO.getCartItems(cart.getCartId()));

            request.getRequestDispatcher(
                    "/WEB-INF/views/cart.jsp")
                    .forward(request, response);

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to load the cart.", e);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {

            Cart cart = cartDAO.getCartByUserId(userId);

            if (cart == null) {
                cart = cartDAO.createCart(userId);
            }

            if (cart == null) {
                throw new ServletException(
                        "Unable to create or retrieve the cart.");
            }

            // REMOVE ITEM
            if ("remove".equals(action)) {

                int cartItemId = Integer.parseInt(
                        request.getParameter("cartItemId"));

                if (cartItemId <= 0) {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid cart item ID.");
                    return;
                }

                CartItem item =
                        cartItemDAO.getCartItemById(cartItemId);

                if (item == null
                        || item.getCartId() != cart.getCartId()) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Cart item not found.");
                    return;
                }

                cartItemDAO.removeCartItem(cartItemId);

                response.sendRedirect(
                        request.getContextPath() + "/cart");
                return;
            }

            // UPDATE QUANTITY
            if ("update".equals(action)) {

                int cartItemId = Integer.parseInt(
                        request.getParameter("cartItemId"));

                int quantity = Integer.parseInt(
                        request.getParameter("quantity"));

                if (cartItemId <= 0
                        || quantity < 1
                        || quantity > 10) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Quantity must be between 1 and 10.");
                    return;
                }

                CartItem item =
                        cartItemDAO.getCartItemById(cartItemId);

                if (item == null
                        || item.getCartId() != cart.getCartId()) {

                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Cart item not found.");
                    return;
                }

                ProductVariant variant =
                        productVariantDAO.getVariantById(
                                item.getVariantId());

                if (variant == null
                        || quantity > variant.getStockQuantity()) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Requested quantity exceeds available stock.");
                    return;
                }

                cartItemDAO.updateQuantity(
                        cartItemId, quantity);

                response.sendRedirect(
                        request.getContextPath() + "/cart");
                return;
            }

            // ADD PRODUCT TO CART
            String variantIdParam =
                    request.getParameter("variantId");

            String quantityParam =
                    request.getParameter("quantity");

            String productIdParam =
                    request.getParameter("productId");

            if (variantIdParam == null
                    || quantityParam == null
                    || productIdParam == null) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Product, variant, and quantity are required.");
                return;
            }

            int variantId =
                    Integer.parseInt(variantIdParam);

            int quantity =
                    Integer.parseInt(quantityParam);

            int productId =
                    Integer.parseInt(productIdParam);

            if (variantId <= 0
                    || productId <= 0
                    || quantity < 1
                    || quantity > 10) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product, variant, or quantity.");
                return;
            }

            ProductVariant variant =
                    productVariantDAO.getVariantById(variantId);

            if (variant == null
                    || variant.getProductId() != productId) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product variant.");
                return;
            }

            if (quantity > variant.getStockQuantity()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Not enough stock available.");
                return;
            }

            boolean added = cartItemDAO.addCartItem(
                    cart.getCartId(),
                    variantId,
                    quantity);

            if (added) {

                // Read the return destination from product.jsp.
                String returnUrl =
                        request.getParameter("returnUrl");

                // Accept only the product listing or a numeric product ID.
                if (returnUrl == null
                        || !(returnUrl.equals("product")
                        || returnUrl.matches("product\\?id=\\d+"))) {

                    returnUrl = "product";
                }

                // Preserve an existing query parameter when necessary.
                String separator =
                        returnUrl.contains("?") ? "&" : "?";

                response.sendRedirect(
                        request.getContextPath()
                                + "/"
                                + returnUrl
                                + separator
                                + "added=true");

            } else {

                response.sendError(
                        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                        "Unable to add the product to the cart.");
            }

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart or product details.");

        } catch (SQLException e) {

            throw new ServletException(
                    "Unable to process the cart request.", e);

        } catch (IllegalArgumentException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    e.getMessage());
        }
    }
}