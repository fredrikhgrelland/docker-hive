# Docker-compose
Provided examples for development purposes

## Requirements
* MC - [minio client](https://github.com/minio/mc). Should be available on PATH.

## How to start
```
# up platform
make up

# create-tables in hive
make create-hive-tables

# down 
make down
```

For more info check `docker-compose/Makefile`

## Hive SQL
```
SHOW DATABASES;
SHOW TABLES IN <database-name>;
DROP DATABASE <database-name>;
```
## Metastore
```
# from metastore (loopback) 
beeline -u jdbc:hive2://
    
# from hive-server (to metastore)
beeline -u "jdbc:hive2://localhost:10000/default;auth=noSasl" -n hive -p hive

# exec script from file (example)
beeline -u jdbc:hive2:// -f /tmp/create-table.hql
```

## JSON formats
Added ser/des dependency, see https://stackoverflow.com/questions/26644351/cannot-validate-serde-org-openx-data-jsonserde-jsonserde 

### Create a table Json type data (Works)
Example `json`
```
CREATE External TABLE my_table (
  description STRING,
  foo STRUCT<bar: STRING, quux: STRING, level1: STRUCT<l2string: STRING, l2struct: STRUCT<level3: STRING>>>,
  wibble STRING,
  wobble ARRAY<STRUCT <entry: INT, EntryDetails: STRUCT<details1: STRING, details2: INT>>>)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'  location 's3a://hive/warehouse/json/';
``` 

Example `json1`
```
CREATE EXTERNAL TABLE my_table1 (field1 string, field2 int, 
                                field3 string, field4 double)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' location 's3a://hive/warehouse/json1/';
```

Example `json2`
```
CREATE External TABLE my_table2 (
    id int,
    creation_date string,
    text string,
    loggedInUser STRUCT<id:INT, name: STRING>
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe' location 's3a://hive/warehouse/json2/';
```

## Notes
### External docker network
You have to create external docker network. If not, docker-compose will automatically create one with underscore symbol, which will trigger `java.net.URISyntaxException` on hive-server.
If the exception occurs, hive-server logs contain: 
```text
Caused by: org.apache.hadoop.hive.metastore.api.MetaException: Got exception: java.net.URISyntaxException Illegal character in hostname at index 38: thrift://hive-metastore.docker-compose_default:9083
```

`!NB`: Network creation is part of `make up` command.