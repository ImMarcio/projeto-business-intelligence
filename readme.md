
# 🌍 **Northwind**  

## 👥 **Equipe**  
- **Alic Victor**  
- **Juliana Ferreira**  
- **Márcio José**  
- **Ricardo Luis** 

## 📌 **Visão Geral**  
Este modelo dimensional segue a abordagem **Esquema Estrela**, onde a **tabela fato** (`Fatos_Vendas`) contém os dados quantitativos e as **tabelas dimensão** (`Clientes`, `Tempo`, `Produtos`, `Funcionarios`, `Transportadora`.) fornecem o contexto para análise.  

Ele foi projetado para facilitar consultas analíticas e gerar insights sobre vendas, desempenho de funcionários, eficiência logística e segmentação de clientes.  

# 📊 Modelo Dimensional - Esquema Estrela  

Este modelo segue a abordagem de **Esquema Estrela**, onde há uma **tabela fato** (`Fatos_Vendas`) que armazena métricas e indicadores de vendas, e várias **tabelas dimensão** (`Clientes`, `Tempo`, `Produtos`, `Funcionarios`, `Transportadora`.), que permitem a análise dos dados sob diferentes perspectivas.  

## 🔹 Avaliação do Modelo  

### **1️⃣ Tabela Fato (`Fatos_Vendas`)**  
✅ Contém as métricas principais: `PrecoTotal`, `PrecoUnitario`, `Desconto`, `Frete`, `PaisDeDestino`.  <br>
✅ Referencia dimensões importantes (`SK_TempoPedido`, `SK_TempoEntrega`, `SK_TempoEnvio`, `SK_Cliente`, `SK_Funcionario`, `SK_Transportadora`, `SK_Produto`), permitindo análises baseadas no tempo, cliente, funcionário, transportadora e produto.  <br>
✅ O uso de `NUMERIC(14,2)` para valores monetários evita problemas de precisão.  <br>
🔹 **Sugestão**: Poderia incluir um campo `Total_Venda` calculado (`PrecoUnitario * Quantidade - Desconto`) para facilitar consultas.  

### **2️⃣ Dimensão Tempo (`Dim_Tempo`)**  
✅ Representa a dimensão de tempo com colunas para `Data`, `Ano`, `Mes`, `Dia`, `Trimestre`, `DiadaSemana` e `NomeDoMes`.   <br>
✅ Permite análises temporais detalhadas, como sazonalidade e tendências. <br>
✅ `SK_Tempo` é a chave primária gerada automaticamente por uma sequência. <br>
🔹 **Sugestão**: Adicionar um campo SemanaDoAno para permitir análises semanais.  

### **3️⃣ Dimensão Clientes (`Dim_Clientes`)**  
✅ Contém informações sobre os clientes, como ``NomeDaEmpresa``, ``CodigoDoCliente``, `NomeDoContato`, ``CargoDoContato``, ``Endereco``, ``Cidade``, ``Regiao``, ``CEP``, ``Pais``, ``Telefone``, ``Fax`` e ``PaisISO``. <br>
✅ ``SK_Cliente`` é a chave primária gerada automaticamente por uma sequência. <br>
🔹 **Sugestão**: O campo ``CodigoDoCliente`` poderia ser um índice único para otimizar buscas.

### **4️⃣ Dimensão Transportadoras (`Dim_Transportadoras`)**  
✅ Contém informações sobre as transportadoras, incluindo ``CodigoDaTransportadora``, ``NomeDaEmpresa`` e ``Telefone``.  <br>
✅ ``SK_Transportadora`` é a chave primária gerada automaticamente por uma sequência.  <br>
✅ Possui um índice único em ``CodigoDaTransportadora`` para garantir consistência. <br>
🔹 **Sugestão**: Adicionar um campo ``Email`` para contato.

### **5️⃣ Dimensão Produtos (`Dim_Produtos`)**  
✅ Contém detalhes dos produtos, como ``EmpresaFornecedora``, ``CodigoDoProduto``, ``NomeDoProduto``, ``QuantidadePorUnidade``, ``PrecoUnitario`` e ``Categoria``. <br>
✅ ``SK_Produto`` é a chave primária gerada automaticamente por uma sequência. <br>
✅ ``CodigoDoProduto`` possui um índice único para garantir integridade. <br>
🔹 **Sugestão**: Adicionar um campo ``EstoqueAtual`` para controle de disponibilidade. 

### **6️⃣ Dimensão Funcionários (`Dim_Funcionarios`)**  
✅ Contém informações dos funcionários, incluindo ``CodigoDoFuncionario``, ``NomeCompleto``, ``Cargo``, ``DataDeNascimento``, ``DataDeContratacao``, ``CEP`` e ``Pais``. <br>
✅ ``SK_Funcionario`` é a chave primária gerada automaticamente por uma sequência. <br>
✅ ``CodigoDoFuncionario`` possui um índice único para otimizar buscas. <br>
🔹 **Sugestão**: Incluir um campo ``EmailProfissional`` para facilitar o contato interno.


# Modelagem Dimensional
###  Modelo Estrela
![alt text](image.jpeg)


