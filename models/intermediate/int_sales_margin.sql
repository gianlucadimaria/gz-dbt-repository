SELECT
    o.orders_id,
    o.revenue AS revenue_total,
    o.purchase_cost AS cost_total,
    {{ margin_percent('o.revenue', 'o.purchase_cost') }} AS margin_percent
FROM {{ ref("int_orders_margin") }} o
