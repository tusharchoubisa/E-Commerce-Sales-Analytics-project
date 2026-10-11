
-- =====================================================
-- PROJECT: E-COMMERCE SALES & BUSINESS ANALYTICS
-- DATABASE: MySQL
-- TOTAL SAMPLE RECORDS: 125
-- =====================================================

create database if not exists ecommerce_analytics;
use ecommerce_analytics;


-- =====================================================
-- 1. CREATE TABLES
-- =====================================================

create table customers (
    customer_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(100) unique not null,
    phone varchar(15),
    city varchar(50),
    state varchar(50),
    signup_date date
);

create table products (
    product_id int primary key auto_increment,
    product_name varchar(100) not null,
    category varchar(50) not null,
    price decimal(10,2) not null,
    stock_quantity int not null default 0,
    product_status varchar(20) default 'active',
    check (price >= 0),
    check (stock_quantity >= 0)
);

create table orders (
    order_id int primary key auto_increment,
    customer_id int not null,
    order_date datetime not null default current_timestamp,
    order_status varchar(20) not null default 'pending',
    shipping_city varchar(50),
    shipping_state varchar(50),
    foreign key (customer_id) references customers(customer_id)
);

create table order_items (
    order_item_id int primary key auto_increment,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    unit_price decimal(10,2) not null,
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id),
    check (quantity > 0),
    check (unit_price >= 0)
);

create table payments (
    payment_id int primary key auto_increment,
    order_id int not null,
    payment_date datetime,
    payment_method varchar(30),
    payment_amount decimal(10,2) not null,
    payment_status varchar(20) not null default 'pending',
    transaction_reference varchar(100) unique,
    foreign key (order_id) references orders(order_id),
    check (payment_amount >= 0)
);

create table reviews (
    review_id int primary key auto_increment,
    customer_id int not null,
    product_id int not null,
    rating int not null,
    review_text varchar(500),
    review_date date,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id),
    check (rating between 1 and 5),
    unique (customer_id, product_id)
);


-- =====================================================
-- 2. INSERT CUSTOMERS (15 RECORDS)
-- =====================================================

insert into customers
(customer_id, first_name, last_name, email, phone, city, state, signup_date)
values
(1, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '9876500001', 'Ahmedabad', 'Gujarat', '2025-01-05'),
(2, 'Priya', 'Patel', 'priya.patel@example.com', '9876500002', 'Surat', 'Gujarat', '2025-01-12'),
(3, 'Rahul', 'Verma', 'rahul.verma@example.com', '9876500003', 'Jaipur', 'Rajasthan', '2025-02-02'),
(4, 'Neha', 'Joshi', 'neha.joshi@example.com', '9876500004', 'Udaipur', 'Rajasthan', '2025-02-15'),
(5, 'Amit', 'Kumar', 'amit.kumar@example.com', '9876500005', 'Delhi', 'Delhi', '2025-03-01'),
(6, 'Sneha', 'Shah', 'sneha.shah@example.com', '9876500006', 'Mumbai', 'Maharashtra', '2025-03-18'),
(7, 'Karan', 'Mehta', 'karan.mehta@example.com', '9876500007', 'Pune', 'Maharashtra', '2025-04-03'),
(8, 'Pooja', 'Singh', 'pooja.singh@example.com', '9876500008', 'Indore', 'Madhya Pradesh', '2025-04-20'),
(9, 'Rohit', 'Choudhary', 'rohit.choudhary@example.com', '9876500009', 'Jodhpur', 'Rajasthan', '2025-05-06'),
(10, 'Anjali', 'Desai', 'anjali.desai@example.com', '9876500010', 'Vadodara', 'Gujarat', '2025-05-22'),
(11, 'Vikram', 'Malhotra', 'vikram.malhotra@example.com', '9876500011', 'Chandigarh', 'Chandigarh', '2025-06-04'),
(12, 'Isha', 'Kapoor', 'isha.kapoor@example.com', '9876500012', 'Amritsar', 'Punjab', '2025-06-19'),
(13, 'Arjun', 'Nair', 'arjun.nair@example.com', '9876500013', 'Kochi', 'Kerala', '2025-07-02'),
(14, 'Meera', 'Reddy', 'meera.reddy@example.com', '9876500014', 'Hyderabad', 'Telangana', '2025-07-16'),
(15, 'Dev', 'Patil', 'dev.patil@example.com', '9876500015', 'Bengaluru', 'Karnataka', '2025-08-01');


-- =====================================================
-- 3. INSERT PRODUCTS (20 RECORDS)
-- =====================================================

