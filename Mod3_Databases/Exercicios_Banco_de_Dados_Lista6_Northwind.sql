/*
Módulo: Bando de dados
Exercícios extras com o banco de dados da Northwind
*/

--############################
--Exercícios Extras (3) de SQL
--############################

-- Q1 - Da tabela territories:
-- 1. Quantos territórios temos ao todo?
SELECT COUNT(DISTINCT territory_id) AS total_territorios
FROM territories;

-- 2. Quantos territórios por região?
SELECT 
	region_id, 
	COUNT(DISTINCT territory_id) AS total_territorios
FROM territories
group by region_id
order by region_id;

-- Q2 - Selecione da tabela empolyees:
-- 1. Quantos empregados reportam para cada chefe?
SELECT 
	reports_to AS chefe,
	COUNT(employee_id) AS qtde_empregados
FROM employees
GROUP BY reports_to
ORDER BY reports_to;

-- 2. Quantos empregados em cada cidade?
SELECT 
	city AS cidade,
	COUNT(employee_id) AS qtde_empregados
FROM employees
GROUP BY city;

-- Q3 - Selecione da tabela order_details:
-- 1. Quantas unidades forem vendidas por ordem?
SELECT 
	order_id AS ordem,
	SUM(quantity) AS qtde_vendida
FROM order_details
GROUP BY order_id
ORDER BY order_id;

-- 2. Qual o valor total de cada ordem?
SELECT 
	order_id AS ordem,
	SUM(unit_price * quantity)::numeric(20,2) AS total_ordem
FROM order_details
GROUP BY order_id
ORDER BY order_id;

-- 3. Qual o produto mais vendido?
SELECT 
	product_id, 
	SUM(quantity) AS mais_vendido
FROM order_details
GROUP BY product_id
ORDER BY mais_vendido DESC
LIMIT 1;

-- Retorne o id do produto e o total de items vendidos
SELECT 
	product_id, 
	total 
FROM (
    -- Retorna os nomes e a soma dos produtos vendidos para todos os produtos
    SELECT product_id, 
	SUM(quantity) AS total
    FROM order_details
    GROUP BY product_id
    ORDER BY total DESC
) AS soma_por_produto
-- Utilize o where para retornar apenas o produto com o valor maximo
WHERE soma_por_produto.total = (
    -- Retornar o valor maximo dentre os produtos vendidos
    SELECT max(max_vendido.total) from (
        SELECT product_id, SUM(quantity) AS total
        FROM order_details
        GROUP BY product_id
        ORDER BY total DESC
    ) AS max_vendido
);

-- 4. Selecione ordens que tenham menos de três produtos.
SELECT 
	order_id,
	SUM(quantity) AS total_produtos
FROM order_details
GROUP BY order_id
HAVING SUM(quantity) <= 3
ORDER BY order_id;

-- Q4. Selecione da tabels orders:
-- 1. Qual cliente realizou mais ordens?
SELECT 
	customer_id,
	COUNT(customer_id) AS qtde_compras
FROM orders
GROUP BY customer_id
ORDER BY qtde_compras DESC
LIMIT 1;

-- 2. Qual cliente realizou menos ordens?
SELECT 
	customer_id,
	COUNT(customer_id) AS qtde_compras
FROM orders
GROUP BY customer_id
ORDER BY qtde_compras
LIMIT 1;

-- 3. Quantas ordems foram feitas por mês?
SELECT 
	date_part('month', order_date) AS mes,
	COUNT(order_id) AS qtde_ordens
FROM orders
GROUP BY date_part('month', order_date)
ORDER BY mes;

-- 4. Qual o tempo de envio por cliente?
SELECT 
	customer_id, 
	(shipped_date - order_date) as tempo_envio
FROM orders
ORDER BY  customer_id;

-- 5. Faça uma lista ordenada dos países que receberam mais ordens.
SELECT 
	ship_country, 
	COUNT(ship_country) AS qtde_ordens
