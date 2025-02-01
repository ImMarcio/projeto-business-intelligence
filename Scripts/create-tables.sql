
CREATE SEQUENCE public.tempo_sk_tempo_seq;

CREATE TABLE public.Tempo (
                SK_Tempo INTEGER NOT NULL DEFAULT nextval('public.tempo_sk_tempo_seq'),
                Data DATE NOT NULL,
                Ano INTEGER NOT NULL,
                Mes INTEGER NOT NULL,
                Dia INTEGER NOT NULL,
                Trimestre INTEGER NOT NULL,
                DiadaSemana VARCHAR NOT NULL,
                NomeDoMes VARCHAR NOT NULL,
                CONSTRAINT tempo_pk PRIMARY KEY (SK_Tempo)
);


ALTER SEQUENCE public.tempo_sk_tempo_seq OWNED BY public.Tempo.SK_Tempo;

CREATE UNIQUE INDEX dim_tempo_idx
 ON public.Tempo
 ( Data );

CREATE SEQUENCE public.clientes_sk_cliente_seq_1;

CREATE TABLE public.Clientes (
                SK_cliente INTEGER NOT NULL DEFAULT nextval('public.clientes_sk_cliente_seq_1'),
                NomeDaEmpresa CHAR(40),
                CodigoDoCliente CHAR(5) NOT NULL,
                NomeDoContato CHAR(30),
                CargoDoContato CHAR(30),
                Endereco CHAR(60),
                Cidade CHAR(15),
                Regiao CHAR(15),
                CEP CHAR(10),
                Pais CHAR(15),
                Telefone CHAR(24),
                Fax CHAR(24),
                PaisISO CHAR(10),
                CONSTRAINT clientes_pk PRIMARY KEY (SK_cliente)
);


ALTER SEQUENCE public.clientes_sk_cliente_seq_1 OWNED BY public.Clientes.SK_cliente;

CREATE SEQUENCE public.fornecedores_sk_fornecedor_seq;

CREATE TABLE public.Fornecedores (
                SK_fornecedor INTEGER NOT NULL DEFAULT nextval('public.fornecedores_sk_fornecedor_seq'),
                CodigoDoFornecedor INTEGER NOT NULL,
                NomeDaEmpresa CHAR(40),
                NomeDoContato CHAR(30),
                CONSTRAINT forpk PRIMARY KEY (SK_fornecedor)
);


ALTER SEQUENCE public.fornecedores_sk_fornecedor_seq OWNED BY public.Fornecedores.SK_fornecedor;

CREATE UNIQUE INDEX fornecedores_idx
 ON public.Fornecedores
 ( CodigoDoFornecedor );

CREATE SEQUENCE public.transportadoras_sk_transportadora_seq;

CREATE TABLE public.Transportadoras (
                SK_transportadora VARCHAR NOT NULL DEFAULT nextval('public.transportadoras_sk_transportadora_seq'),
                CodigoDaTransportadora INTEGER NOT NULL,
                NomeDaEmpresa CHAR(40),
                Telefone CHAR(24),
                CONSTRAINT trask PRIMARY KEY (SK_transportadora)
);


ALTER SEQUENCE public.transportadoras_sk_transportadora_seq OWNED BY public.Transportadoras.SK_transportadora;

CREATE UNIQUE INDEX transportadoras_idx
 ON public.Transportadoras
 ( CodigoDaTransportadora );

CREATE SEQUENCE public.pedidos_sk_pedido_seq;

CREATE SEQUENCE public.pedidos_numerodopedido_seq;

CREATE TABLE public.Pedidos (
                SK_pedido INTEGER NOT NULL DEFAULT nextval('public.pedidos_sk_pedido_seq'),
                NumeroDoPedido INTEGER NOT NULL DEFAULT nextval('public.pedidos_numerodopedido_seq'),
                SK_transportadora VARCHAR NOT NULL,
                SK_TempoEnvio INTEGER NOT NULL,
                SK_TempoPedido INTEGER NOT NULL,
                DataDeEntrega DATE NOT NULL,
                DataDeEnvio DATE,
                DataDoPedido DATE NOT NULL,
                SK_TempoEntrega INTEGER NOT NULL,
                CONSTRAINT sk_pedido PRIMARY KEY (SK_pedido)
);


ALTER SEQUENCE public.pedidos_sk_pedido_seq OWNED BY public.Pedidos.SK_pedido;

ALTER SEQUENCE public.pedidos_numerodopedido_seq OWNED BY public.Pedidos.NumeroDoPedido;

CREATE UNIQUE INDEX dim_pedido_idx
 ON public.Pedidos
 ( NumeroDoPedido );

CREATE SEQUENCE public.categorias_sk_categoria_seq;

CREATE TABLE public.Categorias (
                SK_categoria INTEGER NOT NULL DEFAULT nextval('public.categorias_sk_categoria_seq'),
                CodigoDaCategoria INTEGER NOT NULL,
                NomeDaCategoria CHAR(15),
                Descricao CHAR(300),
                CONSTRAINT catpk PRIMARY KEY (SK_categoria)
);


