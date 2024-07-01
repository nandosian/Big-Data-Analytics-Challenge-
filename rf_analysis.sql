create table kimia_farma.kf_analisis as 
select
* 
from 
(
select
ft.transaction_id, ft.date, ft.branch_id, kc.branch_name, kc.kota, 
kc.provinsi, kc.rating as rating_kantor_cabang, ft.customer_name,
ft.product_id, p.product_name, ft.price, ft.discount_percentage,
 case
  when ft.price <= 50000 then 0.1
  when ft.price <= 100000 then 0.15
  when ft.price <= 300000 then 0.2
  when ft.price <= 500000 then 0.25
  else 0.3
  end as persentase_laba_brutto,
  (ft.price-(ft.price*ft.discount_percentage)) as nett_sales,
  (ft.price-(ft.price*ft.discount_percentage)-
  (ft.price * 
  case
  when ft.price <= 50000 then 1-0.1
  when ft.price <= 100000 then 1-0.15
  when ft.price <= 300000 then 1-0.2
  when ft.price <= 500000 then 1-0.25
  else 1-0.3
  end
  )) as nett_profit,
 ft.rating as rating_transaksi

from kimia_farma.kf_final_transaction ft
left join 
kimia_farma.kf_kantor_cabang kc
on 
ft.branch_id = kc.branch_id
left join 
kimia_farma.kf_product p 
on ft.product_id = p.product_id
order by ft.branch_id asc
)
;

