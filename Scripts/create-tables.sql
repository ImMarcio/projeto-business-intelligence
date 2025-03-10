
CREATE SEQUENCE transportadoras_sk_transportadora_seq;

CREATE TABLE transportadoras (
                sk_transportadora INTEGER DEFAULT nextval('transportadoras_sk_transportadora_seq'::regclass) NOT NULL DEFAULT nextval('transportadoras_sk_transportadora_seq'),
                codigodatransportadora INTEGER NOT NULL,
                nomedaempresa CHAR(40),
                data_from TIMESTAMP,
                data_to TIMESTAMP,
                version INTEGER,
                CONSTRAINT trask PRIMARY KEY (sk_transportadora)
);


ALTER SEQUENCE transportadoras_sk_transportadora_seq OWNED BY transportadoras.sk_transportadora;

CREATE SEQUENCE funcionarios_sk_funcionario_seq;

CREATE TABLE funcionarios (
                sk_funcionario INTEGER DEFAULT nextval('funcionarios_sk_funcionario_seq'::regclass) NOT NULL DEFAULT nextval('funcionarios_sk_funcionario_seq'),
                codigodofuncionario INTEGER NOT NULL,
                nome_completo VARCHAR(20),
                data_from TIMESTAMP,
                version INTEGER,
                data_to TIMESTAMP,
                CONSTRAINT funpk PRIMARY KEY (sk_funcionario)
);


ALTER SEQUENCE funcionarios_sk_funcionario_seq OWNED BY funcionarios.sk_funcionario;

CREATE SEQUENCE produtos_sk_produto_seq;

CREATE TABLE produtos (
                sk_produto INTEGER DEFAULT nextval('produtos_sk_produto_seq'::regclass) NOT NULL DEFAULT nextval('produtos_sk_produto_seq'),
                codigodoproduto INTEGER NOT NULL,
                nomedoproduto CHAR(40),
                fornecedor VARCHAR(30) NOT NULL,
                version INTEGER,
                data_from TIMESTAMP,
                data_to TIMESTAMP,
                categoria VARCHAR(30) NOT NULL,
                CONSTRAINT prodpk PRIMARY KEY (sk_produto)
);


ALTER SEQUENCE produtos_sk_produto_seq OWNED BY produtos.sk_produto;

CREATE SEQUENCE clientes_sk_cliente_seq;

CREATE TABLE clientes (
                sk_cliente INTEGER DEFAULT nextval('clientes_sk_cliente_seq'::regclass) NOT NULL DEFAULT nextval('clientes_sk_cliente_seq'),
                codigodocliente CHAR(5) NOT NULL,
                cidade CHAR(15) DEFAULT 'Não Informado'::bpchar,
                regiao CHAR(15) DEFAULT 'Não Informado'::bpchar,
                pais CHAR(15) DEFAULT 'Não Informado'::bpchar,
                paisiso CHAR(10),
                version INTEGER,
                data_from TIMESTAMP,
                data_to TIMESTAMP,
                nome VARCHAR(50),
                CONSTRAINT clientes_pk PRIMARY KEY (sk_cliente)
);


ALTER SEQUENCE clientes_sk_cliente_seq OWNED BY clientes.sk_cliente;

CREATE SEQUENCE tempo_sk_tempo_seq;

CREATE TABLE tempo (
                sk_tempo INTEGER DEFAULT nextval('tempo_sk_tempo_seq'::regclass) NOT NULL DEFAULT nextval('tempo_sk_tempo_seq'),
                data DATE NOT NULL,
                ano INTEGER NOT NULL,
                mes INTEGER NOT NULL,
                dia INTEGER NOT NULL,
                trimestre INTEGER NOT NULL,
                diadasemana VARCHAR(2147483647) NOT NULL,
                nomedomes VARCHAR(2147483647) NOT NULL,
                CONSTRAINT tempo_pk PRIMARY KEY (sk_tempo)
);


ALTER SEQUENCE tempo_sk_tempo_seq OWNED BY tempo.sk_tempo;

CREATE TABLE fatos_vendas (
                numerodopedido INTEGER NOT NULL,
                sk_cliente INTEGER NOT NULL,
                sk_transportadora INTEGER NOT NULL,
                sk_produto INTEGER NOT NULL,
                sk_funcionario INTEGER NOT NULL,
                sk_tempopedido INTEGER NOT NULL,
                sk_tempoentrega INTEGER NOT NULL,
                sk_tempoenvio INTEGER NOT NULL,
                frete NUMERIC(14,2),
                precounitario NUMERIC(14,2),
                quantidade SMALLINT,
                valorbruto NUMERIC(14,2) NOT NULL,
                desconto NUMERIC(14,2),
                valorliquido NUMERIC(14,2) NOT NULL,
                CONSTRAINT pedpk PRIMARY KEY (numerodopedido, sk_cliente, sk_transportadora, sk_produto, sk_funcionario, sk_tempopedido, sk_tempoentrega, sk_tempoenvio)
);


ALTER TABLE fatos_vendas ADD CONSTRAINT transportadoras_pedidos_fk
FOREIGN KEY (sk_transportadora)
REFERENCES transportadoras (sk_transportadora)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fatos_vendas ADD CONSTRAINT funcionarios_pedidos_fk
FOREIGN KEY (sk_funcionario)
REFERENCES funcionarios (sk_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fatos_vendas ADD CONSTRAINT produtos_pedidos_fk
FOREIGN KEY (sk_produto)
REFERENCES produtos (sk_produto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fatos_vendas ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (sk_cliente)
REFERENCES clientes (sk_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fatos_vendas ADD CONSTRAINT tempo_pedidos_fk
FOREIGN KEY (sk_tempopedido)
REFERENCES tempo (sk_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fatos_vendas ADD CONSTRAINT tempo_pedidos_fk1
FOREIGN KEY (sk_tempoentrega)
REFERENCES tempo (sk_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE fatos_vendas ADD CONSTRAINT tempo_pedidos_fk2
FOREIGN KEY (sk_tempoenvio)
REFERENCES tempo (sk_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;