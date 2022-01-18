/*
Módulo: Bando de dados
Exercícios extras 
*/

--############################
--Exercícios Extras (5) de SQL
--############################

-- Q1. Crie duas tabelas: produto e categoria. Essas duas tabelas devem estar relacionadas.
-- Considere que o produto possui uma descrição, preço, frete e categoria.
-- Considere que a categoria possui apenas uma descrição.
-- Não esqueça de inserir as chaves primárias e estrangeira da forma correta, de modo a criar o relacionamento entre as tabelas.

CREATE TABLE categoria (
    categoria_id SERIAL PRIMARY KEY, 
    descricao VARCHAR(255));

CREATE TABLE produto (
    produto_id SERIAL PRIMARY KEY, 
    descricao VARCHAR(255) NOT NULL, 
    preco NUMERIC(10,2), 
	frete NUMERIC(10,2), 
    categoria INT REFERENCES categoria(categoria_id));

-- Q2. -- Adicione 3 registros em cada tabela.
INSERT INTO categoria(descricao)
VALUES ('enlatados'), ('frios'), ('gluten-free');

INSERT INTO produto(descricao, preco, frete, categoria)
VALUES ('Feijao', 0.23, 0.00, 1), ('Ervilha', 0.50, 0.00, 1), ('Presunto', 1.50, 0.00, 2);

-- Q3.  Crie duas tabelas: turmas e alunos. Essas duas tabelas devem estar relacionadas.
-- Um aluno pode pertencer a muitas turmas e uma turma deve conter muitos alunos (tabela extra).
-- Considere que o aluno possui: nome, matrícula, data de nascimento e e-mail.
-- A turma possui os atributos descrição, professor (considere apenas um), data de início, e data de término.
CREATE TABLE aluno(
    aluno_id SERIAL PRIMARY KEY, 
    nome VARCHAR(255) NOT NULL, 
    matricula INT, 
	data_nasc DATE, 
    email VARCHAR(255));

CREATE TABLE turma(
    turma_id VARCHAR(100) PRIMARY KEY, 
    descricao VARCHAR(255) NOT NULL, 
    professor VARCHAR(255),  
	data_inicio DATE, 
    data_fim DATE);

CREATE TABLE turmas(
    turma_id VARCHAR(100) REFERENCES turma(turma_id),
	aluno_id INT REFERENCES aluno(aluno_id));
	
-- Q4. Adicione 3 registros em cada tabela.
INSERT INTO aluno(nome, matricula, data_nasc, email)
VALUES 
('Joana Vieira', 1578, '12-10-2005', 'joana@email.com'), 
('Bianca Pires', 1875, '05-08-2005', 'bianca@email.com'), 
('Suelen Silva', 895, '17-10-1982', 'suelen@email.com');

INSERT INTO turma(turma_id, descricao, professor, data_inicio, data_fim)
VALUES
('I_A','Informática-A', 'José', '01-05-2021', '31-12-2021'),
('I_B','Informática-B', 'José', '01-06-2021', '31-01-2022'),
('P_A','Python - A', 'Maria', '01-07-2021', '28-02-2022');

INSERT INTO turmas(turma_id, aluno_id)
VALUES ('I_A', 1), ('I_B', 2), ('P_A', 3);


--#############################
--Exercícios Extras (5b) de SQL
--#############################

---com o banco de dados da Northwind
-- Q2. Copie o resultado de uma consulta qualquer para um arquivo utilizando o comando COPY.
COPY (
SELECT 
	product_id, 
	(unit_price * quantity * (1 - discount) + orders.freight) as valor_pedido 
FROM order_details
INNER JOIN orders ON order_details.order_id = orders.order_id)
TO './consulta.csv' DELIMITER ';' CSV HEADER;