create table restaurant_data.users_master
(
	id	serial	primary key,
	first_name	varchar(100) not null,
	second_name	varchar(100) not null,
	email		varchar(100) not null,
	phone_number	varchar(11),
	age		integer
);

create table younger_than_20 () inherits (restaurant_dta.users_master);

create table between_20_and_60 () inherits (restaurant_data.users_master);

create table more_than_60 () inherits (restaurant_data.users_master);

CREATE OR REPLACE FUNCTION restaurant_data.age_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
	IF ( NEW.age < 20 ) THEN
		INSERT INTO restaurant_data.younger_than_20 VALUES
			(NEW.*);
	ELSIF ( NEW.age >= 20 AND NEW.age <= 60 ) THEN
		INSERT INTO restaurant_data.between_20_and_60 VALUES
			(NEW.*);
	ELSE
		RAISE EXCEPTION 'hehe';
	END IF;
	RETURN NULL;
END
$$
	LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER insert_age_trigger
	BEFORE INSERT OR UPDATE ON restaurant_data.users_master
	FOR EACH ROW
	WHEN ( pg_trigger_depth() < 1 )
EXECUTE FUNCTION restaurant_data.age_insert_trigger();
