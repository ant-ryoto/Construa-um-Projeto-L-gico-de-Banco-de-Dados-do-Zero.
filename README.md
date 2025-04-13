# Construa-um-Projeto-L-gico-de-Banco-de-Dados-do-Zero.


# 🛍️ Nova D - Banco de Dados de E-commerce

Este projeto apresenta a modelagem e implementação de um banco de dados relacional para a loja de roupas **Nova D**, que atua nos modelos B2C e B2B, vendendo diretamente para consumidores e também permitindo que vendedores terceirizados comercializem seus produtos pela plataforma.

## 📌 Objetivo

Modelar e implementar um sistema de banco de dados relacional completo para gerenciar os processos de vendas, estoque, entregas e relacionamento com clientes (PF e PJ), fornecedores e vendedores parceiros.

---

## 🧩 Modelo Lógico

A modelagem foi refinada a partir do modelo ER e adaptada para refletir:

- Clientes Pessoa Física e Jurídica (exclusivamente um ou outro)
- Múltiplos métodos de pagamento por cliente
- Vendedores terceirizados (estilo Magalu)
- Controle de estoque
- Fornecedores de produtos
- Produtos organizados por coleção, grupo, tipo, numeração, cor e preço (com variação por vendedor)
- Processamento de pedidos e entregas com status e código de rastreio

---

## 🛠️ Estrutura do Banco de Dados

Principais entidades e relacionamentos:

- `Cliente` (PF ou PJ)
- `Pagamento`
- `Fornecedor`
- `Produto`, `TipoProduto`, `GrupoProduto`, `Colecao`
- `Vendedor`
- `Estoque`
- `Pedido` e `ItemPedido`
- `Entrega`

---

## 💻 Script de Criação
