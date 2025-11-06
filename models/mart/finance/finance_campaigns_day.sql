with finance_data as (
    select
        date_date,
        total_operational_margin,
        average_basket,
        total_revenue,
        total_purchase_cost,
        total_shipping_fees,
        total_log_costs,
        total_quantity
    from {{ ref('finance_days') }}
),

campaign_data as (
    select
        date_date,
        total_ads_cost,
        total_impressions,
        total_clicks
    from {{ ref('int_campaigns_day') }}
)

select
    f.date_date,
    (f.total_operational_margin - c.total_ads_cost) as ads_margin,
    f.average_basket,
    f.total_operational_margin as operational_margin,
    c.total_ads_cost as ads_cost,
    c.total_impressions as ads_impression,
    c.total_clicks as ads_clicks,
    f.total_quantity as quantity,
    f.total_revenue as revenue,
    f.total_purchase_cost as purchase_cost,
    (f.total_revenue - f.total_purchase_cost) as margin,
    f.total_shipping_fees as shipping_fee,
    f.total_log_costs as log_cost,
    (f.total_shipping_fees + f.total_log_costs) as ship_cost
from finance_data f
inner join campaign_data c
    on f.date_date = c.date_date
order by f.date_date desc