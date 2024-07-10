select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,

    -- amount is stored in cents, convert it to dollars
    -- amount / 100 as amount,
    {{ cents_to_euros('amount', 1) }} as amount,
    created as created_at

from {{ source('stripe', 'payment')}}