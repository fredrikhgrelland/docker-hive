CREATE EXTERNAL TABLE my_table1 (field1 string, field2 int,
                                field3 string, field4 double)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' location 's3a://hive/warehouse/json1/';