<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FashionStore | Style. Quality. You.</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/font.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/home.css">

    <style>
        .logout-link {
            display: inline-block;
            padding: 10px 18px;
            margin-left: 20px;
            background-color: #222;
            color: #fff !important;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            position: relative;
            z-index: 100;
        }

        .logout-link:hover {
            background-color: #444;
        }

        .logout-message {
            text-align: center;
            padding: 12px;
            color: green;
            font-weight: bold;
        }

        /* Expandable Search */
        .navbar-search-container {
            position: relative;
            display: inline-flex;
            align-items: center;
            z-index: 9999;
        }

        .search-toggle {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 5px;
            background: transparent;
            border: none;
            color: inherit;
            font-size: 25px;
            line-height: 1;
            cursor: pointer;
        }

        .search-toggle:hover {
            opacity: 0.65;
        }

        .navbar-search-form {
            display: none;
            position: absolute;
            top: calc(100% + 10px);
            right: 0;
            align-items: center;
            gap: 8px;
            width: max-content;
            max-width: 95vw;
            padding: 10px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            z-index: 10000;
        }

        .navbar-search-form.active {
            display: flex;
        }

        .navbar-search-form input {
            width: 220px;
            max-width: 55vw;
            min-width: 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            outline: none;
            font: inherit;
            font-size: 14px;
        }

        .navbar-search-form input:focus {
            border-color: #222;
        }

        .navbar-search-submit {
            padding: 10px 14px;
            background: #222;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
            white-space: nowrap;
        }

        .navbar-search-submit:hover {
            background: #444;
        }

        @media (max-width: 650px) {
            .navbar-search-form input {
                width: 155px;
                max-width: 45vw;
            }

            .navbar-search-form {
                right: -5px;
            }

            .navbar-search-submit {
                padding: 10px;
            }

            .logout-link {
                margin-left: 5px;
                padding: 8px 10px;
                font-size: 12px;
            }
        }
    </style>
</head>

