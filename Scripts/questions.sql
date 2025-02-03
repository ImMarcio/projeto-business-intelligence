-- 1 Ranking com os 10 maiores clientes (vendas)
select c.nomedaempresa, sum(fv.quantidade * fv.precounitario) as totalvendas
from fatos_vendas fv
join clientes c on fv.sk_cliente = c.sk_cliente
group by c.nomedaempresa
order by totalvendas desc
limit 10;

--2  Ranking com os 10 maiores produtos (vendas) por categoria de produto
select cat.nomedacategoria, p.nomedoproduto, sum(fv.quantidade) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join categorias cat on p.sk_categoria = cat.sk_categoria
group by cat.nomedacategoria, p.nomedoproduto
order by totalvendas desc
limit 10;

-- 3 Relação dos produtos mais vendidos para os clientes da alemanha
select p.nomedoproduto, sum(fv.quantidade) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join clientes c on fv.sk_cliente = c.sk_cliente
where c.pais = 'Alemanha'
group by p.nomedoproduto
order by totalvendas desc;

-- 4 Categoria de produto mais representativa (vendas) nos clientes dos eua
select cat.nomedacategoria, sum(fv.quantidade * fv.precounitario) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join categorias cat on p.sk_categoria = cat.sk_categoria
join clientes c on fv.sk_cliente = c.sk_cliente
where c.pais = 'eua'
group by cat.nomedacategoria
order by totalvendas desc
limit 1;

-- 5. Relação dos vendedores e o detalhamento das vendas de cada um para os respectivos clientes
select f.nomecompleto as vendedor, c.nomedaempresa as cliente, fv.quantidade, fv.desconto, fv.precounitario
from fatos_vendas fv
join funcionarios f on fv.sk_funcionario = f.sk_funcionario
join clientes c on fv.sk_cliente = c.sk_cliente;

-- 6. Vendedores que mais dão descontos nos seus pedidos
select f.nomecompleto as vendedor, sum(fv.desconto) as totaldesconto
from fatos_vendas fv
join funcionarios f on fv.sk_funcionario = f.sk_funcionario
group by f.nomecompleto
order by totaldesconto desc;

-- 7. Quantidade de clientes existentes por cada país
select pais, count(*) as quantidadeclientes
from clientes
group by pais;

-- 8. Quantidade de produtos existentes por cada categoria
select cat.nomedacategoria, count(*) as quantidadeprodutos
from produtos p
join categorias cat on p.sk_categoria = cat.sk_categoria
group by cat.nomedacategoria;

-- 9. Fornecedores, cujos produtos são os mais vendidos na categoria de bebidas
select f.nomedaempresa as fornecedor, sum(fv.quantidade * fv.precounitario) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join fornecedores f on p.sk_fornecedor = f.sk_fornecedor
join categorias cat on p.sk_categoria = cat.sk_categoria
where cat.nomedacategoria = 'bebidas'
group by f.nomedaempresa
order by totalvendas desc;

-- 10. Evolução mensal das vendas no ano de 1997
select to_char(t.data, 'yyyy-mm') as mes, sum(fv.quantidade * fv.precounitario) as totalvendas
from fatos_vendas fv
join tempo t on fv.sk_tempo = t.sk_tempo
where t.ano = 1997
group by to_char(t.data, 'yyyy-mm')
order by mes;

-- 11. Tempo médio de entrega (em dias) de cada transportadora no ano de 1997
SELECT 
    t.nomedaempresa AS transportadora,
    ROUND(AVG(p.datadeentrega - p.datadeenvio), 2) AS tempo_medio_entrega
FROM fatos_vendas f
JOIN pedidos p ON f.sk_pedido = p.sk_pedido
JOIN transportadoras t ON p.sk_transportadora = t.sk_transportadora
WHERE EXTRACT(YEAR FROM p.datadeentrega) = 1997
GROUP BY t.nomedaempresa
ORDER BY tempo_medio_entrega;

-- 12. Distribuição da quantidade de vendedores por país de origem do mesmo
select f.pais, count(*) as quantidadevendedores
from funcionarios f
group by f.pais;

