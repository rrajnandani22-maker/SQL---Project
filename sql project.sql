drop table if exists books;
create table books(
	book_id serial primary key ,
	title varchar(100),
	author varchar(100),
	genre varchar (50),
	published_year int,
	price numeric (10,2),
	stock int
);
drop table if exists customers;
create table customers(
	customer_id serial primary key,
	name varchar (100),
	emial varchar (100),
	phone varchar (15),
	city varchar (50),
	country varchar (150)
	);
drop table if exists orders ;
create table orders(
	order_id serial primary key,
	customer_id int  references customers (customer_id),
	book_id int references books (book_id),
	order_date date ,
	quantity int,
	total_amount numeric (10,2)
	);

select * from books;
select * from customers;
select*from orders;
1--retirve all books in the 'fiction'genre:
select * from books
where genre ='Fiction';

2--find books published after the 1950 year
select * from books
where published_year >1950;

3--list all customers from the canada
select * from customers 
where country = 'Canada';

4--show orders placed in november 2023
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

5--retrive the total stock of the book avilable 
select sum (stock)as total_stock
from books;

6--find the details of the most expensive book
select *from books order by price desc  limit 1;


7--show all the customers who ordered more then 1 quantity of a book 
select * from orders 
where quantity>1;

8--retrive  all orders where the total amount exceed $20:
select * from orders 
where total_amount >20;

9--list all the genre available in the book table:
select distinct genre from books;
 
10--find the books with the lowest stock 
select * from books order by stock asc ; 

11--calcutale the total revenue generated from all orders:
select sum (total_amount)as revenue from orders;

-----advance query 

12--retrive the total number of books sold for each genre 
select b. genre , sum(o.quantity)as total_books_sold
from orders o 
join books b on o.book_id = b.book_id
group by b.genre;

13--find the average price of the books in the fantasy genre
select avg (price )as avg_price 
from books 
where genre = 'Fantasy';

14--List coustomers who have orderd at least 2 order
select o. customer_id ,c.name, count (o.customer_id) from orders o
join customers c on o.customer_id = c.customer_id 
group by o. customer_id ,c.name 
having count(o.customer_id)>=2;

15--find the most frequently orderd book 
select book_id,count (order_id)as order_count 
from orders 
group by book_id
order by order_count desc ;

16--show the top 3 most expensive books of 'fantasy' genre 
select * from books 
where genre = 'Fantasy' 
ORDER BY PRICE desc limit 3;

17--retrive the total quantity of books sold by each author
select b.author  ,  sum (o.quantity)as total_sold_books
from orders o 
join books b on o.book_id = b.book_id
group by b. author;

18--list the cities where customers who spent over $30 are located 
select distinct  c.city , total_amount
from orders o
join customers c on o.customer_id = c. customer_id
where o.total_amount >30;

19--find the customers who spent the most on orders 
select c. customer_id , c.name ,sum (o.total_amount)as total_spent
from orders o
join customers c on o.customer_id=c.customer_id
group by c.customer_id , c. name
order by total_spent desc  ;

20--calculate the stock remaining after fufiling all orders 
select b.book_id, b. title , b.stock , coalesce (sum (quantity),0)as order_quantity
from books b
left join orders o on b.book_id =o.book_id 
group by b.book_id;