<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Order" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - FashionStore</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 30px;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .order-card {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .order-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .label {
            color: #666;
            font-size: 14px;
        }

        .value {
            font-weight: bold;
            margin-top: 5px;
        }

        .status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 15px;
            background-color: #e6f4ea;
            color: #137333;
            font-size: 13px;
        }

        .empty-message {
            text-align: center;
            background: white;
            padding: 40px 20px;
            border-radius: 8px;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background-color: #222;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #444;
        }

        @media (max-width: 600px) {
            body {
                padding: 15px;
            }

            .order-info {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="container">

    <h1>My Orders</h1>

    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");

        if (orders == null || orders.isEmpty()) {
    %>

        <div class="empty-message">
            <h2>No orders yet!</h2>
            <p>Your orders will appear here after you place an order.</p>
            <a href="<%= request.getContextPath() %>/home" class="btn">
                Continue Shopping
            </a>
        </div>

    <%
        } else {
            for (Order order : orders) {
    %>

        <div class="order-card">

            <h2>Order #<%= order.getOrderId() %></h2>

            <div class="order-info">

                <div>
                    <div class="label">Order Date</div>
                    <div class="value">
                        <%= order.getOrderDate() != null
                                ? order.getOrderDate()
                                : "Not available" %>
                    </div>
                    <a href="<%= request.getContextPath() %>/order-details?orderId=<%= order.getOrderId() %>"
   class="btn">
    View Details
</a>
                </div>

                <div>
                    <div class="label">Total Amount</div>
                    <div class="value">
                        ₹<%= order.getTotalAmount() %>
                    </div>
                </div>

                <div>
                    <div class="label">Payment Method</div>
                    <div class="value">
                        <%= order.getPaymentMethod() %>
                    </div>
                </div>

                <div>
                    <div class="label">Order Status</div>
                    <div class="value">
                        <span class="status">
                            <%= order.getOrderStatus() %>
                        </span>
                    </div>
                </div>

            </div>

        </div>

    <%
            }
        }
    %>

    <div style="text-align: center;">
        <a href="<%= request.getContextPath() %>/home" class="btn">
            Continue Shopping
        </a>
    </div>

</div>

</body>
</html>