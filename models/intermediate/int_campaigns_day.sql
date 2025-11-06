select
    date_date,
    
    sum(ads_cost) as total_ads_cost,
    sum(impression) as total_impressions,
    sum(click) as total_clicks,
    
    round(sum(ads_cost) / nullif(sum(click), 0), 2) as cpc,
    round(sum(ads_cost) / nullif(sum(impression), 0) * 1000, 2) as cpm,
    round(sum(click) / nullif(sum(impression), 0) * 100, 2) as ctr,
    
    count(distinct campaign_key) as unique_campaigns,
    count(distinct paid_source) as unique_sources,

from {{ ref('int_campaigns') }}

group by date_date

order by date_date desc