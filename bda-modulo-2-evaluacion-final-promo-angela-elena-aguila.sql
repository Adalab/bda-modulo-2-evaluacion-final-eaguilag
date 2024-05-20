-- Evaluación Final Módulo 2

-- Para este ejerccio utilizaremos la BBDD Sakila
USE sakila;

-- 1.
/* Selecciona todos los nombres de las películas
sin que aparezcan duplicados. */

SELECT DISTINCT title -- uso la clausula 'DISTINCT' para seleccionar varoles unicos
FROM film
ORDER BY title; -- organizo los resultados con la clausula 'ORDER BY' para visualizar los datos de manera efectiva
-- 1000 rows returned

-- 2.
/* Muestra los nombres de todas las películas
que tengan una clasificación de "PG-13". */

SELECT title
FROM film
WHERE rating = 'PG-13' -- uso operador de condicion 'WHERE' para filtrar datos y especifico condicion a cumplir
ORDER BY title;
-- 223 rows returned

-- 3.
/* Encuentra el título y la descripción de todas
las películas que contengan la palabra "amazing"
en su descripción. */

SELECT
title,
description
FROM film
WHERE description LIKE '%amazing%' -- uso clausula 'LIKE' para buscar patrones de texto
ORDER BY title;
-- 48 rows returned

-- 4.
/* Encuentra el título de todas las películas que
tengan una duración mayor a 120 minutos. */

SELECT title
FROM film
WHERE length > 120 -- especifico condicion a cumplir usando operador de comparacion 'mayor que'
ORDER BY title;
-- 457 rows returned

-- 5.
/* Recupera los nombres de todos los actores. */

SELECT DISTINCT -- uso 'DISTINCT' ya que un actor se repite
first_name AS nombre, -- renombro las columnas con la palabra clave 'AS' para una mejor legibilidad
last_name AS apellido
FROM actor
ORDER BY apellido;
-- 199 rows returned

-- 6.
/* Encuentra el nombre y apellido de los
actores que tengan "Gibson" en su apellido. */

SELECT
first_name AS nombre,
last_name AS apellido
FROM actor
WHERE last_name REGEXP 'Gibson'; -- busco patrones de texto usando expresiones regulares con la funcion 'REGEXP'
-- 1 row returned

-- 7.
/* Encuentra los nombres de los actores
que tengan un actor_id entre 10 y 20. */

SELECT
first_name AS nombre,
last_name AS apellido
FROM actor
WHERE actor_id BETWEEN 10 AND 20; -- establezco condicion 'WHERE' usando 'BETWEEN' para seleccionar valores dentro de un rango espcifico
-- 11 rows returned

-- 8.
/* Encuentra el título de las películas en la tabla film
que no sean ni "R" ni "PG-13" en cuanto a su clasificación. */

SELECT title
FROM film
WHERE rating NOT IN ('R','PG-13') -- empleo la operacion 'NOT IN' para excluir registros que coinciden con una lista de valores
ORDER BY title;
-- 582 rows returned

-- 9.
/* Encuentra la cantidad total de películas en cada clasificación
de la tabla film y muestra la clasificación junto con el recuento. */

SELECT
rating,
COUNT(*) AS num_films -- uso la funcion agregada 'COUNT(*)' para contar las ocurrencias de cada clasificacion
FROM film
GROUP BY rating; -- organizo los resultados de cada clasificacion con 'GROUP BY'
-- 5 rows returned

-- 10.
/* Encuentra la cantidad total de películas alquiladas
por cada cliente y muestra el ID del cliente, su nombre y
apellido junto con la cantidad de películas alquiladas. */

SELECT
customer.customer_id,
customer.first_name,
customer.last_name,
COUNT(rental.rental_id) AS rented_films
FROM customer
LEFT JOIN rental -- empleo 'JOIN' para combinar datos de diferentes tablas, en este caso 'LEFT JOIN' en caso de que algun cliente no haya alquilado ninguna pelicula
ON customer.customer_id = rental.customer_id -- uso palabra reservada 'ON' para  enlazar las tablas mediante una condicion de igualdad entre columnas
GROUP BY customer.customer_id,
customer.first_name,
customer.last_name;
-- 599 rows returned

-- 11.
/* Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres. */

SELECT category.name, (-- ahora empiezo una subconosulta para el recuento de alquileres:
	SELECT COUNT(*)
	FROM rental
	JOIN inventory -- empleo dos 'JOIN' (equivalente a 'INNER JOIN') para encontrar las coincidencias entre las tablas que quiero unir: rental -> inventory -> category
	ON rental.inventory_id = inventory.inventory_id
	JOIN film_category
	ON film_category.film_id = inventory.film_id
	WHERE film_category.category_id = category.category_id) AS rented_films
FROM category;
-- 16 rows returned

