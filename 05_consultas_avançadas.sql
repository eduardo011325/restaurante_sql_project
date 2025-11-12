/*
  Projeto: Banco de Dados do Restaurante
  Seção: Consultas Avançadas (Views e Funções Personalizadas)
  Autor: Eduardo Santos
  Data: 2025-11-12
  Descrição:
    Este script contém consultas SQL avançadas aplicadas ao banco 'restaurante',
    incluindo:
      - Criação e manipulação de Views (consultas salvas);
      - Consultas analíticas com funções de agregação (SUM, GROUP BY);
      - Funções personalizadas (User Defined Functions - UDFs) para análise de dados;
      - Uso de CASE, COALESCE e GROUP_CONCAT.
    O objetivo é demonstrar domínio em consultas complexas e componentes reutilizáveis.
*/

--------------------------------------------------------------------------------
-- BLOCO 1: VIEW DE RESUMO DE PEDIDOS
--------------------------------------------------------------------------------

use restaurante;

-- Criação da View
create view resumo_pedido as
select
c.nome as cliente,
c.email,
f.nome as funcionarios,
p.nome as produtos,
p.preco,
id_pedido,
pe.quantidade,
pe.data_pedido
from clientes c 
join pedidos pe on pe.id_cliente = c.id_cliente
join produtos p on pe.id_produto = p.id_produto 
join funcionarios f on pe.id_funcionario = f.id_funcionario;

-- Selecionando a View recém criada 
select * from resumo_pedido; 

-- Realizando uma soma através da view
select 
cliente,
id_pedido,
sum(preco * quantidade) as total_gasto
from resumo_pedido
group by cliente, id_pedido;

-- Alterando a view recém criada
create or replace view resumo_pedido as
select
c.nome as cliente,
c.email,
f.nome as funcionarios,
p.nome as produtos,
p.preco,
id_pedido,
pe.quantidade,
pe.data_pedido,
(p.preco * pe.quantidade) as total
from clientes c 
join pedidos pe on pe.id_cliente = c.id_cliente
join produtos p on pe.id_produto = p.id_produto 
join funcionarios f on pe.id_funcionario = f.id_funcionario;

-- Selecionando a coluna recém criada da view
select 
total 
from resumo_pedido;


-- Selecionando o total que cada cliente gastou 
select 
cliente,
id_pedido,
total
from resumo_pedido;

-- Mostra o quão otimizado a view esta com a consulta
explain select 
cliente,
id_pedido,
total
from resumo_pedido;

/*
  Função: BuscaIngredientesProdutos
  Autor: Eduardo Santos
  Data: 2025-11-12
  Banco de Dados: restaurante

  Descrição:
    Esta função retorna uma lista de ingredientes associados a um produto específico
    a partir do seu ID. Ela utiliza a função de agregação GROUP_CONCAT para unir 
    todos os ingredientes de um produto em uma única linha de texto, separados por vírgula.

  Parâmetros:
    p_id_produto (INT) → ID do produto a ser pesquisado.

  Retorno:
    VARCHAR(100) → String contendo todos os ingredientes do produto.

  Exemplo de uso:
    SELECT nome, BuscaIngredientesProdutos(id_produto) AS ingredientes
    FROM produtos;
*/

delimiter //
create function BuscaIngredientesProdutos(p_id_produto int)
returns varchar(100)
reads sql data
begin
    -- Declara variável para armazenar a lista de ingredientes
    declare v_buscaProdutos varchar(100);

    -- Busca e concatena os ingredientes relacionados ao produto informado
    select group_concat(distinct i.ingredientes separator ', ')
    into v_buscaProdutos
    from info_produtos i
    join produtos p on p.id_produto = i.id_produto
    where i.id_produto = p_id_produto;

    -- Retorna o texto com todos os ingredientes encontrados
    return v_buscaProdutos;
end //
delimiter ;

-- exemplo de uso 

select id_produto, nome, BuscaIngredientesProdutos(id_produto) as ingredientes
from produtos;

/*
  Função: MediaPedido
  Autor: Eduardo Santos
  Data: 2025-11-12
  Banco de Dados: restaurante

  Descrição:
    Esta função compara o total de vendas de um produto específico com a média geral 
    de vendas de todos os produtos cadastrados no banco. O resultado indica se o produto 
    teve desempenho acima, abaixo ou igual à média geral de vendas.

  Parâmetros:
    p_id_produto (INT) → ID do produto que será avaliado.

  Retorno:
    VARCHAR(100) → Texto indicando a classificação do produto:
                   - 'Acima da Média'
                   - 'Abaixo da Média'
                   - 'Igual à Média'

  Lógica de funcionamento:
    1. Calcula o total de vendas do produto informado (preço × quantidade);
    2. Calcula a média geral das vendas de todos os produtos;
    3. Compara os dois valores e retorna a classificação em texto.

  Exemplo de uso:
    SELECT nome, MediaPedido(id_produto) AS desempenho
    FROM produtos;
*/


delimiter //

create function MediaPedido(p_id_produto int)
returns varchar(100)
reads sql data
begin
    declare v_totalPedidos decimal(10,2);
    declare v_mediaPreco decimal(10,2);

    -- total de vendas do produto específico
    select sum(p.preco * pe.quantidade)
    into v_totalPedidos
    from pedidos pe
    join produtos p on pe.id_produto = p.id_produto
    where pe.id_produto = p_id_produto;

    -- média geral de vendas de todos os produtos
    select coalesce(avg(p.preco * pe.quantidade),0)
    into v_mediaPreco
    from pedidos pe
    join produtos p on pe.id_produto = p.id_produto;

    -- comparação do total do produto com a média geral
    return (
        case
            when v_totalPedidos > v_mediaPreco then 'Acima da Média'
            when v_totalPedidos < v_mediaPreco then 'Abaixo da Média'
            else 'Igual à Média'
        end
    );
end //
delimiter ;

-- Exemplo de uso:
select id_produto, nome, MediaPedido(id_produto) as desempenho
from produtos;

drop function if exists MediaPedido
