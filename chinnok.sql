-- Month-wise invoice sales 
select monthname(invoicedate) as month,sum(total) as sales 
from invoice group by month order by sales desc;

-- Employees and their managers
select e.firstname as employee,m.firstname as manager from employee e join employee m 
on e.reportsto=m.employeeid;

-- Name of the customers who have made a purchase in the USA
select distinct customerid,c.firstname,c.lastname from customer c join invoice i using(customerid) where 
i.billingcountry='usa';

-- Show the name of each genre and the total number of tracks in that genre.
select g.name,count(t.trackid) from genre g join track t using(genreid) group by g.genreid,g.name;

-- Show the name of each customer and the total amount they have spent on purchases.
select c.firstname,c.lastname,sum(i.total) as total_amount from customer c join invoice i 
using(customerid) group by c.customerid;

-- Name of the album with the highest unit price.
with cte2 as
(with cte1 as (select a.title,sum(t.unitprice) as album_price from album a left join track t
 using(albumid) group by a.title order by album_price desc)
 select *,rank() over(order by album_price desc) as album_rank from cte1)
 select * from cte2 where album_rank=1;
 
 
 -- Show the name of each track and the total number of times it has been purchased.
 select t.trackid,t.name,count(invoicelineid),count(invoiceid) from track t left join invoiceline i 
 using(trackid) group by t.trackid,t.name;
 
 --  Find the name of the customer who has made the largest purchase in terms of total cost.
 select c.customerid,c.firstname,sum(i.total) as total_sales from customer c left join invoice i 
 using(customerid) group by c.customerid,c.firstname order by total_sales desc;
 
 -- Find the total amount spent by each customer and the number of invoices they have.
 select c.customerid,c.firstname,sum(i.total) as total_sales,count(i.customerid) as invoice_count 
 from customer c left join invoice i using(customerid) group by c.customerid,c.firstname order by total_sales desc;
 
 -- Find the name of the artist who has the most tracks in the chinook database.
 select a.artistid,a.name,count(t.trackid) as no_tracks from artist a left join album al using(artistid) 
 left join track t using(albumid) group by a.artistid,a.name order by no_tracks desc;
 
 -- Customer details who have spent more than the average amount on invoices
 select c.customerid,c.firstname,c.email,sum(i.total) as total_sales,avg(i.total) as avg_sales from customer c left join invoice i 
 using(customerid) group by c.customerid,c.firstname having total_sales>avg_sales;
 
 -- Names of the artists that have tracks in the 'Rock' genre.
 select distinct a.artistid,a.name,g.name from artist a left join album al using(artistid) left join track t
 using(albumid) left join genre g using(genreid) where g.name='rock';