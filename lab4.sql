ALTER DATABASE postgres SET session_preload_libraries = 'anon'

create extension anon cascade;

select anon.init();

ALTER DATABASE postgres SET anon.sourceschema TO 'rastaurant_data';

select anon.start_dynamic_masking();

create role cucumber login;

security label for anon on role cucumber is 'MASKED';
SECURITY LABEL FOR anon ON COLUMN restaurant_data.users.phone_number
	IS 'MASKED WITH FUNCTION anon.partial(phone_number, 2, $$*******$$, 2)';

set role cucumber;

select *
from mask.users;


CREATE MATERIALIZED VIEW restaurant_data.generalized_booking_info AS
SELECT 
	id,
	user_id,
	anon.generalize_int4range(restaurant_id, 5),
	anon.generalize_int4range(num_guests, 3) AS booking_date,
	anon.generalize_daterange(booking_date, 'decade') AS birth
FROM restaurant_data.booking_info;

CREATE MATERIALIZED VIEW restaurant_data.generalized_booking_info AS
SELECT 
	id,
	user_id,
	anon.fake_first_name() as first_name,
	anon.fake_last_name() as second_name,
	anon.fake_email() as email,
FROM restaurant_data.cooks;

CREATE MATERIALIZED VIEW restaurant_data.generalized_restaurants AS
SELECT 
	anon.random_string(12) as name,
	anon.random_string(50) as about_info,
	anon.random_int_between(7, 19) as city_id,
	anon.random_int_between(1, 15) as picture_id
FROM restaurant_data.restaurants;
