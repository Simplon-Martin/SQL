---------------------------------- Interrogations avancées --------------------------------------

-- question 1 --
USE sakila;
SELECT monthname(rental_date)
FROM rental
WHERE year(rental_date) = 2006;


-- question 2 --
USE sakila;
SELECT timediff(rental.return_date, rental.rental_date) as location_tps
from rental;


-- question 3 --
USE sakila;
SELECT date_format(rental_date, "%d/%m/%Y")
FROM rental
WHERE year(rental_date) = 2005 and time(rental_date) >= "00:00:00" and time(rental_date) < "01:00:00";


-- question 4 --
USE sakila;
SELECT *
FROM rental
WHERE month(rental_date) >= 4 AND month(rental_date) <= 5 
ORDER BY rental_date DESC;


-- question 5 --
USE sakila;
SELECT title
FROM film
WHERE title NOT LIKE "Le%";


-- question 6 --
USE sakila;
SELECT title, rating, 
CASE rating 
WHEN "NC-17"
	THEN "OUI"
	ELSE "NON"
END AS Resultat
FROM film
WHERE rating = "PG-13" or rating = "NC-17";


-- question 7 --
USE sakila;
SELECT name
FROM category
WHERE LEFT(name, 1) = 'A' OR LEFT(name, 1) = 'C';


-- question 8 --
USE sakila;
SELECT LEFT(name, 3) as name_3_caract
FROM category;


-- question 9 --
USE sakila;
SELECT REPLACE(first_name, 'E', 'A') as switched_first_name
FROM actor
LIMIT 20;



--------------------------------------- Les jointures ---------------------------------------------


-- question 1 --
USE sakila;
SELECT title as film_titre, name as film_langue
FROM film
INNER JOIN language ON film.language_id = language.language_id
LIMIT 10;


-- question 2 --
USE sakila;
SELECT film.title as titre_film, actor.first_name as prenom_acteur, actor.last_name as nom_acteur
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id
WHERE actor.first_name = "JENNIFER" AND actor.last_name = "DAVIS" AND film.release_year = "2006";


-- question 3 --
USE sakila;
SELECT customer.first_name, customer.last_name
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
WHERE film.title = "ALABAMA DEVIL";


-- question 4 --
USE sakila;
SELECT distinct film.title
from film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
WHERE city.city = "Woodridge";


-- question 5 --
USE sakila;
SELECT distinct film.title, timediff(rental.return_date, rental.rental_date) as diff_tps
from film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
where rental.rental_date IS NOT NULL AND rental.return_date IS NOT NULL
ORDER BY diff_tps
LIMIT 10;


-- question 6 --
USE sakila;
SELECT film.title
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "ACTION"
ORDER BY category.name;


-- question 7 --
USE sakila;
SELECT distinct film.title
from film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date IS NOT NULL AND rental.return_date IS NOT NULL AND datediff(rental.return_date, rental.rental_date) < 2



---------------------------------------------------------- Pour aller plus loin ----------------------------------------------------------



-- Question 1 --
USE sakila;
SELECT customer.last_name, customer.first_name, film.title, city.city,
timediff(rental.return_date, rental.rental_date) as diff_tps
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
INNER JOIN store ON customer.store_id = store.store_id
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
where rental.rental_date IS NOT NULL AND rental.return_date IS NOT NULL
ORDER BY diff_tps DESC
LIMIT 10;



-- Question 2 --
USE sakila;
SELECT customer.first_name, SUM(payment.amount) as somme
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 10;



-- Question 3 --
USE sakila;
SELECT film.title, AVG(timediff(rental.return_date, rental.rental_date)) as moyenne
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date IS NOT NULL AND rental.return_date IS NOT NULL
GROUP BY film.film_id
ORDER BY moyenne DESC;



-- Question 4 --
USE sakila;
SELECT film.title
FROM film
WHERE film.title NOT IN(
	SELECT distinct film.title
	FROM rental
	JOIN inventory ON rental.inventory_id = inventory.inventory_id
	JOIN film ON inventory.film_id = film.film_id
);



