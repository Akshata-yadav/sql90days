
CREATE TABLE april6 (
    user_id INT,
    user_name VARCHAR(50),
    song_name VARCHAR(50),
    artist_name VARCHAR(50),
    genre VARCHAR(30),
    listen_date DATE,
    minutes_listened INT
);

INSERT INTO april6 VALUES
(1, 'Aman', 'Song A', 'Arijit', 'Romantic', '2024-01-01', 4),
(2, 'Neha', 'Song B', 'Shreya', 'Classical', '2024-01-01', 5),
(3, 'Ravi', 'Song C', 'Arijit', 'Romantic', '2024-01-02', 6),
(4, 'Pooja', 'Song D', 'Badshah', 'Rap', '2024-01-02', 3),
(5, 'Karan', 'Song E', 'Honey Singh', 'Rap', '2024-01-03', 7),
(6, 'Simran', 'Song F', 'Shreya', 'Classical', '2024-01-03', 8),
(7, 'Vikram', 'Song G', 'Arijit', 'Romantic', '2024-01-04', 5),
(8, 'Anjali', 'Song H', 'Badshah', 'Rap', '2024-01-04', 6),
(9, 'Rahul', 'Song I', 'Arijit', 'Romantic', '2024-01-05', 7),
(10, 'Sneha', 'Song J', 'Shreya', 'Classical', '2024-01-05', 4);

select * from april6;

---Rank songs based on minutes_listened (highest first).
select song_name,minutes_listened , rank() over(order by minutes_listened desc) as song_based_minutes_listened from april6;

---Find row number of songs within each genre ordered by listen_date.
select song_name,genre,listen_date, row_number() over(partition by genre order by listen_date) as
songs_rn from april6;

---Find dense rank of artists based on total minutes listened (per artist).
select artist_name,total_minutes,dense_rank() over(order by total_minutes desc) as artist_rank from (
select artist_name,sum(minutes_listened) as total_minutes from april6 group by artist_name
)t;

---Show previous song’s minutes_listened using LAG()
select * from april6;

select * , lag(minutes_listened) over(order by listen_date) as prev_minutes from april6;

---Show next song’s minutes_listened using LEAD().
select *,lead(minutes_listened) over(order by listen_date) as next_minutes from april6;

---Calculate running total of minutes_listened per user.
select * from april6;

select * ,sum(minutes_listened) over(partition by user_id order by listen_date) as running_total
from april6;

---Average listening time per genre
select * from april6;

select *,avg(minutes_listened) over(partition by genre) as avg_listening_time  from 
april6;

---Maximum minutes_listened per artist
select * from april6;

select *,max(minutes_listened) over(partition by artist_name) as max_min from april6;

---Difference between current and previous minutes per user
select *,minutes_listened - lag(minutes_listened) over(
partition by user_id 
order by listen_date) as diff_minutes 
from april6;

----Top 2 most listened songs per genre
select * from (
select * , row_number() over(partition by genre order by minutes_listened desc) as rn 
from april6)t
where rn <= 2;

---Find total minutes listened per genre.
select * from april6;

select genre , sum(minutes_listened) as total_minutes from april6
group by genre;

---Find total minutes listened per artist only for 'Romantic' genre.
select * from april6;

select artist_name , genre,sum(minutes_listened) as total_minutes from april6 where genre = 'Romantic'
group by artist_name ,genre;

---Find artists whose total listening time is more than 15 minutes.
select * from april6;

select artist_name, sum(minutes_listened) as total_listening from april6
group by artist_name 
having sum(minutes_listened) > 15;

---Find number of songs listened by each user where minutes_listened > 5.
select * from april6;

select user_name , count(*) as number_count from april6 where minutes_listened > 5
group by user_name;

--Find genres where average listening time is greater than 5 minutes.
select * from april6;

select genre,avg(minutes_listened) as avg_listening from april6
group by genre
having avg(minutes_listened) > 5;