# 📊 Relatório de Métricas da Análise do Negócio

## 📌 Sumário

| Pergunta | Medidas | Dimensões | Hierarquia | Observações |
|---|---|---|---|---|
| Ranking com os 10 maiores clientes (vendas) | Total de vendas | Cliente | - | - |
| Ranking com os 10 maiores produtos (vendas) por categoria de produto | Total de vendas | Produto, Categoria | Categoria > Produto | - |
| Relação dos produtos mais vendidos para os clientes da Alemanha | Total de vendas | Produto, País | País > Produto | Filtrar por Alemanha |
| Categoria de produto mais representativa (vendas) nos clientes dos EUA | Total de vendas | Categoria, País | País > Categoria | Filtrar por EUA |
| Relação dos vendedores e o detalhamento das vendas de cada um para os respectivos clientes | Total de vendas | Vendedor, Cliente | Vendedor > Cliente | - |
| Vendedores que mais dão descontos nos seus pedidos | Desconto médio | Vendedor | - | - |
| Quantidade de clientes existentes por cada país | Quantidade de clientes | País | País | - |
| Quantidade de produtos existentes por cada categoria | Quantidade de produtos | Categoria | Categoria | - |
| Fornecedores cujos produtos são os mais vendidos na categoria de Bebidas | Total de vendas | Fornecedor, Categoria | Categoria > Fornecedor | Filtrar por Bebidas |
| Evolução mensal das vendas no ano de 1997 | Total de vendas | Tempo (Ano, Mês) | Ano > Mês | Filtrar por 1997 |
| Tempo médio de entrega (em dias) de cada transportadora no ano de 1997 | Tempo médio de entrega | Transportadora, Tempo (Ano) | Ano > Transportadora | Filtrar por 1997 |
| Distribuição da quantidade de vendedores por país de origem do mesmo | Quantidade de vendedores | País | País | - |
| Cidades que mais consomem (quantidade) o produto “Côte de Blaye” | Quantidade de vendas | Cidade, Produto | Produto > Cidade | Filtrar por “Côte de Blaye” |
| Tomando como base o principal cliente da Northwind (vendas), vendedores que participaram nas vendas | Total de vendas | Cliente, Vendedor | Cliente > Vendedor | - |
| Tomando como base o principal cliente da Northwind (vendas), fornecedores vinculados às vendas | Total de vendas | Cliente, Fornecedor | Cliente > Fornecedor | - |
| Tomando como base o principal cliente da Northwind (vendas), produtos mais vendidos | Total de vendas | Cliente, Produto | Cliente > Produto | - |
| Relação contendo cada Categoria, os Produtos mais vendidos nas mesmas e os principais clientes de cada produto | Total de vendas | Categoria, Produto, Cliente | Categoria > Produto > Cliente | - |
| A relação dos clientes do Brasil, com as seguintes informações: Empresa, Contato, Cidade, Estado, Telefone e Fax | - | Cliente | País > Estado > Cidade > Cliente | Filtrar por Brasil |
| Relação da quantidade de pedidos atendidos por transportadora nos anos de 96, 97 e 98 | Quantidade de pedidos | Transportadora, Tempo (Ano) | Ano > Transportadora | Filtrar por 96, 97, 98 |
| Ticket médio por pedido (Geral, por Cliente/País/Cidade) | Ticket médio | Cliente, País, Cidade | País > Cidade > Cliente | - |
| Transportadoras com melhor tempo de entrega | Tempo médio de entrega | Transportadora | - | Ordenar por menor tempo |
| Tempo médio para liberação dos produtos para entrega | Tempo médio de liberação | Produto | - | - |
| Vendedores e respectivos tickets médios por pedido | Ticket médio | Vendedor | - | - |
| Produtos que não estão tendo movimentação de venda | - | Produto | - | Identificar produtos sem vendas |
| Categorias de produtos que mais se dão descontos | Desconto médio | Categoria | - | - |
| Tendência no faturamento, com base no histórico de vendas | Total de vendas ao longo do tempo | Tempo (Ano, Mês) | Ano > Mês | - |
| Existem clientes com perfil de consumo similar? | Análise de similaridade | Cliente | - | Requer técnicas de clustering |


# Diretoria

| Pergunta | Medidas | Dimensões | Hierarquia | Observações |
|---|---|---|---|---|
| Ticket médio por pedido | Ticket médio | Pedido | - | (Total de vendas / Quantidade de pedidos) |
| Faturamento médio por cliente | Faturamento médio | Cliente | - | (Total de vendas / Quantidade de clientes) |
| Quantidade de clientes atendidos | Quantidade de clientes | Tempo (Ano, Mês) | Ano > Mês | Contagem de clientes distintos por período |
| Tempo médio de entrega pela transportadora | Tempo médio de entrega | Transportadora | - | (Data de entrega - Data do pedido) |
| Tempo médio para liberação do pedido para transportadora | Tempo médio de liberação | Pedido | - | (Data de envio - Data do pedido) |
| Faturamento geral | Total de vendas | Tempo (Ano, Mês) | Ano > Mês | Soma do faturamento total por período |