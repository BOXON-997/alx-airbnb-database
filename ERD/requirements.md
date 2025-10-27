Check out my visualized ER design on the Database Design

https://drive.google.com/file/d/159a-F5gx9clbMiR_UcUy2wVcTmZZ099n/view?usp=sharing

Airbnb Database – ERD Requirements
🎯 Objective

Design an Entity-Relationship Diagram (ERD) for the Airbnb-style booking platform.
The ERD defines all core entities, their key attributes, and the relationships between them.

🧩 Entities and Attributes
🧑‍💼 User
Attribute	Type	Description
user_id	UUID (PK)	Unique user identifier
first_name	VARCHAR	User's first name
last_name	VARCHAR	User's last name
email	VARCHAR (UNIQUE)	Login email
password_hash	VARCHAR	Encrypted password
phone_number	VARCHAR	Optional contact number
role	ENUM (guest, host, admin)	Defines user type
created_at	TIMESTAMP	Auto timestamp on creation
🏠 Property
Attribute	Type	Description
property_id	UUID (PK)	Unique property ID
host_id	UUID (FK → User.user_id)	Owner/host
name	VARCHAR	Property name
description	TEXT	Details of the listing
location	VARCHAR	City or area
price_per_night	DECIMAL	Cost per night
created_at	TIMESTAMP	Creation timestamp
updated_at	TIMESTAMP	Auto update timestamp
📅 Booking
Attribute	Type	Description
booking_id	UUID (PK)	Booking identifier
property_id	UUID (FK → Property.property_id)	Booked property
user_id	UUID (FK → User.user_id)	Guest who made the booking
start_date	DATE	Start of stay
end_date	DATE	End of stay
total_price	DECIMAL	Calculated total
status	ENUM (pending, confirmed, canceled)	Booking state
created_at	TIMESTAMP	Booking creation time
💳 Payment
Attribute	Type	Description
payment_id	UUID (PK)	Payment ID
booking_id	UUID (FK → Booking.booking_id)	Related booking
amount	DECIMAL	Amount paid
payment_date	TIMESTAMP	Date of payment
payment_method	ENUM (credit_card, paypal, stripe)	Payment channel
⭐ Review
Attribute	Type	Description
review_id	UUID (PK)	Review ID
property_id	UUID (FK → Property.property_id)	Reviewed property
user_id	UUID (FK → User.user_id)	Reviewer
rating	INTEGER (1-5)	Rating score
comment	TEXT	Feedback text
created_at	TIMESTAMP	Review creation time
💬 Message
Attribute	Type	Description
message_id	UUID (PK)	Message ID
sender_id	UUID (FK → User.user_id)	Message sender
recipient_id	UUID (FK → User.user_id)	Message recipient
message_body	TEXT	Content of the message
sent_at	TIMESTAMP	Timestamp sent