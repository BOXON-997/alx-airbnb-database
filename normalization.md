# Normalized

Database Normalization – Airbnb Schema (3NF)
🎯 Objective

Apply normalization principles to ensure the Airbnb database design is in Third Normal Form (3NF) by removing redundancy, ensuring data consistency, and improving data integrity.

🧩 Step 1: First Normal Form (1NF)
✅ Rules of 1NF

Each table has a primary key.

All fields contain atomic (indivisible) values.

No repeating groups or arrays.

🔍 Application
Table	Violation	Resolution
User	None	All fields are atomic (e.g., separate first_name, last_name).
Property	None	Description, price, and location are single-valued.
Booking	None	Each booking record is atomic and has its own booking_id.
Payment	None	Each payment belongs to one booking only.
Review	None	Each review record stands alone.
Message	None	Each message has one sender and one recipient.

✅ Result: All tables meet 1NF.

🧱 Step 2: Second Normal Form (2NF)
✅ Rules of 2NF

Must already satisfy 1NF.

No partial dependencies — every non-key attribute must depend on the entire primary key (not just part of it).

🔍 Application

Since all tables use single-column primary keys (UUIDs) (e.g., user_id, property_id, etc.),
there are no composite keys and therefore no partial dependencies.

✅ Result: All tables meet 2NF.

🧮 Step 3: Third Normal Form (3NF)
✅ Rules of 3NF

Must already satisfy 2NF.

No transitive dependencies — non-key attributes must depend only on the primary key, not on other non-key attributes.

🔍 Analysis and Fixes
Table	Possible Issue	Resolution
User	Storing derived data like full name or total bookings could create transitive dependencies.	Exclude computed/derived fields. Keep only base attributes.
Property	Location details like city, country could be repeated.	If necessary, create a Location table to store unique locations and reference it via location_id.
Booking	Total price could depend on price_per_night × duration.	Store only base price and compute totals in queries.
Payment	Payment method details (e.g., card number, provider info) could be repeated.	Create a separate PaymentMethod table if detailed payment info is needed.
Review	No issues — each review belongs to a property and user.	
Message	No issues — sender and recipient both reference User.	

✅ Result: All tables are now in Third Normal Form (3NF).

✅ Final Normalized Schema Overview

User(user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)

Property(property_id, host_id [FK], name, description, location, price_per_night, created_at)

Booking(booking_id, user_id [FK], property_id [FK], start_date, end_date, status, created_at)

Payment(payment_id, booking_id [FK], amount, payment_date, payment_method)

Review(review_id, user_id [FK], property_id [FK], rating, comment, created_at)

Message(message_id, sender_id [FK], recipient_id [FK], message_body, sent_at)

(Optional normalization enhancement: create Location and PaymentMethod tables if data repetition grows.)