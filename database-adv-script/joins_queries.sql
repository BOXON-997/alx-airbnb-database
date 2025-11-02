-- Objective: Master SQL joins by writing complex queries using different types of joins.

-- Instructions:

--     Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

--     Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

--     Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.


-- INNER JOIN — Retrieve all bookings and the respective users who made those bookings

-- The INNER JOIN only returns records where there is a matching user 
-- for each booking. If a booking has no valid user_id, it will not 
-- appear in the results

SELECT 
    bookings.id AS booking_id,
    users.id AS user_id,
    users.name AS user_name,
    users.email AS user_email,
    bookings.property_id,
    bookings.date
FROM bookings
INNER JOIN users 
    ON bookings.user_id = users.id;

-- LEFT JOIN — Retrieve all properties and their reviews (including properties with no reviews)

-- The LEFT JOIN ensures that all properties appear in the results.
-- If a property has no review, the review columns will return NULL.


SELECT 
    properties.id AS property_id,
    properties.name AS property_name,
    properties.location,
    reviews.id AS review_id,
    reviews.rating,
    reviews.comment
FROM properties
LEFT JOIN reviews 
    ON properties.id = reviews.property_id;

-- FULL OUTER JOIN — Retrieve all users and all bookings (even if unmatched)

-- The FULL OUTER JOIN includes:
-- Users who have bookings
-- Users who don’t have any bookings
-- Bookings that don’t belong to any user
-- When there’s no match, the missing side will contain NULL values.


SELECT 
    users.id AS user_id,
    users.name AS user_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.date
FROM users
FULL OUTER JOIN bookings 
    ON users.id = bookings.user_id;

-- Optional: Example Using PostgreSQL (which supports FULL OUTER JOIN natively)
-- If you’re using MySQL (which doesn’t directly support FULL OUTER JOIN), you can simulate it with UNION:

SELECT 
    users.id AS user_id,
    users.name AS user_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.date
FROM users
LEFT JOIN bookings ON users.id = bookings.user_id

UNION

SELECT 
    users.id AS user_id,
    users.name AS user_name,
    bookings.id AS booking_id,
    bookings.property_id,
    bookings.date
FROM bookings
LEFT JOIN users ON users.id = bookings.user_id;
