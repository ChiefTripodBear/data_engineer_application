--SELECT statement to prepare a dataset for a sales report returning columns month, style_code, color_name, revenue

--notes:
-- web sales are negative?
-- web orders aren't included in the order table? Seems weird - like perhaps direct to customer was implemented later and not properly integrated into Orders table.
-- amount for web order doesn't match the list price in product table. Product table should probably distinguish between wholesale and retail RRP.
-- 

SELECT
	strftime('%m', invoice_date) as month,
	style_code,
	color_name,	
	sum(abs(ii.total_amount)) as revenue
from invoices i
left join orders o on o.order_id = i.invoice_number
left join invoice_lines ii on ii.invoice_id = i.id
left join products p on p.id = ii.product_id
where i.invoice_type not in ('purchase')
group by
	month,
	style_code,
	color_name
;

/*
SELECT
	*
from invoices i
left join orders o on o.order_id = i.invoice_number
left join invoice_lines ii on ii.invoice_id = i.id
left join products p on p.id = ii.product_id
where i.invoice_type not in ('purchase')
;
*/

