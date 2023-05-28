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
COMMENT ON TABLE lojas.produtos IS 'A tabela produtos obtém todas as informações necessárias para que um produto seja cadastrado no banco de dados';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Essa coluna obtém a id de um produto, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Essa coluna obtém o nome de um produto, em formato de varchar, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Essa coluna obtém o preço unitário de um produto, em formato numérico, para que seja possível verificar o seu valor na hora do pagamento.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Essa coluna obtém os detalhes de um produto, em formato binário (blob), para que seja possível verificar suas informações.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Essa coluna obtém a imagem de um produto, em formato de imagem (blob), para que seja possível reconhecê-lo no sistema e encontrá-lo mais fácil.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Essa coluna obtém algumas informações da imagem de um produto, em formato de varchar, para que seja possível reconhecê-lo no sistema e identificá-lo mais facilmente.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Essa coluna obtém algumas informações da imagem de um produto, em formato de varchar, para que seja possível reconhecê-lo no sistema e identificá-lo mais facilmente.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Essa coluna obtém algumas informações da imagem de um produto, em formato de varchar, para que seja possível reconhecê-lo no sistema e identificá-lo mais facilmente.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Essa coluna obtém a data da última atualização da imagem de um produto, em formato de date, para que seja possível verificar se a logo está ultrapassada e precisa ser atualizada.';


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
COMMENT ON TABLE lojas.lojas IS 'A tabela lojas obtém todas as informações necessárias para que uma loja seja cadastrada no banco de dados';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Essa coluna obtém a id de uma loja, em formato numérico, para que seja possível reconhecê-la no sistema, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Essa coluna obtém o nome de uma loja, em formato de varchar, para que seja possível reconhecê-la no sistema, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Essa coluna obtém o endereço web de uma loja, em formato de varchar, para que seja possível reconhecê-la no sistema e encontrá-la mais facilmente nas buscas de internet.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Essa coluna obtém o endereço de uma loja, em formato de varchar, para que seja possível reconhecê-la no sistema e encontrá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Essa coluna obtém a latitude de uma loja, em formato numérico, para que seja possível reconhecê-la no sistema e encontrá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Essa coluna obtém a latitude de uma loja, em formato numérico, para que seja possível reconhecê-la no sistema e encontrá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Essa coluna obtém a logo de uma loja, em formato de imagem (blob), para que seja possível reconhecê-la no sistema e identificá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Essa coluna obtém algumas informações da logo de uma loja, em formato de varchar, para que seja possível reconhecê-la no sistema e identificá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Essa coluna obtém algumas informações da logo de uma loja, em formato de varchar, para que seja possível reconhecê-la no sistema e identificá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Essa coluna obtém algumas informações da logo de uma loja, em formato de varchar, para que seja possível reconhecê-la no sistema e identificá-la mais facilmente.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Essa coluna obtém a data da última atualização da logo de uma loja, em formato de date, para que seja possível verificar se a logo está ultrapassada e precisa ser atualizada.';


