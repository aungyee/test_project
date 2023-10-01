{{
    config(
        materialized = 'table',
    )
}}

with days as (

    {{
        dbt_utils.date_spine(
            'day',
            "to_date('01/01/2000','mm/dd/yyyy')",
            "to_date('01/01/2027','mm/dd/yyyy')"
        )
    }}

),

final as (
    select 
        cast(date_day as date) as date_day,
        case when month(date_day) >= 9 then year(date_day) else year(date_day) - 1 end as academic_year
    from days
)

select * from final