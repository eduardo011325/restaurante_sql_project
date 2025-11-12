 
 /*
  Projeto: Banco de Dados do Restaurante
  Seção: Definição e Criação de Tabelas
  Autor: Eduardo Santos
  Data: 2025-11-12
  Descrição:
    Script responsável pela criação das tabelas do banco 'restaurante',
    incluindo estrutura, chaves primárias e estrangeiras.
*/

CREATE DATABASE IF NOT EXISTS restaurante;
USE restaurante;

--------------------------------------------------------------------------------
-- TABELA FUNCIONÁRIOS
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS funcionarios;
CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) not null,
    cpf VARCHAR(14) unique,
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    cargo VARCHAR(100),
    salario DECIMAL(10,2),
    data_admissao DATE
);
 
 
 --------------------------------------------------------------------------------
-- TABELA CLIENTES
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) not null,
    cpf VARCHAR(14) unique,
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE
);

--------------------------------------------------------------------------------
-- TABELA PRODUTOS
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS produtos;
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)not null,    
    descricao TEXT,
    preco DECIMAL(10,2)not null,
    categoria VARCHAR(100)
);

--------------------------------------------------------------------------------
-- TABELA PEDIDOS
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS pedidos;
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_funcionario INT,
    id_produto INT,
    quantidade INT,
    preco decimal (10,2),
    data_pedido DATE,
    status VARCHAR(50) default 'Pendente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);


--------------------------------------------------------------------------------
-- TABELA INFO_PRODUTOS
--------------------------------------------------------------------------------

DROP TABLE IF EXISTS info_produtos;
CREATE TABLE info_produtos (
    id_info INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    ingredientes TEXT,
    fornecedor VARCHAR(255),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);











