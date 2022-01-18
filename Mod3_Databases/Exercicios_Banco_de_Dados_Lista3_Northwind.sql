/*
Módulo: Bando de dados
Lista: Exercícios com a base Northwind
Professor: Sandro Saorin
Data: 09/2021
*/

/*
Exercícios: Para iniciar, visualize as tabelas orders,
			order_details, products e customers
*/

SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM products;
SELECT * FROM customers;

/*
1. Obtenha uma tabela que contenha o id do pedido e o valor total do mesmo.
Obes.: Gerando uma VIEW temporária e depois a visualizando
*/

CREATE OR REPLACE TEMP VIEW orders_price AS
SELECT 
	A.order_id,
	A.product_id,
	A.quantity,
	A.discount,
	B.unit_price
FROM order_details AS A
LEFT JOIN products AS B ON A.product_id = B.product_id;
		
SELECT * 
FROM orders_price;

---Extra: adicionar a coluna freight na tabela orders_price
CREATE OR REPLACE TEMP VIEW orders_frete AS
SELECT
	A.*,
	B.freight
FROM orders_price AS A
LEFT JOIN orders AS B ON A.order_id = B.order_id;

SELECT * 
FROM orders_frete;

---Extras: Calculando valores
SELECT
	order_id,
	SUM(unit_price * quantity * (1 - discount)) + AVG(freight) AS total_order_price
FROM orders_frete
GROUP BY 1
ORDER BY 1;

SELECT
	order_id,
	ROUND(SUM(unit_price * quantity * (1 - discount)) + AVG(freight)) AS total_order_price
FROM orders_frete
GROUP BY 1
ORDER BY 1;

/* QUERY OTIMIZADA */
SELECT 
	A.order_id,
	ROUND(SUM(B.unit_price * A.quantity * (1 - A.discount)) + AVG(C.freight)) AS total_order_price
FROM order_details AS A
LEFT JOIN products AS B ON A.product_id = B.product_id
LEFT JOIN orders AS C ON A.order_id = C.order_id
GROUP BY 1
ORDER BY 1;

/*
2. Obtenha uma lista dos 10 clientes que realizaram o maior número de pedidos, 
bem como o número de pedidos de cada, ordenados em ordem decrescente de nº de pedidos.
*/

SELECT
	customer_id,
	COUNT(order_id) AS total_pedidos
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

/*
3. Obtenha uma tabela que contenha o id e o valor total do pedido e o nome do cliente que o realizou.
order_id e o valor total do pedido temos do exercício 1
precisamos cruzar orders com costumers
*/

CREATE OR REPLACE TEMP VIEW total_pedidos AS 
SELECT 
	A.order_id,
	ROUND(SUM(B.unit_price * A.quantity * (1 - A.discount)) + AVG(C.freight)) AS total_order_price
FROM order_details AS A
LEFT JOIN products AS B ON A.product_id = B.product_id
LEFT JOIN orders AS C ON A.order_id = C.order_id
GROUP BY 1;

CREATE OR REPLACE TEMP VIEW pedidos_clientes AS
SELECT
	A.order_id,
	B.company_name
FROM orders AS A
LEFT JOIN customers AS B ON A.customer_id = B.customer_id;

SELECT
	A.*,
	B.company_name
FROM total_pedidos AS A
LEFT join pedidos_clientes AS B on A.order_id = B.order_id;

/*
4. Obtenha uma tabela que contenha o país do cliente e o valor da compra que ele realizou.
*/
SELECT 
	A.order_id,
	ROUND(SUM(B.unit_price * A.quantity * (1 - A.discount)) + AVG(C.freight)) AS total_order_price
FROM order_details AS A
LEFT JOIN products AS B ON A.product_id = B.product_id
LEFT JOIN orders AS C ON A.order_id = C.order_id
GROUP BY 1


/*
5. Obtenha uma tabela que contenha uma lista dos países dos clientes e o valor total de compras realizadas em cada um dos países. Ordene a tabela, na order descrescente, considerando o valor total de compras realizadas por país.
*/

SELECT 
	B.country,
	SUM(A.total_order_price) AS total_pais
FROM total_pedidos AS A
LEFT JOIN pedidos_paises AS B on A.order_id = B.order_id
GROUP BY 1
ORDER BY 2 DESC

/*
6. Obtenha uma tabela com o valor médio das vendas em cada mês (ordenados do mês com mais vendas para o mês com menos vendas)
*/

SELECT 
	to_char(B.order_date, 'yyyy/mm') AS safra,
	ROUND(AVG(A.total_order_price)) AS media_mes
FROM total_pedidos AS A
LEFT JOIN orders AS B ON A.order_id = B.order_id
GROUP BY 1
ORDER BY 2 DESC;
	
---Extras: extraindo informações de tempo
current_date

SELECT date_part('month',current_date) 
SELECT date_part('year',current_date)
SELECT now()
SELECT current_date

SELECT date_trunc('month',current_date)

SELECT to_char(current_date, 'dd/mm/yy')
SELECT to_char(current_date, 'dd/mm/yyyy')
SELECT to_char(current_date, 'mm/dd/yyyy')
