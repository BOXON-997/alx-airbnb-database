## 1. Identify High-Usage Columns
ased on the queries we’ve written so far (joins, filters, aggregations, rankings), the most frequently used columns are:

Table	High-Usage Columns	Reason for Index
users	id, email	id used in joins; email often used for login or lookup
bookings	user_id, property_id, date	user_id and property_id appear in JOIN and GROUP BY clauses; date can be used in filtering
properties	id, location, price	id used in joins; location and price likely used in searches or filters

## 2. Create Indexes

Below are the SQL commands to create indexes for optimization —
You can copy all of these into your database_index.sql file.

-- ==========================
-- Indexes for Users Table
-- ==========================
CREATE INDEX idx_users_id ON users(id);
CREATE INDEX idx_users_email ON users(email);

-- ==========================
-- Indexes for Bookings Table
-- ==========================
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_date ON bookings(date);

-- ==========================
-- Indexes for Properties Table
-- ==========================
CREATE INDEX idx_properties_id ON properties(id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price);

## Notes:

Index names follow a clear naming convention (idx_<table>_<column>).

If your database already has a primary key (e.g., id), you don’t need an index on that column again — it’s indexed automatically.

You can create composite indexes if queries frequently filter by multiple columns, e.g.:

CREATE INDEX idx_bookings_user_property ON bookings(user_id, property_id);

## 3. Measure Query Performance

To confirm the optimization worked, run EXPLAIN (or EXPLAIN ANALYZE in PostgreSQL) before and after adding indexes.

Example: Checking a Query Before Index
EXPLAIN ANALYZE
SELECT * 
FROM bookings
WHERE user_id = 5;

Example: After Creating Index
EXPLAIN ANALYZE
SELECT * 
FROM bookings
WHERE user_id = 5;

## Expected Results:

The query plan before indexing might show Seq Scan (sequential scan).

After indexing, it should show Index Scan — meaning the DBMS is using the index efficiently.

## Summary
Step	Action	Purpose
Identify columns	Choose columns used in WHERE/JOIN/ORDER BY	Target for optimization
Create indexes	Use CREATE INDEX	Improve data access speed
Measure performance	Run EXPLAIN / EXPLAIN ANALYZE	Verify improvement