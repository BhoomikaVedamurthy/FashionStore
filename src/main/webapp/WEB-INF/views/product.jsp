<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - FashionStore</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 35px 5%;
            font-family: Arial, sans-serif;
            background-color: #f8f7f5;
            color: #292929;
        }

        h1 {
            text-align: center;
            font-size: 34px;
            margin-bottom: 35px;
            color: #222;
            letter-spacing: 1px;
        }

        /* =========================
           ALL PRODUCTS GRID
           ========================= */

        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 28px;
            max-width: 1250px;
            margin: 30px auto;
        }

        .product-card {
            background-color: #fff;
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 22px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.09);
        }

        .product-card img {
            width: 100%;
            height: 250px;
            object-fit: contain;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .product-card h2 {
            font-size: 21px;
            margin: 12px 0;
            color: #222;
        }

        .product-card p {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
        }

        .price {
            font-size: 23px !important;
            font-weight: bold;
            color: #b12745 !important;
            margin: 18px 0;
        }

        .product-card form {
            margin-top: 20px;
        }

        /* =========================
           FORM ELEMENTS
           ========================= */

        label {
            display: block;
            margin-top: 15px;
            font-size: 14px;
            font-weight: bold;
            text-align: left;
        }

        select,
        input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-top: 7px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background-color: #fff;
            font-size: 14px;
            outline: none;
        }

        select:focus,
        input[type="number"]:focus {
            border-color: #b12745;
        }

        button {
            display: block;
            width: 100%;
            margin: 20px auto 12px;
            padding: 13px;
            background-color: #292929;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.25s ease;
        }

        button:hover {
            background-color: #b12745;
        }

        /* =========================
           LINKS
           ========================= */

        .back-link {
            display: inline-block;
            margin-top: 15px;
            color: #444;
            text-decoration: none;
            font-size: 14px;
        }

        .back-link:hover {
            color: #b12745;
            text-decoration: underline;
        }

        /* =========================
           SUCCESS MESSAGE
           ========================= */

        .success-message {
            text-align: center;
            color: #218838;
            background-color: #eaf7ed;
            border: 1px solid #c8e6ce;
            border-radius: 6px;
            padding: 14px;
            margin: 20px auto;
            max-width: 500px;
        }

        /* =========================
           EMPTY PRODUCT MESSAGE
           ========================= */

        .message {
            text-align: center;
            margin: 60px auto;
        }

        .message a {
            display: inline-block;
            margin-top: 15px;
            color: #b12745;
            text-decoration: none;
        }

        .message a:hover {
            text-decoration: underline;
        }

        /* =========================
           INDIVIDUAL PRODUCT DETAILS
           ========================= */

        .product-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            max-width: 1100px;
            margin: 35px auto;
            padding: 35px;
            background-color: #fff;
            border-radius: 14px;
            box-shadow: 0 5px 25px rgba(0, 0, 0, 0.06);
        }

        .product-details-image {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 400px;
            background-color: #f8f7f5;
            border-radius: 10px;
            padding: 25px;
        }

        .product-details-image img {
            display: block;
            width: 100%;
            max-width: 430px;
            height: 420px;
            object-fit: contain;
        }

        .product-details-info {
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-width: 0;
        }

        .product-details-info h2 {
            font-size: 30px;
            line-height: 1.3;
            margin: 8px 0 15px;
            color: #222;
        }

        .details-brand {
            color: #888;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 5px;
        }

        .details-description {
            color: #666;
            line-height: 1.8;
            font-size: 15px;
        }

        .details-price {
            font-size: 30px;
            font-weight: bold;
            color: #b12745;
            margin: 20px 0 5px;
        }

        .details-note {
            color: #777;
            font-size: 12px;
            margin-bottom: 15px;
        }

        .product-details-info form {
            margin-top: 10px;
        }

        .product-details-info select,
        .product-details-info input[type="number"] {
            width: 100%;
        }

        .details-cart-button {
            background-color: #b12745;
            margin-top: 25px;
            padding: 15px;
            font-size: 16px;
        }

        .details-cart-button:hover {
            background-color: #891c35;
        }

        .product-details-links {
            display: flex;
            justify-content: space-between;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .product-details-links a {
            color: #444;
            text-decoration: none;
            font-size: 14px;
        }

        .product-details-links a:hover {
            color: #b12745;
            text-decoration: underline;
        }

        /* =========================
           BOTTOM NAVIGATION
           ========================= */

        .navigation {
            text-align: center;
            margin-top: 40px;
            padding: 20px 0;
            border-top: 1px solid #e5e5e5;
        }

        .navigation .back-link {
            margin: 8px 12px;
        }

        /* =========================
           RESPONSIVE DESIGN
           ========================= */

        @media (max-width: 750px) {
            .product-details {
                grid-template-columns: 1fr;
                gap: 25px;
                padding: 20px;
            }

            .product-details-image {
                min-height: 280px;
            }

            .product-details-image img {
                height: 280px;
            }

            .product-details-info h2 {
                font-size: 25px;
            }

            .details-price {
                font-size: 26px;
            }
        }

        @media (max-width: 600px) {
            body {
                padding: 25px 15px;
            }

            h1 {
                font-size: 27px;
            }

            .product-container {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .product-card img {
                height: 220px;
            }

            .navigation .back-link {
                margin: 8px;
            }

            .product-details-links {
                flex-direction: column;
                gap: 12px;
            }
        }
    </style>
</head>

<body>

    <%-- PAGE HEADING --%>

    <h1>
        <c:choose>
            <c:when test="${not empty products}">
                All Products
            </c:when>
            <c:otherwise>
                Product Details
            </c:otherwise>
        </c:choose>
    </h1>


    <%-- SUCCESS MESSAGE --%>

    <c:if test="${param.added eq 'true'}">
        <p class="success-message">
            Product added to cart successfully!
        </p>
    </c:if>


    <c:choose>

        <%-- ALL PRODUCTS MODE: /product --%>

        <c:when test="${not empty products}">

            <div class="product-container">

                <c:forEach var="p" items="${products}">

                    <c:if test="${p.active}">

                        <div class="product-card">

                            <%-- PRODUCT IMAGE --%>

                            <c:if test="${not empty p.imageUrl}">
                                <img
                                    src="<c:out value='${p.imageUrl}'/>"
                                    alt="<c:out value='${p.productName}'/>"
                                    onerror="this.style.display='none';">
                            </c:if>


                            <%-- PRODUCT NAME --%>

                            <h2>
                                <c:out value="${p.productName}"/>
                            </h2>


                            <%-- BRAND --%>

                            <p>
                                Brand:
                                <c:out value="${p.brand}"/>
                            </p>


                            <%-- DESCRIPTION --%>

                            <p>
                                <c:out value="${p.description}"/>
                            </p>


                            <%-- PRICE --%>

                            <p class="price">
                                ₹<c:out value="${p.price}"/>
                            </p>


                            <%-- ADD TO CART FORM --%>

                            <form
                                action="${pageContext.request.contextPath}/cart"
                                method="post">

                                <input
                                    type="hidden"
                                    name="productId"
                                    value="${p.productId}">

                                <input
                                    type="hidden"
                                    name="returnUrl"
                                    value="product">


                                <%-- SIZE SELECTION --%>

                                <label for="variant-${p.productId}">
                                    Select Size:
                                </label>

                                <select
                                    name="variantId"
                                    id="variant-${p.productId}"
                                    required>

                                    <c:forEach
                                        var="variant"
                                        items="${variantsMap[p.productId]}">

                                        <c:if test="${variant.stockQuantity > 0}">
                                            <option value="${variant.variantId}">
                                                <c:out value="${variant.size}"/>
                                                - Stock: ${variant.stockQuantity}
                                            </option>
                                        </c:if>

                                    </c:forEach>

                                </select>


                                <%-- QUANTITY --%>

                                <label for="quantity-${p.productId}">
                                    Quantity:
                                </label>

                                <input
                                    type="number"
                                    name="quantity"
                                    id="quantity-${p.productId}"
                                    value="1"
                                    min="1"
                                    max="10"
                                    required>


                                <%-- SUBMIT BUTTON --%>

                                <button type="submit">
                                    Add to Cart
                                </button>

                            </form>


                            <%-- VIEW PRODUCT DETAILS --%>

                            <a
                                href="${pageContext.request.contextPath}/product?id=${p.productId}"
                                class="back-link">
                                View Details
                            </a>

                        </div>

                    </c:if>

                </c:forEach>

            </div>

        </c:when>


        <%-- SINGLE PRODUCT MODE: /product?id=1 --%>

        <c:when test="${not empty product}">

            <div class="product-details">

                <%-- PRODUCT IMAGE --%>

                <div class="product-details-image">

                    <c:if test="${not empty product.imageUrl}">
                        <img
                            src="<c:out value='${product.imageUrl}'/>"
                            alt="<c:out value='${product.productName}'/>"
                            onerror="this.style.display='none';">
                    </c:if>

                </div>


                <%-- PRODUCT INFORMATION --%>

                <div class="product-details-info">

                    <%-- BRAND --%>

                    <p class="details-brand">
                        <c:out value="${product.brand}"/>
                    </p>


                    <%-- PRODUCT NAME --%>

                    <h2>
                        <c:out value="${product.productName}"/>
                    </h2>


                    <%-- DESCRIPTION --%>

                    <p class="details-description">
                        <c:out value="${product.description}"/>
                    </p>


                    <%-- PRICE --%>

                    <p class="details-price">
                        ₹<c:out value="${product.price}"/>
                    </p>


                    <%-- TAX INFORMATION --%>

                    <p class="details-note">
                        Inclusive of all applicable taxes
                    </p>


                    <%-- ADD TO CART FORM --%>

                    <form
                        action="${pageContext.request.contextPath}/cart"
                        method="post">

                        <input
                            type="hidden"
                            name="productId"
                            value="${product.productId}">

                        <input
                            type="hidden"
                            name="returnUrl"
                            value="product?id=${product.productId}">


                        <%-- SIZE SELECTION --%>

                        <label for="single-variant">
                            Select Size
                        </label>

                        <select
                            name="variantId"
                            id="single-variant"
                            required>

                            <c:forEach var="variant" items="${variants}">

                                <c:if test="${variant.stockQuantity > 0}">
                                    <option value="${variant.variantId}">
                                        <c:out value="${variant.size}"/>
                                        - Stock: ${variant.stockQuantity}
                                    </option>
                                </c:if>

                            </c:forEach>

                        </select>


                        <%-- QUANTITY --%>

                        <label for="single-quantity">
                            Quantity
                        </label>

                        <input
                            type="number"
                            name="quantity"
                            id="single-quantity"
                            value="1"
                            min="1"
                            max="10"
                            required>


                        <%-- ADD TO CART BUTTON --%>

                        <button
                            type="submit"
                            class="details-cart-button">
                            Add to Cart
                        </button>

                    </form>


                    <%-- PRODUCT NAVIGATION --%>

                    <div class="product-details-links">

                        <a href="${pageContext.request.contextPath}/product">
                            &larr; Continue Shopping
                        </a>

                        <a href="${pageContext.request.contextPath}/cart">
                            View Cart &rarr;
                        </a>

                    </div>

                </div>

            </div>

        </c:when>


        <%-- NO PRODUCTS FOUND --%>

        <c:otherwise>

            <div class="message">
                <p>No products are available.</p>

                <a href="${pageContext.request.contextPath}/home">
                    Return Home
                </a>
            </div>

        </c:otherwise>

    </c:choose>


    <%-- BOTTOM NAVIGATION --%>

    <div class="navigation">

        <a
            href="${pageContext.request.contextPath}/home"
            class="back-link">
            Back to Home
        </a>

        &nbsp; | &nbsp;

        <a
            href="${pageContext.request.contextPath}/product"
            class="back-link">
            All Products
        </a>

        &nbsp; | &nbsp;

        <a
            href="${pageContext.request.contextPath}/cart"
            class="back-link">
            View Cart
        </a>

    </div>

</body>
</html>