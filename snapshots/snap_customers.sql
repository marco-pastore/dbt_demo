{% snapshot snap_costumers %}

{{
    config(
        target_database = 'analytics',
        target_schema = 'dbt_mpastore_snapshot',
        unique_key = 'customer_id',

        strategy = 'check',
        check_cols = ['first_name']
    )

}}

select *
from {{ ref('stg_jaffle_shop__customers')}}

{% endsnapshot %}