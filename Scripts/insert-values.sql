-- drop table clientes, categorias, pedidos,tempo,fatos_vendas,fornecedores,funcionarios,produtos,transportadoras cascade


-- INSERT INTO clientes (codigodocliente, nomeDaEmpresa, nomeDoContato, cargoDoContato, endereco, cidade, regiao, CEP, pais, telefone, fax)
-- SELECT "CodigoDoCliente","NomeDaEmpresa", "NomeDoContato", "CargoDoContato", "Endereco", "Cidade", "Regiao", "CEP", "Pais", "Telefone", "Fax"
-- FROM "Clientes";


-- INSERT INTO fornecedores (codigodofornecedor, nomedaempresa,nomedocontato)
-- SELECT "CodigoDoFornecedor", "NomeDaEmpresa", "NomeDoContato"
-- FROM "Fornecedores";


-- INSERT INTO funcionarios (codigodofuncionario, nomecompleto, cargo, pais, datadenascimento, datadecontratacao, cep)
-- SELECT "CodigoDoFuncionario", "Sobrenome" || ', ' || "Nome", "Cargo", "Pais", "DataDeNascimento", "DataDeContratacao", "CEP"  -- Aspas duplas em todas as colunas da tabela de origem
-- FROM "Funcionarios";



-- WITH Datas AS (
--     SELECT d::DATE AS data
--     FROM generate_series('1996-01-01'::date, '1998-12-31'::date, '1 day'::interval) AS t(d)
-- )
-- INSERT INTO Tempo (data, ano, trimestre, mes, dia, diadasemana, nomedomes)
-- SELECT data,
--        to_char(data, 'YYYY')::INTEGER,  -- Conversão para inteiro
--        (to_char(data, 'MM')::INTEGER - 1) / 3 + 1,
--        to_char(data, 'MM')::INTEGER,  -- Conversão para inteiro
--        to_char(data, 'DD')::INTEGER,  -- Conversão para inteiro
--        to_char(data, 'D')::INTEGER,
--        to_char(data, 'YYYY-MM')
-- FROM Datas;


-- INSERT INTO categorias (codigodacategoria, nomedacategoria, descricao)
-- SELECT "CodigoDaCategoria", "NomeDaCategoria", "Descricao"
-- FROM "Categorias"; 

-- INSERT INTO transportadoras (codigodatransportadora, nomedaempresa, telefone)
-- SELECT  "CodigoDaTransportadora", "NomeDaEmpresa", "Telefone"
-- FROM "Transportadoras";  




-- INSERT INTO produtos (codigodoproduto, nomedoproduto, sk_fornecedor, sk_categoria, quantidadeporunidade, precounitario)
-- SELECT "CodigoDoProduto", "NomeDoProduto",  forn.CodigoDoFornecedor, cat.CodigoDaCategoria, "QuantidadePorUnidade", "PrecoUnitario"
-- FROM "Produtos" p
-- JOIN Categorias cat ON p."CodigoDaCategoria" = cat.codigodacategoria 
-- JOIN Fornecedores forn ON p."CodigoDoFornecedor" = forn.codigodofornecedor; 



-- ALTER TABLE pedidos
-- ALTER COLUMN sk_tempoenvio DROP NOT NULL;

-- INSERT INTO pedidos (numerodopedido, datadopedido, datadeentrega, datadeenvio, sk_tempopedido, sk_tempoentrega, sk_tempoenvio, sk_transportadora)
-- SELECT "NumeroDoPedido", "DataDoPedido", "DataDeEntrega", "DataDeEnvio", tp."sk_tempo", te."sk_tempo", ts."sk_tempo", transp."codigodatransportadora"
-- FROM "Pedidos" ped
-- JOIN Tempo tp ON ped."DataDoPedido" = tp.data
-- LEFT JOIN Tempo te ON ped."DataDeEntrega" = te.data
-- LEFT JOIN Tempo ts ON ped."DataDeEnvio" = ts.data
-- JOIN Transportadoras transp ON ped."Via" = transp.codigodatransportadora;




INSERT INTO fatos_vendas (numerodopedido,cod_produto,sk_cliente,       sk_funcionario,            sk_tempo,     quantidade,     precounitario,     desconto,      sk_pedido,paisdedestino)
SELECT ped."NumeroDoPedido",prod."CodigoDoProduto",cli."CodigoDoCliente",func."CodigoDoFuncionario",dt."sk_tempo",dp."Quantidade",dp."PrecoUnitario",dp."Desconto",dp."NumeroDoPedido",cli."Pais" 
FROM "Detalhes do Pedido" dp  
JOIN Pedidos ped ON "dp.NumeroDoPedido" = "ped.NumeroDoPedido"
JOIN Produtos prod ON "dp.CodigoDoProduto" = "prod.CodigoDoProduto"
JOIN Clientes cli ON "ped.CodigoDoCliente" = "cli.CodigoDoCliente"
JOIN Funcionarios func ON "ped.CodigoDoFuncionario" = "func.CodigoDoFuncionario"
JOIN Tempo dt ON "ped.DataDoPedido" = "dt.data";


INSERT INTO fatos_vendas (
    numerodopedido, 
    cod_produto, 
    sk_cliente, 
    sk_funcionario, 
    sk_tempo, 
    quantidade, 
    precounitario, 
    desconto, 
    sk_pedido, 
    paisdedestino
)
SELECT 
    p."numerodopedido", 
    d."CodigoDoProduto", 
    c.CodigoDoCliente, 
    f.CodigoDoFuncionario, 
    t.sk_tempo, 
    d."Quantidade", 
    d."PrecoUnitario", 
    d."Desconto", 
    pd.sk_pedido, 
    p."PaisDeDestino"
FROM "Pedidos" p
JOIN "Detalhes do Pedido" d ON p."NumeroDoPedido" = d."NumeroDoPedido"
JOIN "Clientes" c ON d."CodigoDoCliente" = "c.CodigoDoCliente"
JOIN "Funcionarios" f ON "p.CodigoDoFuncionario" = "f.CodigoDoFuncionario"
JOIN "tempo" t ON "p.DataDoPedido" = "t.data"
Join "pedidos" pd on "p.NumeroDoPedido" = "pd.sk_pedido";








select * from "pedidos"
select * from "Pedidos"

select * from fatos_vendas
select * from "Detalhes do Pedido";

SELECT "NumeroDoPedido", "CodigoDoProduto", "PrecoUnitario", "Quantidade", "Desconto"
	FROM public."Detalhes do Pedido";

