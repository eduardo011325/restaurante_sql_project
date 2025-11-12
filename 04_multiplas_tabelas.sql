/*
  Projeto: Banco de Dados do Restaurante
  Seção: Consultas Relacionais e Múltiplas Tabelas
  Autor: Eduardo Santos
  Data: 2025-11-12
  Descrição:
    Script com consultas SQL envolvendo múltiplas tabelas do banco 'restaurante'.
    Abrange relacionamentos, agregações e filtros, demonstrando uso de INNER e LEFT JOIN.
*/


--------------------------------------------------------------------------------
-- BLOCO 1: CONSULTA EM MÚLTIPLAS TABELAS
--------------------------------------------------------------------------------

use restaurante;

-- Selecionando a tabela produto e info_produto
select distinct  
p.id_produto, 
p.nome, 
p.descricao,
i.ingredientes
from produtos p 
join info_produtos i on p.id_produto = i.id_produto;

-- Selecionando a tabela pedido e cliente 

select 
c.nome,
c.email,
pe.id_pedido,
pe.quantidade,
pe.data_pedido
from clientes c 
join pedidos pe on pe.id_cliente = c.id_cliente;

-- Seleciona todos os funcionarios que fizeram os pedidos dos clientes

select
c.nome as cliente,
c.email,
f.nome as funcionarios,
pe.id_pedido,
pe.data_pedido
from pedidos pe
 join clientes c on pe.id_cliente = c.id_cliente
join funcionarios f on pe.id_funcionario = f.id_funcionario;

-- Seleciona a quantidade de pedidos que cada funcionario fez pros clientes

select 
c.nome as clientes,
c.email,
f.nome as funcionarios,
p.nome as produtos,
p.preco,
pe.id_pedido,
pe.quantidade,
pe.data_pedido
from pedidos pe
join clientes c on c.id_cliente = pe.id_cliente
join funcionarios f on f.id_funcionario = pe.id_funcionario
join produtos p on p.id_produto = pe.id_produto;

-- Seleciona os clientes que o status esta pendente

 select
 c.nome,
 pe.id_pedido
 from pedidos pe
 join clientes c on c.id_cliente = pe.id_cliente
 where pe.status = 'Pendente'
 order by pe.id_pedido desc;
 
 -- Seleciona os pedidos que estão nulos 

 select distinct 
 c.nome,
 c.email,
 pe.id_pedido
 from clientes c
 left join pedidos pe on pe.id_cliente = c.id_cliente
 where id_pedido is null;
 
 -- Conta a quantidade de pedidos dos clientes
 
 select 
 c.nome,
 count(pe.id_pedido) as quantidade_pedido
 from clientes c
 left join pedidos pe on pe.id_cliente = c.id_cliente
 group by c.nome
 order by quantidade_pedido desc;
 
 -- Faz a soma dos produtos + a quantidade de cada
 
 select 
 p.nome,
 sum(pe.quantidade * p.preco) as preco_total
 from produtos p 
join pedidos pe on pe.id_produto = p.id_produto
group by p.nome
order by preco_total desc;













