-- Objective: Use SQL aggregation and window functions to analyze data.
-- Instructions:
--     Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
--     Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.

-- Aggregation Query

SELECT 
    u.id AS user_id,
    u.name AS user_name,
    COUNT(b.id) AS total_bookings
FROM users u
LEFT JOIN bookings b 
    ON u.id = b.user_id
GROUP BY u.id, u.name
ORDER BY total_bookings DESC;

-- Explanation:
-- COUNT(b.id) counts all bookings per user.
-- LEFT JOIN ensures users with no bookings still appear (with count = 0).
-- GROUP BY groups results per user.
-- ORDER BY sorts users by booking volume.

-- Window Function Query
-- Rank properties based on the total number of bookings they have received.

SELECT
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS property_rank
FROM properties p
LEFT JOIN bookings b 
    ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY property_rank;

-- Explanation:

-- COUNT(b.id) counts total bookings per property.
-- The window function RANK() assigns a rank (1 = most booked property).
-- RANK() handles ties (two properties with same booking count get same rank).
-- If you want strict ordering without ties, use ROW_NUMBER() instead:
-- ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS property_rank