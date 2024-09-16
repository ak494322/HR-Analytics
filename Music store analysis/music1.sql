--Question 1.1
select * from employee
order by levels desc
limit 1

--question 1.2
select  billing_country, count(billing_country) as co from invoice
group by billing_country
	order by co desc
	limit 1

-- question 1.3
select total from invoice 
order by total desc
limit 3

--question 1.4
select sum(total) as invoice_total, billing_city 
	from invoice
group by billing_city
order by invoice_total desc
limit 1

--question 1.5
select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id 
order by total desc
limit 1

--question 2.1
select distinct email, first_name, last_name from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
	select track_id from track
    join genre on track.genre_id = genre.genre_id
    where genre.name = 'Rock'
)
order by email;

--question 2.2











