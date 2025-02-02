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


DROP INDEX IF EXISTS fatos_vendas_idx;

INSERT INTO fatos_vendas (numerodopedido, precounitario, quantidade, desconto, paisdedestino, cod_produto, sk_pedido, sk_tempo, sk_cliente, sk_funcionario)
SELECT ped."NumeroDoPedido", dp."PrecoUnitario", dp."Quantidade", dp."Desconto", cli."Pais", prod."CodigoDoProduto", pd."sk_pedido", te."sk_tempo", clid."sk_cliente", fund."sk_funcionario"
FROM "Pedidos" ped
JOIN "Detalhes do Pedido" dp ON ped."NumeroDoPedido" = dp."NumeroDoPedido"
JOIN "Clientes" cli ON ped."CodigoDoCliente" = cli."CodigoDoCliente"
JOIN "Funcionarios" fun ON ped."CodigoDoFuncionario" = fun."CodigoDoFuncionario"
JOIN "tempo" te ON ped."DataDoPedido" = te."data"
JOIN "pedidos" pd ON ped."NumeroDoPedido" = pd."numerodopedido"
JOIN "funcionarios" fund ON ped."CodigoDoFuncionario" = fund."codigodofuncionario"
JOIN "clientes" clid ON ped."CodigoDoCliente" = clid."codigodocliente"
JOIN "Produtos" prod ON dp."CodigoDoProduto" = prod."CodigoDoProduto";



select * from "Pedidos"

select * from "Clientes"
select * from "Produtos"
select * from "Funcionarios"
select * from "tempo"
select * from "Detalhes do Pedido";

select * from "clientes"
select * from "Produtos"
select * from "funcionarios"
select * from "tempo"
select * from "Detalhes do Pedido";

select * from "fatos_vendas";

