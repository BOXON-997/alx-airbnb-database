
SELECT * FROM bookings WHERE start_date BETWEEN '2025-01-01' AND '2025-03-31';

-- partitioning.sql
-- =====================================
-- Step 1: Rename the original bookings table
-- =====================================
ALTER TABLE bookings RENAME TO bookings_old;

-- =====================================
-- Step 2: Create a new partitioned bookings table
-- =====================================
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    payment_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
) PARTITION BY RANGE (start_date);

-- =====================================
-- Step 3: Create partitions by year (or month)
-- Example: yearly partitions for 2024–2026
-- =====================================
CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_2026 PARTITION OF bookings
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- =====================================
-- Step 4: Move existing data into the new partitions
-- =====================================
INSERT INTO bookings (id, user_id, property_id, payment_id, start_date, end_date)
SELECT id, user_id, property_id, payment_id, start_date, end_date
FROM bookings_old;

-- =====================================
-- Step 5: Drop the old table (optional, after verification)
-- =====================================
-- DROP TABLE bookings_old;


-- After (on partitioned table)

EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2025-02-01' AND '2025-03-01';

-- Optional: Add Index to Each Partition

CREATE INDEX idx_bookings_2025_user_id ON bookings_2025(user_id);
CREATE INDEX idx_bookings_2025_property_id ON bookings_2025(property_id);


