with 

op_margin as (
    select * from {{ ref('int_orders_operational') }}
),

orders_margin as (
    select * from {{ ref('int_orders_margin') }}
),

ship as (
    select * from {{ ref('stg_raw__ship') }}
),

daily_granular as (
    select
        op_margin.date_date,
        count(distinct op_margin.orders_id) as total_transactions,
        sum(orders_margin.revenue) as total_revenue,
        sum(orders_margin.revenue) / count(distinct op_margin.orders_id) as average_basket,
        sum(op_margin.operational_margin) as total_operational_margin,
        sum(orders_margin.purchase_cost) as total_purchase_cost,
        sum(ship.shipping_fee) as total_shipping_fees,
        sum(ship.logcost) as total_log_costs,
        sum(orders_margin.quantity) as total_quantity
    
    from op_margin
    
    inner join orders_margin
        using (orders_id)
    
    inner join ship
        using (orders_id)
    
    group by op_margin.date_date
)

select * from daily_granular
order by date_date