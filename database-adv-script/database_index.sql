CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);
CREATE INDEX idx_bookings_date ON bookings(date);

CREATE INDEX idx_users_id ON users(id);
CREATE INDEX idx_properties_id ON properties(id);
CREATE INDEX idx_payments_id ON payments(id);