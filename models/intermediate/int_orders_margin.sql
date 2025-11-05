with 

sales_margin as (
    select * from {{ ref('int_sales_margin') }}
),

picked_by_order as (
    select
        orders_id,
        date_date,
        sum(quantity) as quantity,
        sum(revenue) as revenue,
        sum(purchase_cost) as purchase_cost,
        sum(margin) as margin
    
    from sales_margin
    group by orders_id, date_date
    order by orders_id DESC
)

select * from picked_by_order