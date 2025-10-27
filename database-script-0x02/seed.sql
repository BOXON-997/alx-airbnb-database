-- Airbnb Database Sample Data Seeder
-- Author: [Your Name]
-- Description: Populates database with sample users, properties, bookings, payments, reviews, and messages.

-- =========================
-- USERS
-- =========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Johnson', 'alice@example.com
', 'hashed_pw_1', '+254700111111', 'guest'),
('22222222-2222-2222-2222-222222222222', 'Brian', 'Otieno', 'brian@example.com
', 'hashed_pw_2', '+254700222222', 'host'),
('33333333-3333-3333-3333-333333333333', 'Catherine', 'Mutua', 'catherine@example.com
', 'hashed_pw_3', '+254700333333', 'host'),
('44444444-4444-4444-4444-444444444444', 'David', 'Mwangi', 'david@example.com
', 'hashed_pw_4', '+254700444444', 'guest'),
('55555555-5555-5555-5555-555555555555', 'Admin', 'User', 'admin@example.com
', 'hashed_pw_5', '+254700555555', 'admin');

-- =========================
-- PROPERTIES
-- =========================
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 'Cozy Studio Apartment', 'A quiet studio perfect for short stays.', 'Nairobi, Kenya', 45.00),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 'Beachfront Cottage', 'A relaxing getaway by the ocean.', 'Mombasa, Kenya', 120.00),
('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 'Luxury Villa', 'Spacious villa with pool and garden.', 'Naivasha, Kenya', 300.00);

-- =========================
-- BOOKINGS
-- =========================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '2025-10-20', '2025-10-23', 135.00, 'confirmed'),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', '2025-11-01', '2025-11-05', 480.00, 'pending'),
('bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '2025-12-10', '2025-12-15', 1500.00, 'confirmed');

-- =========================
-- PAYMENTS
-- =========================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
('ppppppp1-pppp-pppp-pppp-pppppppppppp', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 135.00, 'credit_card'),
('ppppppp2-pppp-pppp-pppp-pppppppppppp', 'bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 1500.00, 'paypal');

-- =========================
-- REVIEWS
-- =========================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
('rrrrrrr1-rrrr-rrrr-rrrr-rrrrrrrrrrrr', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 5, 'Amazing stay! Very comfortable.'),
('rrrrrrr2-rrrr-rrrr-rrrr-rrrrrrrrrrrr', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', 4, 'Beautiful view, will come again.');

-- =========================
-- MESSAGES
-- =========================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
('mmmmmmm1-mmmm-mmmm-mmmm-mmmmmmmmmmmm', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi Brian, is your studio available next weekend?'),
('mmmmmmm2-mmmm-mmmm-mmmm-mmmmmmmmmmmm', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Yes, it’s available. Would you like to book it?'),
('mmmmmmm3-mmmm-mmmm-mmmm-mmmmmmmmmmmm', '33333333-3333-3333-3333-333333333333', '44444444-4444-4444-4444-444444444444', 'Hi David, your stay is confirmed!');

-- finally the end