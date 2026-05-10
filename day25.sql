CREATE TABLE day25(
    trade_id INT PRIMARY KEY,
    trader_name VARCHAR(50),
    stock_name VARCHAR(50),
    trade_type VARCHAR(10),   -- Buy / Sell
    quantity INT,
    price DECIMAL(10,2),
    trade_date DATE,
    broker_name VARCHAR(50),
    market VARCHAR(20)        -- NSE / BSE
);

INSERT INTO day25 VALUES
(1, 'Amit', 'TCS', 'Buy', 10, 3500, '2026-05-01', 'Zerodha', 'NSE'),
(2, 'Neha', 'Infosys', 'Sell', 5, 1450, '2026-05-02', 'Upstox', 'BSE'),
(3, 'Rahul', 'HDFC', 'Buy', 8, 1600, '2026-05-03', 'Groww', 'NSE'),
(4, 'Priya', 'Wipro', 'Sell', 12, 420, '2026-05-03', 'Zerodha', 'BSE'),
(5, 'Karan', 'Reliance', 'Buy', 15, 2800, '2026-05-04', 'AngelOne', 'NSE'),
(6, 'Sneha', 'ICICI', 'Buy', 20, 950, '2026-05-04', 'Groww', 'NSE'),
(7, 'Vikas', 'TCS', 'Sell', 7, 3550, '2026-05-05', 'Upstox', 'BSE'),
(8, 'Anjali', 'Infosys', 'Buy', 9, 1420, '2026-05-05', 'Zerodha', 'NSE'),
(9, 'Rohit', 'HDFC', 'Sell', 6, 1620, '2026-05-06', 'AngelOne', 'BSE'),
(10, 'Meera', 'Reliance', 'Buy', 11, 2780, '2026-05-06', 'Groww', 'NSE');


---Display all trade records.
select * from day25;

---Show only Buy trades.
select * from day25 where trade_type = 'Buy';

---Find trades where quantity is greater than 10.
select * from day25;

select * from day25 where quantity > 10;

---Display trader name and stock name only.
select * from day25;

select trader_name , stock_name from day25;

---Find total quantity traded for each stock.
select stock_name, sum(quantity) as total_quantity from day25
group by stock_name ;

---Show the highest stock price traded.
select max(price) as highest_stock from day25;

---Find the average price of all Buy trades.
select * from day25;

select avg(price) as avg_prce from day25 where trade_type = 'Buy';

---Display trades done through Zerodha broker.
select * from day25;

select * from day25 where broker_name = 'Zerodha';

---Find total trade value for each trade using : quantity * price
select trade_id , sum(quantity * price) as total_trade_value from day25 
group by trade_id;

---Show the latest trade based on trade_date.
select top 1 trade_id , trade_date from day25
order by trade_date desc;

