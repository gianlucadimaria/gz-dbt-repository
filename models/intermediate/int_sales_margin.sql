with 

sales as (
    select * from {{ ref('stg_raw__sales') }}
),

products as (
    select * from {{ ref('stg_raw__product') }}
),

joined as (
    select
        sales.orders_id,
        sales.date_date,
        sales.products_id,
        sales.quantity,
        sales.revenue,
        products.purchase_price,
        sales.quantity * products.purchase_price as purchase_cost,
        sales.revenue - (sales.quantity * products.purchase_price) as margin
    
    from sales
    inner join products
        using (products_id)
)

select * from joined