create database air_line;
use air_line;

create table flights(
flight_id int primary key ,
flight_no int,
source_city varchar(50),
destination varchar(50)
);

insert into flights(flight_id,flight_no,source_city,destination)values
(1,'11','mumbai','delhi'),
(2,'12','delhi','chennai'),
(3,'13','banglure','mumbai'),
(4,'14','chennai','pune'),
(5,'15','mumbai','banglure'),
(6,'16','hyderabad','pune');

select * from flights;

create table passengers(
passengers_id int primary key ,
name varchar(50),
age int,
city varchar(50)
);

insert into passengers(passengers_id,name,age,city)values
(1,'ali','22','mumbai'),
(2,'khizar','23','delhi'),
(3,'shaik','21','banglure'),
(4,'khizarali','20','chennai'),
(5,'skali','25','pune');

select * from passengers;

create table bookings(
booking_id int primary key,
passengers_id int,
flight_id int,
ticket_price int,
travel_date date,
foreign key (passengers_id) references passengers(passengers_id),
foreign key (flight_id) references flights(flight_id)
);


INSERT INTO bookings (booking_id, passengers_id, flight_id, ticket_price, travel_date)
VALUES 
(1, 1, 1, '5000', '2025-10-12'),
(2, 2, 2, '10000', '2025-10-13'),
(3, 3, 2, '15000', '2025-10-14'),
(4, 4, 3, '20000', '2025-10-15'),
(5, 5, 4, '25000', '2025-10-16'),
(6, 1, 5, '15000', '2025-10-17'),
(7, 2, 5, '10000', '2025-10-18'),
(8, 2, 6, '25000', '2025-10-19'),
(9, 3, 1, '20000', '2025-10-20'),
(10, 4, 4, '15000', '2025-10-21');

select * from bookings;

1--show all passengers with their flight details-----

SELECT p.name, f.flight_no, f.source_city, f.destination, b.travel_date FROM passengers p
JOIN bookings b ON p.passengers_id = b.passengers_id JOIN flights f ON b.flight_id = f.flight_id;

2-- List all flights that depart from Mumbai----

select * from flights where source_city ='mumbai';

3-- find average ticket price for each flight route

SELECT f.source_city, f.destination, AVG(b.ticket_price) AS avg_price FROM bookings b JOIN flights f ON b.flight_id = f.flight_id GROUP BY f.source_city, f.destination;

4. Show passengers who booked tickets costing more than ₹6000:

SELECT p.name, b.ticket_price FROM passengers p JOIN bookings b ON p.passengers_id = b.passengers_id WHERE b.ticket_price > 6000;

5. Find the most expensive flight booked:

SELECT f.flight_no, MAX(b.ticket_price) AS max_price FROM bookings b JOIN flights f ON b.flight_id = f.flight_id 
GROUP BY f.flight_no ORDER BY max_price DESC LIMIT 1;


6. Categorize passengers based on ticket price--

select p.name,b.ticket_price,
case
when b.ticket_price < 15000 then 'low'
when b.ticket_price between 15000 and 25000 then 'medium'
else 'high'
end as category
from passengers p
join bookings b on p.passengers_id = b.passengers_id;

7. Find passengers who paid above the average ticket price--

select p.name,b.ticket_price from passengers p
join bookings b on p.passengers_id = b.passengers_id 
where b.ticket_price>(select avg(ticket_price) from bookings);

8. List all passengers who are from Delhi or Mumbai:---

select p.name  from passengers p where p.city in ('delhi','mumbai');


9. Show bookings made between ‘2025-10-09’ and ‘2025-10-12’:---

select * from bookings where travel_date between '2025-10-09' and '2025-10-12';

Show total ticket revenue for each destination:---

select f.destination, sum(b.ticket_price) as total_revenue  from bookings b
join flights f on b.flight_id = f.flight_id 
group by f.destination;

11. Find average ticket price paid by each passenger:---

select p.name, avg(b.ticket_price)  as avg_price from passengers p
join bookings b on p.passengers_id = b.passengers_id
group by p.name;


12. Show passenger name, flight number, and travel date:---

select p.name, f.flight_no,b.travel_date from passengers p
join bookings b on p.passengers_id = b.passengers_id
join flights f on b.flight_id = f.flight_id;


13. Find which cities passengers are traveling to:---

select distinct f.destination from bookings b
join flights f on b.flight_id = f.flight_id;

14. Show all passengers with their booked flight numbers:--

select p.name, f.flight_no from passengers p
join bookings b on p.passengers_id = b.passengers_id
join flights f on b.flight_id = f.flight_id;

15. Show passenger names with their travel route (source → destination):---

SELECT p.name, CONCAT(f.source_city, ' → ', f.destination) AS travel_route
FROM passengers p
JOIN bookings b ON p.passengers_id = b.passengers_id
JOIN flights f ON b.flight_id = f.flight_id;

16. Show total amount spent by each passenger:--

select p.name, sum(b.ticket_price) as total_spent from passengers p
join bookings b on p.passengers_id = b.passengers_id
group by p.name;