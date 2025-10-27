# Airbnb Database - Sample Data Seeder
## Objective

Populate the Airbnb database with sample data for testing and demonstration purposes.
This data simulates realistic scenarios with multiple users, properties, bookings, payments, reviews, and messages.

## Entities Seeded
Table	Description	Example Count
users	Guests, hosts, and an admin user	5
properties	Hosted by various users	3
bookings	User bookings for different properties	3
payments	Payments linked to bookings	2
reviews	Reviews from users for properties	2
messages	Conversations between users	3
## Usage

Make sure your database schema from database-script-0x01/schema.sql is created.

Connect to your SQL database (e.g., MySQL or PostgreSQL).

Run the seeder:

SOURCE database-script-0x02/seed.sql;

Verify by running:

SELECT * FROM users;
SELECT * FROM properties;

## Notes

UUIDs are manually set for simplicity but can be auto-generated in real environments.

Dates and prices reflect realistic Airbnb-style data.

The data ensures referential integrity with proper foreign key references.

## Author BOXON-997