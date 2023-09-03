-- Para este cenário você irá utilizar seu esquema conceitual, 
-- criado no desafio do módulo de modelagem de BD com modelo ER,
-- para criar o esquema lógico para o contexto de uma oficina. 
-- Neste desafio, você definirá todas as etapas. Desde o esquema
-- até a implementação do banco de dados. Sendo assim, neste 
-- projeto você será o protagonista. Tenha os mesmos cuidados, 
-- apontados no desafio anterior, ao modelar o esquema utilizando 
-- o modelo relacional.



-- Criação das tabelas
CREATE TABLE Cliente (
    ClienteID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Telefone VARCHAR(20)
);

CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY,
    ClienteID INT,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    AnoFabricacao INT,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

-- Crie as tabelas restantes seguindo o mesmo padrão

-- Consultas SQL
-- Recuperação simples de todas as Ordens de Serviço
SELECT * FROM OrdemServico;

-- Recuperação de Clientes com veículos fabricados após 2015
SELECT Cliente.Nome, Veiculo.Marca, Veiculo.Modelo
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
WHERE Veiculo.AnoFabricacao > 2015;

-- Criação de atributo derivado para calcular o total de uma Ordem de Serviço
SELECT OrdemServico.OrdemServicoID, SUM(ItemServico.Quantidade * ItemServico.PrecoUnitario) AS Total
FROM OrdemServico
JOIN ItemServico ON OrdemServico.OrdemServicoID = ItemServico.OrdemServicoID
GROUP BY OrdemServico.OrdemServicoID;

-- Ordenação de Ordens de Serviço por Data de Início
SELECT * FROM OrdemServico ORDER BY DataInicio;

-- Filtros e agregação para encontrar a quantidade de Serviços em cada Ordem de Serviço
SELECT OrdemServico.OrdemServicoID, COUNT(ItemServico.ServicoID) AS QuantidadeServicos
FROM OrdemServico
JOIN ItemServico ON OrdemServico.OrdemServicoID = ItemServico.OrdemServicoID
GROUP BY OrdemServico.OrdemServicoID
HAVING COUNT(ItemServico.ServicoID) > 2;

-- Junção de tabelas para obter informações detalhadas da Ordem de Serviço e do Cliente
SELECT OrdemServico.OrdemServicoID, Cliente.Nome AS NomeCliente, OrdemServico.Status
FROM OrdemServico
JOIN Cliente ON OrdemServico.ClienteID = Cliente.ClienteID;
