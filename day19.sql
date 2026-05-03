CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);

CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    disease VARCHAR(50),
    treatment_cost DECIMAL(10,2),
    treatment_date DATE
);

INSERT INTO patient VALUES
(1, 'Amit', 34, 'Mumbai'),
(2, 'Neha', 28, 'Delhi'),
(3, 'Raj', 45, 'Bangalore'),
(4, 'Simran', 38, 'Mumbai'),
(5, 'Karan', 50, 'Pune'),
(6, 'Pooja', 30, 'Delhi');

INSERT INTO treatment VALUES
(101, 1, 'Diabetes', 5000, '2024-01-10'),
(102, 1, 'Flu', 1500, '2024-02-15'),
(103, 2, 'Cancer', 20000, '2024-01-20'),
(104, 3, 'Diabetes', 7000, '2024-03-05'),
(105, 4, 'Flu', 1200, '2024-03-10'),
(106, 4, 'Cancer', 25000, '2024-04-01'),
(107, 5, 'Diabetes', 8000, '2024-02-25');

select * from patient;
select * from treatment;

---Get all patients with their diseases.
select p.*,t.disease from patient p inner join treatment t on
p.patient_id = t.patient_id;

---Show all patients and their treatments (including patients with no treatment).
select p.*,t.* from patient p left join treatment t on 
p.patient_id = t.patient_id;

---Find patients who have taken treatment for Diabetes.
select p.*,t.disease from patient p inner join treatment t on
p.patient_id = t.patient_id
where t.disease = 'Diabetes';

---List all treatments with patient name and city.
select p.patient_name , p.city ,t.* from patient p 
right join treatment t on p.patient_id = t.patient_id;

--Find total treatment cost per patient.
select * from patient;
select * from treatment;

select p.patient_name ,sum(t.treatment_cost) as total_cost from patient p 
inner join treatment t on p.patient_id = t.patient_id 
group by p.patient_name;

---Get average treatment cost per city.
select p.city ,avg(t.treatment_cost) as avg_treatment from patient p 
inner join treatment t on p.patient_id = t.patient_id 
group by p.city;

---Find patients who never had any treatment. (LEFT JOIN + IS NULL)
select p.* , t.* from patient p left join treatment t 
on p.patient_id = t.patient_id 
where t.patient_id is null;

----Find the most common disease (highest count).
select * from patient;
select * from treatment;

select top 1 count(t.disease) , p.patient_name from patient p 
inner join treatment t on p.patient_id = t.patient_id 
group by patient_name 
order by count(t.disease) desc;

---Find total revenue generated per city.
select * from patient;
select * from treatment;

select p.city , sum(treatment_cost) as total_revenue from patient p 
inner join treatment t on 
p.patient_id = t.patient_id 
group by p.city;

----Find top 2 patients who spent the most on treatments.
select top 2 p.patient_id , sum(t.treatment_cost) as most_spent from patient p 
inner join treatment t on p.patient_id = t.patient_id 
group by p.patient_id 
order by sum(t.treatment_cost) desc;