-- 13. Cidades que mais consomem (quantidade) o produto “côte de blaye”
select c.cidade, sum(fv.quantidade) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join clientes c on fv.sk_cliente = c.sk_cliente
where p.nomedoproduto = 'Côte de Blaye'
group by c.cidade
order by totalvendas desc;

select * from "produtos"

-- 14. Tomando como base o principal cliente da northwind (vendas), vendedores que participaram nas vendas
with principalcliente as (
    select fv.sk_cliente
    from fatos_vendas fv
    group by fv.sk_cliente
    order by sum(fv.quantidade * fv.precounitario) desc
    limit 1
)
select f.nomecompleto as vendedor
from fatos_vendas fv
join funcionarios f on fv.sk_funcionario = f.sk_funcionario
where fv.sk_cliente = (select sk_cliente from principalcliente);

-- 15. Tomando como base o principal cliente da northwind (vendas), fornecedores vinculados às vendas
with principalcliente as (
    select fv.sk_cliente
    from fatos_vendas fv
    group by fv.sk_cliente
    order by sum(fv.quantidade * fv.precounitario) desc
    limit 1
)
select distinct f.nomedaempresa as fornecedor
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join fornecedores f on p.sk_fornecedor = f.sk_fornecedor
where fv.sk_cliente = (select sk_cliente from principalcliente);

-- 16. Tomando como base o principal cliente da northwind (vendas), produtos mais vendidos
with principalcliente as (
    select fv.sk_cliente
    from fatos_vendas fv
    group by fv.sk_cliente
    order by sum(fv.quantidade * fv.precounitario) desc
    limit 1
)
select p.nomedoproduto, sum(fv.quantidade) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
where fv.sk_cliente = (select sk_cliente from principalcliente)
group by p.nomedoproduto
order by totalvendas desc;

-- 17. Relação contendo cada categoria, os produtos mais vendidos nas mesmas e os principais clientes de cada produto
select cat.nomedacategoria, p.nomedoproduto, c.nomedaempresa as cliente, sum(fv.quantidade) as totalvendas
from fatos_vendas fv
join produtos p on fv.cod_produto = p.sk_produto
join categorias cat on p.sk_categoria = cat.sk_categoria
join clientes c on fv.sk_cliente = c.sk_cliente
group by cat.nomedacategoria, p.nomedoproduto, c.nomedaempresa
order by totalvendas desc;

-- 18. Relação dos clientes do brasil, com as seguintes informações: empresa, contato, cidade, estado, telefone e fax
select nomedaempresa, nomedocontato, cidade, regiao as estado, telefone, fax
from clientes
where pais = 'Brasil';

-- 19. Relação da quantidade de pedidos atendidos por transportadora nos anos de 96, 97 e 98
select tr.nomedaempresa as transportadora, t.ano, count(p.sk_pedido) as quantidadepedidos
from pedidos p
join transportadoras tr on p.sk_transportadora = tr.sk_transportadora
join tempo t on p.sk_tempoenvio = t.sk_tempo
where t.ano in (1996, 1997, 1998)
group by tr.nomedaempresa, t.ano
order by t.ano;

-- 20. Ticket médio por pedido (geral, por cliente/país/cidade)
select c.pais, c.cidade, c.nomedaempresa as cliente, avg(fv.quantidade * fv.precounitario) as ticketmedio
from fatos_vendas fv
join clientes c on fv.sk_cliente = c.sk_cliente
group by c.pais, c.cidade, c.nomedaempresa;

-- 21. Transportadoras com melhor tempo de entrega
SELECT 
    t.nomedaempresa AS transportadora,
    ROUND(AVG(p.datadeentrega - p.datadeenvio), 2) AS tempo_medio_entrega
FROM pedidos p
JOIN transportadoras t ON p.sk_transportadora = t.sk_transportadora
GROUP BY t.nomedaempresa
ORDER BY tempo_medio_entrega ASC;

-- 22. Tempo médio para liberação dos produtos para entrega
SELECT 
    ROUND(AVG(p.datadeenvio - p.datadopedido), 2) AS tempo_medio_liberacao
