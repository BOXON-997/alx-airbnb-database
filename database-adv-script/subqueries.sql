-- Objective: Write both correlated and non-correlated subqueries.

-- Instructions:

--     Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

--     Write a correlated subquery to find users who have made more than 3 bookings.


-- Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0.

SELECT 
    id,
    name,
    location,
    price
FROM properties
WHERE id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- The subquery:
-- SELECT property_id
-- FROM reviews
-- GROUP BY property_id
-- HAVING AVG(rating) > 4.0

-- finds property IDs whose average rating > 4.0.
-- The outer query retrieves full property details for only those property IDs.
-- This is non-correlated because the inner query runs independently of the outer one.

-- 2. Correlated Subquery
-- Find users who have made more than 3 bookings.

SELECT 
    u.id,
    u.name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*) 
    FROM bookings b
    WHERE b.user_id = u.id
) > 3;

-- The inner query:

-- SELECT COUNT(*)
-- FROM bookings b
-- WHERE b.user_id = u.id

-- runs once per user, counting how many bookings that specific user made.
-- The outer query filters for those users where that count is greater than 3.
-- This is correlated, because the subquery depends on each row of the outer query (u.id).

-- Optional Bonus — Same Queries Using Joins
-- Properties with avg rating > 4.0 (using JOIN)

SELECT p.id, p.name, AVG(r.rating) AS avg_rating
FROM properties p
JOIN reviews r ON p.id = r.property_id
GROUP BY p.id, p.name
HAVING AVG(r.rating) > 4.0;

-- Users with >3 bookings (using JOIN)

SELECT u.id, u.name, COUNT(b.id) AS total_bookings
FROM users u
JOIN bookings b ON u.id = b.user_id
GROUP BY u.id, u.name
HAVING COUNT(b.id) > 3;

