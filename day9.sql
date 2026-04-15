CREATE TABLE april15 (
    user_id INT,
    user_name VARCHAR(50),
    city VARCHAR(50),
    course_id INT,
    course_name VARCHAR(100),
    category VARCHAR(50),
    price INT,
    enroll_date DATE,
    completion_date DATE,
    progress INT,
    rating INT
);

INSERT INTO april15 VALUES
(1, 'Amit', 'Mumbai', 101, 'SQL for Beginners', 'Data', 999, '2024-03-01', '2024-03-10', 100, 5),
(1, 'Amit', 'Mumbai', 102, 'Advanced Excel', 'Data', 799, '2024-03-05', NULL, 60, NULL),

(2, 'Neha', 'Pune', 101, 'SQL for Beginners', 'Data', 999, '2024-03-02', '2024-03-12', 100, 4),
(2, 'Neha', 'Pune', 103, 'Python Basics', 'Programming', 1199, '2024-03-10', NULL, 40, NULL),

(3, 'Rahul', 'Delhi', 104, 'Power BI Dashboarding', 'Data', 1499, '2024-03-15', '2024-03-25', 100, 5),
(3, 'Rahul', 'Delhi', 105, 'Machine Learning Intro', 'AI', 1999, '2024-03-20', NULL, 30, NULL),

(4, 'Sneha', 'Mumbai', 101, 'SQL for Beginners', 'Data', 999, '2024-03-18', '2024-03-28', 100, 3),
(4, 'Sneha', 'Mumbai', 104, 'Power BI Dashboarding', 'Data', 1499, '2024-03-20', NULL, 80, NULL),

(5, 'Karan', 'Bangalore', 103, 'Python Basics', 'Programming', 1199, '2024-03-22', NULL, 20, NULL),
(5, 'Karan', 'Bangalore', 102, 'Advanced Excel', 'Data', 799, '2024-03-25', '2024-04-05', 100, 4);

select * from april15;

---Find total users per city
select city,count(user_id) as total_user from april15
group by city;

---Find total enrollments per course
select * from april15;

select course_name , count(course_id) as total_enrollment from april15
group by course_name;

---Find courses with more than 2 enrollments
select * from april15;

select course_name , count(course_id) as course_enrollment from april15
group by course_name 
having count(course_id) > 2;

---Find users who enrolled in more than 1 course
select * from april15;

select user_name , count(course_id) as user_enrollment from april15
group by user_name 
having count(course_id) > 1;

---Find average progress per course
select * from april15;

select course_name , avg(progress) as progress_per_course from april15
group by course_name;

---Find completion rate per course
select * from april15;

select course_name , count(*) as total_enrollments,
sum(case when progress = 100 then 1 else 0 end) as completed,
round(sum(case when progress = 100 then 1 else 0 end) * 100.0 /count(*),2) as completon_rate_percentage 
from april15
group by course_name;

---Find average rating per course (ignore NULLs)
select * from april15;

select course_name , avg(rating) as avg_rating from april15
group by course_name;

---Find users who completed all courses they enrolled in
select * from april15

select user_name , progress from april15 
where progress = '100';

---Find users whose latest course progress < previous course progress
select * from (
select user_id, user_name , course_name , enroll_date,progress, 
lag(progress) over(partition by user_id order by enroll_date) as prev_progress 
from april15)t
where progress < prev_progress;

--Revenue generated per category
select * from april15;

select category , sum(price) as revenue_generated from april15
group by category;

