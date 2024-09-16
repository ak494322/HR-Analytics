--question 2.2
select artist.name, artist.artist_id, count (artist.artist_id) as no_of_songs
from track
join album on track.album_id = album.album_id
join artist on album.artist_id = artist.artist_id
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by no_of_songs desc
limit 10

--question 3.1
with best_artist as 
(select artist.artist_id, artist.name, sum(invoice_line.unit_price) as total
from invoice_line
join track on track.track_id = invoice_line.track_id
join album on track.album_id = album.album_id
join artist on album.artist_id = artist.artist_id
group by artist.artist_id
order by total desc
limit 2
)

select customer.customer_id, customer.first_name, customer.last_name, best_artist.name,
sum(invoice_line.unit_price) as tot
from invoice
join customer on invoice.customer_id = customer.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join album on track.album_id = album.album_id
join best_artist on album.artist_id = best_artist.artist_id
group by 1,2,3,4
order by tot desc	
limit 10

--question 3.2
with popular_genre as(
select invoice.billing_country, genre.name, count(genre.name) as nog,
Row_number() over(partition by invoice.billing_country order by count(genre.name) desc) as Rowno
from genre
join track on genre.genre_id = track.genre_id
join invoice_line on track.track_id = invoice_line.track_id
join invoice on invoice_line.invoice_id = invoice.invoice_id
group by 1, 2
order by nog desc
)
select * from popular_genre
where Rowno<=1

--question 3.3
with ct as (
select customer.first_name, customer.last_name, customer.country, 
sum(invoice.total),
Row_number() over(partition by customer.country order by sum(invoice.total) desc) as Rowno
from invoice
join customer on invoice.customer_id = customer.customer_id
group by 1,2,3
)

select * from ct
where Rowno <= 1



