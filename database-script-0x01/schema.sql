-- Airbnb Database Schema (DDL)
-- Author: [BOXON-997]
-- Description: Database schema defining tables, constraints, and relationships for Airbnb-like system.

-- =========================
-- USER TABLE
-- =========================
CREATE TABLE users (
user_id UUID PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
password_hash VARCHAR(255) NOT NULL,
phone_number VARCHAR(20),
role ENUM('guest', 'host', 'admin') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_email ON users (email);

-- =========================
-- PROPERTY TABLE
-- =========================
CREATE TABLE properties (
property_id UUID PRIMARY KEY,
host_id UUID NOT NULL,
name VARCHAR(150) NOT NULL,
description TEXT NOT NULL,
location VARCHAR(255) NOT NULL,
price_per_night DECIMAL(10,2) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES users(user_id)
);

CREATE INDEX idx_property_host ON properties (host_id);

-- =========================
-- BOOKING TABLE
-- =========================
CREATE TABLE bookings (
booking_id UUID PRIMARY KEY,
property_id UUID NOT NULL,
user_id UUID NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
total_price DECIMAL(10,2) NOT NULL,
status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES properties(property_id),
CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE INDEX idx_booking_property ON bookings (property_id);
CREATE INDEX idx_booking_user ON bookings (user_id);

-- =========================
-- PAYMENT TABLE
-- =========================
CREATE TABLE payments (
payment_id UUID PRIMARY KEY,
booking_id UUID NOT NULL,
amount DECIMAL(10,2) NOT NULL,
payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE INDEX idx_payment_booking ON payments (booking_id);

-- =========================
-- REVIEW TABLE
-- =========================
CREATE TABLE reviews (
review_id UUID PRIMARY KEY,
property_id UUID NOT NULL,
user_id UUID NOT NULL,
rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
comment TEXT NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES properties(property_id),
CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE INDEX idx_review_property ON reviews (property_id);
CREATE INDEX idx_review_user ON reviews (user_id);

-- =========================
-- MESSAGE TABLE
-- =========================
CREATE TABLE messages (
message_id UUID PRIMARY KEY,
sender_id UUID NOT NULL,
recipient_id UUID NOT NULL,
message_body TEXT NOT NULL,
sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES users(user_id),
CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);

CREATE INDEX idx_message_sender ON messages (sender_id);
CREATE INDEX idx_message_recipient ON messages (recipient_id);