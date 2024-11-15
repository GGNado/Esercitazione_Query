-- q1
SELECT first_name, last_name
from actor

-- q2
SELECT first_name, last_name
from actor
where actor_id < 31

-- q3
SELECT COUNT(actor_id)
from actor

-- q4
SELECT last_name, first_name
from actor
ORDER BY last_name ASC, first_name DESC

-- q5
SELECT COUNT(actor_id) as NumeroDegliAttori
from actor

-- q6
SELECT last_name AS Cognome, first_name AS Nome
from actor
ORDER BY Cognome ASC, Nome DESC

-- q7
SELECT last_name AS Cognome, first_name AS Nome
from actor
where first_name LIKE "B%"
ORDER BY Cognome ASC, Nome DESC

-- q8
SELECT last_name AS Cognome, first_name AS Nome
from actor
where first_name LIKE "_____" or last_name LIKE "_____"
ORDER BY Cognome ASC, Nome DESC

-- q9
SELECT last_name AS Cognome, first_name AS Nome
from actor
where last_name LIKE "%A%" or first_name LIKE "%A%"
ORDER BY Cognome ASC, Nome DESC

-- q10
SELECT first_name as Nome, last_name as Cognome
FROM actor
WHERE first_name NOT LIKE "%E%" and last_name NOT LIKE "%E%"
ORDER BY Cognome, Nome ASC

-- q11
SELECT last_name as SecondoNome
FROM actor
where actor_id < 21
ORDER BY last_name DESC

-- q12
SELECT DISTINCT last_name as SecondoNome
FROM actor
ORDER BY last_name DESC

-- q13
SELECT COUNT(DISTINCT last_name) as SecondoNome
FROM actor
ORDER BY last_name DESC

-- q14
SELECT title AS TitoloFilm, length AS LunghezzaFILM
from film
ORDER BY length DESC, title ASC

-- q15
SELECT title AS TitoloFilm, length AS LunghezzaFILM
from film
where length < 54
ORDER BY length DESC, title ASC

-- q16
SELECT title AS TitoloFilm, length AS LunghezzaFILM
from film
where length < 110 AND length > 50
ORDER BY length DESC, title ASC

-- q17
SELECT title AS TitoloFilm, length AS LunghezzaFILM
from film
where length BETWEEN 50 AND 110
ORDER BY length DESC, title ASC

-- q18
SELECT COUNT(*) AS "Numero Film", ROUND(SUM(length) / 60) as "Totale In ore", ROUND(AVG(length)) AS "Media", ROUND(MIN(length)) AS "Minima", ROUND(MAX(length)) AS "Massimo"
FROM film;

-- q19
SELECT last_name, COUNT(*) AS "Numero Attori"
FROM actor
GROUP BY last_name;

-- q20
SELECT last_name AS Cognome, COUNT(*) AS NumeroAttori
FROM actor
GROUP BY last_name
HAVING NumeroAttori > 1
ORDER BY NumeroAttori ASC, last_name DESC;

-- q21
SELECT last_name AS Cognome, COUNT(*) AS NumeroAttori
FROM actor
where last_name LIKE "%A%"
GROUP BY last_name
HAVING NumeroAttori > 1
ORDER BY NumeroAttori ASC, last_name DESC;

-- q22 Non so se corretta
SELECT last_name AS Cognome, COUNT(*) AS NumeroAttori
FROM actor
GROUP BY last_name
HAVING NumeroAttori > 1 && last_name LIKE "%A%"
ORDER BY NumeroAttori ASC, last_name DESC;

-- q23
SELECT last_name AS Cognome, COUNT(*) AS NumeroAttori
FROM actor
GROUP BY last_name
HAVING NumeroAttori >= 3
ORDER BY last_name;

-- q24
SELECT film.title AS Titolo, film.length AS Durata, category.category_id AS Genere, category.name as GenereStringa
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
ORDER BY Genere ASC, Titolo ASC, Durata DESC;