ALTER SEQUENCE public.categorias_sk_categoria_seq OWNED BY public.Categorias.SK_categoria;

CREATE UNIQUE INDEX categorias_idx
 ON public.Categorias
 ( CodigoDaCategoria );

CREATE SEQUENCE public.produtos_sk_produto_seq;

CREATE TABLE public.Produtos (
                SK_Produto INTEGER NOT NULL DEFAULT nextval('public.produtos_sk_produto_seq'),
                CodigoDoProduto INTEGER NOT NULL,
                NomeDoProduto CHAR(40),
                QuantidadePorUnidade CHAR(25),
                PrecoUnitario NUMERIC(10,2),
                SK_fornecedor INTEGER NOT NULL,
                SK_categoria INTEGER NOT NULL,
                CONSTRAINT prodpk PRIMARY KEY (SK_Produto)
);


ALTER SEQUENCE public.produtos_sk_produto_seq OWNED BY public.Produtos.SK_Produto;

CREATE UNIQUE INDEX produtos_idx
 ON public.Produtos
 ( CodigoDoProduto );

CREATE SEQUENCE public.funcionarios_sk_funcionario_seq;

CREATE TABLE public.Funcionarios (
                SK_Funcionario INTEGER NOT NULL DEFAULT nextval('public.funcionarios_sk_funcionario_seq'),
                CodigoDoFuncionario INTEGER NOT NULL,
                NomeCompleto VARCHAR(30) NOT NULL,
                Cargo CHAR(30),
                DataDeNascimento DATE,
                DataDeContratacao DATE,
                CEP CHAR(10),
                Pais CHAR(15),
                CONSTRAINT funpk PRIMARY KEY (SK_Funcionario)
);


ALTER SEQUENCE public.funcionarios_sk_funcionario_seq OWNED BY public.Funcionarios.SK_Funcionario;

CREATE UNIQUE INDEX funcionarios_idx
 ON public.Funcionarios
 ( CodigoDoFuncionario );

CREATE SEQUENCE public.fatos_vendas_sk_venda_seq;

CREATE TABLE public.Fatos_Vendas (
                SK_venda INTEGER NOT NULL DEFAULT nextval('public.fatos_vendas_sk_venda_seq'),
                NumeroDaVenda INTEGER NOT NULL,
                PrecoUnitario NUMERIC(14,2),
                Quantidade SMALLINT,
                Desconto NUMERIC(14,2),
                PaisDeDestino CHAR(15),
                COD_produto INTEGER NOT NULL,
                SK_Pedido INTEGER NOT NULL,
                SK_Tempo INTEGER NOT NULL,
                SK_Cliente INTEGER NOT NULL,
                SK_Funcionario INTEGER NOT NULL,
                CONSTRAINT pedpk PRIMARY KEY (SK_venda)
);
COMMENT ON COLUMN public.Fatos_Vendas.SK_Tempo IS 'Data de venda geral';


ALTER SEQUENCE public.fatos_vendas_sk_venda_seq OWNED BY public.Fatos_Vendas.SK_venda;

CREATE UNIQUE INDEX fatos_vendas_idx
 ON public.Fatos_Vendas
 ( NumeroDaVenda );

ALTER TABLE public.Pedidos ADD CONSTRAINT dim_pedido_dim_tempo_fk
FOREIGN KEY (SK_TempoEntrega)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Pedidos ADD CONSTRAINT dim_tempo_dim_pedido_fk
FOREIGN KEY (SK_TempoPedido)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Pedidos ADD CONSTRAINT dim_tempo_dim_pedido_fk1
FOREIGN KEY (SK_TempoEnvio)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT dim_tempo_fatos_vendas_fk
FOREIGN KEY (SK_Tempo)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT clientes_fatos_vendas_fk
FOREIGN KEY (SK_Cliente)
REFERENCES public.Clientes (SK_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Produtos ADD CONSTRAINT prodfor
FOREIGN KEY (SK_fornecedor)
REFERENCES public.Fornecedores (SK_fornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Pedidos ADD CONSTRAINT transportadoras_dim_pedido_fk
FOREIGN KEY (SK_transportadora)
REFERENCES public.Transportadoras (SK_transportadora)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT dim_pedido_fatos_vendas_fk
FOREIGN KEY (SK_Pedido)
REFERENCES public.Pedidos (SK_pedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Produtos ADD CONSTRAINT prodcat
FOREIGN KEY (SK_categoria)
REFERENCES public.Categorias (SK_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT produtos_fatos_vendas_fk
FOREIGN KEY (COD_produto)
REFERENCES public.Produtos (SK_Produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT pedfun
FOREIGN KEY (SK_Funcionario)
REFERENCES public.Funcionarios (SK_Funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
