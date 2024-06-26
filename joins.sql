
-- CHALLENGE - Joining on multiple tables

USE sakila;

-- 1. List the number of films per category.
SELECT name as category_name, COUNT(*) AS num_films
FROM category 
JOIN film_category USING (category_id)
GROUP BY name
ORDER BY num_films DESC;

-- 2. Retrieve the store ID, city, and country for each store.
SELECT s.store_id, c.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS co ON c.country_id = co.country_id;

-- 3. Calculate the total revenue generated by each store in dollars.
SELECT store.store_id, SUM(payment.amount) AS total_revenue
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 4. Determine the average running time of films for each category.
SELECT category.name, ROUND(AVG(film.length),2) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

-- 5. Identify the film categories with the longest average running time. Round the average to two decimal places.
SELECT category.name, ROUND(AVG(film.length),2) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY average_running_time DESC;

-- 6. Display the top 10 most frequently rented movies in descending order.
SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY rental_count DESC
LIMIT 10;

-- 7 Can "Academy Dinosaur" be rented from Store 1.
SELECT film.film_id, film.title, store.store_id, inventory.inventory_id
FROM inventory
JOIN store using (store_id)
JOIN film using (film_id)
WHERE title = 'Academy Dinosaur' AND store.store_id = 1;