-- cria a tabela "estoques" dentro do schema "lojas"
CREATE TABLE lojas.estoques (
                estoque_id 					NUMERIC(38) 	NOT NULL,
                quantidade 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                produto_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT estoque_id 		PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'A tabela estoques obtém todas as informações necessárias para que seja possível ver a quantidade de um produto dentro de uma determinada loja no banco de dados';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Essa coluna obtém a id de um estoque, em formato numérico, para que seja possível reconhecê-lo na loja e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Essa coluna obtém a quantidade de produtos em um estoque, em formato numérico, para que seja possível  verificar a quantidade de produtos disponíveis, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Essa coluna obtém a loja na qual um estoque existe, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Essa coluna obtém um produto em que o estoque pertence, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';


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
COMMENT ON TABLE lojas.clientes IS 'A tabela clientes obtém todas as informações necessárias para que um cliente seja cadastrado no banco de dados';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Essa coluna obtém a id de um cliente, em formato numérico, para que seja possível reconhecê-lo na loja, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.clientes.email IS 'Essa coluna obtém o email de um cliente, em formato de varchar, para que seja possível reconhecê-lo na loja e enviar notícias ou mensagens para ele, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Essa coluna obtém o nome de um cliente, em formato de varchar, para que seja possível reconhecê-lo na loja, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Essa coluna obtém o telefone de um cliente, em formato de varchar, para que seja possível reconhecê-lo na loja e enviar notícias ou mensagens para ele.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Essa coluna obtém o telefone secundário de um cliente, em formato de varchar, para que seja possível reconhecê-lo na loja e enviar notícias ou mensagens para ele, caso o primeiro telefone não esteja disponível.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Essa coluna obtém o telefone terciário de um cliente, em formato de varchar, para que seja possível reconhecê-lo na loja e enviar notícias ou mensagens para ele, caso o primeiro e o segundo telefones não estejam disponível.';



-- cria a tabela "envios" dentro do schema "lojas"
CREATE TABLE lojas.envios (
                envio_id 					NUMERIC(38) 	NOT NULL,
                endereco_entrega 			VARCHAR(512) 	NOT NULL,
                status 						VARCHAR(15) 	NOT NULL,
                cliente_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT envio_id 		PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'A tabela envios obtém todas as informações necessárias para que seja possível visualizar o envio dos pedidos no banco de dados';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Essa coluna obtém a id de um envio, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Essa coluna obtém o endereço de entrega de um envio, em formato de varchar, para que seja possível entregar o pedido para o cliente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.envios.status IS 'Essa coluna obtém o status de um envio, em formato de varchar, para que seja possível verificar se o pedido já foi entregue ou não, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Essa coluna obtém a id de um cliente, em formato numérico, para que seja possível reconhecê-lo na hora da entrega, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Essa coluna obtém a id de uma loja, em formato numérico, para que seja possível reconhecê-la no sistema, sendo uma informação necessária que não pode ser ignorada.';


-- cria a tabela "pedidos" dentro do schema "lojas"
CREATE TABLE lojas.pedidos (
                pedido_id 					NUMERIC(38) 	NOT NULL,
                data_hora 					TIMESTAMP 		NOT NULL,
                status 						VARCHAR(15) 	NOT NULL,
                cliente_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT pedido_id 		PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'A tabela pedidos obtém todas as informações necessárias para que um pedido seja cadastrado no banco de dados';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Essa coluna obtém a id de um pedido, em formato numérico, para que seja possível reconhecê-lo no sistema, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Essa coluna obtém a data e a hora em que um pedido foi feito, em formato de timestamp, para que seja possível reconhecê-lo no sistema e encontrá-lo com mais facilidade, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos.status IS 'Essa coluna obtém o status de um pedido, em formato de varchar, para que seja possível reconhecê-lo no sistema e encontrá-lo mais fácil, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Essa coluna obtém a id do cliente que fez um pedido, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais fácil, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Essa coluna obtém a id da loja em que um pedido foi feito, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais fácil, sendo uma informação necessária que não pode ser ignorada.';


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
COMMENT ON TABLE lojas.pedidos_itens IS 'A tabela pedidos_itens obtém todas as informações necessárias para que seja possível visualizar os itens dentro de um pedido no banco de dados';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Essa coluna obtém a id de um pedido, em formato numérico, para que seja possível reconhecê-lo no sistema, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Essa coluna obtém a id de um produto, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Essa coluna obtém o número da linha de um pedido, em formato numérico, para que facilite a busca por um produto em caso de alterações, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Essa coluna obtém o preço unitário de um produto dentro do pedido, em formato numérico, para que seja possível verificar o seu valor na hora do pagamento.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Essa coluna obtém a quantidade de itens em um pedido, em formato numérico, para que seja possível  verificar a quantidade de produtos que o cliente pediu, sendo uma informação necessária que não pode ser ignorada.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Essa coluna obtém a id de um envio, em formato numérico, para que seja possível reconhecê-lo no sistema e encontrá-lo mais facilmente, sendo uma informação necessária que não pode ser ignorada.';


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
