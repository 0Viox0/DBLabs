create view restaurant_data.restaurants_and_cooks as
select r.name	as restaurant_name,
	about_info,
	c.first_name as cook_first_name,
	c.second_name as cook_second_name,
	c.contact_info
from restaurant_data.restaurants_cooks
	inner join restaurant_data.cooks c on c.id = restaurants_cooks.cook_id
	inner join restaurant_data.restaurants r on r.id = restaurants_cooks.restaurant_id;


create index indx_user_id on restaurant_data.booking_info using btree (user_id, restaurant_id);

select * 
from restaurant_data.booking_info
where user_id = 35 and restaurant_id = 5;

create index idx_user_first_name-second_name on restaurant_data.users using btree (first_name, second_name);

select *
from restaurant_data.users
where first_name = 'jake' and second_name = 'cornell'