<body>

    <!-- Announcement Bar -->
    <div class="announcement-bar">
        Free Shipping on orders above ₹999 &nbsp; | &nbsp;
        Easy Returns &nbsp; | &nbsp; Secure Payments
    </div>

    <!-- Navigation -->
    <header class="main-header">

        <a href="${pageContext.request.contextPath}/home"
           class="brand">
            FashionStore
        </a>

        <nav class="main-nav">

            <a href="${pageContext.request.contextPath}/home">
                Home
            </a>

            <a href="${pageContext.request.contextPath}/product">
                Shop
            </a>

            <a href="${pageContext.request.contextPath}/product?category=2">
                Women
            </a>

            <a href="${pageContext.request.contextPath}/product?category=1">
                Men
            </a>

            <a href="${pageContext.request.contextPath}/product?category=5">
                Accessories
            </a>

            <a href="#footer">
                About
            </a>

        </nav>

        <div class="header-actions">

            <!-- Expandable Search -->
            <div class="navbar-search-container">

                <button type="button"
                        id="searchToggle"
                        class="search-toggle"
                        aria-label="Open search"
                        aria-expanded="false"
                        aria-controls="navbarSearchForm">
                    ⌕
                </button>

                <form action="${pageContext.request.contextPath}/product"
                      method="get"
                      id="navbarSearchForm"
                      class="navbar-search-form">

                    <input type="text"
                           name="search"
                           id="navbarSearchInput"
                           placeholder="Search products..."
                           aria-label="Search products"
                           required>

                    <button type="submit"
                            class="navbar-search-submit">
                        Search
                    </button>

                </form>

            </div>

            <!-- Account -->
            <a href="${pageContext.request.contextPath}/login"
               aria-label="My account">
                ♙
            </a>

            <!-- Shopping Bag -->
            <a href="${pageContext.request.contextPath}/cart"
               aria-label="Shopping bag">
                ♧
            </a>

        </div>

        <!-- Logout -->
        <a href="${pageContext.request.contextPath}/logout"
           class="logout-link">
            Logout
        </a>

    </header>

    <!-- Logout Success Message -->
    <% if ("success".equals(request.getParameter("logout"))) { %>

        <p class="logout-message">
            You have been logged out successfully.
        </p>

    <% } %>

    <!-- Hero Section -->
    <main>

        <section class="home-hero">

            <div class="hero-content">

                <p class="eyebrow">
                    NEW SEASON &nbsp; / &nbsp; NEW STYLE
                </p>

                <h1>
                    Style That<br>
                    Speaks For You
                </h1>

                <p class="hero-description">
                    Discover the latest trends and find your perfect style.
                </p>

                <a href="#collections" class="primary-button">
                    EXPLORE COLLECTION <span>→</span>
                </a>

            </div>

            <div class="hero-note">
                Fashion<br>
                is a form of<br>
                self-expression.
            </div>

        </section>

        <!-- Categories -->
        <section class="content-section" id="collections">

            <div class="section-heading">

                <div>
                    <p class="eyebrow">SHOP BY CATEGORY</p>
                    <h2>Explore Our Collections</h2>
                </div>

                <a href="${pageContext.request.contextPath}/product"
                   class="view-all">
                    View All →
                </a>

            </div>

            <div class="category-grid">

                <!-- Women -->
                <a href="${pageContext.request.contextPath}/product?category=2"
                   class="category-card women-card">

                    <div class="category-info">
                        <h3>Women</h3>
                        <span>Shop Now →</span>
                    </div>

                </a>

                <!-- Men -->
                <a href="${pageContext.request.contextPath}/product?category=1"
                   class="category-card men-card">

                    <div class="category-info">
                        <h3>Men</h3>
                        <span>Shop Now →</span>
                    </div>

                </a>

                <!-- Accessories -->
                <a href="${pageContext.request.contextPath}/product?category=5"
                   class="category-card accessories-card">

                    <div class="category-info">
                        <h3>Accessories</h3>
                        <span>Shop Now →</span>
                    </div>

                </a>

                <!-- Footwear -->
                <a href="${pageContext.request.contextPath}/product?category=4"
                   class="category-card footwear-card">

                    <div class="category-info">
                        <h3>Footwear</h3>
                        <span>Shop Now →</span>
                    </div>

                </a>

            </div>

        </section>

        <!-- Products -->
        <section class="content-section products-section" id="products">

            <div class="section-heading">

                <div>
                    <p class="eyebrow">HANDPICKED FOR YOU</p>
                    <h2>Trending Now</h2>
                </div>

                <a href="${pageContext.request.contextPath}/product"
                   class="view-all">
                    View All →
                </a>

            </div>

            <div class="product-grid">

                <!-- Product 1 -->
                <article class="product-card">

                    <div class="product-image product-one">

                        <span class="discount-badge">-20%</span>

                        <button class="wishlist-button"
                                type="button"
                                aria-label="Add dress to wishlist">
                            ♡
                        </button>

                    </div>

                    <div class="product-details">

                        <h3>Elegant Black Dress</h3>

                        <p class="product-price">
                            ₹2,399 <del>₹2,999</del>
                        </p>

                        <a class="add-cart"
                           href="${pageContext.request.contextPath}/product">
                            SHOP NOW
                        </a>

                    </div>

                </article>

                <!-- Product 2 -->
                <article class="product-card">

                    <div class="product-image product-two">

                        <span class="discount-badge">-15%</span>

                        <button class="wishlist-button"
                                type="button"
                                aria-label="Add shirt to wishlist">
                            ♡
                        </button>

                    </div>

                    <div class="product-details">

                        <h3>Classic Linen Shirt</h3>

                        <p class="product-price">
                            ₹1,699 <del>₹1,999</del>
                        </p>

                        <a class="add-cart"
                           href="${pageContext.request.contextPath}/product">
                            SHOP NOW
                        </a>

                    </div>

                </article>

                <!-- Product 3 -->
                <article class="product-card">

                    <div class="product-image product-three">

                        <span class="discount-badge">-10%</span>

                        <button class="wishlist-button"
                                type="button"
                                aria-label="Add dress to wishlist">
                            ♡
                        </button>

                    </div>

                    <div class="product-details">

                        <h3>Floral Midi Dress</h3>

                        <p class="product-price">
                            ₹2,249 <del>₹2,499</del>
                        </p>

                        <a class="add-cart"
                           href="${pageContext.request.contextPath}/product">
                            SHOP NOW
                        </a>

                    </div>

                </article>

                <!-- Product 4 -->
                <article class="product-card">

                    <div class="product-image product-four">

                        <span class="discount-badge">-18%</span>

                        <button class="wishlist-button"
                                type="button"
                                aria-label="Add sneakers to wishlist">
                            ♡
                        </button>

                    </div>

                    <div class="product-details">

                        <h3>Classic Sneakers</h3>

                        <p class="product-price">
                            ₹2,049 <del>₹2,499</del>
                        </p>

                        <a class="add-cart"
                           href="${pageContext.request.contextPath}/product">
                            SHOP NOW
                        </a>

                    </div>

                </article>

                <!-- Product 5 -->
                <article class="product-card">

                    <div class="product-image product-five">

                        <span class="discount-badge">-12%</span>

                        <button class="wishlist-button"
                                type="button"
                                aria-label="Add handbag to wishlist">
                            ♡
                        </button>

                    </div>

                    <div class="product-details">

                        <h3>Leather Handbag</h3>

                        <p class="product-price">
                            ₹3,499 <del>₹3,999</del>
                        </p>

                        <a class="add-cart"
                           href="${pageContext.request.contextPath}/product?id=1">
                            SHOP NOW
                        </a>

                    </div>

                </article>

            </div>

        </section>

        <!-- Promotional Banners -->
        <section class="promo-grid">

            <!-- Women Promotion -->
            <div class="promo-panel promo-women">

                <p class="eyebrow">YOUR STYLE, YOUR STORY</p>

                <h2>
                    Look Good.<br>
                    Feel Better.
                </h2>

                <p>
                    Because confidence is the best outfit.
                </p>

                <a href="${pageContext.request.contextPath}/product?category=2"
                   class="light-button">
                    SHOP WOMEN →
                </a>

            </div>

            <!-- Accessories Promotion -->
            <div class="promo-panel promo-accessories">

                <p class="eyebrow">THE FINISHING TOUCH</p>

                <h2>
                    Timeless<br>
                    Accessories
                </h2>

                <p>
                    Little details. Big impact.
                </p>

                <a href="${pageContext.request.contextPath}/product?category=5"
                   class="light-button">
                    SHOP ACCESSORIES →
                </a>

            </div>

        </section>

        <!-- Service Benefits -->
        <section class="benefits-section">

            <div class="benefit">
                <span class="benefit-icon">♧</span>
                <h3>Free Shipping</h3>
                <p>On orders above ₹999</p>
            </div>

            <div class="benefit">
                <span class="benefit-icon">♢</span>
                <h3>Secure Payments</h3>
                <p>100% secure checkout</p>
            </div>

            <div class="benefit">
                <span class="benefit-icon">↶</span>
                <h3>Easy Returns</h3>
                <p>Hassle-free within 7 days</p>
            </div>

            <div class="benefit">
                <span class="benefit-icon">♧</span>
                <h3>24/7 Support</h3>
                <p>We're here to help</p>
            </div>

        </section>

    </main>

    <!-- Footer -->
    <footer class="site-footer" id="footer">

        <div class="footer-grid">

            <!-- Footer Brand -->
            <div class="footer-brand">

                <a href="${pageContext.request.contextPath}/home"
                   class="brand">
                    FashionStore
                </a>

                <p>
                    Style &nbsp; · &nbsp; Quality &nbsp; · &nbsp; You
                </p>

            </div>

            <!-- Quick Links -->
            <div class="footer-links">

                <h3>Quick Links</h3>

                <a href="${pageContext.request.contextPath}/home">
                    Home
                </a>

                <a href="${pageContext.request.contextPath}/product">
                    Shop
                </a>

                <a href="#footer">
                    About Us
                </a>

                <a href="#footer">
                    Contact
                </a>

            </div>

            <!-- Categories -->
            <div class="footer-links">

                <h3>Categories</h3>

                <a href="${pageContext.request.contextPath}/product?category=2">
                    Women
                </a>

                <a href="${pageContext.request.contextPath}/product?category=1">
                    Men
                </a>

                <a href="${pageContext.request.contextPath}/product?category=5">
                    Accessories
                </a>

                <a href="${pageContext.request.contextPath}/product?category=4">
                    Footwear
                </a>

            </div>

            <!-- Newsletter -->
            <div class="newsletter">

                <h3>Join Our Newsletter</h3>

                <p>
                    Get updates on new arrivals and special offers.
                </p>

                <form action="#"
                      method="get"
                      class="newsletter-form">

                    <label class="visually-hidden"
                           for="newsletter-email">
                        Email address
                    </label>

                    <input id="newsletter-email"
                           name="email"
                           type="email"
                           placeholder="Enter your email address"
                           required>

                    <button type="submit" aria-label="Subscribe">
                        →
                    </button>

                </form>

            </div>

        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">

            <p>
                © 2026 FashionStore. All rights reserved.
            </p>

            <p>
                Designed with ♡ for fashion lovers
            </p>

        </div>

    </footer>

    <!-- Expandable Search JavaScript -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {

            const toggle = document.getElementById("searchToggle");
            const form = document.getElementById("navbarSearchForm");
            const input = document.getElementById("navbarSearchInput");

            if (!toggle || !form || !input) {
                console.error("Search elements were not found.");
                return;
            }

            toggle.addEventListener("click", function (event) {

                event.preventDefault();

                const isOpen = form.classList.toggle("active");

                toggle.setAttribute("aria-expanded", String(isOpen));

                if (isOpen) {
                    input.focus();
                }

            });

            form.addEventListener("submit", function (event) {

                if (!input.value.trim()) {
                    event.preventDefault();
                    input.focus();
                }

            });

            document.addEventListener("click", function (event) {

                if (!event.target.closest(".navbar-search-container")) {

                    form.classList.remove("active");

                    toggle.setAttribute("aria-expanded", "false");

                }

            });

            document.addEventListener("keydown", function (event) {

                if (event.key === "Escape") {

                    form.classList.remove("active");

                    toggle.setAttribute("aria-expanded", "false");

                }

            });

        });
    </script>

</body>
</html>