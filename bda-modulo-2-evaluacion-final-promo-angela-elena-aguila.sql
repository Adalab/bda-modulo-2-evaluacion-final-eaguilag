-- Evaluación Final Módulo 2

-- Para este ejerccio utilizaremos la BBDD Sakila
USE sakila;

-- 1.
/* Selecciona todos los nombres de las películas
sin que aparezcan duplicados. */

SELECT DISTINCT title
FROM film
ORDER BY title;
-- 1000 rows returned

-- 2.
/* Muestra los nombres de todas las películas
que tengan una clasificación de "PG-13". */

SELECT title
FROM film
WHERE rating = 'PG-13'
ORDER BY title;
-- 223 rows returned

-- 3.
/* Encuentra el título y la descripción de todas
las películas que contengan la palabra "amazing"
en su descripción. */

SELECT title, description
FROM film
WHERE description LIKE '%amazing%'
ORDER BY title;
-- 48 rows returned

-- 4.
/* Encuentra el título de todas las películas que
tengan una duración mayor a 120 minutos. */

SELECT title
FROM film
WHERE length > 120
ORDER BY title;
-- 457 rows returned

-- 5.
/* Recupera los nombres de todos los actores. */

SELECT DISTINCT
first_name AS nombre,
last_name AS apellido
FROM actor
ORDER BY apellido;
-- 199 rows returned

-- 6.
/* Encuentra el nombre y apellido de los actores
que tengan "Gibson" en su apellido. */

SELECT
first_name AS nombre,
last_name AS apellido
FROM actor
WHERE last_name REGEXP 'Gibson';
-- 1 row returned

-- 7.
/* Encuentra los nombres de los actores que
tengan un actor_id entre 10 y 20. */

SELECT
first_name AS nombre,
last_name AS apellido
FROM actor
WHERE actor_id BETWEEN 10 AND 20;
-- 11 rows returned

-- 8.
/* Encuentra el título de las películas en la tabla film
que no sean ni "R" ni "PG-13" en cuanto a su clasificación. */

SELECT title
FROM film
WHERE rating NOT IN ('R','PG-13')
ORDER BY title;
-- 582 rows returned

-- 9.
/* Encuentra la cantidad total de películas en cada clasificación
de la tabla film y muestra la clasificación junto con el recuento. */

SELECT 
category.name,
COUNT(film_category.film_id) AS num_films
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
GROUP BY category.name;
-- 16 rows returned

-- 10.
/* Encuentra la cantidad total de películas alquiladas
por cada cliente y muestra el ID del cliente, su nombre y
apellido junto con la cantidad de películas alquiladas. */

SELECT customer.customer_id,
customer.first_name,
customer.last_name,
COUNT(rental.rental_id) AS rented_films
FROM customer
LEFT JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id,
customer.first_name,
customer.last_name;
-- 599 rows returned

-- 11.
/* Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres. */

SELECT category.name,
COUNT(rental.rental_id) AS rented_films
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name;
-- 16 rows returned

-- 12.
/* Encuentra el promedio de duración de las películas para cada clasificación
de la tabla film y muestra la clasificación junto con el promedio de duración. */

SELECT rating,
AVG(length) AS avg_length
FROM film
GROUP BY rating;
-- 5 rows returned

-- 13.
/* Encuentra el nombre y apellido de los actores que
aparecen en la película con title "Indian Love". */

SELECT actor.first_name,
actor.last_name
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
JOIN film
ON film_actor.film_id = film.film_id
WHERE film.title = 'Indian Love'
ORDER BY actor.last_name;

-- 14.
/* Muestra el título de todas las películas que contengan
la palabra "dog" o "cat" en su descripción. */

SELECT title
FROM film
WHERE description LIKE '%cat%'
OR description LIKE '%dog%';
-- 167 rows returned

-- o usando regexp
SELECT title
FROM film
WHERE description REGEXP 'cat|dog';

-- 15.
/* Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. */

-- 16.
/* Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */

-- 17.
/* Encuentra el título de todas las películas que son de la misma categoría que "Family". */

-- 18.
/* Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

-- 19.
/* Encuentra el título de todas las películas que son "R" y
tienen una duración mayor a 2 horas en la tabla film. */

-- 20.
/* Encuentra las categorías de películas que tienen un promedio de duración superior
a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. */

-- 21.
/* Encuentra los actores que han actuado en al menos 5 películas y muestra
el nombre del actor junto con la cantidad de películas en las que han actuado. */

-- 22.
/* Encuentra el título de todas las películas que fueron alquiladas por más de 5 días.
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días
y luego selecciona las películas correspondientes. */

-- 23.
/* Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de
la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado
en películas de la categoría "Horror" y luego exclúyelos de la lista de actores. */

-- BONUS

-- 24.
/* BONUS: Encuentra el título de las películas que son comedias y
tienen una duración mayor a 180 minutos en la tabla film. */

-- 25.
/* BONUS: Encuentra todos los actores que han actuado juntos en al menos una película.
La consulta debe mostrar el nombre y apellido de los actores y el número de películas
en las que han actuado juntos. */
