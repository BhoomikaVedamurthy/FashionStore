<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - FashionStore</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #ffffff;
            color: #333333;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #dddddd;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .empty-cart {
            text-align: center;
            margin-top: 30px;
        }

        .continue-shopping {
            display: inline-block;
            margin: 10px;
            text-decoration: none;
            color: white;
            background-color: #333333;
            padding: 10px 18px;
            border-radius: 4px;
        }

        .continue-shopping:hover {
            background-color: #555555;
        }

        .quantity-form {
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-form button {
            padding: 5px 10px;
            cursor: pointer;
        }

        .quantity-form button:disabled {
            cursor: not-allowed;
            opacity: 0.5;
        }

        .remove-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            border-radius: 4px;
        }

        .remove-button:hover {
            background-color: #b02a37;
        }

        .cart-total {
            text-align: right;
            margin-top: 25px;
            font-size: 22px;
            font-weight: bold;
        }

        .cart-actions {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>

<body>

    <h1>Your Shopping Cart</h1>

    <c:choose>

        <%-- Display when the cart is empty --%>
        <c:when test="${empty cartItems}">

            <div class="empty-cart">
                <p>Your cart is empty.</p>

                <a href="${pageContext.request.contextPath}/home"
                   class="continue-shopping">
                    Continue Shopping
                </a>
            </div>

        </c:when>

        <%-- Display cart items --%>
        <c:otherwise>

            <table>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Size</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="item" items="${cartItems}">

                        <tr>

                            <%-- Product name --%>
                            <td>
                                <c:out value="${item.productName}"/>
                            </td>

                            <%-- Selected size --%>
                            <td>
                                <c:out value="${item.size}"/>
                            </td>

                            <%-- Price per item --%>
                            <td>
                                ₹<fmt:formatNumber
                                    value="${item.price}"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>
                            </td>

                            <%-- Quantity controls --%>
                            <td>

                                <form action="${pageContext.request.contextPath}/cart"
                                      method="post"
                                      class="quantity-form">

                                    <input type="hidden"
                                           name="action"
                                           value="update">

                                    <input type="hidden"
                                           name="cartItemId"
                                           value="${item.cartItemId}">

                                    <button type="submit"
                                            name="quantity"
                                            value="${item.quantity - 1}"
                                            <c:if test="${item.quantity <= 1}">
                                                disabled
                                            </c:if>>
                                        −
                                    </button>

                                    <span>
                                        <c:out value="${item.quantity}"/>
                                    </span>

                                    <button type="submit"
                                            name="quantity"
                                            value="${item.quantity + 1}"
                                            <c:if test="${item.quantity >= 10}">
                                                disabled
                                            </c:if>>
                                        +
                                    </button>

                                </form>

                            </td>

                            <%-- Subtotal --%>
                            <td>
                                ₹<fmt:formatNumber
                                    value="${item.price * item.quantity}"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>
                            </td>

                            <%-- Remove item --%>
                            <td>

                                <form action="${pageContext.request.contextPath}/cart"
                                      method="post">

                                    <input type="hidden"
                                           name="action"
                                           value="remove">

                                    <input type="hidden"
                                           name="cartItemId"
                                           value="${item.cartItemId}">

                                    <button type="submit"
                                            class="remove-button"
                                            onclick="return confirm('Remove this item from your cart?');">
                                        Remove
                                    </button>

                                </form>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>
            </table>

            <%-- Calculate total cart amount --%>
            <c:set var="totalAmount" value="${0}"/>

            <c:forEach var="item" items="${cartItems}">
                <c:set var="totalAmount"
                       value="${totalAmount + (item.price * item.quantity)}"/>
            </c:forEach>

            <%-- Display total --%>
            <div class="cart-total">
                Total Amount:
                ₹<fmt:formatNumber
                    value="${totalAmount}"
                    minFractionDigits="2"
                    maxFractionDigits="2"/>
            </div>

            <%-- Cart actions --%>
            <div class="cart-actions">

                <a href="${pageContext.request.contextPath}/home"
                   class="continue-shopping">
                    Continue Shopping
                </a>

                <a href="${pageContext.request.contextPath}/checkout"
                   class="continue-shopping">
                    Proceed to Checkout
                </a>

            </div>

        </c:otherwise>

    </c:choose>

</body>
</html>