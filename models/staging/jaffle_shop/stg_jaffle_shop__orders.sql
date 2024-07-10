{{ config (
   materialized = 'incremental'
) }}

select
    {{ dbt_utils.surrogate_key(['user_id', 'order_date']) }} as id,
    id as order_id,
    user_id as customer_id,
    order_date,
    status,
    _etl_loaded_at as load_time
from {{ source('jaffle_shop', 'orders') }}

{% if is_incremental() %}
where _etl_loaded_at > (select max(_etl_loaded_at) from {{ source('jaffle_shop', 'orders') }})
{% endif %}

{{ limit_data_in_dev('order_date', 1000) }}