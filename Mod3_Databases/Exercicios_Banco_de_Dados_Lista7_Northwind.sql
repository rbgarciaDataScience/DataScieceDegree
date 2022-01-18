/*
Módulo: Bando de dados
Exercícios extras com o banco de dados da Northwind
*/
--############################
--Exercícios Extras (4) de SQL
--############################

-- Q1 Faça um relatório que traga o número de cidades por estado (nome por extenso) e ordene:
-- Ordem alfabética por nome do estado;
SELECT
	est.nome, 
	COUNT(cid.id)
FROM tb_estados AS est
JOIN tb_cidades AS cid ON est.id = cid.estado
GROUP BY est.nome
ORDER BY est.nome;

-- Do maior para o menor número de municípios.
SELECT
	est.nome, 
	COUNT (cid.id) AS total
FROM tb_estados AS est
JOIN tb_cidades AS cid ON est.id = cid.estado
GROUP BY est.nome
ORDER BY total DESC;

-- Q2 Faça um relatório que gere uma lista com todas as cidades (nome por extenso) com nomes repetidos.
SELECT 
	nome, 
	COUNT(nome) AS repeticoes
FROM tb_cidades
GROUP BY nome
HAVING COUNT(nome) >= 2
ORDER BY repeticoes DESC;

-- Q3 Faça um relatório que gere uma lista com os municipíos repetidos por estados (nome por extenso): estado|cidade|numero.
SELECT 
	est.nome AS estado, 
	cid.nome AS cidade, 
	COUNT(cid.nome) AS repeticoes
FROM tb_cidades AS cid
LEFT JOIN tb_estados AS est ON est.id = cid.estado
GROUP BY est.nome, cid.nome
HAVING COUNT(cid.nome) >= 2
ORDER BY estado;

-- Q4) No banco de dados do northwind, obtenha:
-- 1. Uma lista dos 10 clientes que realizaram o maior número de pedidos, bem como o número de
-- pedidos de cada, ordenados em ordem decrescente de nº de pedidos
SELECT 
	customer_id, 
	COUNT(order_id) AS num_pedidos
FROM orders
LEFT JOIN customer_id
ORDER BY num_pedidos DESC
LIMIT 10;

---2)-Uma tabela com o valor médio das vendas em cada mês, ordenando do mês com mais vendas ao mês com menos venda
SELECT 
	DATE_PART('month', orders.order_date) as mes,
	ROUND(avg(order_details.unit_price * quantity):: numeric, 2) as media
FROM orders
LEFT JOIN order_details on orders.order_id = order_details.order_id
LEFT JOIN mes
ORDER BY media DESC;

-- Q5) No banco de dados do northwind, obtenha:
-- 1. Quantos clientes fizeram mais de 10 pedidos?
SELECT COUNT(*) AS qtd_cli_mais_10_pedidos
FROM (
	SELECT customer_id, COUNT(order_id) AS qtd_pedidos
	FROM orders
	GROUP BY customer_id
	HAVING COUNT(order_id) > 10
) AS clientes_com_mais_pedidos;

-- 2. Quantos vendedores tiveram menos de 70 pedidos?
SELECT COUNT(*) AS qtd_vend_menos_70_pedidos
FROM (
	SELECT employee_id, COUNT(order_id)
	FROM orders
	GROUP BY employee_id
	HAVING COUNT(order_id) < 70
) AS vend_com_menos_pedidos;

-- 3. Qual a média dos valores por pedido de cada vendedor?
WITH tab_com_valor_pedido AS(
	SELECT ord.order_id, ord.employee_id, ord.freight,
	ROUND(SUM(odt.unit_price * odt.quantity * (1 - odt.discount))::NUMERIC, 2) AS valor_sem_frete
	FROM orders AS ord INNER JOIN order_details AS odt ON ord.order_id = odt.order_id
	GROUP BY ord.order_id
)
SELECT 
	employee_id AS vendedor_id,
	ROUND(AVG(freight + valor_sem_frete)::NUMERIC, 2) AS media_valor_pedidos
FROM tab_com_valor_pedido
GROUP BY employee_id
ORDER BY employee_id;

-- 4. Quantos vendedores tiveram menos de 300 pedidos e média superior a 700 reais por pedido?
WITH tab_com_total_sem_frete AS(
	SELECT ord.order_id, ord.employee_id, ord.freight,
	ROUND(SUM(odt.unit_price * odt.quantity * (1 - odt.discount))::NUMERIC, 2) AS total_sem_frete
	FROM orders AS ord INNER JOIN order_details AS odt ON ord.order_id = odt.order_id
	GROUP BY ord.order_id
)
SELECT 
	employee_id, 
	COUNT(order_id) AS qtd_pedidos, 
	ROUND(AVG(freight + total_sem_frete)::NUMERIC, 2) AS valor_medio_pedido
FROM tab_com_total_sem_frete
GROUP BY employee_id
HAVING COUNT(order_id) < 300
AND ROUND(AVG(freight + total_sem_frete)::NUMERIC, 2) > 700
ORDER BY employee_id;