/*******PROJETO PSET*******
 *ALUNO: Aline Pontes Dório
 *TURMA: CC1N             */


--exclui o schema "lojas" caso já exista
DROP SCHEMA IF EXISTS lojas CASCADE;

--exclui o banco de dados "uvv" caso já exista
DROP DATABASE IF EXISTS uvv;

--exclui o usuário "aline" caso já exista
DROP USER IF EXISTS aline;

--cria o usuário "aline"
CREATE USER aline WITH ENCRYPTED PASSWORD 'computacao@raiz';

--cria o banco de dados "uvv" e coloca o usuário "aline" como proprietário
CREATE DATABASE uvv
    WITH
    OWNER = aline
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;

 --cria o schema "lojas", que garantirá que apenas quem tem acesso (usuário "aline") a ele pode editar o banco de dados
CREATE SCHEMA IF NOT EXISTS lojas
    AUTHORIZATION aline;

 -- garante o acesso de todas as tabelas dentro do schema ao usuário "aline"
GRANT ALL ON SCHEMA lojas TO aline;

-- cria a tabela "produtos" dentro do schema "lojas"
CREATE TABLE lojas.produtos (
                produto_id 					NUMERIC(38) 	NOT NULL,
                nome 						VARCHAR(255) 	NOT NULL,
                preco_unitario 				NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type 			VARCHAR(512),
                imagem_arquivo 				VARCHAR(512),
                imagem_charset 				VARCHAR(512),
                imagem_ultima_atualizacao 	DATE,
                CONSTRAINT produto_id 		PRIMARY KEY (produto_id)
);

-- cria a tabela "lojas" dentro do schema "lojas"
CREATE TABLE lojas.lojas (
                loja_id 					NUMERIC(38) 	NOT NULL,
                nome 						VARCHAR(255) 	NOT NULL,
                endereco_web 				VARCHAR(100),
                endereco_fisico 			VARCHAR(512),
                latitude 					NUMERIC,
                longitude 					NUMERIC,
                logo BYTEA,
                logo_mime_type 				VARCHAR(512),
                logo_arquivo 				VARCHAR(512),
                logo_charset 				VARCHAR(512),
                logo_ultima_atualizacao 	DATE,
                CONSTRAINT loja_id 			PRIMARY KEY (loja_id)
);

-- cria a tabela "estoques" dentro do schema "lojas"
CREATE TABLE lojas.estoques (
                estoque_id 					NUMERIC(38) 	NOT NULL,
                quantidade 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                produto_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT estoque_id 		PRIMARY KEY (estoque_id)
);

-- cria a tabela "clientes" dentro do schema "lojas"
CREATE TABLE lojas.clientes (
                cliente_id 					NUMERIC(38) 	NOT NULL,
                email 						VARCHAR(255) 	NOT NULL,
                nome 						VARCHAR(255) 	NOT NULL,
                telefone1 					VARCHAR(20),
                telefone2 					VARCHAR(20),
                telefone3 					VARCHAR(20),
                CONSTRAINT cliente_id 		PRIMARY KEY (cliente_id)
);

-- cria a tabela "envios" dentro do schema "lojas"
CREATE TABLE lojas.envios (
                envio_id 					NUMERIC(38) 	NOT NULL,
                endereco_entrega 			VARCHAR(512) 	NOT NULL,
                status 						VARCHAR(15) 	NOT NULL,
                cliente_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT envio_id 		PRIMARY KEY (envio_id)
);

-- cria a tabela "pedidos" dentro do schema "lojas"
CREATE TABLE lojas.pedidos (
                pedido_id 					NUMERIC(38) 	NOT NULL,
                data_hora 					TIMESTAMP 		NOT NULL,
                status 						VARCHAR(15) 	NOT NULL,
                cliente_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT pedido_id 		PRIMARY KEY (pedido_id)
);

-- cria a tabela "pedidos_itens" dentro do schema "lojas"
CREATE TABLE lojas.pedidos_itens (
                pedido_id 					NUMERIC(38) 	NOT NULL,
                produto_id 					NUMERIC(38) 	NOT NULL,
                numero_da_linha 			NUMERIC(38) 	NOT NULL,
                preco_unitario 				NUMERIC(10,2) 	NOT NULL,
                quantidade 					NUMERIC(38) 	NOT NULL,
                envio_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT pedidos_itens_id PRIMARY KEY (pedido_id, produto_id)
);

-- altera a tabela "estoques" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.estoques 			ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY 		(produto_id)
REFERENCES 			lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "pedidos_itens" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.pedidos_itens 	ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY 		(produto_id)
REFERENCES 			lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "pedidos" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.pedidos 			ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY 		(loja_id)
REFERENCES 			lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "envios" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.envios 			ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY 		(loja_id)
REFERENCES 			lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "estoques" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.estoques 			ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY 		(loja_id)
REFERENCES 			lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "pedidos" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.pedidos 			ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY 		(cliente_id)
REFERENCES 			lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "envios" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.envios 			ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY 		(cliente_id)
REFERENCES 			lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "pedidos_itens" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.pedidos_itens 	ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY 		(envio_id)
REFERENCES 			lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- altera a tabela "pedidos_itens" dentro do schema "lojas", acrescentando uma Foreign Key
ALTER TABLE 		lojas.pedidos_itens 	ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY 		(pedido_id)
REFERENCES 			lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;