insert into products
(product_id, product_name, category, price, stock_quantity, product_status)
values
(1, 'Wireless Mouse', 'Accessories', 799.00, 120, 'active'),
(2, 'Mechanical Keyboard', 'Accessories', 2499.00, 65, 'active'),
(3, 'USB-C Hub', 'Accessories', 1799.00, 40, 'active'),
(4, 'Laptop Stand', 'Accessories', 999.00, 75, 'active'),
(5, 'Full HD Monitor', 'Electronics', 12999.00, 25, 'active'),
(6, 'Wireless Headphones', 'Electronics', 3499.00, 50, 'active'),
(7, 'Bluetooth Speaker', 'Electronics', 1999.00, 45, 'active'),
(8, 'Webcam', 'Electronics', 2299.00, 30, 'active'),
(9, 'Laptop Backpack', 'Bags', 1499.00, 80, 'active'),
(10, 'Office Chair', 'Furniture', 7499.00, 18, 'active'),
(11, 'Study Desk', 'Furniture', 5999.00, 15, 'active'),
(12, 'LED Desk Lamp', 'Home', 899.00, 90, 'active'),
(13, 'Water Bottle', 'Lifestyle', 499.00, 150, 'active'),
(14, 'Smart Watch', 'Electronics', 4999.00, 35, 'active'),
(15, 'Power Bank', 'Accessories', 1299.00, 70, 'active'),
(16, 'External SSD 1TB', 'Storage', 6999.00, 22, 'active'),
(17, 'Wi-Fi Router', 'Networking', 1899.00, 32, 'active'),
(18, 'Printer', 'Electronics', 8999.00, 12, 'active'),
(19, 'HDMI Cable', 'Accessories', 349.00, 200, 'active'),
(20, 'Laptop Cooling Pad', 'Accessories', 1199.00, 55, 'active');


-- =====================================================
-- 4. INSERT ORDERS (20 RECORDS)
-- =====================================================

insert into orders
(order_id, customer_id, order_date, order_status, shipping_city, shipping_state)
values
(1, 1, '2025-09-01 10:15:00', 'delivered', 'Ahmedabad', 'Gujarat'),
(2, 2, '2025-09-02 12:30:00', 'delivered', 'Surat', 'Gujarat'),
(3, 3, '2025-09-03 15:45:00', 'shipped', 'Jaipur', 'Rajasthan'),
(4, 4, '2025-09-04 11:20:00', 'delivered', 'Udaipur', 'Rajasthan'),
(5, 5, '2025-09-05 17:10:00', 'cancelled', 'Delhi', 'Delhi'),
(6, 6, '2025-09-06 09:40:00', 'delivered', 'Mumbai', 'Maharashtra'),
(7, 7, '2025-09-07 14:25:00', 'pending', 'Pune', 'Maharashtra'),
(8, 8, '2025-09-08 16:50:00', 'delivered', 'Indore', 'Madhya Pradesh'),
(9, 9, '2025-09-09 13:15:00', 'shipped', 'Jodhpur', 'Rajasthan'),
(10, 10, '2025-09-10 18:05:00', 'delivered', 'Vadodara', 'Gujarat'),
(11, 1, '2025-09-11 10:35:00', 'delivered', 'Ahmedabad', 'Gujarat'),
(12, 2, '2025-09-12 12:55:00', 'cancelled', 'Surat', 'Gujarat'),
(13, 11, '2025-09-13 15:20:00', 'delivered', 'Chandigarh', 'Chandigarh'),
(14, 12, '2025-09-14 11:45:00', 'shipped', 'Amritsar', 'Punjab'),
(15, 13, '2025-09-15 17:30:00', 'delivered', 'Kochi', 'Kerala'),
(16, 14, '2025-09-16 09:25:00', 'pending', 'Hyderabad', 'Telangana'),
(17, 15, '2025-09-17 14:10:00', 'delivered', 'Bengaluru', 'Karnataka'),
(18, 3, '2025-09-18 16:35:00', 'delivered', 'Jaipur', 'Rajasthan'),
(19, 6, '2025-09-19 13:50:00', 'shipped', 'Mumbai', 'Maharashtra'),
(20, 8, '2025-09-20 18:25:00', 'delivered', 'Indore', 'Madhya Pradesh');


-- =====================================================
-- 5. INSERT ORDER ITEMS (35 RECORDS)
-- =====================================================

