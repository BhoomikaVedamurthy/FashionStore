<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout | FashionStore</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            color: #333;
        }

        header {
            background: #222;
            color: white;
            padding: 20px 40px;
        }

        header a {
            color: white;
            text-decoration: none;
        }

        .container {
            max-width: 750px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
        }

        h2 {
            margin-top: 0;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        button {
            width: 100%;
            padding: 14px;
            background: #222;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #444;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #333;
            text-decoration: none;
        }

        .error {
            color: #c62828;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<header>
    <h2>
        <a href="${pageContext.request.contextPath}/home">
            FashionStore
        </a>
    </h2>
</header>

<div class="container">

    <h2>Checkout</h2>
    <p>Enter your delivery details to continue.</p>

    <c:if test="${not empty error}">
        <p class="error">
            <c:out value="${error}"/>
        </p>
    </c:if>

    <form action="${pageContext.request.contextPath}/checkout"
          method="post">

        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text"
                   id="fullName"
                   name="fullName"
                   required
                   maxlength="100">
        </div>

        <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel"
                   id="phone"
                   name="phone"
                   required
                   pattern="[0-9]{10}"
                   maxlength="10"
                   title="Enter a 10-digit phone number">
        </div>

        <div class="form-group">
            <label for="address">Delivery Address</label>
            <textarea id="address"
                      name="address"
                      required
                      maxlength="500"></textarea>
        </div>

        <div class="form-group">
            <label for="city">City</label>
            <input type="text"
                   id="city"
                   name="city"
                   required
                   maxlength="100">
        </div>

        <div class="form-group">
            <label for="state">State</label>
            <input type="text"
                   id="state"
                   name="state"
                   required
                   maxlength="100">
        </div>

        <div class="form-group">
            <label for="pincode">PIN Code</label>
            <input type="text"
                   id="pincode"
                   name="pincode"
                   required
                   pattern="[0-9]{6}"
                   maxlength="6"
                   title="Enter a 6-digit PIN code">
        </div>

        <button type="submit">Place Order</button>

    </form>

    <a class="back-link"
       href="${pageContext.request.contextPath}/cart">
        &larr; Back to Cart
    </a>

</div>

</body>
</html>