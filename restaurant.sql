-- count resaurant example

CREATE TABLE payment_methods (
   id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200)
);

CREATE TABLE tables (

    id INT PRIMARY KEY AUTO_INCREMENT,
    num_seats INT,
    category VARCHAR(200)
);

CREATE TABLE bookings (
 id INT PRIMARY KEY AUTO_INCREMENT,
    booking_date DATE NOT NULL,
    num_guests INT NOT NULL,
    amount_billed NUMERIC(6, 2)  NOT NULL,
    amount_tipped NUMERIC(6, 2),
    payment_id INT REFERENCES payment_methods,
    table_id INT REFERENCES tables
);

select count(*) from bookings; -- count how many bookings in the table booking

select count(amount_tipped) from bookings;

select count(distinct booking_date) from bookings;


select max(amount_billed),max(amount_tipped) as max_tipped
from bookings;

select sum(amount_billed) from bookings;

select avg(num_guests) from bookings;


select round(avg(num_guests)) from bookings; -- round number no decimals


select round(avg(num_guests)) from bookings
where amount_billed > 20 and num_guests > 2; -- add more conditions using keyword add


select booking_date, sum(num_guests) 
from bookings
group by booking_date;


select name, sum(num_guests)
from payment_methods as p
inner join bookings as b on p.id=b.payment_id
group by p.name




-- filter data with 'where'

select booking_date, count(booking_date)
from bookings
where amount_billed > 30
group by booking_date;


-- having

select booking_date, count(booking_date)
from bookings
group by booking_date
having sum(amount_billed) > 30;


-- nested query


select booking_date
from bookings
group by booking_date
having sum(amount_billed) =(
    select min(daily_sum)
    from(
        select booking_date, sum(amount_billed) as daily_sum
        from bookings
        group by booking_date
    )
    as daily_table);


-- window function

select booking_date, amount_tipped, sum(amount_tipped) over()
from bookings;

select booking_date, amount_tipped, sum(amount_tipped) over(
partition by booking_date order by amount_billed)
from bookings;


-- math functions

select price * billing_frequency
from memberships;

select ceil (consumption)   -- no decimals
from memberships;

floor

-- string functions


select concat('$ ',price)
from memberships;


trim(trailing ' ' from 'male  ');  -- delete the blankspace


select weekday(last_checkin) +1,last_checkin from memberships;


-- calculate the diffrence of the time

select timestampdiff(minute,last_checkin,last_checkout)
from memberships;

-- calculate the difference of days
select datediff(membership_end,membership_start)
from memberships;



select datediff(now(),membership_start)
from memberships;




select date_add(membership_start, interval 7 day),membership_end
from memberships;



select first_name like 'Ma%', first_name
from memberships; -- something not 100% sure


select first_name 
from memberships
where first_name like 'J____'




select exists (
); -- to check one certain value if avilable



-- subquery in


select email
from customers
where id in(select customer_id from orders);

-- condition expression

select price,
    case when price >199 then'good day'
        when price >19 then 'Normal day'
        else 'bad day'
    END
 from memberships;


select weekday_no,
case when weekday_no =1 then 'Monday'
    when weekday_no =2 then 'Tuesday'
    when weekday_no =3 then 'Wednesday'
    when weekday_no =4 then 'Thursday'
    when weekday_no =5 then 'Friday'
    when weekday_no =6 then 'Saturday'
    else 'Sunday'
    end
from(select weekday(last_checkin) + 1 as weekday_no
from memberships)as weekday_numbers; -- as have to be set, every drived table must have alias



