insert into order_items
(order_item_id, order_id, product_id, quantity, unit_price)
values
(1, 1, 1, 1, 799.00),
(2, 1, 2, 1, 2499.00),
(3, 2, 6, 1, 3499.00),
(4, 2, 13, 2, 499.00),
(5, 3, 5, 1, 12999.00),
(6, 3, 19, 2, 349.00),
(7, 4, 4, 1, 999.00),
(8, 4, 12, 2, 899.00),
(9, 5, 14, 1, 4999.00),
(10, 6, 10, 1, 7499.00),
(11, 6, 1, 1, 799.00),
(12, 7, 2, 1, 2499.00),
(13, 7, 13, 1, 499.00),
(14, 8, 9, 1, 1499.00),
(15, 8, 13, 1, 499.00),
(16, 9, 17, 1, 1899.00),
(17, 9, 3, 1, 1799.00),
(18, 10, 5, 1, 12999.00),
(19, 10, 19, 1, 349.00),
(20, 11, 15, 1, 1299.00),
(21, 11, 6, 1, 3499.00),
(22, 12, 18, 1, 8999.00),
(23, 13, 8, 1, 2299.00),
(24, 13, 12, 1, 899.00),
(25, 14, 14, 1, 4999.00),
(26, 15, 16, 1, 6999.00),
(27, 15, 20, 1, 1199.00),
(28, 16, 7, 1, 1999.00),
(29, 17, 11, 1, 5999.00),
(30, 17, 4, 1, 999.00),
(31, 18, 2, 1, 2499.00),
(32, 18, 1, 2, 799.00),
(33, 19, 18, 1, 8999.00),
(34, 20, 6, 1, 3499.00),
(35, 20, 13, 1, 499.00);


-- =====================================================
-- 6. INSERT PAYMENTS (20 RECORDS)
-- =====================================================

insert into payments
(payment_id, order_id, payment_date, payment_method, payment_amount, payment_status, transaction_reference)
values
(1, 1, '2025-09-01 10:20:00', 'upi', 3298.00, 'paid', 'TXN10001'),
(2, 2, '2025-09-02 12:35:00', 'credit card', 4497.00, 'paid', 'TXN10002'),
(3, 3, '2025-09-03 15:50:00', 'debit card', 13697.00, 'paid', 'TXN10003'),
(4, 4, '2025-09-04 11:25:00', 'upi', 2797.00, 'paid', 'TXN10004'),
(5, 5, '2025-09-05 17:15:00', 'credit card', 4999.00, 'cancelled', 'TXN10005'),
(6, 6, '2025-09-06 09:45:00', 'net banking', 8298.00, 'paid', 'TXN10006'),
(7, null, 'upi', 2998.00, 'pending', 'TXN10007'),
(8, 8, '2025-09-08 16:55:00', 'debit card', 1998.00, 'paid', 'TXN10008'),
(9, 9, '2025-09-09 13:20:00', 'upi', 3698.00, 'paid', 'TXN10009'),
(10, 10, '2025-09-10 18:10:00', 'credit card', 13348.00, 'paid', 'TXN10010'),
(11, 11, '2025-09-11 10:40:00', 'upi', 4798.00, 'paid', 'TXN10011'),
(12, 12, '2025-09-12 13:00:00', 'credit card', 8999.00, 'cancelled', 'TXN10012'),
(13, 13, '2025-09-13 15:25:00', 'debit card', 3198.00, 'paid', 'TXN10013'),
(14, 14, null, 'upi', 4999.00, 'pending', 'TXN10014'),
(15, 15, '2025-09-15 17:35:00', 'net banking', 8198.00, 'paid', 'TXN10015'),
(16, 16, null, 'upi', 1999.00, 'pending', 'TXN10016'),
(17, 17, '2025-09-17 14:15:00', 'credit card', 6998.00, 'paid', 'TXN10017'),
(18, 18, '2025-09-18 16:40:00', 'upi', 4097.00, 'paid', 'TXN10018'),
(19, 19, '2025-09-19 13:55:00', 'debit card', 8999.00, 'paid', 'TXN10019'),
(20, 20, '2025-09-20 18:30:00', 'upi', 3998.00, 'paid', 'TXN10020');


-- =====================================================
-- 7. INSERT REVIEWS (15 RECORDS)
-- =====================================================

insert into reviews
(review_id, customer_id, product_id, rating, review_text, review_date)
values
(1, 1, 1, 5, 'Excellent mouse for daily use', '2025-09-05'),
(2, 2, 6, 4, 'Good sound quality', '2025-09-06'),
(3, 3, 5, 5, 'Clear display and good colors', '2025-09-07'),
(4, 4, 4, 4, 'Useful and sturdy laptop stand', '2025-09-08'),
(5, 5, 14, 3, 'Features are good but battery could improve', '2025-09-09'),
(6, 6, 10, 5, 'Comfortable chair for office work', '2025-09-10'),
(7, 7, 2, 4, 'Nice keyboard for typing', '2025-09-11'),
(8, 8, 9, 4, 'Spacious and practical backpack', '2025-09-12'),
(9, 9, 17, 5, 'Stable internet connection', '2025-09-13'),
(10, 10, 12, 4, 'Good brightness for a desk lamp', '2025-09-14'),
(11, 11, 15, 3, 'Works well but charging takes time', '2025-09-15'),
(12, 12, 18, 4, 'Print quality is good', '2025-09-16'),
(13, 13, 8, 5, 'Clear video quality for meetings', '2025-09-17'),
(14, 14, 16, 5, 'Fast file transfer speed', '2025-09-18'),
(15, 15, 20, 4, 'Helps keep the laptop cool', '2025-09-19');


