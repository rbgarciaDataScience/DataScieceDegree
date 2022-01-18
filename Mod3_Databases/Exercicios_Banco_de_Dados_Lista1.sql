/*
Módulo: Bando de dados
Lista: primeiros exercícios sobre banco de dados
Professor: Sandro Saorin
Data: 09/2021
*/
/*
Exercício 1
Crie uma tabela chamada de funcionários com as seguintes informações:
- ID do Funcionário;
- Nome do Funcionário;
- Departamento;
- Senioridade (Junior, Pleno e Senior);
- Tempo de Experiência em anos;
- Salário.
*/

CREATE TABLE tb_funcionarios (
	id INT NOT NULL,
	nome_funcionario VARCHAR(255),
	departamento VARCHAR(255),
	senioridade VARCHAR(255),
	anos_experiencia INT,
	salario INT /*NUMERIC(8,2)*/
);

/*
Exercíco 2
Preencha a tabela com os dados abaixo:
(10, 'Pedro', 'Analytics', 'Pleno', 3, 7000)
(11, 'Sarah', 'Comercial', 'Senior', 6, 7000)
(12, 'Sofia', 'Analytics', 'Junior', 1, 5000)
(13, 'Hanna', 'Comercial', 'Junior', 0, 3000)
(14, 'Luiza', 'Analytics', 'Pleno', 8, 7000)
(15, 'Lucas', 'Analytics', 'Junior', 2, 5000)
(16, 'Amanda', 'Data Science', 'Senior', 4, 11000)
(17, 'Paulo', 'Comercial', 'Senior', 7, 7000)
(18, 'Marcos', 'Data Science', 'Pleno', 5, 8000)
(19, 'Adriano', 'Analytics', 'Pleno', 4, 7000)
(20, 'Tiago', 'Data Science', 'Senior', 10, 11000)
(21, 'Juliana', 'Data Science', 'Junior', 2, 6000)
(22, 'Sergio', 'Data Science', 'Senior', 6, 11000)
(23, 'Sonia', 'Comercial', 'Senior', 8, 7000)
(24, 'Chen', 'Data Science', 'Pleno', 4, 8000)
(25, 'Ana', 'Comercial', 'Pleno', 6, 5000)
(26, 'Julia', 'Comercial', 'Senior', 6, 7000)
(27, 'Anderson', 'Data Science', 'Senior', 12, 11000)
(28, 'Leandro', 'Analytics', 'Pleno', 3, 7000)
(29, 'Rafael', 'Comercial', 'Senior', 5, 7000)
(30, 'André', 'Analytics', 'Senior', 8, 9000)
(31, 'João', 'Comercial', 'Senior', 9, 7000)
(32, 'Jessica', 'Comercial', 'Junior', 0, 3000)
(33, 'Henrique', 'Data Science', 'Senior', 4, 11000)
(34, 'Paulo', 'Data Science', 'Pleno', 2, 8000)
(35, 'Ana', 'Data Science', 'Senior', 9, 11000)
(36, 'Simas', 'Analytics', 'Pleno', 2, 7000)
(37, 'Julio', 'Analytics', 'Junior', 0, 5000)
(38, 'Jorge', 'Comercial', 'Senior', 7, 7000)
(39, 'Elisa', 'Comercial', 'Pleno', 4, 5000)
(40, 'Rodrigo', 'Comercial', 'Junior', 2, 3000)
*/

