-- performance.sql
-- Initial Query: Retrieve all bookings with user, property, and payment details

SELECT 
    b.id AS booking_id,
    b.date AS booking_date,
    u.name AS user_name,
    u.email AS user_email,
    p.name AS property_name,
    p.location,
    p.price,
    pay.amount AS payment_amount,
    pay.method AS payment_method,
    pay.status AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
ORDER BY b.date DESC;

-- Returns full booking information joined across four tables.
-- Commonly used for admin dashboards or reporting.


-- Analyze Performance Using EXPLAIN
-- Before optimization, run:
-- EXPLAIN ANALYZE

SELECT 
    b.id AS booking_id,
    b.date AS booking_date,
    u.name AS user_name,
    u.email AS user_email,
    p.name AS property_name,
    p.location,
    p.price,
    pay.amount AS payment_amount,
    pay.method AS payment_method,
    pay.status AS payment_status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id
ORDER BY b.date DESC;

-- What to Look For:
-- Sequential Scans (Seq Scan) on large tables (inefficient)
-- Nested Loop Joins on large datasets
-- Sorting or temporary disk writes (slow ORDER BY)
-- High execution time (ms)
-- If you see multiple Seq Scan entries on users, bookings, or properties, it means the DB is scanning entire tables instead of using indexes.

-- Refactor and Optimize the Query below: 
-- If you only need specific columns, avoid SELECT * and unnecessary joins.
-- For example, if you don’t need all payment details:

-- Optimized Query

SELECT 
    b.id AS booking_id,
    b.date AS booking_date,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount AS payment_amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.payment_id = pay.id
ORDER BY b.date DESC;

-- Optimization Notes:
--  Reduced number of joined columns (less data processed)
--  Changed the payment join to a LEFT JOIN (if payments can be missing)
--  Proper indexes ensure Index Scan instead of full table scan
--  Ordered by an indexed column (b.date)

-- Re-Test Performance
-- After refactoring and adding indexes, run again:

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.date AS booking_date,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount AS payment_amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.payment_id = pay.id
ORDER BY b.date DESC;


-- You should see:
-- Index Scan instead of Seq Scan
-- Lower cost and execution time
-- Fewer rows read