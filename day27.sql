CREATE TABLE day27 (
    watch_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    movie_name VARCHAR(100),
    genre VARCHAR(30),
    watch_time_minutes INT,
    device_type VARCHAR(30),
    subscription_plan VARCHAR(20),
    watch_date DATE
);

INSERT INTO day27 VALUES
(1, 'Amit Sharma', 'Inception', 'Sci-Fi', 148, 'Mobile', 'Premium', '2025-01-10'),

(2, 'Priya Mehta', '3 Idiots', 'Comedy', 170, 'Laptop', 'Standard', '2025-01-12'),

(3, 'Rahul Verma', 'Avengers Endgame', 'Action', 181, 'Smart TV', 'Premium', '2025-01-14'),

(4, 'Sneha Patil', 'Bhool Bhulaiyaa', 'Comedy', 129, 'Mobile', 'Basic', '2025-01-15'),

(5, 'Karan Singh', 'Titanic', 'Romance', 195, 'Laptop', 'Premium', '2025-01-18'),

(6, 'Neha Joshi', 'The Batman', 'Action', 176, 'Tablet', 'Standard', '2025-01-20'),

(7, 'Arjun Nair', 'Drishyam', 'Thriller', 145, 'Mobile', 'Basic', '2025-01-22'),

(8, 'Pooja Desai', 'Deadpool', 'Comedy', 108, 'Smart TV', 'Premium', '2025-01-25'),

(9, 'Vikas Rao', 'Interstellar', 'Sci-Fi', 169, 'Laptop', 'Standard', '2025-01-27'),

(10, 'Meera Kulkarni', 'Zindagi Na Milegi Dobara', 'Comedy', 155, 'Mobile', 'Premium', '2025-01-30');

select * from day27;

---Show all watch history records.
select * from day27;

---Find users who watched movies for more than 120 minutes.
select user_name from day27 where watch_time_minutes > 120;

---Display all Comedy genre movies.
select * from day27 where genre = 'Comedy';

---Count total movies watched by each user.
select user_name , count(*) as total_movies from day27 
group by user_name;

----Find the most used device type.
select * from day27;

select top 1 count(*) as device_type_count,device_type from day27
group by device_type
order by count(*) desc;

---Show movies watched on mobile devices only.
select * from day27;

select movie_name from day27 where device_type = 'Mobile';

---Find average watch time by subscription plan.
select * from day27;

select avg(watch_time_minutes) as avg_watch , subscription_plan from day27
group by subscription_plan;

---Display the latest watched movie.
select * from day27;

select top 1 movie_name, watch_date as latest_watched
from day27
order by watch_date desc;

---Rank users based on total watch time.
select * from day27;

select user_name, sum(watch_time_minutes) as total_watch, rank() over
(order by sum(watch_time_minutes) desc) as rn 
from day27
group by user_name;

---Find users who watched more than 2 movies.
select * from day27;

select user_name , count(*) as movie_count from day27
group by user_name 
having count(*) > 2;

