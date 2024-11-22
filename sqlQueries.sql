INSERT INTO reviews (book_id, reviewer_id, rating, review_text, review_date, is_deleted)
VALUES
    (3333333, 1, 4, 'Great read, though a bit repetitive at times.', '2024-11-23', false),
    (3333334, 2, 5, 'Exceptional book, really enjoyed it!', '2024-11-24', false);


-- Query to fetch reviews for a specific book
SELECT r.id, r.rating, r.review_text, r.review_date, 
       CONCAT(rv.first_name, ' ', rv.last_name) AS reviewer_name
FROM reviews r
JOIN reviewers rv ON r.reviewer_id = rv.id
WHERE r.book_id = 3333333 AND r.is_deleted = false
ORDER BY r.review_date DESC
LIMIT 10;

-- Agreggate customers data
SELECT o.id, o.order_date, o.total_amount, 
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       c.email AS customer_email
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'Completed'
ORDER BY o.order_date DESC
LIMIT 10;


-- Insert a new customer
INSERT INTO customers (first_name, last_name, email, phone, address, city, country)
VALUES ('Sarah', 'White', 'sarah@example.com', '555-1234', '789 Pine Street', 'San Francisco', 'USA');

INSERT INTO orders (customer_id, order_date, total_amount, status)
VALUES (LAST_INSERT_ID(), '2024-11-23', 45.00, 'Completed');


-- Query to find the most recent completed orders by customer
SELECT o.id, o.order_date, o.total_amount, 
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'Completed'
ORDER BY o.order_date DESC
LIMIT 5;
