--1
SELECT ord_no, purch_amt, ord_date, customer_id, s.salesman_id FROM Salesman s
JOIN Orders o on s.salesman_id = o.salesman_id
where s.name = 'Paul Adam'

--2 
SELECT * FROM orders
WHERE salesman_id in (SELECT salesman_id FROM salesman
where city = 'London')

--3
select * from orders a
where a.salesman_id in (select * from orders b
where b.salesman_id = 3007)

--4
select * from orders
where purch_amt in (SELECT AVG(purch_amt) FROM orders WHERE ord_date = '10/10/2012')

--5
select * from orders
where salesman_id in (select salesman_id from salesman
where city = 'New York')

--6
select commission from salesman
where salesman_id in (select salesman_id from customer where city = 'Paris')

--7
SELECT * from customer
where customer_id <= (select salesman_id - 2001 from salesman
where name = 'Mc Lyon')

--8
SELECT COUNT(customer_id) from customer
where grade > (select AVG(grade) from customer
where city = 'New York')

--9
SELECT ord_no, purch_amt, ord_date, salesman_id from orders 
where salesman_id in (select salesman_id from salesman where commission = (select max(commission) from salesman))

--16
select * from salesman
where salesman_id in (select salesman_id from customer group by salesman_id having count(customer_id) >1 )

--17
select salesman_id, name, commission from salesman
where salesman_id in (select salesman_id from customer group by salesman_id having count(customer_id) =1)

--18
select salesman_id, name, city, commission from salesman
where salesman_id in (select customer_id from orders group by salesman_id having count(ord_no) >1)