-- =====================================================
-- 8. BUSINESS ANALYSIS QUERIES
-- =====================================================

-- Q1. How many orders were placed?
select count(*) as total_orders
from orders;

-- Q2. How many orders belong to each status?
select order_status, count(*) as total_orders
from orders
group by order_status;

-- Q3. What is the total quantity ordered for each product?
select p.product_name, sum(oi.quantity) as total_quantity_ordered
from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
order by total_quantity_ordered desc;

-- Q4. What is the total item value for delivered orders?
select sum(oi.quantity * oi.unit_price) as delivered_sales
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = 'delivered';

-- Q5. What are the delivered sales by shipping city?
select o.shipping_city,
       sum(oi.quantity * oi.unit_price) as total_sales
from orders o
join order_items oi on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by o.shipping_city
order by total_sales desc;

-- Q6. What is the average value of a delivered order?
select round(avg(order_total), 2) as average_order_value
from (
    select o.order_id,
           sum(oi.quantity * oi.unit_price) as order_total
    from orders o
    join order_items oi on o.order_id = oi.order_id
    where o.order_status = 'delivered'
    group by o.order_id
) as order_summary;

-- Q7. Who are the top 5 customers by spending on delivered orders?
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as customer_name,
       sum(oi.quantity * oi.unit_price) as total_spending
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
where o.order_status = 'delivered'
group by c.customer_id, c.first_name, c.last_name
order by total_spending desc
limit 5;

-- Q8. Which are the top 5 products by quantity ordered on delivered orders?
select p.product_name,
       sum(oi.quantity) as total_quantity_sold
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = 'delivered'
group by p.product_id, p.product_name
order by total_quantity_sold desc
limit 5;

-- Q9. Which products have an average rating of at least 4?
select p.product_name,
       round(avg(r.rating), 2) as average_rating,
       count(r.review_id) as total_reviews
from products p
join reviews r on p.product_id = r.product_id
group by p.product_id, p.product_name
having avg(r.rating) >= 4
order by average_rating desc;

-- Q10. How many orders has each customer placed?
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as customer_name,
       count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_orders desc;

-- Q11. What is the delivered sales value for each product category?
select p.category,
       sum(oi.quantity * oi.unit_price) as total_revenue
from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = 'delivered'
group by p.category
order by total_revenue desc;

-- Q12. Which orders have an item total greater than 5000?
select o.order_id,
       o.order_status,
       sum(oi.quantity * oi.unit_price) as order_total
from orders o
join order_items oi on o.order_id = oi.order_id
group by o.order_id, o.order_status
having sum(oi.quantity * oi.unit_price) > 5000
order by order_total desc;

-- Q13. Which customers have never placed an order?
select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as customer_name
from customers c
left join orders o on c.customer_id = o.customer_id
where o.order_id is null;

-- Q14. What is the overall average product rating?
select round(avg(rating), 2) as overall_average_rating,
       count(*) as total_reviews
from reviews;

-- Q15. How many units are currently in stock across active products?
select sum(stock_quantity) as total_units_in_stock
from products
where product_status = 'active';

-- Q16. Which payment methods are most frequently recorded?
select payment_method,
       count(*) as total_transactions
from payments
group by payment_method
order by total_transactions desc;

-- Q17. Which delivered orders have an item total above the average
-- delivered order value?
select order_totals.order_id, order_totals.order_total
from (
    select o.order_id,
           sum(oi.quantity * oi.unit_price) as order_total
    from orders o
    join order_items oi on o.order_id = oi.order_id
    where o.order_status = 'delivered'
    group by o.order_id
) as order_totals
where order_totals.order_total > (
    select avg(delivered_total)
    from (
        select sum(oi.quantity * oi.unit_price) as delivered_total
        from orders o
        join order_items oi on o.order_id = oi.order_id
        where o.order_status = 'delivered'
        group by o.order_id
    ) as average_summary
);

-- Q18. What are the record counts in all six tables?
select
    (select count(*) from customers) as customers,
    (select count(*) from products) as products,
    (select count(*) from orders) as orders,
    (select count(*) from order_items) as order_items,
    (select count(*) from payments) as payments,
    (select count(*) from reviews) as reviews;

-- =====================================================
-- END OF PROJECT
-- =====================================================