INSERT INTO tb_funcionarios VALUES (10, 'Pedro', 'Analytics', 'Pleno', 3, 7000);
INSERT INTO tb_funcionarios VALUES (11, 'Sarah', 'Comercial', 'Senior', 6, 7000);
INSERT INTO tb_funcionarios VALUES (12, 'Sofia', 'Analytics', 'Junior', 1, 5000);
INSERT INTO tb_funcionarios VALUES (13, 'Hanna', 'Comercial', 'Junior', 0, 3000);
INSERT INTO tb_funcionarios VALUES (14, 'Luiza', 'Analytics', 'Pleno', 8, 7000);
INSERT INTO tb_funcionarios VALUES (15, 'Lucas', 'Analytics', 'Junior', 2, 5000);
INSERT INTO tb_funcionarios VALUES (16, 'Amanda', 'Data Science', 'Senior', 4, 11000);
INSERT INTO tb_funcionarios VALUES (17, 'Paulo', 'Comercial', 'Senior', 7, 7000);
INSERT INTO tb_funcionarios VALUES (18, 'Marcos', 'Data Science', 'Pleno', 5, 8000);
INSERT INTO tb_funcionarios VALUES (19, 'Adriano', 'Analytics', 'Pleno', 4, 7000);
INSERT INTO tb_funcionarios VALUES (20, 'Tiago', 'Data Science', 'Senior', 10, 11000);
INSERT INTO tb_funcionarios VALUES (21, 'Juliana', 'Data Science', 'Junior', 2, 6000);
INSERT INTO tb_funcionarios VALUES (22, 'Sergio', 'Data Science', 'Senior', 6, 11000);
INSERT INTO tb_funcionarios VALUES (23, 'Sonia', 'Comercial', 'Senior', 8, 7000);
INSERT INTO tb_funcionarios VALUES (24, 'Chen', 'Data Science', 'Pleno', 4, 8000);
INSERT INTO tb_funcionarios VALUES (25, 'Ana', 'Comercial', 'Pleno', 6, 5000);
INSERT INTO tb_funcionarios VALUES (26, 'Julia', 'Comercial', 'Senior', 6, 7000);
INSERT INTO tb_funcionarios VALUES (27, 'Anderson', 'Data Science', 'Senior', 12, 11000);
INSERT INTO tb_funcionarios VALUES (28, 'Leandro', 'Analytics', 'Pleno', 3, 7000);
INSERT INTO tb_funcionarios VALUES (29, 'Rafael', 'Comercial', 'Senior', 5, 7000);
INSERT INTO tb_funcionarios VALUES (30, 'André', 'Analytics', 'Senior', 8, 9000);
INSERT INTO tb_funcionarios VALUES (31, 'João', 'Comercial', 'Senior', 9, 7000);
INSERT INTO tb_funcionarios VALUES (32, 'Jessica', 'Comercial', 'Junior', 0, 3000);
INSERT INTO tb_funcionarios VALUES (33, 'Henrique', 'Data Science', 'Senior', 4, 11000);
INSERT INTO tb_funcionarios VALUES (34, 'Paulo', 'Data Science', 'Pleno', 2, 8000);
INSERT INTO tb_funcionarios VALUES (35, 'Ana', 'Data Science', 'Senior', 9, 11000);
INSERT INTO tb_funcionarios VALUES (36, 'Simas', 'Analytics', 'Pleno', 2, 7000);
INSERT INTO tb_funcionarios VALUES (37, 'Julio', 'Analytics', 'Junior', 0, 5000);
INSERT INTO tb_funcionarios VALUES (38, 'Jorge', 'Comercial', 'Senior', 7, 7000);
INSERT INTO tb_funcionarios VALUES (39, 'Elisa', 'Comercial', 'Pleno', 4, 5000);
INSERT INTO tb_funcionarios VALUES (40, 'Rodrigo', 'Comercial', 'Junior', 2, 3000);

/*
Exercicio 3
Verifique a construção da tabela!
*/

SELECT * 
FROM tb_funcionarios;

/*
Exercicio 4
Ordene a lista de funcionários por Departamento e Senioridade
*/

SELECT * 
FROM tb_funcionarios
ORDER BY departamento, senioridade;
/* Alternativa: ORDER BY 3, 4;  (indicando as colunas pela posição)*/

/*
Exercicio 5
Calcule a quantidade de funcionários quebrado por departamento e senioridade

Dica.: Utilize o GROUP BY com o COUNT*/

SELECT
	departamento,
	senioridade,
	COUNT(nome_funcionario) as contagem_funcionarios
FROM tb_funcionarios
GROUP BY 1, 2;

/*
Exercicio 6
Calcule a soma dos salarios por Departamento
*/

SELECT 
	departamento,
	SUM(salario) AS total_salarios
FROM tb_funcionarios
GROUP BY 1
ORDER BY 1;
	
/*
Exercicio 7
Calcule a média salarial dos funcionários por departamento
*/

SELECT 
	departamento,
	ROUND(AVG(salario),2) AS media_salarios
FROM tb_funcionarios
GROUP BY 1
ORDER BY 1;
   
/*
Exercicio 8
Calcule a média do tempo de experiência por senioridade com tempo de experiencia maior que 3
*/

SELECT
	senioridade,
	ROUND(AVG(anos_experiencia),2)
FROM tb_funcionarios
WHERE anos_experiencia > 3
GROUP BY 1
ORDER BY 1;