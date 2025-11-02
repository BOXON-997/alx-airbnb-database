### 1. Initial Complex Query

Let’s assume your tables are:
users(id, name, email)
bookings(id, user_id, property_id, payment_id, date)
properties(id, name, location, price)
payments(id, amount, method, status, booking_id)
You’ll save this initial query in a file named performance.sql.
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


 Purpose:

Returns full booking information joined across four tables.
Commonly used for admin dashboards or reporting.

### 2. Analyze Performance Using EXPLAIN

Before optimization, run:
EXPLAIN ANALYZE

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

>>> What to Look For:

Sequential Scans (Seq Scan) on large tables (inefficient)
Nested Loop Joins on large datasets
Sorting or temporary disk writes (slow ORDER BY)
High execution time (ms)
If you see multiple Seq Scan entries on users, bookings, or properties, it means the DB is scanning entire tables instead of using indexes.

### 3. Refactor and Optimize the Query

You can improve performance using these strategies:
 a) Ensure Proper Indexes Exist
database_index.sql from previous task (database_index.sql):

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);
CREATE INDEX idx_bookings_date ON bookings(date);

CREATE INDEX idx_users_id ON users(id);
CREATE INDEX idx_properties_id ON properties(id);
CREATE INDEX idx_payments_id ON payments(id);

These indexes help the database quickly locate records when joining or filtering.
 b) Refactor Query for Efficiency
If you only need specific columns, avoid SELECT * and unnecessary joins.
For example, if you don’t need all payment details:
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

Optimization Notes:

 Reduced number of joined columns (less data processed)
 Changed the payment join to a LEFT JOIN (if payments can be missing)
 Proper indexes ensure Index Scan instead of full table scan
 Ordered by an indexed column (b.date)

### 4. Re-Test Performance

After refactoring and adding indexes, run again:
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

You should see:

Index Scan instead of Seq Scan
Lower cost and execution time
Fewer rows read

### 5. Summary Table
Step	Action	Purpose
Write full join query	Establish baseline
	Use EXPLAIN ANALYZE	Measure performance
	Add indexes	Speed up lookups
    Refactor joins and select fields	Reduce data load
	Re-test performance	Confirm optimization