<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Order Successful | FashionStore</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f7f7f7;
            color: #333;
        }

        .success-container {
            max-width: 550px;
            margin: 80px auto;
            padding: 35px;
            background: white;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 18px rgba(0, 0, 0, 0.08);
        }

        .success-icon {
            width: 75px;
            height: 75px;
            margin: 0 auto 20px;
            border-radius: 50%;
            background: #e4f7e9;
            color: #218838;
            font-size: 42px;
            line-height: 75px;
        }

        h1 {
            color: #218838;
            margin-bottom: 12px;
        }

        .details {
            margin: 25px 0;
            padding: 18px;
            background: #f8f9fa;
            border-radius: 8px;
            line-height: 1.9;
        }

        .btn {
            display: inline-block;
            padding: 12px 22px;
            margin: 8px;
            border-radius: 6px;
            text-decoration: none;
            background: #222;
            color: white;
        }

        .btn:hover {
            background: #444;
        }
    </style>
</head>

<body>

    <div class="success-container">

        <div class="success-icon">&#10003;</div>

        <h1>Order Placed Successfully!</h1>

        <p>Thank you for shopping with FashionStore.</p>

        <div class="details">
            <p>
                <strong>Order ID:</strong>
                <c:out value="${orderId}" />
            </p>

            <p>
                <strong>Total Amount:</strong>
                ₹<c:out value="${totalAmount}" />
            </p>

            <p><strong>Payment Method:</strong> Cash on Delivery</p>
            <p><strong>Status:</strong> Placed</p>
        </div>

        <p>Your order has been recorded successfully.</p>

        <a class="btn" href="${pageContext.request.contextPath}/home">
            Continue Shopping
        </a>

    </div>

</body>
</html>