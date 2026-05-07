CREATE TABLE day23 (
    trade_id INT PRIMARY KEY,
    investor_name VARCHAR(50),
    company_name VARCHAR(50),
    stock_type VARCHAR(20),   -- Equity / ETF
    quantity INT,
    buy_price DECIMAL(10,2),
    sell_price DECIMAL(10,2),
    trade_date DATE
);

INSERT INTO day23 VALUES
(101, 'Amit Sharma', 'TCS', 'Equity', 50, 3200.50, 3450.75, '2025-01-10'),
(102, 'Priya Mehta', 'Infosys', 'Equity', 30, 1450.00, 1525.25, '2025-01-12'),
(103, 'Rahul Verma', 'Reliance', 'Equity', 20, 2500.00, 2610.40, '2025-01-15'),
(104, 'Sneha Patil', 'HDFC Bank', 'Equity', 40, 1600.00, 1580.50, '2025-01-18'),
(105, 'Karan Singh', 'ICICI Bank', 'Equity', 35, 950.75, 1020.00, '2025-01-20'),
(106, 'Neha Joshi', 'Wipro', 'Equity', 60, 410.20, 430.10, '2025-01-22'),
(107, 'Arjun Nair', 'Adani Ports', 'Equity', 25, 780.00, 850.50, '2025-01-25'),
(108, 'Pooja Desai', 'SBI', 'Equity', 70, 620.00, 640.75, '2025-01-28'),
(109, 'Vikas Rao', 'Axis Bank', 'Equity', 45, 980.40, 940.25, '2025-02-01'),
(110, 'Meera Kulkarni', 'ITC', 'Equity', 100, 420.00, 455.60, '2025-02-03');

select * from day23;

---Show all stock trade records from the stock_trades table
select * from day23;

---Display all trades where the company name is 'TCS'.
select * from day23 where company_name = 'TCS';

---Find investors who bought more than 40 shares.
select investor_name , quantity from day23 where quantity > 40;

---Show investor name, company name, and calculated profit for each trade.
select * from day23;

select investor_name , company_name , (sell_price - buy_price ) as calculated_profit from day23;

---Find trades where sell price is lower than buy price.
select * from day23;

select * from day23 where sell_price < buy_price;

---Display the total quantity traded for each company.
select company_name , sum(quantity) as total_quantity from day23
group by company_name;

---Find the average buy price of stocks for each company.
select * from day23;

select company_name , avg(buy_price) as avg_buy_price from day23
group by company_name;

---Show the trade with the highest profit.
select * from day23;

select top 1 * , 
(sell_price - buy_price) as profit from day23
order by profit desc;

---Rank investors based on total profit earned.
select * from day23;

select investor_name , 
sum((sell_price - buy_price) * quantity) as total_profit , 
rank() over(order by sum((sell_price - buy_price) * quantity) desc) as rankiing 
from day23 
group by investor_name;

---Find companies where average sell price is greater than average buy price.
select * from day23;

select company_name , avg(buy_price) as avg_buy , 
avg(sell_price) as avg_sell from day23 
group by company_name 
having avg(sell_price) > avg(buy_price);