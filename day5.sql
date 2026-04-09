CREATE TABLE Customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO Customers VALUES
(1, 'Amit', 'Mumbai'),
(2, 'Neha', 'Delhi'),
(3, 'Raj', 'Pune'),
(4, 'Sara', 'Bangalore'),
(5, 'John', 'Chennai');

INSERT INTO Orders VALUES
(101, 1, '2024-01-01', 500),
(102, 2, '2024-01-02', 700),
(103, 1, '2024-01-03', 300),
(104, 3, '2024-01-04', 400),
(105, 6, '2024-01-05', 800); -- note: customer_id 6 doesn't exist

select * from Customers;

select * from Orders;

---Get all customers with their orders.
select c.customer_id,c.* , o.customer_id,o.* from Customers c
inner join Orders o on c.customer_id = o.customer_id;

---Show all customers and their orders (even if no orders).
select * from Customers;

select * from Orders;

select * from Customers c left join Orders o on 
c.customer_id = o.customer_id;

---Show all orders with customer details (even unmatched).
select * from Customers;
select * from Orders;

select * from Customers c right join Orders o 
on c.customer_id = o.customer_id;

----Get customer names who placed orders above 500.
select c.customer_name,o.amount  from Customers c left join Orders o on 
c.customer_id = o.customer_id 
where o.amount > 500;

---Find customers from Mumbai who placed orders.
select c.customer_name,c.city from Customers c right join Orders o on 
c.customer_id = o.customer_id 
where c.city = 'Mumbai';

---Find total order amount per customer
select * from Customers;
select * from Orders;

select c.customer_name , sum(o.amount) as total_order_amount from Customers c 
inner join Orders o on 
c.customer_id = o.customer_id
group by c.customer_name;

---Find average order amount per city.
select c.city , avg(o.amount) as aov from Customers c inner join 
Orders o on c.customer_id = o.customer_id 
group by c.city;

---Find customers who never placed any order.
select c.customer_id ,c.customer_name from Customers c left join 
orders o on c.customer_id = o.customer_id where o.customer_id is null;

---Find orders that do not have a matching customer
select o.customer_id,o.order_id,o.amount from Orders o left join 
Customers c on c.customer_id = o.customer_id 
where c.customer_id is null;

---Find the customer who placed the highest total order amount
select * from Customers;
select * from Orders;

select top 1 c.customer_name , sum(o.amount) as highest_total_order from Customers c inner join 
Orders o on c.customer_id = o.customer_id 
group by c.customer_name
order by sum(o.amount) desc;

CREATE TABLE april9 (
    patient_id INT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    disease VARCHAR(50),
    visit_date DATE,
    bill_amount INT,
    doctor_name VARCHAR(50)
);

INSERT INTO april9 VALUES
(1, 'Amit', 30, 'Male', 'Flu', '2024-01-01', 500, 'Dr. Sharma'),
(2, 'Neha', 25, 'Female', 'Cold', '2024-01-02', 300, 'Dr. Mehta'),
(3, 'Raj', 40, 'Male', 'Diabetes', '2024-01-03', 800, 'Dr. Sharma'),
(4, 'Sara', 35, 'Female', 'Flu', '2024-01-04', 400, 'Dr. Khan'),
(5, 'John', 50, 'Male', 'BP', '2024-01-05', 700, 'Dr. Mehta'),
(6, 'Priya', 28, 'Female', 'Cold', '2024-01-06', 350, 'Dr. Sharma'),
(7, 'Karan', 45, 'Male', 'Diabetes', '2024-01-07', 900, 'Dr. Khan');

select * from april9;

---Find patients with bill_amount > 500
select * from april9;

select * from april9 where bill_amount > 500;

---Get all patients diagnosed with Flu
select * from april9 where disease = 'Flu';

---Find total bill amount per disease
select disease, sum(bill_amount) as total_bill from april9
group by disease;

---Find average age per disease
select * from april9;

select disease, avg(age) as avg_age from april9
group by disease;

---Find diseases where average bill > 500
select * from april9;

select disease, avg(bill_amount) as avg_age from april9
group by disease
having avg(bill_amount) > 500;

---Get top 3 highest bills
select * from april9;

select top 3 patient_id,bill_amount from april9 
order by bill_amount desc;

---Find patients who visited after '2024-01-03'
select * from april9;

select * from april9 where visit_date > '2024-01-03';

---Categorize patients:
select * from april9;

select patient_id,bill_amount ,
case when bill_amount > 700 then 'High'
    when bill_amount between 400 and 700 then 'medium'
    else 'low'
    end as 'expense_category'
from april9;

---Rank patients based on bill_amount (highest first)
select * from april9;

select patient_id,bill_amount,rank() over
(order by bill_amount desc) as highest_first from april9;

---Find second highest bill amount
select * from april9;

select max(bill_amount) as second_higest from april9 where 
bill_amount < (select max(bill_amount) as second_higest from april9);