-- q25
SELECT film.title AS Titolo, film.length AS Durata, category.category_id AS Genere, category.name as GenereStringa
FROM film
         JOIN film_category ON film.film_id = film_category.film_id
         JOIN category ON film_category.category_id = category.category_id
WHERE category.name != "Drama" AND category.name != "Comedy"
ORDER BY Genere ASC, Titolo ASC, Durata DESC;

-- q26
SELECT COUNT(*) AS "Numero Film", ROUND(SUM(length) / 60) as "Totale In ore", ROUND(AVG(length)) AS "Media", ROUND(MIN(length)) AS "Minima", ROUND(MAX(length)) AS "Massimo"
FROM film
         JOIN film_category ON film.film_id = film_category.film_id
         JOIN category ON film_category.category_id = category.category_id
WHERE category.name != "Drama" AND category.name != "Comedy";

-- q27
SELECT address.address AS Indirizzo, address.postal_code AS CAP, city.city AS Città, country.country AS Paese
FROM address
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id
ORDER BY Indirizzo, CAP, Città;

-- q28
SELECT address.address AS Indirizzo, address.postal_code AS CAP, city.city AS Città, country.country AS Paese
FROM address
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id
WHERE address.postal_code != 0 || address.phone != 0
ORDER BY Indirizzo, CAP, Città;

-- q29 Okay fatto
SELECT COUNT(address.address) AS Conteggio_Indirizzo, country.country AS Paese
FROM address
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id
GROUP BY Paese

-- q30 ora va
SELECT COUNT(address.address) AS Conteggio_Indirizzo, country.country AS Paese
FROM address
         JOIN city ON address.city_id = city.city_id
         JOIN country ON city.country_id = country.country_id
GROUP BY Paese
HAVING Conteggio_Indirizzo > 3

-- q31
SELECT category.name, COUNT(fc.film_id) as Numero_Film
from category
         JOIN sakila.film fc on category.category_id = fc.film_id
         JOIN film_category on category.category_id = film_category.category_id
GROUP BY category.name

-- q32
SELECT category.name, COUNT(fc.film_id) as Numero_Film
FROM category
         JOIN film_category ON category.category_id = film_category.category_id
         JOIN film fc ON film_category.film_id = fc.film_id
GROUP BY category.name
ORDER BY Numero_Film
LIMIT 1

-- Q33 Dovrebbe funzionare ma nel DB non ci sono lingue diverse da Inglese, quindi non posso verificare
SELECT name as Lingua, COUNT(f.title) as Conteggio
from language
         JOIN sakila.film f on language.language_id = f.language_id
ORDER BY Conteggio DESC, Lingua ASC

-- q34
SELECT name as Lingua, COUNT(f.title) as Conteggio
FROM language
         JOIN sakila.film f ON language.language_id = f.language_id
GROUP BY Lingua
ORDER BY Conteggio DESC
    LIMIT 1; -- Penso si faccia cosi

-- q35
SELECT first_name AS Nome, last_name, Count(film.title) as ConteggioFilm
from actor
         JOIN film_actor on actor.actor_id = film_actor.actor_id
         JOIN film on film_actor.film_id = film.film_id
GROUP BY first_name

-- q36
SELECT title as Titolo, Count(a.last_name) as ConteggioAttori
from film
         JOIN film_actor on film.film_id = film_actor.film_id
         JOIN sakila.actor a on a.actor_id = film_actor.actor_id
GROUP BY title

-- q37
SELECT title as Titolo, COUNT(DISTINCT a.last_name) as ConteggioAttori
FROM film
         JOIN film_actor ON film.film_id = film_actor.film_id
         JOIN sakila.actor a ON a.actor_id = film_actor.actor_id
GROUP BY title;

-- q38 i primi 5 migliori
SELECT first_name AS Nome, last_name, Count(film.title) as ConteggioFilm
from actor
         JOIN film_actor on actor.actor_id = film_actor.actor_id
         JOIN film on film_actor.film_id = film.film_id
GROUP BY first_name
ORDER BY ConteggioFilm DESC
    LIMIT 5

-- q39
SELECT title
FROM film
WHERE length > (SELECT AVG(length) FROM film)











