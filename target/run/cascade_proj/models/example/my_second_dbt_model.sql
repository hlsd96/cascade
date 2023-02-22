
  create or replace   view cascade.dev.my_second_dbt_model
  
   as (
    -- Use the `ref` function to select from other models

select *
from cascade.dev.my_first_dbt_model
where id = 1
  );

