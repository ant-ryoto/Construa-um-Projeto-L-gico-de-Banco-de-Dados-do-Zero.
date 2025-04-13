-- =========================
-- MODELO LÓGICO - NOVA D
-- =========================

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco TEXT
);

-- Tabela ClientePF
CREATE TABLE ClientePF (
    idCliente INT PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela ClientePJ
CREATE TABLE ClientePJ (
    idCliente INT PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE,
    razaoSocial VARCHAR(150),
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY,
    idCliente INT,
    tipo VARCHAR(50),
    dadosPagamento TEXT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Tabela TipoProduto
CREATE TABLE TipoProduto (
    idTipo INT PRIMARY KEY,
    descricao VARCHAR(50)
);

-- Tabela GrupoProduto
CREATE TABLE GrupoProduto (
    idGrupo INT PRIMARY KEY,
    descricao VARCHAR(50)
);

-- Tabela Colecao
CREATE TABLE Colecao (
    idColecao INT PRIMARY KEY,
    nomeColecao VARCHAR(50),
    ano INT
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    nome VARCHAR(100),
    descricao TEXT,
    precoBase DECIMAL(10,2),
    cor VARCHAR(30),
    numeracao VARCHAR(10),
    idTipo INT,
    idGrupo INT,
    idColecao INT,
    FOREIGN KEY (idTipo) REFERENCES TipoProduto(idTipo),
    FOREIGN KEY (idGrupo) REFERENCES GrupoProduto(idGrupo),
    FOREIGN KEY (idColecao) REFERENCES Colecao(idColecao)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    nome VARCHAR(100),
    cnpj VARCHAR(18),
    contato VARCHAR(100)
);

-- Tabela ProdutoFornecedor
CREATE TABLE ProdutoFornecedor (
    idProduto INT,
    idFornecedor INT,
    PRIMARY KEY (idProduto, idFornecedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- Tabela Vendedor
CREATE TABLE Vendedor (
    idVendedor INT PRIMARY KEY,
    nome VARCHAR(100),
    cnpj VARCHAR(18),
    contato VARCHAR(100)
);

-- Tabela PrecoVendedor
CREATE TABLE PrecoVendedor (
    idProduto INT,
    idVendedor INT,
    precoEspecial DECIMAL(10,2),
    PRIMARY KEY (idProduto, idVendedor),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    idProduto INT,
    quantidade INT,
    localizacao VARCHAR(100),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    idCliente INT,
    idVendedor INT,
    dataPedido DATE,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(idVendedor)
);

-- Tabela ItemPedido
CREATE TABLE ItemPedido (
    idItemPedido INT PRIMARY KEY,
    idPedido INT,
    idProduto INT,
    quantidade INT,
    precoVenda DECIMAL(10,2),
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    idPedido INT,
    statusEntrega VARCHAR(50),
    codigoRastreio VARCHAR(50),
    dataEnvio DATE,
    dataEntrega DATE,
    FOREIGN KEY (idPedido) REFERENCES Pedido(idPedido)
);

-- =========================
-- EXEMPLOS DE QUERIES SQL
-- =========================

-- 1. Quantos pedidos foram feitos por cada cliente
SELECT c.nome, COUNT(p.idPedido) AS total_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.idCliente = p.idCliente
GROUP BY c.idCliente;

-- 2. Relação de nomes dos fornecedores e os produtos fornecidos
SELECT f.nome AS fornecedor, pr.nome AS produto
FROM Fornecedor f
JOIN ProdutoFornecedor pf ON f.idFornecedor = pf.idFornecedor
JOIN Produto pr ON pr.idProduto = pf.idProduto;

-- 3. Total de vendas por produto (usando HAVING para filtrar)
SELECT pr.nome, SUM(ip.quantidade * ip.precoVenda) AS total_vendas
FROM Produto pr
JOIN ItemPedido ip ON pr.idProduto = ip.idProduto
GROUP BY pr.idProduto
HAVING total_vendas > 1000;

-- 4. Mostrar status e rastreio de todos os pedidos de um cliente específico
SELECT p.idPedido, e.statusEntrega, e.codigoRastreio
FROM Pedido p
JOIN Entrega e ON e.idPedido = p.idPedido
WHERE p.idCliente = 1;

-- 5. Exibir condição com CASE (produto esgotado ou em estoque)
SELECT pr.nome,
       e.quantidade,
       CASE 
           WHEN e.quantidade = 0 THEN 'Esgotado'
           ELSE 'Disponível'
       END AS status_estoque
FROM Produto pr
JOIN Estoque e ON pr.idProduto = e.idProduto
ORDER BY status_estoque DESC;
