CREATE TABLE april10 (
    member_id INT,
    visit_date DATE,
    workout_type VARCHAR(50),
    duration_minutes INT,
    calories_burned INT,
    trainer_name VARCHAR(50),
    membership_type VARCHAR(20)  -- Basic / Premium
);

INSERT INTO april10 VALUES
(1, '2024-03-01', 'Cardio', 45, 400, 'Rohit', 'Premium'),
(1, '2024-03-03', 'Strength', 60, 500, 'Rohit', 'Premium'),
(2, '2024-03-01', 'Yoga', 30, 150, 'Neha', 'Basic'),
(2, '2024-03-04', 'Cardio', 40, 350, 'Neha', 'Basic'),
(3, '2024-03-02', 'Strength', 55, 480, 'Amit', 'Premium'),
(3, '2024-03-05', 'Cardio', 50, 420, 'Amit', 'Premium'),
(4, '2024-03-01', 'Yoga', 35, 200, 'Neha', 'Basic'),
(4, '2024-03-06', 'Strength', 65, 550, 'Rohit', 'Premium'),
(5, '2024-03-02', 'Cardio', 20, 180, 'Amit', 'Basic'),
(5, '2024-03-07', 'Yoga', 30, 160, 'Neha', 'Basic'),
(6, '2024-03-03', 'Strength', 70, 600, 'Rohit', 'Premium'),
(6, '2024-03-08', 'Cardio', 45, 390, 'Amit', 'Premium');

select * from april10;

---Find total calories burned by each member.
select member_id , sum(calories_burned) as total_calories from april10
group by member_id;

---Find average workout duration for each workout type.
select * from april10;

select workout_type , avg(duration_minutes) as avg_workout_duration from april10
group by workout_type;

---Find number of visits per trainer.
select * from april10;

select trainer_name , count(visit_date) as no_visit from april10
group by trainer_name;

---Find which membership type burns more calories on average.
select * from april10;

select membership_type,avg(calories_burned) as avg_burned from april10
group by membership_type;

---Find total workout time for each member.
select * from april10;

select member_id , sum(duration_minutes) as total_workout_time from april10
group by member_id;

---Find the top 3 members who burned the most calories.
select * from april10;

---Find the top 3 members who burned the most calories.
select top 3 member_id , sum(calories_burned) as most_calories from april10
group by member_id 
order by sum(calories_burned) desc;

---Find members who visited the gym more than once in 3 days gap
select * from april10;

WITH visit_diff AS (
    SELECT 
        member_id,
        visit_date,
        LAG(visit_date) OVER (PARTITION BY member_id ORDER BY visit_date) AS prev_visit
    FROM april10
)

SELECT DISTINCT member_id
FROM visit_diff
WHERE DATEDIFF(day, prev_visit, visit_date) <= 3;

---Find the most popular workout type (highest count).
select * from april10;

select top 1 workout_type, count(*) as workout_count from april10
group by workout_type 
order by workout_count desc;

---Find each member’s latest workout (use window function).
select * from april10;

select member_id,visit_date ,workout_type from (select *,row_number() over
(partition by member_id order by visit_date desc) as rn 
from april10 )t
where rn = 1;

---Rank trainers based on total calories burned
select * from april10;

select trainer_name , sum(calories_burned) as total_calories , rank() over
(order by sum(calories_burned) desc) as rn 
from april10
group by trainer_name;

---Members whose performance improved
with perf as (
select member_id , visit_date, calories_burned ,lag(calories_burned) over (partition by member_id order by visit_date) as prev_cal
from april10)

select distinct member_id from perf where calories_burned > prev_cal;

---Categorize workouts
select member_id , workout_type,calories_burned , 
case when calories_burned > 500 then 'high intensity'
when calories_burned between 300 and 500 then 'medium'
else 'low'
end as intensity_leve from april10;

CREATE TABLE course (
    user_id INT,
    course_name VARCHAR(50),
    session_date DATE,
    minutes_watched INT,
    quiz_score INT,
    device VARCHAR(20)  -- Mobile / Laptop
);

INSERT INTO course VALUES
(1, 'SQL Basics', '2024-02-01', 30, 80, 'Laptop'),
(1, 'SQL Basics', '2024-02-02', 40, 85, 'Mobile'),
(1, 'Power BI', '2024-02-05', 50, 90, 'Laptop'),

(2, 'SQL Basics', '2024-02-01', 20, 60, 'Mobile'),
(2, 'Power BI', '2024-02-03', 25, 70, 'Laptop'),

(3, 'Python', '2024-02-02', 60, 95, 'Laptop'),
(3, 'Python', '2024-02-04', 55, 92, 'Mobile'),

(4, 'SQL Basics', '2024-02-01', 10, 50, 'Mobile'),
(4, 'Power BI', '2024-02-06', 20, 65, 'Laptop'),

(5, 'Python', '2024-02-03', 45, 88, 'Laptop'),
(5, 'SQL Basics', '2024-02-05', 35, 78, 'Mobile');

select * from course;

---Find total minutes watched per course
select course_name , sum(minutes_watched) as total_minutes from course
group by course_name;

---Find courses where average quiz score > 80
select course_name , avg(quiz_score) as avg_qiuiz_score from course 
group by course_name;

---Find users who have watched more than 60 minutes in total
select * from course;

select user_id , sum(minutes_watched) as total_minutes from course 
group by user_id 
having sum(minutes_watched) > 60;

---Find courses that have been taken by more than 2 users
select * from course;

select course_name , count(distinct user_id) as course_count from course
group by course_name 
having count(distinct user_id) > 2;

---Find users whose average quiz score is greater than overall average quiz score
select * from course;

select user_id , avg(quiz_score) as avg_score from course group by user_id having avg(quiz_score)  > 
(select avg(quiz_score) from course);