-- Question 5 --
USE sakila;
SELECT store.store_id, address.address, count(staff.staff_id) as nb_employee
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN address ON store.address_id = address.address_id
group by store.store_id;



-- Question 6 --
USE sakila;
SELECT city.city, count(store.store_id) as nb_store
from city
JOIN address ON city.city_id = address.city_id
JOIN store ON address.address_id = store.address_id
GROUP BY city.city_id
ORDER BY nb_store DESC
LIMIT 10;



-- Question 7 --
USE sakila;
SELECT film.title, film.length
from film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = "JOHNNY" AND actor.last_name = "LOLLOBRIGIDA"
ORDER BY film.length DESC
LIMIT 1;



-- Question 8 --
SELECT film.title, avg(timediff(rental.return_date, rental.rental_date)) as moyenne
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE film.title = "ACADEMY DINOSAUR";



-- Question 9 --
USE sakila;
SELECT store.store_id, film.title, count(film.title) as nb_film
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY inventory.film_id, store.store_id
HAVING nb_film > 2;



-- Question 10 --
USE sakila;
SELECT film.title
FROM film
WHERE film.title LIKE '%DIN%';



-- Question 11 --
USE sakila;
select film.title, count(film.film_id) as nb_location_par_film
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY nb_location_par_film DESC
LIMIT 5;



-- Question 12 --
USE sakila;
SELECT film.title, film.release_year
FROM film 
WHERE film.release_year = "2003" OR film.release_year = "2005" OR film.release_year = "2006"



-- Question 13 --
USE sakila;
SELECT film.title, rental.rental_date
FROM film 
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date IS NOT NULL AND rental.return_date IS NULL
ORDER BY rental.rental_date
LIMIT 10;



-- Question 14 --
USE sakila;
SELECT film.title, film.length, category.name
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Action" AND film.length > 120;



-- Question 15 --
USE sakila;
SELECT DISTINCT customer.first_name, customer.last_name
FROM film 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE film.rating = "NC-17"
GROUP BY customer.customer_id



-- Question 16 --
USE sakila;
SELECT film.title
FROM film
JOIN language ON film.language_id = language.language_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Animation" AND film.original_language_id = 1



-- Question 17 --
USE sakila;
SELECT film.title
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = "JENNIFER" AND film.film_id IN (
	SELECT film.film_id
	FROM film
	JOIN film_actor ON film.film_id = film_actor.film_id
	JOIN actor ON film_actor.actor_id = actor.actor_id
	WHERE actor.first_name = "JOHNNY"
);



-- Question 18 --
USE sakila;
SELECT count(film.film_id) as nb, category.name
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name
ORDER BY nb DESC
LIMIT 3



-- Question 19 --
USE sakila;
SELECT count(rental.rental_id) as nb, city.city
FROM store
JOIN inventory ON store.store_id = inventory.store_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
group by city.city_id
ORDER BY nb DESC
LIMIT 10;



-- Question 20 --
USE sakila;
SELECT count(film.film_id) as nb , actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id
HAVING nb > 1




---------------------------------------------------------- exercices Mise en pratique ---------------------------------------



-- Question 1 --
USE sakila;
SELECT COUNT(film.film_id) as nb_film, category.name
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = "JOHNNY" AND actor.last_name = "LOLLOBRIGIDA"
GROUP BY category.category_id



-- Question 2 --
USE sakila;
SELECT COUNT(film.film_id) as nb_film, category.name
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE actor.first_name = "JOHNNY" AND actor.last_name = "LOLLOBRIGIDA"
GROUP BY category.category_id
HAVING nb_film > 3



-- Question 3 --
USE sakila;
SELECT AVG(film.rental_duration) as moy, actor.first_name, actor.last_name
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor.actor_id



-- Question 4 --
USE sakila;
SELECT SUM(payment.amount) as total_depense, customer.first_name, customer.last_name
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_depense ASC
