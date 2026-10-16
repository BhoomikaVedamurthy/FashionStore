<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Announcement Bar -->
<div class="announcement-bar">
    <div class="announcement-message">
        FREE SHIPPING ON ORDERS ABOVE ₹999
    </div>

    <div class="announcement-links">
        <a href="${pageContext.request.contextPath}/order-success">
            TRACK ORDER
        </a>
        <span>|</span>
        <a href="mailto:support@fashionstore.com">
            CUSTOMER CARE
        </a>
    </div>
</div>

<!-- Main Navigation -->
<header class="site-header">
    <nav class="navbar">

        <!-- Left Navigation -->
        <div class="navbar-left">
            <a href="${pageContext.request.contextPath}/product?category=1">MEN</a>
            <a href="${pageContext.request.contextPath}/product?category=2">WOMEN</a>
            <a href="${pageContext.request.contextPath}/product?category=3">KIDS</a>
            <a href="${pageContext.request.contextPath}/product?category=4">FOOTWEAR</a>
            <a href="${pageContext.request.contextPath}/product?category=5">ACCESSORIES</a>
        </div>

        <!-- Brand Logo -->
        <div class="navbar-logo">
            <a href="${pageContext.request.contextPath}/home">
                FASHIONSTORE
            </a>
        </div>

        <!-- Right Navigation -->
        <div class="navbar-right">

            <!-- Expandable Search -->
<div class="navbar-search-container">

    <!-- Search Icon -->
    <button type="button"
            id="searchToggle"
            class="navbar-action search-toggle"
            aria-label="Open search"
            aria-expanded="false">

        <span class="navbar-icon">&#128269;</span>
        <span class="navbar-label">SEARCH</span>

    </button>

    <!-- Search Form -->
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

        <button type="submit" class="navbar-search-submit">
            Search
        </button>

    </form>

</div>
            <!-- Account -->
            <a href="${pageContext.request.contextPath}/login"
               class="navbar-action">
                <span class="navbar-icon">&#9817;</span>
                <span class="navbar-label">ACCOUNT</span>
            </a>

            <!-- Wishlist: placeholder until implemented -->
            <a href="${pageContext.request.contextPath}/home"
               class="navbar-action"
               aria-label="Wishlist not yet available">
                <span class="navbar-icon">&#9825;</span>
                <span class="navbar-label">WISHLIST</span>
            </a>

            <!-- Shopping Cart -->
            <a href="${pageContext.request.contextPath}/cart"
               class="navbar-action">
                <span class="navbar-icon">&#128722;</span>
                <span class="navbar-label">CART</span>
            </a>

        </div>
    </nav>
</header>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const toggle = document.getElementById("searchToggle");
    const form = document.getElementById("navbarSearchForm");
    const input = document.getElementById("navbarSearchInput");

    if (!toggle || !form || !input) {
        console.error("Search elements not found.");
        return;
    }

    toggle.addEventListener("click", function () {
        const isOpen = form.classList.toggle("active");

        toggle.setAttribute("aria-expanded", isOpen);

        if (isOpen) {
            input.focus();
        }
    });

    form.addEventListener("submit", function (event) {
        if (!input.value.trim()) {
            event.preventDefault();
        }
    });
});
</script>