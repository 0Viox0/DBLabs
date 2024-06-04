DROP TABLE restaurant_data.booking_info;
DROP TABLE restaurant_data.restaurants;

DROP TABLE restaurant_data.users;
DROP TABLE restaurant_data.categories;
DROP TABLE restaurant_data.cities;
DROP TABLE restaurant_data.pictures;
DROP TABLE restaurant_data.cooks;

CREATE TABLE restaurant_data.users (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	second_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	phone_number VARCHAR(11)
);

CREATE TABLE restaurant_data.categories (
	id SERIAL PRIMARY KEY,
	category_name VARCHAR(40),
	category_description TEXT
);

CREATE TABLE restaurant_data.cities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE restaurant_data.pictures (
	id SERIAL PRIMARY KEY,
	ulr TEXT
);

CREATE TABLE restaurant_data.cooks (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    second_name VARCHAR(100),
    contact_info TEXT
);

CREATE TABLE restaurant_data.restaurants (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	about_info TEXT NOT NULL,
	city_id INTEGER,
	picture_id INTEGER,

	FOREIGN KEY (city_id) REFERENCES restaurant_data.cities (id),
	FOREIGN KEY (picture_id) REFERENCES restaurant_data.pictures (id)
);

CREATE TABLE restaurant_data.booking_info (
    id SERIAL PRIMARY KEY,
	user_id INTEGER,
    restaurant_id INTEGER,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    num_guests INTEGER,
    
    FOREIGN KEY (user_id) REFERENCES restaurant_data.users (id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurant_data.restaurants (id)
);

CREATE TABLE restaurant_data.restaurants_categories (
	id SERIAL NOT NULL,
    restaurant_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    
    FOREIGN KEY (restaurant_id) REFERENCES restaurant_data.restaurants (id),
    FOREIGN KEY (category_id) REFERENCES restaurant_data.categories (id)
);

CREATE TABLE restaurant_data.restaurants_cooks (
	id SERIAL NOT NULL,
    restaurant_id INTEGER,
    cook_id INTEGER,
    
    FOREIGN KEY (restaurant_id) REFERENCES restaurant_data.restaurants (id),
    FOREIGN KEY (cook_id) REFERENCES restaurant_data.cooks (id)
);
