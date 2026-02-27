use uber_management_system;

-- Check the total count of drivers

select count(*) as Total_drivers from drivers;

-- find Top 5 Rated Drivers

select full_name,rating from drivers order by rating desc limit 5;

-- find top 5 long distance trips with user name and driver name

select t.trip_id,u.full_name as "User Name",d.full_name as "Driver Name" ,t.distance_km from users u 
join trips t
on u.user_id=t.user_id
join drivers d
on t.driver_id=d.driver_id
order by t.distance_km desc limit 5;

-- find high paid trip details

select * from trips where fare_amount=(select max(fare_amount) from trips);

-- find day waise trip count

select date(booking_time) as Date ,count(*) as Day_Waise_Trip_Count from trips group by date(booking_time) order by Day_Waise_Trip_Count desc;

-- Total Revenue by City: Identify which Indian city generates the most business.

select u.city,sum(t.fare_amount) as Total_Revenue from trips t
join users u 
on t.user_id=u.user_id 
group by u.city order by Total_Revenue desc;

-- Check Most Popular Payment Method

select payment_method,count(*) as pyment_method_Count from payments 
group by payment_method order by pyment_method_Count desc;

-- Average Fare per Vehicle Category

SELECT v.category, ROUND(AVG(t.fare_amount), 2) as Avg_Fare 
FROM Trips t JOIN Vehicles v ON t.driver_id = v.driver_id 
GROUP BY v.category;

-- Drivers with Most Completed Trips

select d.full_name as "Driver Name",count(t.trip_id) as total_rides from drivers d
join trips t 
on d.driver_id=t.driver_id
where t.status='Completed' group by d.driver_id order by total_rides desc;

-- Low Rated Drivers (Action Required): Drivers falling below the 4.0 threshold.

select * from drivers where rating<4.0;

-- find which customer spend more amount

SELECT u.full_name, SUM(t.fare_amount) as total_spent 
FROM Users u JOIN Trips t ON u.user_id = t.user_id 
GROUP BY u.user_id ORDER BY total_spent DESC LIMIT 10;

-- High-Value Customers (Top Spenders): Identify users who spend the most.

select u.full_name as "User Name",sum(t.fare_amount) as total_spent from users u
join trips t 
on u.user_id=t.user_id
group by u.user_id order by total_spent desc;

-- Wallet Balance Distribution: See how much "float" money is in the system.

SELECT city, ROUND(SUM(wallet_balance), 2) as Total_Wallet_Cash FROM Users GROUP BY city;

-- Peak Booking Times hours waise booking count

select hour(booking_time) as ride_hour ,count(*) as ride_count from trips group by ride_hour order by ride_count desc;

-- Correlation Between Vehicle Category & Ratings: Do UberPremier rides get better reviews

SELECT v.category, AVG(r.rating) as avg_rating 
FROM Vehicles v JOIN Trips t ON v.driver_id = t.driver_id 
JOIN Reviews r ON t.trip_id = r.trip_id GROUP BY v.category;

-- find Common Feedback Keywords

select feedback ,count(*) as occurrence from reviews group by feedback;