-- o usando 'CTE' para separar el conteo de alquileres (y poder reutilizarlo si fuese necesario) de la consulta principal
WITH category_rental_count AS (
    SELECT film_category.category_id,
    COUNT(*) AS rented_films -- funcion agregadaa 'COUNT' para hacer el conteo de alquileres
    FROM rental
    JOIN inventory
    ON rental.inventory_id = inventory.inventory_id
    JOIN film_category
    ON inventory.film_id = film_category.film_id
    GROUP BY film_category.category_id
)
SELECT category.name, -- consulta principal donde muestro el nombre de la categoría y su conteo de alquileres correspondiente
category_rental_count.rented_films
FROM category
JOIN category_rental_count
ON category.category_id = category_rental_count.category_id
ORDER BY category.name;
-- aunque sea mas extenso, las CTE's ofrecen mejor organización y legibilidad a la hora de estructurar consultas largas

-- 12.
/* Encuentra el promedio de duración de las películas para cada clasificación
de la tabla film y muestra la clasificación junto con el promedio de duración. */

SELECT rating,
AVG(length) AS avg_length -- uso la funcion agregada 'AVG' para calcular el valor medio de la columna 'length' (duracion)
FROM film
GROUP BY rating; -- lo agrupo por 'rating' (clasificacion) para organizar los resultados
-- 5 rows returned

-- 13.
/* Encuentra el nombre y apellido de los actores que
aparecen en la película con title "Indian Love". */

SELECT
actor.first_name,
actor.last_name
FROM actor
JOIN film_actor -- empleo 'JOIN' para encontrar las coincidencias entre las tablas actor y film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id IN ( -- con 'IN' busco coincidencias con los valores devueltos de la subconsulta 
	SELECT film.film_id
	FROM film
	WHERE film.title = 'Indian Love'
)
ORDER BY actor.last_name;
-- 10 rows returned

-- 14.
/* Muestra el título de todas las películas que contengan
la palabra "dog" o "cat" en su descripción. */

SELECT title
FROM film
WHERE description LIKE '%cat%'
OR description LIKE '%dog%'; -- con el operador logico 'OR' puedo añadir una segunda clausula 'LIKE' donde una de las dos condiciones se ha de cumplir para devolver el resultado
-- 167 rows returned

-- o usando regexp
SELECT title
FROM film
WHERE description REGEXP 'cat|dog'; -- la barra vertical equivale a 'OR'
-- 167 rows returned

-- 15.
/* Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. */

-- OPCION 1. Compruebo si hay algun/a actor/actriz registrado pero que no tenga ninguna pelicula asignada
SELECT
actor.actor_id,
actor.first_name,
actor.last_name
FROM actor
WHERE actor.actor_id IN ( -- subconsulta
	SELECT actor_id
    FROM film_actor
    WHERE film_id IS NULL); -- compruebo si hay algun/a actor/actriz cuyo id de pelicula sea nulo con 'IS NULL'
-- 0 rows returned -> Todos los actores/actrices aparecen en alguna pelicula

-- OPCION 2. Compruebo si hay algun/a actor/actriz en la tabla 'actor' que no esté en la tabla 'film_actor'
SELECT
a.actor_id,
a.first_name,
a.last_name
FROM actor AS a
WHERE NOT EXISTS ( -- el operado 'NOT EXISTS' nos devuelve los resultados no incluidos en la subconsulta 
    SELECT *
    FROM film_actor AS fa
    WHERE fa.actor_id = a.actor_id);
-- 0 rows returned -> Todos los actores/actrices aparecen en alguna pelicula

-- 16.
/* Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */

SELECT DISTINCT title
FROM film
WHERE release_year BETWEEN 2005 AND 2010; -- con la clausula BETWEEN selecciono los registros dentro de un rango determinado
-- 1000 rows returned
-- Todas las peliculas son de 2006

-- 17.
/* Encuentra el título de todas las películas que son de la misma categoría que "Family". */

SELECT DISTINCT title
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
WHERE film_category.category_id = ( -- obtengo la 'category_id' y en la subconsulta busco las coincidencias de peliculas de la categoria 'Family'
	SELECT category.category_id
	FROM category
	WHERE category.name = 'Family');
-- 69 rows returned

-- 18.
/* Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

-- uso queries avanzadas como 'GROUP BY' y 'HAVING'
SELECT DISTINCT actor.first_name,
actor.last_name
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
HAVING COUNT(film_actor.film_id) > 10 -- sentencia 'HAVING' para filtrar el grupo generado anteriormente
ORDER BY actor.last_name;

-- 19.
/* Encuentra el título de todas las películas que son "R" y
tienen una duración mayor a 2 horas en la tabla film. */

SELECT title
FROM film
WHERE rating = 'R'
AND length > 120; -- con el operador logico 'AND' indico que se han de cumplir las dos condiciones para devolver el resultado
-- 90 rows returned

