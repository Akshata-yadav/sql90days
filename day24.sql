CREATE TABLE day24 (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(100),
    author VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    available_copies INT
);

INSERT INTO day24 VALUES
(1, 'The Alchemist', 'Paulo Coelho', 'Fiction', 450, 5),
(2, 'Wings of Fire', 'A.P.J Abdul Kalam', 'Biography', 300, 3),
(3, 'Data Structures', 'Narasimha Karumanchi', 'Education', 800, 2),
(4, 'Harry Potter', 'J.K. Rowling', 'Fantasy', 600, 4),
(5, 'Let Us C', 'Yashavant Kanetkar', 'Education', 350, 0),
(6, 'Rich Dad Poor Dad', 'Robert Kiyosaki', 'Finance', 500, 6),
(7, 'Atomic Habits', 'James Clear', 'Self-help', 550, 1);

----Display all books
select * from day24;

----Find all books where category = 'Fiction'.
select * from day24 where category = 'Fiction';

----Display books with price greater than 500.
select * from day24;

select * from day24 where price > 500;

---Find books where available_copies = 0.
select * from day24 where available_copies = 0;

---Increase available_copies by 2 for all Education category books.
select * from day24;

update day24 
set available_copies = available_copies + 2
where category = 'Education';

select * from day24;

---Delete books where available_copies = 0.
select * from day24;

delete from day24 where available_copies = 0;

---Show all books written by 'J.K. Rowling'.
select * from day24;

select * from day24 where author = 'J.K. Rowling';

---Display books in descending order of price.
select * from day24;

select book_name , price from day24 
order by price desc;

---Find the book with the lowest price.
select * from day24;

select min(price) as lowest_prce from day24;

---Find the total number of available copies in the library.
select * from day24;

select count(*) as total_number from day24;