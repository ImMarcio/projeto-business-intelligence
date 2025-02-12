
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

CREATE SEQUENCE public.dim_clientes_sk_cliente_seq;

CREATE TABLE public.Dim_Clientes (
                SK_cliente INTEGER NOT NULL DEFAULT nextval('public.dim_clientes_sk_cliente_seq'),
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
                CONSTRAINT dim_clientes_pk PRIMARY KEY (SK_cliente)
);


ALTER SEQUENCE public.dim_clientes_sk_cliente_seq OWNED BY public.Dim_Clientes.SK_cliente;

CREATE SEQUENCE public.dim_transportadoras_sk_transportadora_seq;

CREATE TABLE public.Dim_Transportadoras (
                SK_transportadora INTEGER NOT NULL DEFAULT nextval('public.dim_transportadoras_sk_transportadora_seq'),
                CodigoDaTransportadora INTEGER NOT NULL,
                NomeDaEmpresa CHAR(40),
                Telefone CHAR(24),
                CONSTRAINT trask PRIMARY KEY (SK_transportadora)
);


ALTER SEQUENCE public.dim_transportadoras_sk_transportadora_seq OWNED BY public.Dim_Transportadoras.SK_transportadora;

CREATE UNIQUE INDEX transportadoras_idx
 ON public.Dim_Transportadoras
 ( CodigoDaTransportadora );

CREATE SEQUENCE public.dim_produtos_sk_produto_seq;

CREATE TABLE public.Dim_Produtos (
                SK_Produto INTEGER NOT NULL DEFAULT nextval('public.dim_produtos_sk_produto_seq'),
                EmpresaFornecedora CHAR(40),
                CodigoDoProduto INTEGER NOT NULL,
                NomeDoProduto CHAR(40),
                QuantidadePorUnidade CHAR(25),
                PrecoUnitario NUMERIC(10,2),
                Categoria VARCHAR NOT NULL,
                CONSTRAINT prodpk PRIMARY KEY (SK_Produto)
);


ALTER SEQUENCE public.dim_produtos_sk_produto_seq OWNED BY public.Dim_Produtos.SK_Produto;

CREATE UNIQUE INDEX produtos_idx
 ON public.Dim_Produtos
 ( CodigoDoProduto );

CREATE SEQUENCE public.dim_funcionarios_sk_funcionario_seq;

CREATE TABLE public.Dim_Funcionarios (
                SK_Funcionario INTEGER NOT NULL DEFAULT nextval('public.dim_funcionarios_sk_funcionario_seq'),
                CodigoDoFuncionario INTEGER NOT NULL,
                NomeCompleto VARCHAR(30) NOT NULL,
                Cargo CHAR(30),
                DataDeNascimento DATE,
                DataDeContratacao DATE,
                CEP CHAR(10),
                Pais CHAR(15),
                CONSTRAINT funpk PRIMARY KEY (SK_Funcionario)
);


ALTER SEQUENCE public.dim_funcionarios_sk_funcionario_seq OWNED BY public.Dim_Funcionarios.SK_Funcionario;

CREATE UNIQUE INDEX funcionarios_idx
 ON public.Dim_Funcionarios
 ( CodigoDoFuncionario );

CREATE TABLE public.Fatos_Vendas (
                PrecoTotal NUMERIC(14,2) NOT NULL,
                PrecoUnitario NUMERIC(14,2),
                Frete NUMERIC(14,2),
                Quantidade SMALLINT,
                Desconto NUMERIC(14,2),
                PaisDeDestino CHAR(15),
                SK_produto INTEGER NOT NULL,
                SK_Cliente INTEGER NOT NULL,
                SK_Funcionario INTEGER NOT NULL,
                SK_transportadora INTEGER NOT NULL,
                SK_TempoPedido INTEGER NOT NULL,
                SK_TempoEntrega INTEGER NOT NULL,
                SK_TempoEnvio INTEGER NOT NULL
);
COMMENT ON COLUMN public.Fatos_Vendas.SK_TempoPedido IS 'Data de venda geral';


ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT dim_tempo_fatos_vendas_fk
FOREIGN KEY (SK_TempoPedido)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT tempo_fatos_vendas_fk
FOREIGN KEY (SK_TempoEntrega)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT tempo_fatos_vendas_fk1
FOREIGN KEY (SK_TempoEnvio)
REFERENCES public.Tempo (SK_Tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT clientes_fatos_vendas_fk
FOREIGN KEY (SK_Cliente)
REFERENCES public.Dim_Clientes (SK_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT transportadoras_fatos_vendas_fk
FOREIGN KEY (SK_transportadora)
REFERENCES public.Dim_Transportadoras (SK_transportadora)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT produtos_fatos_vendas_fk
FOREIGN KEY (SK_produto)
REFERENCES public.Dim_Produtos (SK_Produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Fatos_Vendas ADD CONSTRAINT pedfun
FOREIGN KEY (SK_Funcionario)
REFERENCES public.Dim_Funcionarios (SK_Funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;