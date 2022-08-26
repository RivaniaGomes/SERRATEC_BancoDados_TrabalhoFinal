--Relatorio cadastro de clientes (View).
select
cli_cd_id as cod_cliente,
cli_tx_cpf as cpf,
cli_tx_nome_completo as nome_completo,
cli_tx_nome_de_usuario as usuario,
cli_tx_email as email,
cli_tx_rua || ', ' || cli_int_numero || ', ' || cli_tx_cep
as endereco
from cliente;

--Relatorio Produto, Categoria e Funcionario responsavel (View)
select 
prd_tx_nome as produto, 
cat_tx_nome as categoria,
fun_tx_nome as funcionario,
produto.prd_int_quantidade_estoque as estoque
from produto 
inner join funcionario
on produto.fun_cd_id = funcionario.fun_cd_id
inner join categoria
on categoria.cat_cd_id = produto.cat_cd_id;

--Relatorio Pedidos de Venda (View).
select 
cli_tx_nome_de_usuario as usuario,
pedido_item.ped_cd_id as nr_pedido,
ped_dt_data_pedido as data_pedido,
pdt_int_quantidade as quantidade,
cat_tx_nome as categoria,
prd_tx_nome as nome_produto,
prd_dec_valor_unitario as valor_produto,
prd_dec_valor_unitario * pdt_int_quantidade as valor_total
from
	pedido
inner join pedido_item
on pedido.ped_cd_id = pedido_item.ped_cd_id
inner join produto
on produto.prd_cd_id = pedido_item.prd_cd_id
inner join categoria
on categoria.cat_cd_id = produto.cat_cd_id
inner join cliente
on cliente.cli_cd_id = pedido.cli_cd_id;

--Relatorio produtos pro categoria (view). 
select
c.cat_tx_nome as categoria,
   count(p.cat_cd_id) as quantidade
from categoria c
inner join produto p
on p.cat_cd_id = c.cat_cd_id  
group by cat_tx_nome;

--Atualização
UPDATE public.produto
SET prd_int_quantidade_estoque= 80
WHERE prd_cd_id = 12;

--Deletar Tabela/Entidade
drop table nota_fiscal;

--Nota Fiscal somando todos os produtos.
select 
cli_tx_cpf as cpf,
cli_tx_nome_de_usuario as cliente,
pedido_item.ped_cd_id as nota_pedido,
ped_dt_data_pedido as data_pedido,
pdt_int_quantidade as quantidade,
cat_tx_nome as categoria,
prd_tx_nome as nome_produto,
prd_dec_valor_unitario as valor_produto,
prd_dec_valor_unitario * pdt_int_quantidade as valor_total,
( select sum(prd_dec_valor_unitario * pdt_int_quantidade)
from
	pedido
inner join pedido_item
on pedido.ped_cd_id = pedido_item.ped_cd_id
inner join produto
on produto.prd_cd_id = pedido_item.prd_cd_id
inner join categoria
on categoria.cat_cd_id = produto.cat_cd_id
inner join cliente
on cliente.cli_cd_id = pedido.cli_cd_id
where 
	pedido_item.ped_cd_id = :limite
group by 
	pedido_item.ped_cd_id
) as valor_total_nota
from pedido
inner join pedido_item
on pedido.ped_cd_id = pedido_item.ped_cd_id
inner join  produto
on produto.prd_cd_id = pedido_item.prd_cd_id
inner join categoria
on categoria.cat_cd_id = produto.cat_cd_id
inner join cliente
on cliente.cli_cd_id = pedido.cli_cd_id
where pedido.ped_cd_id = :limite;