FROM orders
GROUP BY ship_country
ORDER BY qtde_ordens DESC;

-- 6. Qual o tempo máximo de envio por cidade?
SELECT 
	ship_city, 
	SUM(shipped_date - order_date) AS qtde_dias
FROM orders
GROUP BY ship_city
ORDER BY qtde_dias DESC;

-- 7. Quanto cada cliente gastou em frete?
SELECT 
	customer_id, 
	SUM(freight)::numeric(20,2) AS total_frete
FROM orders
GROUP BY customer_id;

-- 8. Qual o custo total de cada tipo de frete?
SELECT 
	ship_via, 
	SUM(freight)::numeric(20,2) AS custo_total
FROM orders
GROUP BY ship_via
ORDER BY ship_via;

-- 9. Quanto cada cliente gastou em casa tipo de frete?
SELECT 
	customer_id, 
	ship_via,
	SUM(freight)::numeric(20,2) AS total_frete
FROM orders
GROUP BY customer_id, ship_via
ORDER BY customer_id, ship_via;

-- Q5 - Selecione da tabela suppliers:
-- 1. Uma lista com os países que mais tem fornecedores.
SELECT 
	country, 
	COUNT(country) AS total
FROM suppliers
GROUP BY country
ORDER BY total DESC;

-- Q6 - Selecione da tabela products:
-- 1. Uma lista com o número de produtos por fornecedores.
SELECT 
	products.supplier_id AS cod_fornecedor,
	suppliers.company_name AS fornecedor,
	COUNT(products.product_id) AS qtde_produtos
FROM products
INNER JOIN suppliers ON suppliers.supplier_id = products.supplier_id
GROUP BY products.supplier_id, suppliers.company_name
ORDER BY products.supplier_id;

-- 2. Oderne a lista acima em ordem decrescente.
SELECT 
	products.supplier_id AS cod_fornecedor,
	suppliers.company_name AS fornecedor,
COUNT(products.product_id) AS qtde_produtos
FROM products
INNER JOIN suppliers ON suppliers.supplier_id = products.supplier_id
GROUP BY products.supplier_id, suppliers.company_name
ORDER BY qtde_produtos DESC;

-- 3. Uma lista com o número de produtos por fornecedors por categoria.
SELECT 
	products.supplier_id AS cod_fornecedor,
	suppliers.company_name AS fornecedor,
	COUNT(products.product_id) AS qtde_produtos,
	category_id as categoria
FROM products
INNER JOIN suppliers ON suppliers.supplier_id = products.supplier_id
GROUP BY products.supplier_id, suppliers.company_name, category_id
ORDER BY products.supplier_id;

-- 4. Quantos produtos foram descontinuados.
SELECT 
	COUNT(discontinued) AS produtos_descontinuados
FROM products
WHERE discontinued = 1;

-- 5. Fornecedores com estoque baixo (soma de unidades < 20).
SELECT suppliers.company_name AS fornecedor
FROM products
INNER JOIN suppliers ON suppliers.supplier_id = products.supplier_id
WHERE units_in_stock <= 20;

-- 6. A média do valor total de cada categória.
SELECT 
	category_id,
	AVG(unit_price * units_in_stock)::numeric(20,2) AS media_valor
FROM products
GROUP BY category_id
ORDER BY category_id;

-- 7. O valor do produto mais barato, mais caro e a média dos valores unitários por fornecedor e categoria.
SELECT * 
FROM products
WHERE unit_price = (SELECT MIN(unit_price) FROM products)
UNION
SELECT * FROM products
WHERE unit_price = (SELECT MAX(unit_price) FROM products);

SELECT 
	product_id, 
	supplier_id, 
	category_id,
	AVG(unit_price)::numeric(20,2) AS media_valor
FROM products
GROUP BY product_id, supplier_id, category_id
ORDER BY supplier_id;