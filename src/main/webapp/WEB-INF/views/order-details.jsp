<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.fashionstore.model.Product" %>
<%@ page import="com.fashionstore.model.ProductVariant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
            font-family: Arial, sans-serif;
            background: #f8f7f5;
            color: #292929;
        }

        header {
            background: #292929;
            padding: 18px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        header a {
            color: white;
            text-decoration: none;
            margin-right: 18px;
        }

        .brand {
            font-size: 24px;
            font-weight: bold;
        }

        .container {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        h1 {
            margin-bottom: 25px;
            text-align: center;
        }

        .search-form {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 30px;
        }

        .search-form input {
            width: 65%;
            max-width: 450px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button, .btn {
            display: inline-block;
            border: none;
            background: #292929;
            color: white;
            padding: 11px 16px;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }

        button:hover, .btn:hover {
            background: #b12745;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 24px;
        }

        .product-card {
            background: white;
            border-radius: 9px;
            padding: 18px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.07);
        }

        .product-card img {
            width: 100%;
            height: 230px;
            object-fit: contain;
            background: #f8f7f5;
            border-radius: 6px;
        }

        .product-card h3 {
            margin: 15px 0 8px;
        }

        .price {
            color: #b12745;
            font-weight: bold;
            font-size: 18px;
        }

        .empty {
            text-align: center;
            padding: 35px;
            background: white;
            border-radius: 8px;
        }

        .product-detail {
            max-width: 850px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 30px;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }

        .product-detail img {
            width: 100%;
            max-height: 400px;
            object-fit: contain;
        }

        .product-detail select,
        .product-detail input {
            padding: 10px;
            margin: 8px 0 16px;
            width: 100%;
        }

        @media (max-width: 600px) {
            .product-detail {
                grid-template-columns: 1fr;
            }

            header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>

<body>

<header>
    <a class="brand" href="${pageContext.request.contextPath}/home">
        FashionStore
    </a>

    <nav>
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/product">Products</a>
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
        <a href="${pageContext.request.contextPath}/my-orders">My Orders</a>
    </nav>
</header>

<div class="container">

    <%
        Product product = (Product) request.getAttribute("product");

        if (product != null) {
            List<ProductVariant> variants =
                (List<ProductVariant>) request.getAttribute("variants");
    %>

        <h1>Product Details</h1>

        <div class="product-detail">

            <div>
                <img
                    src="<c:out value='${product.imageUrl}'/>"
                    alt="<c:out value='${product.productName}'/>"
                    onerror="this.style.display='none';">
            </div>

            <div>
                <h2><c:out value="${product.productName}"/></h2>

                <p>
                    Brand:
                    <c:out value="${product.brand}"/>
                </p>

                <p>
                    <c:out value="${product.description}"/>
                </p>

                <p class="price">
                    ₹<c:out value="${product.price}"/>
                </p>

                <form action="${pageContext.request.contextPath}/cart"
                      method="post">

                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId"
                           value="<%= product.getProductId() %>">

                    <label for="variantId">Select Size:</label>

                    <select name="variantId" id="variantId" required>
                        <option value="">Choose a size</option>

                        <% if (variants != null) {
                            for (ProductVariant variant : variants) { %>

                                <option value="<%= variant.getVariantId() %>">
                                    <%= variant.getSize() %>
                                </option>

                        <%  }
                           } %>
                    </select>

                    <label for="quantity">Quantity:</label>
                    <input type="number" id="quantity" name="quantity"
                           value="1" min="1" required>

                    <button type="submit">Add to Cart</button>
                </form>

                <p>
                    <a class="btn"
                       href="${pageContext.request.contextPath}/product">
                        Back to Products
                    </a>
                </p>
            </div>

        </div>

    <%
        } else {
            List<Product> products =
                (List<Product>) request.getAttribute("products");

            Map<Integer, List<ProductVariant>> variantsMap =
                (Map<Integer, List<ProductVariant>>)
                    request.getAttribute("variantsMap");
    %>

        <h1>Our Products</h1>

        <form class="search-form"
              action="${pageContext.request.contextPath}/product"
              method="get">

            <input type="text" name="search"
                   placeholder="Search for products...">

            <button type="submit">Search</button>
        </form>

        <% if (products != null && !products.isEmpty()) { %>

            <div class="product-grid">

                <% for (Product p : products) {
                    if (p != null && p.isActive()) { %>

                    <div class="product-card">

                        <a href="${pageContext.request.contextPath}/product?id=<%= p.getProductId() %>">
                            <img
                                src="<c:out value='${p.imageUrl}'/>"
                                alt="<c:out value='${p.productName}'/>"
                                onerror="this.style.display='none';">
                        </a>

                        <h3>
                            <c:out value="<%= p.getProductName() %>"/>
                        </h3>

                        <p>
                            Brand:
                            <c:out value="<%= p.getBrand() %>"/>
                        </p>

                        <p class="price">
                            ₹<%= p.getPrice() %>
                        </p>

                        <a class="btn"
                           href="${pageContext.request.contextPath}/product?id=<%= p.getProductId() %>">
                            View Details
                        </a>

                    </div>

                <%  }
                   } %>

            </div>

        <% } else { %>

            <div class="empty">
                <h2>No products found</h2>
                <p>Try searching for another product.</p>
                <a class="btn"
                   href="${pageContext.request.contextPath}/product">
                    View All Products
                </a>
            </div>

        <% } %>

    <% } %>

</div>

</body>
</html>