-- 20.
/* Encuentra las categorías de películas que tienen un promedio de duración superior
a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración. */

-- uso CTE para hacer la consulta mas clara, separando el promedio de duracion de la consulta principal
WITH category_avg_length AS (
    SELECT category.name,
    AVG(film.length) AS avg_length -- calculo el promedio de duracion
    FROM category
    JOIN film_category
    ON category.category_id = film_category.category_id
    JOIN film 
    ON film_category.film_id = film.film_id
    GROUP BY category.name -- agrupo los resultados por categorias
)
SELECT name,
avg_length
FROM category_avg_length
WHERE avg_length > 120 -- filtro con condicion 'WHERE'
ORDER BY name;
-- 4 rows returned

-- 21.
/* Encuentra los actores que han actuado en al menos 5 películas y muestra el
nombre del actor junto con la cantidad de películas en las que han actuado. */

-- consulta similar a la n. 18.
-- uso CTE para hacer la consulta mas clara, separando el conteo de peliculas de la consulta principal
WITH actor_film_count AS (
    SELECT actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS film_count -- funcion agregada para el conteo
    FROM actor
    JOIN film_actor
    ON film_actor.actor_id = actor.actor_id
    GROUP BY actor.actor_id, -- agrupar resultados por actor
    actor.first_name,
    actor.last_name
)
SELECT DISTINCT -- consulta principal donde quiero que cumpla la condicion de que actuan en al menos 5 peliculas
first_name,
last_name,
film_count
FROM actor_film_count
WHERE film_count >= 5
ORDER BY last_name;
-- 200 rows returned

-- 22.
/* Encuentra el título de todas las películas que fueron alquiladas por más de 5 días.
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días
y luego selecciona las películas correspondientes. */

SELECT DISTINCT film.title
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN (
    SELECT inventory_id -- subconsulta para encontrar los inventory_id don duracion de mas de 5 dias, no es necesario el rental_id
    FROM rental
    WHERE DATEDIFF(return_date, rental_date) > 5 -- la funcion 'DATEDIFF' devuelve la diferencia entre dos fechas en dias
	) AS rental_5_days
ON inventory.inventory_id = rental_5_days.inventory_id;
-- 955 rows returned

-- 23.
/* Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de
la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado
en películas de la categoría "Horror" y luego exclúyelos de la lista de actores. */

SELECT
actor.first_name,
actor.last_name
FROM actor
WHERE actor.actor_id NOT IN ( -- 'NOT IN' excluye los resultados de la subconsulta
	SELECT DISTINCT film_actor.actor_id
	FROM film_actor
	JOIN film_category
	ON film_actor.film_id = film_category.film_id
	WHERE film_category.category_id = ( -- subconsulta anidada
		SELECT category.category_id
		FROM category
		WHERE category.name = 'Horror' -- condicion 'WHERE' para filtrar las peliculas de categoria 'Horror'
		)
	)
ORDER BY actor.last_name;
-- 44 rows returned

-- BONUS

-- 24.
/* BONUS: Encuentra el título de las películas que son comedias y
tienen una duración mayor a 180 minutos en la tabla film. */

-- usando subconsultas correlacionadas
SELECT title
FROM film
WHERE EXISTS ( -- suconsulta de peliculas que son comedias
    SELECT *
    FROM film_category
    JOIN category
    ON film_category.category_id = category.category_id
    WHERE film_category.film_id = film.film_id
    AND category.name = 'Comedy' -- primer filtro de genero
)
AND length > 180; -- segundo filtro de duracion
-- 3 rows returned

-- 25.
/* BONUS: Encuentra todos los actores que han actuado juntos en al menos una película.
La consulta debe mostrar el nombre y apellido de los actores y el número de películas
en las que han actuado juntos. */

# table actor -> first_name, last_name, actor_id
# table film_actor -> actor_id, film_id

SELECT 
a1.first_name AS actor1_first_name,
a1.last_name AS actor1_last_name,
a2.first_name AS actor2_first_name,
a2.last_name AS actor2_last_name,
COUNT(fa1.film_id) AS films -- contabilizo el numero de peliculas
FROM film_actor AS fa1
JOIN film_actor AS fa2 -- uno la tabla consigo misma para encontrar pares de actores/actrices
ON fa1.film_id = fa2.film_id -- condicion de misma pelicula
AND fa1.actor_id < fa2.actor_id -- condicion para evitar duplicados en las combinaciones de pares de actores/actrices
JOIN actor AS a1
ON fa1.actor_id = a1.actor_id
JOIN actor AS a2
ON fa2.actor_id = a2.actor_id
GROUP BY a1.actor_id, a1.first_name, a1.last_name, a2.actor_id, a2.first_name, a2.last_name -- agrupo los resultados por id y nombres
HAVING films >= 1; -- clausula 'HAVING' para asegurarnos de que coinciden en al menos 1 pelicula
-- 10434 rows returned
