---------------------------------- Interrogations avancées --------------------------------------

-- question 1 --
USE sakila;
SELECT monthname(rental_date)
FROM rental
WHERE year(rental_date) = 2006;


-- question 2 --
USE sakila;
SELECT rental_duration
FROM film;


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
WHERE title NOT LIKE "LE%";


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
INNER JOIN store ON inventory.store_id = store.store_id
INNER JOIN address ON store.address_id = address.address_id
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






