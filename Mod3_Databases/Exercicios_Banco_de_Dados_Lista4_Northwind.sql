/*
Módulo: Bando de dados
Exercícios extras com o banco de dados da Northwind
*/

--############################
--Exercícios Extras (1) de SQL
--############################

-- Q1 Selecione os id's únicos de territórios da tabela employee_territories.
SELECT DISTINCT territory_id
FROM employee_territories;

-- Q2 - Selecione da tabela empolyees:

-- 1. Todos os nomes dos empregados;
SELECT first_name 
FROM employees;

-- 2. Os sobrenomes distintos dos empregados;
SELECT DISTINCT last_name 
FROM employees;

-- 3. Empregados que nasceram após 1970;
SELECT * 
FROM employees 
WHERE date_part('year', birth_date) > 1970;

-- 4. Empregados que foram contratados em 1993;
SELECT * 
FROM employees 
WHERE date_part('year', hire_date) = 1993;

-- 5. Empregados que nasceram entre 1980 e 1985 (inclusos);
SELECT * 
FROM employees 
WHERE date_part('year', birth_date) 
BETWEEN 1980 AND 1985;

-- 6. Empregados que nasceram em 1963 e foram contratados em 1993;
SELECT * FROM employees 
WHERE date_part('year', birth_date) = 1963 
AND date_part('year', hire_date) = 1993;

-- 7. Todos os empregrados que reportam o chefe de id 5;
SELECT * 
FROM employees 
WHERE reports_to = 5;

-- 8. Todos os empregados que moram em Seattle ou Kirkland.
SELECT * 
FROM employees 
WHERE lower(city) IN ('seattle', 'kirkland');

-- Q3 - Selecione da tabela order_details:

-- 1. Produtos (product_id) com mais de 50 unidades vendidas;
SELECT 
	product_id, 
	sum(quantity)
FROM order_details
GROUP BY product_id
HAVING sum(quantity) > 50
ORDER BY product_id;

-- 2. Produtos com mais de 0.2 de desconto;
SELECT *
FROM order_details
WHERE discount::numeric(10,1) > 0.2
ORDER BY product_id;

-- 3. Produtos com 0.05 ou menos de desconto
SELECT *
FROM order_details
WHERE discount::numeric(10,2) < 0.05
ORDER BY product_id;

-- Q4 - Selecione da tabels orders:

-- 1. Ordens realizadas antes Setembro de 1996.
SELECT * 
FROM orders 
WHERE order_date < '1996-08-31';

-- 2. Ordens enviadas em Setembro de 1996.
SELECT * 
FROM orders 
WHERE order_date between '1996-09-01' and '1996-09-30';

-- 3. Ordens que possuam o campo região preenchido.
SELECT * 
FROM orders 
WHERE ship_region is not null;

-- 4. As primeiras 5 linhas da tabela, reescrevendo o nome das colunas de data em português.
SELECT 
	order_date as ordem, 
	required_date as data_exigencia, 
	shipped_date as data_envio
FROM orders 
limit 5;

-- Q5 - Selecione da tabela suppliers:

-- 1. Todos os contatos cujo nome comece com a letra M;
SELECT * 
FROM suppliers 
WHERE lower(contact_name) like 'm%';

-- 2. Todos os contatos que tenham a palavra manager no titulo;
SELECT * 
FROM suppliers 
WHERE lower(contact_title) like '%manager%';

-- 3. Todos os contatos que trabalhem com vendas e morem nos países nórdicos.
SELECT * 
FROM suppliers
WHERE lower(contact_title) like '%sales%' 
and country in ('Sweden', 'Germany', 'Denmark');