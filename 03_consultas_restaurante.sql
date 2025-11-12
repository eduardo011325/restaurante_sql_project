 /*
  Projeto: Banco de Dados do Restaurante
  Seção: Consultas (Básicas, Intermediárias e Condicionais)
  Autor: Eduardo Santos
  Data: 2025-11-12
  Descrição:
    Este script contém consultas SQL do projeto Restaurante, 
    divididas em três níveis de complexidade:
    1. Consultas básicas (filtros e ordenação)
    2. Consultas intermediárias (funções e operadores)
    3. Consultas condicionais (CASE, IFNULL, AND, OR, etc.)
*/

 --------------------------------------------------------------------------------
-- BLOCO 1: CONSULTAS BÁSICAS
--------------------------------------------------------------------------------

-- Seleciona o nome e a categoria dos produtos que têm o preço superior a 30
SELECT nome, categoria
FROM produtos
WHERE preco > 30;

-- Seleciona o nome, telefone e data de nascimento dos clientes que nasceram antes do ano de 1985
SELECT nome, telefone, data_nascimento
FROM clientes
WHERE YEAR(data_nascimento) < 1985;

-- Seleciona o id do produto e os ingredientes de informações de produto para os ingredientes que contenham a palavra “carne”
SELECT id_produto, ingredientes
FROM info_produtos
WHERE ingredientes LIKE '%carne%';

-- Seleciona o nome e a categoria dos produtos ordenados em ordem alfabética por categoria
-- e, dentro de cada categoria, ordenados pelo nome do produto
SELECT nome, categoria
FROM produtos
ORDER BY categoria ASC, nome ASC;

-- Seleciona os 5 produtos mais caros do restaurante
SELECT nome, preco
FROM produtos
ORDER BY preco DESC
LIMIT 5;

-- A cada dia da semana, 2 pratos principais estão na promoção.
-- Hoje seleciona 2 produtos da categoria ‘Prato Principal’ e pula 6 registros (OFFSET = 5)
SELECT id_produto, nome, preco
FROM produtos
WHERE categoria = 'Prato Principal'
ORDER BY id_produto
LIMIT 2 OFFSET 6;

-- Faça backup dos dados da tabela pedidos com o nome de backup_pedidos
CREATE TABLE backup_pedidos AS
SELECT * FROM pedidos;


 --------------------------------------------------------------------------------
-- BLOCO 2: OPERADORES LÓGICOS (AND, OR, NOT, BETWEEN)
--------------------------------------------------------------------------------

-- Funcionarios com status do pedido pendente
select * from pedidos
where id_funcionario = 4 and status = 'Pendente';
 

-- Todos pedidos que não foram concluidos
select * from pedidos
where not status = 'Concluido';

-- Ids que contém apenas os números selecionados
select * from pedidos
where id_produto in (1, 3, 5, 7, 8);

-- Todos os nomes que começam com C
select * from clientes
where nome like 'c%';

-- Todos os produtos que contém carne ou frango
select * from produtos
where descricao like '%carne%' or descricao like'%frango%';

-- Preço entre 20 a 30 
select * from produtos 
where preco between 20 and 30;


 --------------------------------------------------------------------------------
-- BLOCO 3: CONDICIONAIS NULL, IFNULL, CASE
--------------------------------------------------------------------------------


-- Alterando o Status
select status
from pedidos;
update pedidos
set status =  Null
 where id_pedido = 6;
 
 -- Pedidos nulos
 select * from pedidos
 where status is null;
 
 -- Mostrando o status cancelado 
 select id_produto,
 ifnull(status,'Cancelado') as status_tratado from pedidos;
 
 -- Médias
 select nome, cargo, salario,
case
when salario > 3000 then'Acima da Média'
else 'Abaixo da Média'
end as media_salario
from funcionarios;

--  --------------------------------------------------------------------------------
-- BLOCO 4: Relatório final
--------------------------------------------------------------------------------

-- Relatório final: total gasto por cliente
select c.nome, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente
join produtos p on p.id_produto = pe.id_produto
group by c.nome
order by total_gasto desc;


 
