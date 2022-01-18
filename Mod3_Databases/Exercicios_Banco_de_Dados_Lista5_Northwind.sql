/*
Módulo: Bando de dados
Exercícios extras com o banco de dados da Northwind
*/
--############################
--Exercícios Extras (2) de SQL
--############################

-- Q1

-- Selecione os id´s unicos de territórios da tabela employee_territories em ordem decrecente
SELECT territory_id
FROM employee_territories
ORDER BY territory_id DESC;

-- Q2 SElecione da tabela employees (Não esqueça de nomear as colunas criadas):

-- 1. O nome completo dos empregados em ordem alfabetica
SELECT CONCAT(first_name,' ',last_name) as Nome_Completo
FROM employees
ORDER BY Nome_Completo;

-- 2. O nome completo dos empregados com o respectivo titulo em ordem decrescente;
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo, 
	title
FROM employees
ORDER BY title DESC;

-- 3. Os sobrenomes distintos dos empregrados;
SELECT DISTINCT last_name
FROM employees;

-- 4. O ano de nascimento dos empregados usando funções de tempo;
SELECT 
	first_name, 
	date_part('year', birth_date)
FROM employees;

-- 5. O ano de nascimento dos empregados usando funções de string;
SELECT 
	first_name, 
	CONCAT('Dia ', date_part('day', birth_date)::text, ' do ', date_part('month', birth_date)::text, ' de ', date_part('year', birth_date)::text)
FROM employees;

-- 6. A idade atual dos empregados em ordem decrescente;
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo, 
	AGE(birth_date) -- ou pode fazer  ((current_date - birth_date) / 365.25)::integer
FROM employees
ORDER BY AGE(birth_date) DESC;

-- 7. A idade que os empregados tinham quando foram contratados em ordem crescente;
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo, 
	((hire_date - birth_date) / 365.25)::integer as idade_inicio
FROM employees
ORDER BY idade_inicio;

-- 8. Quem é e qual a idade do empregado mais velho?
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo, 
	AGE(birth_date)
FROM employees
ORDER BY AGE(birth_date) DESC
LIMIT 1;

SELECT 
	CONCAT(first_name, ' ', last_name) AS Nome_Completo, 
	AGE(birth_date) AS Idade
FROM employees
WHERE AGE(birth_date) = (SELECT max(AGE(birth_date)) FROM employees);

-- 9. Qual a pessoa mais jovem que foi contratada?
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo,
	((hire_date - birth_date) / 365.25)::integer as idade_inicio
FROM employees
ORDER BY idade_inicio
LIMIT 1;

SELECT 
	CONCAT(first_name, ' ', last_name) AS Nome_Completo, 
	((hire_date - birth_date) / 365.25)::integer AS Idade_Inicio
FROM employees
WHERE ((hire_date - birth_date) / 365.25)::integer = (SELECT min(((hire_date - birth_date) / 365.25)::integer) FROM employees);

-- 10. Crie uma coluna que mapeie os cargos dos empregados com a posição hierárquica na lista, sendo 1 o mais alto.
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo, 
	title,
CASE
WHEN title = 'Vice President, Sales' THEN 'Hierarquia 1'
WHEN title = 'Sales Manager' THEN 'Hierarquia 2'
WHEN title = 'Inside Sales Coordinator' THEN 'Hierarquia 3'
ELSE 'Hierarquia 4'
END AS Hierarquia
FROM employees
ORDER BY Hierarquia;

-- 11. O tempo de empresa dos respectivos empegados;
SELECT 
	CONCAT(first_name,' ',last_name) as Nome_Completo, 
	((current_date - hire_date) / 365.25)::integer as tempo_de_empresa
FROM employees;

-- Q3 (Selecione da tabela products)

-- 1. Os três produtos mais caros com seus respectivos preços;
SELECT 
	product_name, 
	unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 3;

-- 2. Os 10 produtos com estoque mais baixo (diferentes de 0) com suas respectivas quantidades;
SELECT 
	product_name, 
	units_in_stock
FROM products
WHERE units_in_stock <> 0
ORDER BY units_in_stock
LIMIT 10;

-- 3. Os 5 produtos com maior valor agregado atualmente em estoque;
SELECT 
	product_name, 
	units_in_stock, 
	unit_price, 
	(units_in_stock * unit_price) AS Valor_Estoque
FROM products
ORDER BY Valor_Estoque DESC
LIMIT 5;

-- 4. Produtos com mais de 100 unidades no estoque ou valor unitário inferior 15;
SELECT 
	product_name, 
	units_in_stock, 
	unit_price
FROM products
WHERE units_in_stock > 100 OR unit_price < 15;

-- Q4 (Selecione da Tabela orders)

-- 1. O primeiro nome do destinatário da entrega (ship_name);
SELECT SUBSTRING(ship_name, 1, POSITION (' ' in ship_name))
FROM orders;

-- 2. O tempo (em dias) entre a compra e a entrega;
SELECT 
	order_id, 
	order_date, 
	shipped_date, 
	(shipped_date - order_date) AS Dias_Entrega
FROM orders;

-- 3. Os cinco fretes mais caros ordenados pelo tempo de entrega em ordem decrescente (sem dados nulos);
SELECT * FROM (
SELECT 
	order_id, 
	order_date, 
	shipped_date, 
	(shipped_date - order_date) AS Dias_Entrega, 
	freight
FROM orders
WHERE shipped_date IS NOT NULL AND order_date IS NOT NULL
ORDER BY freight DESC
LIMIT 5) as tab_5_fretes_mais_caros ORDER BY tab_5_fretes_mais_caros.dias_entrega DESC;

-- 4. Os cinco fretes com maior tempo de entrega ordenados pelo valor decrescente (sem dados nulos);
SELECT * FROM (
SELECT order_id, order_date, shipped_date, (shipped_date - order_date) AS Dias_Entrega, freight
FROM orders
WHERE shipped_date IS NOT NULL AND order_date IS NOT NULL
ORDER BY Dias_Entrega DESC
LIMIT 5) as tab_5_maior_tmp_entrega ORDER BY tab_5_maior_tmp_entrega.freight DESC;

-- 5. Os 3 fretes mais baratos do Brasil.
SELECT 
	order_id, 
	ship_country, 
	freight
FROM orders
WHERE ship_country = 'Brazil'
ORDER BY freight
LIMIT 3;

-- 6. Uma tabela com as três primeiras letras do nome do pais, o tempo de entrega e o frete ordenados em ordem crescente.
SELECT 
	order_id, 
	SUBSTRING(ship_country,1,3), 
	freight, 
	(shipped_date - order_date) AS Dias_Entrega
FROM orders
ORDER BY freight;