FROM pedidos p;

-- 23. Vendedores e respectivos tickets médios por pedido
select f.nomecompleto as vendedor, avg(fv.quantidade * fv.precounitario) as ticketmedio
from fatos_vendas fv
join funcionarios f on fv.sk_funcionario = f.sk_funcionario
group by f.nomecompleto;

-- 24. Produtos que não estão tendo movimentação de venda
SELECT p.nomedoproduto
FROM produtos p
LEFT JOIN fatos_vendas fv ON p.sk_produto = fv.cod_produto
WHERE fv.cod_produto IS NULL;

-- 25. Categorias de produtos que mais recebem descontos
SELECT cat.nomedacategoria, SUM(fv.desconto) AS totaldescontos
FROM fatos_vendas fv
JOIN produtos p ON fv.cod_produto = p.sk_produto
JOIN categorias cat ON p.sk_categoria = cat.sk_categoria
GROUP BY cat.nomedacategoria
ORDER BY totaldescontos DESC;

-- 26. Tendência no faturamento, com base no histórico de vendas
SELECT to_char(t.data, 'YYYY-MM') AS mes, 
       SUM(fv.quantidade * fv.precounitario) AS totalfaturamento
FROM fatos_vendas fv
JOIN tempo t ON fv.sk_tempo = t.sk_tempo
GROUP BY to_char(t.data, 'YYYY-MM')
ORDER BY mes;

-- 27. Existem clientes com perfil de consumo similar?
SELECT c1.nomedaempresa AS cliente1, 
       c2.nomedaempresa AS cliente2, 
       COUNT(DISTINCT fv1.cod_produto) AS produtos_comuns
FROM fatos_vendas fv1
JOIN fatos_vendas fv2 ON fv1.cod_produto = fv2.cod_produto AND fv1.sk_cliente <> fv2.sk_cliente
JOIN clientes c1 ON fv1.sk_cliente = c1.sk_cliente
JOIN clientes c2 ON fv2.sk_cliente = c2.sk_cliente
GROUP BY c1.nomedaempresa, c2.nomedaempresa
HAVING COUNT(DISTINCT fv1.cod_produto) > 5
ORDER BY produtos_comuns DESC;

-- Diretoria

-- 28. Ticket médio por pedido
SELECT p.sk_pedido, AVG(fv.quantidade * fv.precounitario) AS ticket_medio
FROM fatos_vendas fv
JOIN pedidos p ON fv.sk_pedido = p.sk_pedido
GROUP BY p.sk_pedido
ORDER BY ticket_medio DESC;

-- 29. Faturamento médio por cliente
SELECT c.sk_cliente, c.nomedaempresa, AVG(fv.quantidade * fv.precounitario) AS faturamento_medio
FROM fatos_vendas fv
JOIN clientes c ON fv.sk_cliente = c.sk_cliente
GROUP BY c.sk_cliente, c.nomedaempresa
ORDER BY faturamento_medio DESC;

-- 30. Qtde de clientes atendidos
SELECT COUNT(DISTINCT fv.sk_cliente) AS quantidade_clientes_atendidos
FROM fatos_vendas fv;

-- 31. Tempo médio de entrega pela transportadora
SELECT tr.nomedaempresa AS transportadora, 
       AVG(p.datadeentrega - p.datadopedido) AS tempo_medio_entrega
FROM pedidos p
JOIN transportadoras tr ON p.sk_transportadora = tr.sk_transportadora
GROUP BY tr.nomedaempresa
ORDER BY tempo_medio_entrega;

-- 32. Tempo médio para liberação do pedido para transportadora
SELECT tr.nomedaempresa AS transportadora,
       AVG(p.datadeenvio - p.datadopedido) AS tempo_medio_liberação
FROM pedidos p
JOIN transportadoras tr ON p.sk_transportadora = tr.sk_transportadora
GROUP BY tr.nomedaempresa
ORDER BY tempo_medio_liberação;

-- 33. Faturamento geral
SELECT SUM(f.precounitario * f.quantidade) AS faturamento_geral
FROM fatos_vendas f;