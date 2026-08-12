USE northwind;

select	table_name, ordinal_position,
		column_name, data_type,
		is_nullable, column_default,
		column_key, extra
from information_schema.columns
where table_schema = 'northwind'
order by table_name, ordinal_position;

select	table_name, column_name, constraint_name,
		referenced_table_name, referenced_column_name
from information_schema.key_column_usage
where table_schema = 'northwind' and referenced_table_name is not null
order by table_name, column_name;

select	table_name, table_rows
from information_schema.tables
where table_schema = 'northwind' and table_type = 'base table'
order by table_name;