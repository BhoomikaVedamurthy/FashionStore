package com.fashionstore.controller;

import java.io.IOException;
import java.math.BigDecimal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/order-success")
public class OrderSuccessServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Object orderId = session.getAttribute("lastOrderId");
        Object total = session.getAttribute("lastOrderTotal");

        if (!(orderId instanceof Integer)
                || !(total instanceof BigDecimal)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.setAttribute("orderId", orderId);
        request.setAttribute("totalAmount", total);

        // Prevent refreshing the page from repeating the previous POST.
        session.removeAttribute("lastOrderId");
        session.removeAttribute("lastOrderTotal");

        request.getRequestDispatcher(
                "/WEB-INF/views/order-success.jsp"
        ).forward(request, response);
    }
}