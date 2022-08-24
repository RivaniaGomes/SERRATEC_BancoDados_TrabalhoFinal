CREATE TABLE "categoria" (
  "cat_cd_id" serial not null,
  "cat_tx_nome" varchar(40) not null,
  "cat_tx_descricao" varchar(280),
  PRIMARY KEY ("cat_cd_id")
);

CREATE TABLE "funcionario" (
  "fun_cd_id" serial not null,
  "fun_tx_nome" varchar(20) not null,
  "fun_tx_cpf" varchar(14) not null,
  "fun_tx_cep" varchar(10) not null,
  "fun_tx_rua" varchar(40) not null,
  "fun_int_numero" int4 not null,
  "fun_tx_telefone" int4 not null,
  "fun_tx_email" varchar(40) not null,
  PRIMARY KEY ("fun_cd_id")
);

CREATE TABLE "produto" (
  "prd_cd_id" serial not null,
  "prd_tx_nome" varchar(80) not null,
  "prd_tx_descricao" varchar(280),
  "prd_int_quantidade_estoque" int4 not null,
  "prd_dt_data_de_fabricacao" date not null,
  "prd_dec_valor_unitario" decimal not null,
  "fun_cd_id" int4 not null,
  "cat_cd_id" int4 not null,
  PRIMARY KEY ("prd_cd_id"),
  CONSTRAINT "FK_produto.cat_cd_id"
    FOREIGN KEY ("cat_cd_id")
      REFERENCES "categoria"("cat_cd_id"),
  CONSTRAINT "FK_produto.fun_cd_id"
    FOREIGN KEY ("fun_cd_id")
      REFERENCES "funcionario"("fun_cd_id")
);

CREATE TABLE "pedido_item" (
  "pdt_cd_id" serial not null,
  "pdt_int_quantidade" int4 not null,
  "prd_cd_id" int4 not null,
  PRIMARY KEY ("pdt_cd_id"),
  CONSTRAINT "FK_pedido_item.prd_cd_id"
    FOREIGN KEY ("prd_cd_id")
      REFERENCES "produto"("prd_cd_id")
);

CREATE TABLE "cliente" (
  "cli_cd_id" serial not null,
  "cli_tx_nome_completo" varchar(40) not null,
  "cli_tx_nome_de_usuario" varchar(20) not null,
  "cli_tx_email" varchar(40) not null,
  "cli_tx_cpf" varchar(14) not null,
  "cli_dt_data_de_nascimento" date,
  "cli_tx_cep" varchar(10) not null,
  "cli_tx_rua" varchar(40) not null,
  "cli_int_numero" int4 not null,
  "cli_tx_telefone" varchar(15),
  PRIMARY KEY ("cli_cd_id")
);

CREATE TABLE "pedido" (
  "ped_cd_id" serial not null,
  "ped_dt_data_pedido" date not null,
  "cli_cd_id" int4 not null,
  "pdt_cd_id" int4 not null,
  PRIMARY KEY ("ped_cd_id"),
  CONSTRAINT "FK_pedido.pdt_cd_id"
    FOREIGN KEY ("pdt_cd_id")
      REFERENCES "pedido_item"("pdt_cd_id"),
  CONSTRAINT "FK_pedido.cli_cd_id"
    FOREIGN KEY ("cli_cd_id")
      REFERENCES "cliente"("cli_cd_id")
);

CREATE TABLE "nota_fiscal" (
  "nfe_cd_id" serial not null,
  "ped_cd_id" int4 not null,
  PRIMARY KEY ("nfe_cd_id"),
  CONSTRAINT "FK_nota_fiscal.ped_cd_id"
    FOREIGN KEY ("ped_cd_id")
      REFERENCES "pedido"("ped_cd_id")
);

