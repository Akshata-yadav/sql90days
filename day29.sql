CREATE TABLE day29(
    ticket_id INT PRIMARY KEY,
    employee_id INT,
    department VARCHAR(50),
    issue_type VARCHAR(50),
    priority VARCHAR(20),
    status VARCHAR(20),
    created_date DATE,
    resolved_date DATE,
    agent_name VARCHAR(50)
);

INSERT INTO day29 VALUES
(101,1001,'HR','Payroll','High','Resolved','2026-01-05','2026-01-07','Rahul'),
(102,1002,'Finance','Leave Request','Medium','Resolved','2026-01-06','2026-01-08','Priya'),
(103,1003,'IT','System Access','High','Open','2026-01-07',NULL,'Amit'),
(104,1004,'Sales','Payroll','Low','Resolved','2026-01-08','2026-01-10','Rahul'),
(105,1005,'HR','Benefits','Medium','Resolved','2026-01-09','2026-01-11','Priya'),
(106,1001,'HR','Leave Request','Low','Open','2026-01-10',NULL,'Amit'),
(107,1006,'IT','System Access','High','Resolved','2026-01-11','2026-01-12','Rahul'),
(108,1007,'Finance','Benefits','Medium','Resolved','2026-01-12','2026-01-14','Priya'),
(109,1008,'Sales','Payroll','High','Open','2026-01-13',NULL,'Amit'),
(110,1009,'IT','System Access','Medium','Resolved','2026-01-14','2026-01-15','Rahul');

select * from day29;

----Display all tickets
select * from day29;

----Show all open tickets.
select * from day29 where status = 'Open';

----Find tickets raised by employees from the IT department.
select * from day29;

select * from day29 where department = 'IT';

----Count the total number of tickets.
select count(ticket_id) as total_ticket from day29;

----Find the number of tickets handled by each agent.
select * from day29;

select agent_name , count(ticket_id) as no_of_tickets from day29
group by agent_name;

----Find departments that raised more than 2 tickets.
select department,count(ticket_id) as ticket_count from day29
group by department 
having count(*) > 2;

----Find the number of tickets by issue type.
select issue_type , count(ticket_id) as no_of_ticket from day29
group by issue_type;

----Show agents who resolved more than 2 tickets.
select * from day29;

select agent_name , count(*) as ticket_count
from day29 where status = 'Resolved' 
group by agent_name 
having count(*) > 2;

---Find employees who raised more than one ticket.
select * from day29;

select employee_id , count(ticket_id) as ticket_count from day29
group by employee_id 
having count(*) > 1;

----Find the most common issue type.
select * from day29;

select top 1 issue_type,count(issue_type) as issue_count from day29
group by issue_type
order by count(*) desc;

