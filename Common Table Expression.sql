# Using CTE (common table expression)

<pre>
WITH top_5_customers_from_10_cities_cte (avarage_amount_paid) AS
(SELECT 
	  A.customer_id, 
	  A.first_name, 
	  A.last_name, 
	  D.country, 
	  C.city, 
		SUM(E.amount) AS total_amount_paid
FROM payment E
	JOIN customer A ON E.customer_id = A.customer_id
	JOIN address B ON A.address_id = B.address_id
	JOIN city C ON B.city_id = C.city_id
	JOIN country D ON C.country_id = D.country_id
WHERE C.city in
	(SELECT C.city 
	 FROM customer A
	JOIN address B ON A.address_id = B.address_id
	JOIN city C ON B.city_id = C.city_id
	JOIN country D ON C.country_id = D.country_id
WHERE D.country IN 
	(SELECT D.country FROM customer A
	JOIN address B ON A.address_id = B.address_id
	JOIN city C ON B.city_id = C.city_id
	JOIN country D ON C.country_id = D.country_id
GROUP BY D.country
ORDER BY COUNT(customer_id) DESC
LIMIT 10)
GROUP BY D.country, C.city
ORDER BY COUNT(customer_id) DESC
LIMIT 10)
GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
ORDER BY total_amount_paid DESC
LIMIT 5)
SELECT AVG(total_amount_paid)
FROM top_5_customers_from_10_cities_cte
</pre>
