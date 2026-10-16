package com.fashionstore.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.sql.Connection;
import com.fashionstore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.CartItemDAO;
import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.OrderItemDAO;

import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.CartItemDAOImpl;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.dao.impl.OrderItemDAOImpl;

import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final CartDAO cartDAO = new CartDAOImpl();
    private final CartItemDAO cartItemDAO = new CartItemDAOImpl();
    private final OrderDAO orderDAO = new OrderDAOImpl();
    private final OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

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
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (getLoggedInUserId(session) == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher(
                "/WEB-INF/views/checkout.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        if (isBlank(fullName)
                || phone == null || !phone.matches("[0-9]{10}")
                || isBlank(address)
                || isBlank(city)
                || isBlank(state)
                || pincode == null || !pincode.matches("[0-9]{6}")) {

            request.setAttribute("error",
                    "Please enter valid delivery details.");

            request.getRequestDispatcher(
                    "/WEB-INF/views/checkout.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                Cart cart = cartDAO.getCartByUserId(userId);

                if (cart == null) {
                    throw new SQLException("Your cart is empty.");
                }

                List<CartItem> cartItems =
                        cartItemDAO.getCartItems(cart.getCartId());

                if (cartItems == null || cartItems.isEmpty()) {
                    throw new SQLException("Your cart is empty.");
                }

                BigDecimal totalAmount = BigDecimal.ZERO;

                for (CartItem cartItem : cartItems) {
                    BigDecimal itemTotal = cartItem.getPrice().multiply(
                            BigDecimal.valueOf(cartItem.getQuantity()));

                    totalAmount = totalAmount.add(itemTotal);
                }

                Order order = new Order();
                order.setUserId(userId);
                order.setTotalAmount(totalAmount);
                order.setPaymentMethod("COD");
                order.setOrderStatus("PLACED");
                order.setDeliveryName(fullName.trim());
                order.setDeliveryPhone(phone.trim());
                order.setDeliveryAddressLine1(address.trim());
                order.setDeliveryAddressLine2("");
                order.setDeliveryCity(city.trim());
                order.setDeliveryState(state.trim());
                order.setDeliveryPincode(pincode.trim());
                order.setDeliveryCountry("India");

                if (!orderDAO.placeOrder(con, order)) {
                    throw new SQLException("Unable to create the order.");
                }

                for (CartItem cartItem : cartItems) {
                    OrderItem orderItem = new OrderItem();

                    orderItem.setOrderId(order.getOrderId());
                    orderItem.setVariantId(cartItem.getVariantId());
                    orderItem.setQuantity(cartItem.getQuantity());
                    orderItem.setPrice(cartItem.getPrice());

                    if (!orderItemDAO.addOrderItem(con, orderItem)) {
                        throw new SQLException(
                                "Failed to save an order item.");
                    }
                }

                if (!cartItemDAO.clearCart(con, cart.getCartId())) {
                    throw new SQLException("Unable to clear the cart.");
                }

                con.commit();

                session.setAttribute("lastOrderId", order.getOrderId());
                session.setAttribute("lastOrderTotal", totalAmount);

                response.sendRedirect(
                        request.getContextPath() + "/order-success");

            } catch (SQLException | RuntimeException e) {
                try {
                    con.rollback();
                } catch (SQLException rollbackError) {
                    e.addSuppressed(rollbackError);
                }

                throw e;
            }

        } catch (SQLException e) {
            throw new ServletException(
                    "An error occurred while placing your order.", e);
        }
    }
    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}