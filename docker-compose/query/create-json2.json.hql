CREATE External TABLE my_table2 (
    id int,
    creation_date string,
    text string,
    loggedInUser STRUCT<id:INT, name: STRING>
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' location 's3a://hive/warehouse/json2/';