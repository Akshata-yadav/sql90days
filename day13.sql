CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(20)
);

INSERT INTO customer VALUES
(101, 'Amit', 'Mumbai'),
(102, 'Neha', 'Pune'),
(103, 'Raj', 'Delhi'),
(104, 'Sneha', 'Mumbai'),
(105, 'Karan', 'Pune'),
(106, 'Pooja', 'Delhi'),
(107, 'Vikas', 'Mumbai');

select * from customer;

CREATE TABLE orderr (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(30),
    amount INT,
    order_date DATE
);

INSERT INTO orderr VALUES
(1, 101, 'Laptop', 50000, '2024-01-10'),
(2, 102, 'Shoes', 3000, '2024-01-12'),
(3, 101, 'Mobile', 20000, '2024-01-15'),
(4, 103, 'TV', 40000, '2024-02-01'),
(5, 104, 'Headphones', 2000, '2024-02-05'),
(6, 108, 'Tablet', 15000, '2024-02-10'),  -- no matching customer
(7, 105, 'Shoes', 3500, '2024-02-18'),
(8, 106, 'Fridge', 30000, '2024-03-01');

select * from customer;
select * from orderr;

---Get customer name and their orders
select c.customer_name , o.* from customer c inner join 
orderr o on c.customer_id = o.customer_id;

---Show all orders with customer city
select c.city ,o.* from customer c right join orderr o 
on c.customer_id = o.customer_id;

---Get total order amount per customer
select * from customer;
select * from orderr;

select c.customer_name , sum(o.amount) as total_amount from customer c 
inner join orderr o on c.customer_id = o.customer_id 
group by c.customer_name;

---Find number of orders per customer
select c.customer_name , count(o.order_id) as no_orders from customer c
inner join orderr o on c.customer_id = o.customer_id 
group by c.customer_name;

---Get customers who placed at least 1 order
select c.* , o.* from customer c  inner join orderr o 
on c.customer_id = o.customer_id;

---Get all customers and their orders (including those with no orders)
select c.* ,o.* from customer c left join orderr o 
on c.customer_id = o.customer_id;

---Find customers who have not placed any order
select * from customer;
select * from orderr;

---Get all customers and their orders (including those with no orders)
select c.* ,o.* from customer c left join orderr o 
on c.customer_id = o.customer_id,

---Get all orders including those without matching customers
select c.* ,o.* from customer c right join orderr o 
on c.customer_id = o.customer_id;

---Find orders where customer details are missing
select c.* ,o.* from customer c right join orderr o 
on c.customer_id = o.customer_id
where c.customer_id is null;

---Get customer name and total order amount, include customers with 0 orders
select c.customer_name ,coalesce(sum(o.amount),0) as total_order from customer c left join orderr o 
on c.customer_id = o.customer_id
group by c.customer_name;
