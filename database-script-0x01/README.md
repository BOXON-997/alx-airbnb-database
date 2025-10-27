## Objective

Design and define the SQL schema for the Airbnb-like booking system.
This includes creating all tables, constraints, and indexes required to ensure data integrity and efficient querying.

## Entities and Relationships
Table	Description	Key Relationships
users	Stores all user data (guests, hosts, admins).	Referenced by properties, bookings, reviews, and messages.
properties	Represents listed properties by hosts.	FK → users(host_id)
bookings	Stores booking details for guests.	FK → properties(property_id), users(user_id)
payments	Stores payment transactions.	FK → bookings(booking_id)
reviews	User reviews for properties.	FK → users(user_id), properties(property_id)
messages	Communication between users.	FK → users(sender_id), users(recipient_id)
⚙️ Constraints Overview
Table	Constraint	Description
users	UNIQUE(email)	Each user must have a unique email.
properties	FK(host_id)	Each property is owned by a user (host).
bookings	FK(property_id), FK(user_id)	A booking belongs to both a user and a property.
bookings	ENUM(status)	Status must be pending, confirmed, or canceled.
payments	FK(booking_id)	Each payment links to one valid booking.
reviews	CHECK(rating BETWEEN 1 AND 5)	Rating must be between 1 and 5.
messages	FK(sender_id), FK(recipient_id)	Both sender and recipient must be existing users.
🧠 Notes

All tables use UUIDs as primary keys for global uniqueness.

Timestamps automatically record creation and update times.

Indexes added on frequently queried columns like email, booking_id, and property_id.

Schema is fully normalized up to Third Normal Form (3NF).

## Usage

To create the database schema:

-- Connect to your database (e.g., PostgreSQL or MySQL)
CREATE DATABASE airbnb_db;

-- Use the database
USE airbnb_db;

-- Run schema
SOURCE database-script-0x01/schema.sql;

## Author BOXON-997
