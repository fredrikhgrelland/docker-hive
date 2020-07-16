CREATE External TABLE my_table (
  description STRING,
  foo STRUCT<bar: STRING, quux: STRING, level1: STRUCT<l2string: STRING, l2struct: STRUCT<level3: STRING>>>,
  wibble STRING,
  wobble ARRAY<STRUCT <entry: INT, EntryDetails: STRUCT<details1: STRING, details2: INT>>>)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'  location 's3a://hive/warehouse/json/';