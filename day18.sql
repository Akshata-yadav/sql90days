CREATE TABLE day18 (
    visit_id INT PRIMARY KEY,
    patient_id INT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    disease VARCHAR(50),
    doctor_name VARCHAR(50),
    visit_date DATE,
    treatment_cost DECIMAL(10,2)
);

INSERT INTO day18 VALUES
(1, 201, 'Rohit', 45, 'Male', 'Mumbai', 'Diabetes', 'Dr. Mehta', '2024-01-01', 2000),
(2, 202, 'Priya', 30, 'Female', 'Delhi', 'Flu', 'Dr. Sharma', '2024-01-02', 500),
(3, 203, 'Aman', 60, 'Male', 'Mumbai', 'Heart Disease', 'Dr. Mehta', '2024-01-03', 10000),
(4, 201, 'Rohit', 45, 'Male', 'Mumbai', 'Diabetes', 'Dr. Mehta', '2024-01-10', 2500),
(5, 204, 'Sneha', 25, 'Female', 'Bangalore', 'Flu', 'Dr. Reddy', '2024-01-05', 700),
(6, 205, 'Karan', 50, 'Male', 'Delhi', 'Blood Pressure', 'Dr. Sharma', '2024-01-06', 1500),
(7, 206, 'Anjali', 35, 'Female', 'Mumbai', 'Flu', 'Dr. Mehta', '2024-01-07', 600),
(8, 202, 'Priya', 30, 'Female', 'Delhi', 'Flu', 'Dr. Sharma', '2024-01-15', 800),
(9, 207, 'Vikas', 55, 'Male', 'Bangalore', 'Diabetes', 'Dr. Reddy', '2024-01-08', 2200),
(10, 208, 'Neha', 40, 'Female', 'Mumbai', 'Heart Disease', 'Dr. Mehta', '2024-01-09', 12000);

select * from day18;

---Show all patients from Mumbai
select * from day18 where city = 'Mumbai';

---Find total number of visits
select * from day18;

select count(visit_id) as total_number from day18

---Get all unique diseases
select * from day18;

select distinct(disease) as unique_disease from day18;

---Find patients with treatment cost > 5000
select * from day18;

select * from day18 where treatment_cost > 5000;

---Show visits where age > 50
select * from day18;

select * from day18 where age > 50;

---Find total treatment cost per disease
select * from day18;

select disease ,sum(treatment_cost) as total_treatment from day18
group by disease;

---Count number of visits per doctor
select * from day18;

select doctor_name,count(*) as visit_count from day18
group by doctor_name;

---Find average treatment cost per city
select * from day18;

select city,avg(treatment_cost) as avg_cost from day18
group by city;

---Get patients who visited more than once
select * from day18;

select patient_id , count(*) as patient_visit from day18
group by patient_id 
having count(*) > 1;

---Find total cost spent by each patient
select * from day18;

select patient_id, sum(treatment_cost) as total_cost from day18
group by patient_id;

---Rank patients based on total spending
select * from day18;

select patient_id , sum(treatment_cost) as total_spending, rank() 
over(order by sum(treatment_cost)) as rn from day18
group by patient_id;

---find most common disease (highest count)
select * from day18;

select top 1 disease,count(*) as total_cont from day18
group by disease 
order by count(*) desc;

---Calculate running total of treatment cost by visit_date
select * from day18;

select patient_id , visit_date, sum(treatment_cost) over
(partition by patient_id order by visit_date rows between unbounded preceding and current row) as rt
from day18;

---Find highest treatment cost per city
select * from day18;

select * from (
select *,rank() over(partition by city order by treatment_cost desc) as rnk 
from day18
)t 
where rnk = 1;

---Find patients whose total spending is above average
select * from day18;

SELECT patient_id, patient_name, SUM(treatment_cost) AS total_spending
FROM day18
GROUP BY patient_id, patient_name
HAVING SUM(treatment_cost) > (
    SELECT AVG(treatment_cost)
    FROM day18
);
