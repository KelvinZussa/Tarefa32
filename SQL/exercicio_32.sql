---Homework SQL
---1 - Faça uma consulta que retorne a lista de filmes e suas categorias correspondentes.
---1.1

SELECT 
    a.title AS filme,
    b.name AS categoria
FROM 
    film a
JOIN 
    film_category c ON a.film_id = c.film_id
JOIN 
    category b ON c.category_id = b.category_id;
---Utilizado select acima, dando um nome para a tabela TITLE e NAME para poder trazer o nome do filme e nome da categoria e depois fazendo a junção e conectando com JOIN ON.

--1.2 - - Faça uma consulta que retorne a lista de todos os atores com o número filmes que cada ator participou. Ordene a lista pelo numero de filmes, iniciando pelos atores que mais atuaram.

SELECT 
    a.first_name AS nome,
    a.last_name AS sobrenome,
    COUNT(af.film_id) AS total_filmes
FROM 
    actor a
JOIN 
    film_actor af ON a.actor_id = af.actor_id
GROUP BY 
    a.actor_id
ORDER BY 
    total_filmes DESC
--Novamente usado fixação de letra para nomear a tabela a ser usada e depois usado o AS para dar um nome para a coluna a ser exibida. Usado o COUNT como contador, JOIN para juntar as tabelas, o GROUP BY agrupa pela tabela e o ORDER BY ordena, o DESC por ordem decrescente. 

--1.3 - - Faça uma consulta que retorne a lista de atores que atuaram em filmes com mais de duas horas de duração (120min). Ordene a lista pelo numero de filmes que cada ator participou.
SELECT 
    a.first_name AS nome,
    a.last_name AS sobrenome,
    COUNT(f.film_id) AS total_filmes
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.length > 120
GROUP BY 
    a.actor_id
ORDER BY 
    total_filmes DESC;
---Primeiro é preciso interligar as tabelas de atores e filme, depois deixar somente filmes com mais de 120 min usando o WHERE e o símbolo >, o GROUP para agrupar e o ORDER BY para ordenar e deixar em decrescente a informação.

--Exercício 2: Crie uma consulta para cada consulta do exercício anterior que retorne o numero de registros encontrados pela busca

--Filmes e suas categorias
SELECT 
    COUNT(*) AS total_registros
FROM 
    film a
JOIN 
    film_category c ON a.film_id = c.film_id
JOIN 
    category b ON c.category_id = b.category_id;

--Atores e suas participações em filmes
SELECT 
    nome,
    sobrenome,
    total_filmes,
    (SELECT COUNT(DISTINCT actor_id) FROM film_actor) AS total_registros
FROM (
    SELECT 
        a.first_name AS nome,
        a.last_name AS sobrenome,
        COUNT(af.film_id) AS total_filmes
    FROM 
        actor a
    JOIN 
        film_actor af ON a.actor_id = af.actor_id
    GROUP BY 
        a.actor_id
) AS resultado
ORDER BY 
    total_filmes DESC;

--Atores em filmes com mais de 120 min 
SELECT 
    a.first_name AS nome,
    a.last_name AS sobrenome,
    COUNT(f.film_id) AS total_filmes
FROM 
    actor a
JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.length > 120
GROUP BY 
    a.actor_id

UNION ALL

SELECT 
    'TOTAL' AS nome,
    '' AS sobrenome,
    COUNT(DISTINCT fa.actor_id) AS total_filmes
FROM 
    film_actor fa
JOIN 
    film f ON fa.film_id = f.film_id
WHERE 
    f.length > 120

ORDER BY 
    total_filmes DESC;

