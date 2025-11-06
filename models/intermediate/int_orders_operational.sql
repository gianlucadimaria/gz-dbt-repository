with 

orders_margin as (
    select * from {{ ref('int_orders_margin') }}
),

ship as (
    select * from {{ ref('stg_raw__ship') }}
),

joined as (
    select
        orders_margin.orders_id,
        orders_margin.date_date,
        orders_margin.margin 
            + ship.shipping_fee 
            - ship.logcost 
            - ship.ship_cost as operational_margin
    
    from orders_margin
    inner join ship
        using (orders_id)
        order by orders_id DESC
)

select * from joined