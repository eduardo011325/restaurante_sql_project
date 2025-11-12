# 🍽️ Projeto SQL — Banco de Dados do Restaurante  

**Autor:** Eduardo Santos  
**Data:** Novembro de 2025  
**Tecnologia:** MySQL  
**Categoria:** Modelagem, Manipulação e Consultas SQL  

---

## 📖 Descrição do Projeto  

Este projeto apresenta o desenvolvimento completo de um banco de dados relacional para um sistema de restaurante, criado inteiramente em **MySQL**.  

O objetivo é demonstrar o domínio prático de SQL — desde a criação e modelagem das tabelas até consultas avançadas e funções personalizadas, passando por manipulação e análise de dados.  

---

## 🧩 Etapas do Projeto  

| Etapa | Arquivo | Descrição |
|-------|----------|-----------|
| **1. Modelagem e Estrutura** | [01_criação.tabelas](./01_criação.tabelas) | Criação das tabelas principais (clientes, funcionários, produtos, pedidos e info_produtos), com definição de chaves primárias e estrangeiras. |
| **2. Inserções e Manipulação de Dados** | [02_Inserções_dados_restaurante](./02_Inserções_dados_restaurante) | Inserção, atualização e exclusão de registros (CRUD completo). |
| **3. Consultas Intermediárias** | [03_consultas_restaurante](./03_consultas_restaurante) | Consultas com WHERE, ORDER BY, LIMIT, LIKE, IN, BETWEEN, etc. |
| **4. Consultas entre múltiplas tabelas** | [04_multiplas_tabelas](./04_multiplas_tabelas) | Uso de JOINS (INNER, LEFT, RIGHT) e agrupamentos. |
| **5. Consultas Avançadas e Funções** | [05_consultas_avançadas](./05_consultas_avançadas) | Criação de Views e Functions personalizadas (ex: `MediaPedido`, `BuscaIngredientesProdutos`). |

---

## ⚙️ Principais Recursos e Conceitos Utilizados  

- Modelagem relacional completa  
- Chaves primárias e estrangeiras  
- Funções de agregação: `SUM()`, `AVG()`, `COUNT()`  
- JOINs entre múltiplas tabelas  
- Views e Funções personalizadas (UDFs)  
- Uso de `CASE`, `COALESCE`, `GROUP_CONCAT`  
- Scripts modulares e comentados  

---

## 🧠 Tecnologias Utilizadas  

- **Banco de Dados:** MySQL  
- **Ferramenta:** MySQL Workbench  
- **Linguagem:** SQL  

---

## 🚀 Como Executar o Projeto  

1. Faça o clone do repositório:  
   ```bash
   git clone https://github.com/eduardo011325/restaurante_sql_project.git
