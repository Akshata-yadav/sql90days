CREATE TABLE day12 (
    order_id INT,
    customer_id INT,
    product_category VARCHAR(30),
    amount INT,
    order_date DATE,
    city VARCHAR(20),
    sales_rep VARCHAR(20)
);

INSERT INTO day12 VALUES
(1, 101, 'Electronics', 15000, '2024-01-10', 'Mumbai', 'R1'),
(2, 102, 'Clothing', 3000, '2024-01-12', 'Pune', 'R2'),
(3, 103, 'Electronics', 20000, '2024-01-15', 'Mumbai', 'R1'),
(4, 101, 'Groceries', 2500, '2024-02-01', 'Mumbai', 'R3'),
(5, 104, 'Clothing', 4000, '2024-02-05', 'Delhi', 'R2'),
(6, 105, 'Electronics', 18000, '2024-02-10', 'Pune', 'R3'),
(7, 106, 'Furniture', 22000, '2024-02-12', 'Delhi', 'R1'),
(8, 102, 'Clothing', 3500, '2024-02-18', 'Pune', 'R2'),
(9, 107, 'Groceries', 2000, '2024-03-01', 'Mumbai', 'R3'),
(10, 108, 'Furniture', 25000, '2024-03-03', 'Delhi', 'R1'),
(11, 109, 'Electronics', 12000, '2024-03-05', 'Mumbai', 'R2'),
(12, 110, 'Clothing', 2800, '2024-03-08', 'Pune', 'R3'),
(13, 111, 'Furniture', 30000, '2024-03-10', 'Delhi', 'R1'),
(14, 101, 'Electronics', 16000, '2024-03-12', 'Mumbai', 'R3'),
(15, 112, 'Groceries', 1800, '2024-03-15', 'Pune', 'R2');

select * from day12;

---Find total sales amount for each product_category
select product_category, sum(amount) as sales_amount from day12
group by product_category;

---Count number of orders per city
select * from day12;

select city , count(*) as order_count from day12
group by city;

---Find average order amount per sales_rep
select * from day12;

select sales_rep ,avg(amount) as avg_order_amount from day12
group by sales_rep;

---Get maximum order amount per product_category
select * from day12;

select product_category , max(amount) as max_order_amount from day12
group by product_category;

---Find total sales per customer
select * from day12;

select customer_id , sum(amount) as total_sales from day12
group by customer_id;

---Find product categories with total sales greater than 30,000
select * from day12;

select product_category, sum(amount) as total_sales from day12
group by product_category 
having sum(amount) > 30000;

---Get cities where total sales amount is more than 40,000
select city, sum(amount) as total_sales from day12
group by city
having sum(amount) > 40000;

---Find customers who placed more than 2 orders
select * from day12;

select customer_id , count(*) as order_count from day12
group by customer_id 
having count(*) > 2;

---Get sales reps who handled more than 3 orde
select sales_rep , count(*) as order_count from day12
group by sales_rep 
having count(*) > 3;

---Find product categories with average sales amount greater than 10,000
select * from day12;

select product_category , avg(amount) as avg_sales_amount from day12 
group by product_category 
having avg(amount) > 10000;

---Find customers whose total purchase amount is greater than 25,000
select * from day12;

select customer_id , sum(amount) as total_amount from day12
group by customer_id 
having sum(amount) > 25000;

---Get cities where average order amount is less than 10,000
select * from day12;

select city, avg(amount) as avg_order_amount from day12
group by city 
having avg(amount) < 10000;

---Find sales reps whose total sales fall between 20,000 and 60,000
select * from day12;

select sales_rep , sum(amount) as total_sales from day12
group by sales_rep
having sum(amount) between 20000 and 60000;

---Get product categories having more than 2 orders and total sales > 20,000
select * from day12;

select product_category , sum(amount) as total_sales ,count(*) as order_count from day12
group by product_category
having count(*) > 2 and sum(amount) > 20000;

---Find customers who made purchases in more than 1 product category
select customer_id ,count (distinct product_category) as unique_cat from day12
group by customer_id 
having count(distinct product_category) > 1;

