CREATE TABLE day17 (
    order_id INT,
    customer_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    order_date DATE,
    city VARCHAR(50),
    discount DECIMAL(5,2)
);

INSERT INTO day17 VALUES
(1, 101, 'T-Shirt', 'Clothing', 'Nike', 1200, 2, '2024-01-10', 'Mumbai', 10),
(2, 102, 'Shoes', 'Footwear', 'Adidas', 3000, 1, '2024-01-12', 'Delhi', 15),
(3, 103, 'Jeans', 'Clothing', 'Levis', 2500, 1, '2024-01-15', 'Mumbai', 5),
(4, 101, 'Jacket', 'Clothing', 'Puma', 4000, 1, '2024-02-01', 'Mumbai', 20),
(5, 104, 'Sneakers', 'Footwear', 'Nike', 3500, 2, '2024-02-05', 'Bangalore', 25),
(6, 105, 'Kurta', 'Ethnic', 'FabIndia', 1800, 1, '2024-02-10', 'Delhi', 10),
(7, 102, 'Sandals', 'Footwear', 'Bata', 1200, 2, '2024-02-12', 'Delhi', 5),
(8, 106, 'Dress', 'Clothing', 'Zara', 2800, 1, '2024-03-01', 'Mumbai', 15),
(9, 103, 'T-Shirt', 'Clothing', 'Nike', 1500, 3, '2024-03-05', 'Mumbai', 10),
(10, 107, 'Heels', 'Footwear', 'Metro', 2200, 1, '2024-03-10', 'Chennai', 20),
(11, 108, 'Saree', 'Ethnic', 'Biba', 3200, 1, '2024-03-15', 'Delhi', 30),
(12, 109, 'Shirt', 'Clothing', 'H&M', 2000, 2, '2024-03-18', 'Mumbai', 10),
(13, 110, 'Shorts', 'Clothing', 'Puma', 1500, 1, '2024-03-20', 'Bangalore', 5),
(14, 101, 'Shoes', 'Footwear', 'Nike', 3200, 1, '2024-03-22', 'Mumbai', 20),
(15, 104, 'Kurta', 'Ethnic', 'FabIndia', 2000, 2, '2024-03-25', 'Bangalore', 15);

select * from day17;

---Show all orders from Mumbai.
select * from day17 where city = 'Mumbai';

---Find total number of orders.
select * from day17;

select count(*) as order_count from day17;

---Get distinct categories available.
select * from day17;

select distinct(category)as distinct_category from day17;

---Find total revenue (price × quantity)
select * from day17;

select sum(price * quantity) as revenue from day17;

---Show orders where discount > 15%.
select * from day17;

select * from day17 where discount > 15;

---Find total sales per category.
select category, sum(price* quantity) as total_sales from day17
group by category;

---Find average order value per city.
select * from day17;

select city , avg(price*quantity) as aov from day17
group by city;

---Get top 3 most expensive products.
select * from day17;

select top 3 sum(price * quantity) as most_expensive ,product_name  as total_sum from day17
group by product_name 
order by sum(price * quantity) desc;

---Count number of orders per brand.
select * from day17;

select brand , count(*) as no_of_orders from day17
group by brand;

---Find total quantity sold per product.
select * from day17;

select product_name , sum(quantity) as total_quantity from day17
group by product_name ;

---Find top 2 highest spending customers.
select * from day17;

select top 2 customer_id , sum(price*quantity) as revenue from day17
group by customer_id 
order by sum(price*quantity) desc;

---Find revenue contribution (%) of each category.
select * from day17;

select category, sum(price*quantity) as total ,
round(sum(price*quantity) * 100.0 / sum(sum(price*quantity)) over() , 2 )as revenue_percentage 
from day17
group by category;

---Rank Products Based on Total Sales
select * from day17;

select product_name , sum(price*quantity) as total_sales,rank()
over(order by sum(price*quantity)) as rnk_product from day17
group by product_name;

---Customers Who Made More Than 1 Purchase
select * from day17;

select customer_id , count(order_id) as order_count from day17
group by customer_id 
having count(order_id) > 1;

---Running Total of Revenue by Order Date
SELECT 
    order_date,
    SUM(price * quantity) AS daily_revenue,
    SUM(SUM(price * quantity)) OVER (
        ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM day17
GROUP BY order_date
ORDER BY order_date;