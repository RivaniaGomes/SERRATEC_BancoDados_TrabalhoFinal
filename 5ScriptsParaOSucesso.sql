--Nota Fiscal somando todos os produtos.
select 
cli_tx_cpf as cpf,
cli_tx_nome_de_usuario as cliente,
pedido_item.ped_cd_id as nota__pedido,
ped_dt_data_pedido as data_pedido,
pdt_int_quantidade as quantidade,
cat_tx_nome as categoria,
prd_tx_nome as nome_produto,
prd_dec_valor_unitario as valor_produto,
prd_dec_valor_unitario * pdt_int_quantidade as valor_total,
( select sum(prd_dec_valor_unitario * pdt_int_quantidade)
from
	pedido
join pedido_item
on pedido.ped_cd_id = pedido_item.ped_cd_id
join produto
on produto.prd_cd_id = pedido_item.prd_cd_id
join categoria
on categoria.cat_cd_id = produto.cat_cd_id
join cliente
on cliente.cli_cd_id = pedido.cli_cd_id
where 
	pedido_item.ped_cd_id = :limite
group by 
	pedido_item.ped_cd_id
) as valor_total_nota
from pedido
join pedido_item
on pedido.ped_cd_id = pedido_item.ped_cd_id
join  produto
on produto.prd_cd_id = pedido_item.prd_cd_id
join categoria
on categoria.cat_cd_id = produto.cat_cd_id
join cliente
on cliente.cli_cd_id = pedido.cli_cd_id
where pedido.ped_cd_id = :limite;

--Atualização

UPDATE public.produto
SET prd_int_quantidade_estoque=40
WHERE prd_cd_id= 12;

-- Deletar Tabela/Entidade

drop table nota_fiscal;

-- Script count() contando a variedade de produtos de Cards Colecionaveis. Tem na loja. Categoria 2. 

select count(cat_cd_id), cat_cd_id  from produto group by cat_cd_id;

-- Produto, Categoria e Funcionario responsavel()
select 
prd_tx_nome as produto, 
cat_tx_nome as categoria,
fun_tx_nome as funcionario
from produto 
inner join funcionario
on produto.fun_cd_id = funcionario.fun_cd_id
inner join categoria
on categoria.cat_cd_id = produto.cat_cd_id;
