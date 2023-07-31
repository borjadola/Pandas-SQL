SELECT c.name AS category_name, COUNT(*) AS total_films
FROM Films AS f
JOIN category AS c ON c.category_id = f.category_id
GROUP BY c.name;

SELECT title, `length` 
FROM Films
ORDER BY `length` DESC
LIMIT 10;

SELECT c.name, COUNT(f.title)
FROM Category AS c
LEFT JOIN Films AS f
ON c.category_id = f.category_id
GROUP BY c.name