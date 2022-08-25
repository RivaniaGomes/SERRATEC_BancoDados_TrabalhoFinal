select * from pedido_item;

select * 
from pedido_item
inner join pedido
on pedido_item.ped_cd_id = pedido.ped_cd_id;

select * 
from pedido_item
inner join pedido
on pedido_item.ped_cd_id = pedido.ped_cd_id
inner join produto
on produto.prd_cd_id = pedido_item.prd_cd_id;

select cli_tx_cpf as cpf,
cli_tx_nome_de_usuario as cliente,
pedido_item.ped_cd_id as nr_pedido,
ped_dt_data_pedido as data_pedido,
pdt_int_quantidade as quantidade,
cat_tx_nome as categoria,
prd_tx_nome as nome_produto,
prd_dec_valor_unitario as valor_produto,
prd_dec_valor_unitario * pdt_int_quantidade as valor_total
from pedido
join pedido_item
on pedido.ped_cd_id = pedido_item.ped_cd_id
join produto
on produto.prd_cd_id = pedido_item.prd_cd_id
join categoria
on categoria.cat_cd_id = produto.cat_cd_id
join cliente
on cliente.cli_cd_id = pedido.cli_cd_id;


