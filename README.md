![Docker](https://github.com/fredrikhgrelland/docker-hive/workflows/Docker/badge.svg)
# docker-hive
Docker build for hive 3.1.0 based on [fredrikhgrelland/hadoop](https://github.com/fredrikhgrelland/docker-hadoop).

This image is built to work with object storage, only.
Hive metastore requires connection to a postgres database.

The image can take role as both metastore and hiveserver and is based on the apache hive release bundle.
NOTE: This image is ment to be used as a metastore and hiveserver DDL broker only. It has not been tested for carrying any load.
This might work but it is currently missing tez binaries and it will probably be dead-slow. You may use this image as a metastore for presto, 
and as a HQL-endpoint for NIFI.

## Note on versions
Compatiability of hadoop and hive is ensured by using A know working combination.
See Hortonworks ( or cloudera ) compatibility in releasenotes. https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.0/release-notes/content/comp_versions.html

## Published images
- [dockerhub](https://hub.docker.com/r/fredrikhgrelland/hive)
- [github](https://github.com/fredrikhgrelland/docker-hive/packages)

## Build locally for development
`make build`

This image can be built and operated behind a corporate proxy where the base os needs to trust a custom CA. [See this](./ca_certificates/README.md)

While building locally using the Makefile, you may set the environment variable CUSTOM_CA to a file or directory in order to import them.
`CUSTOM_CA=/usr/local/share/ca-certificates make`

## Examples
TBD
beeline -u "jdbc:hive2://localhost:10000/default;auth=noSasl" -n hive -p hive


###Credits:
Influenced by [BDE](https://github.com/big-data-europe/docker-hive)

##Note on vagrant behind corporate proxy.
```
export SSL_CERT_FILE=/etc/ssl/certs/ske-root-ca-2033-03-18.pem
vagrant plugin update
#https://github.com/gfi-centre-ouest/vagrant-certificates
vagrant plugin install vagrant-certificates
```