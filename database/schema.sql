-- =====================================================================
-- Fashion Store - database schema and sample data
-- Run this once in MySQL (Workbench or: mysql -u root -p < database/schema.sql)
-- WARNING: it drops and recreates the fashion_store database.
-- =====================================================================

DROP DATABASE IF EXISTS fashion_store;
CREATE DATABASE fashion_store;
USE fashion_store;

-- ---------------------------------------------------------------------
-- TABLES
-- ---------------------------------------------------------------------

CREATE TABLE users (
    user_id        INT PRIMARY KEY AUTO_INCREMENT,
    full_name      VARCHAR(100) NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    phone          VARCHAR(15)  NOT NULL UNIQUE,
    password       VARCHAR(255) NOT NULL,          -- BCrypt hash
    address_line1  VARCHAR(150) NOT NULL,
    address_line2  VARCHAR(150),
    city           VARCHAR(100) NOT NULL,
    state          VARCHAR(100) NOT NULL,
    pincode        VARCHAR(10)  NOT NULL,
    country        VARCHAR(100) NOT NULL DEFAULT 'India',
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id    INT PRIMARY KEY AUTO_INCREMENT,
    category_name  VARCHAR(100) NOT NULL UNIQUE,
    description    VARCHAR(500),
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id     INT PRIMARY KEY AUTO_INCREMENT,
    category_id    INT NOT NULL,
    product_name   VARCHAR(150) NOT NULL,
    brand          VARCHAR(100),
    description    TEXT NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    image_url      VARCHAR(255) NOT NULL,
    is_active      BOOLEAN NOT NULL DEFAULT TRUE,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE product_variants (
    variant_id      INT PRIMARY KEY AUTO_INCREMENT,
    product_id      INT NOT NULL,
    size            VARCHAR(10) NOT NULL,
    stock_quantity  INT NOT NULL DEFAULT 0,
    CONSTRAINT uq_product_size UNIQUE (product_id, size),
    CONSTRAINT fk_variants_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE cart (
    cart_id     INT PRIMARY KEY AUTO_INCREMENT,
    user_id     INT NOT NULL UNIQUE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE cart_items (
    cart_item_id  INT PRIMARY KEY AUTO_INCREMENT,
    cart_id       INT NOT NULL,
    variant_id    INT NOT NULL,
    quantity      INT NOT NULL DEFAULT 1,
    CONSTRAINT uq_cart_variant UNIQUE (cart_id, variant_id),
    CONSTRAINT fk_cartitems_cart
        FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
    CONSTRAINT fk_cartitems_variant
        FOREIGN KEY (variant_id) REFERENCES product_variants(variant_id)
);

CREATE TABLE orders (
    order_id                INT PRIMARY KEY AUTO_INCREMENT,
    user_id                 INT NOT NULL,
    order_date              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount            DECIMAL(10,2) NOT NULL,
    payment_method          VARCHAR(50) NOT NULL,
    order_status            VARCHAR(50) NOT NULL DEFAULT 'PLACED',
    delivery_name           VARCHAR(100) NOT NULL,
    delivery_phone          VARCHAR(15)  NOT NULL,
    delivery_address_line1  VARCHAR(150) NOT NULL,
    delivery_address_line2  VARCHAR(150),
    delivery_city           VARCHAR(100) NOT NULL,
    delivery_state          VARCHAR(100) NOT NULL,
    delivery_pincode        VARCHAR(10)  NOT NULL,
    delivery_country        VARCHAR(100) NOT NULL DEFAULT 'India',
    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_items (
    order_item_id  INT PRIMARY KEY AUTO_INCREMENT,
    order_id       INT NOT NULL,
    variant_id     INT NOT NULL,
    quantity       INT NOT NULL,
    price          DECIMAL(10,2) NOT NULL,          -- price at time of purchase
    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_orderitems_variant
        FOREIGN KEY (variant_id) REFERENCES product_variants(variant_id)
);

-- ---------------------------------------------------------------------
-- SAMPLE DATA
-- ---------------------------------------------------------------------

-- Demo account:  demo@example.com  /  Demo@1234   (password stored as BCrypt hash)
INSERT INTO users
    (full_name, email, phone, password,
     address_line1, address_line2, city, state, pincode, country)
VALUES
    ('Demo User', 'demo@example.com', '9000000001',
     '$2a$10$QEWh0X2Qzr2xug0y6slQ6ebpoiYPKbV../q9NfdsK7uJ93tuVKn4S',
     '12 MG Road', NULL, 'Bengaluru', 'Karnataka', '560001', 'India');

-- The site expects category ids 1-5 (see ProductServlet and home.jsp links)
INSERT INTO categories (category_name, description) VALUES
    ('Men',         'Clothing for men'),
    ('Women',       'Clothing for women'),
    ('Kids',        'Clothing for children'),
    ('Footwear',    'Shoes and sandals'),
    ('Accessories', 'Fashion accessories');

INSERT INTO products
    (category_id, product_name, brand, description, price, image_url, is_active)
VALUES
    (1, 'Classic Cotton T-Shirt', 'UrbanWear',  'Comfortable everyday cotton T-shirt',      599.00, 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400&h=500&fit=crop', TRUE),
    (1, 'Slim Fit Jeans',         'DenimCraft', 'Stylish slim-fit denim jeans',            1499.00, 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=400&h=500&fit=crop', TRUE),
    (1, 'Casual Shirt',           'StyleHub',   'Full-sleeve casual shirt',                 999.00, 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=400&h=500&fit=crop', TRUE),
    (2, 'Floral Summer Dress',    'BloomStyle', 'Lightweight floral summer dress',         1299.00, 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400&h=500&fit=crop', TRUE),
    (2, 'High-Waist Jeans',       'DenimQueen', 'Comfortable high-waist denim jeans',      1599.00, 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=400&h=500&fit=crop', TRUE),
    (2, 'Cotton Kurti',           'EthnicAura', 'Printed cotton kurti for everyday wear',   899.00, 'https://images.unsplash.com/photo-1581044777550-4cfa60707c03?w=400&h=500&fit=crop', TRUE),
    (3, 'Kids Graphic T-Shirt',   'LittleStars','Soft cotton graphic T-shirt for kids',     399.00, 'https://images.unsplash.com/photo-1519238263530-99bdd11df2ea?w=400&h=500&fit=crop', TRUE),
    (3, 'Kids Denim Shorts',      'TinyTrends', 'Comfortable denim shorts for children',    499.00, 'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=400&h=500&fit=crop', TRUE),
    (4, 'Running Shoes',          'SprintPro',  'Lightweight running shoes',               1999.00, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=500&fit=crop', TRUE),
    (4, 'Casual Sneakers',        'StreetStep', 'Everyday casual sneakers',                1799.00, 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400&h=500&fit=crop', TRUE),
    (5, 'Leather Belt',           'ClassicEdge','Classic everyday belt',                    499.00, 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=500&fit=crop', TRUE),
    (5, 'Baseball Cap',           'UrbanCap',   'Adjustable casual baseball cap',           299.00, 'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=400&h=500&fit=crop', TRUE);

INSERT INTO product_variants (product_id, size, stock_quantity) VALUES
    (1,'S',20),(1,'M',30),(1,'L',25),(1,'XL',15),
    (2,'30',12),(2,'32',20),(2,'34',18),(2,'36',10),
    (3,'S',10),(3,'M',20),(3,'L',20),(3,'XL',10),
    (4,'S',15),(4,'M',25),(4,'L',20),(4,'XL',10),
    (5,'28',12),(5,'30',20),(5,'32',15),(5,'34',10),
    (6,'S',15),(6,'M',25),(6,'L',20),(6,'XL',10),
    (7,'2Y',10),(7,'4Y',15),(7,'6Y',15),(7,'8Y',10),
    (8,'2Y',10),(8,'4Y',15),(8,'6Y',15),(8,'8Y',10),
    (9,'7',10),(9,'8',15),(9,'9',20),(9,'10',10),
    (10,'7',10),(10,'8',15),(10,'9',20),(10,'10',10),
    (11,'M',15),(11,'L',20),(11,'XL',10),
    (12,'FREE',50);

-- Quick check
SELECT 'users' AS tbl, COUNT(*) AS total FROM users
UNION ALL SELECT 'categories', COUNT(*) FROM categories
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'product_variants', COUNT(*) FROM product_variants;
