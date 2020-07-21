.ONESHELL .PHONY: force-build persistence create-buckets upload-data wait15
.DEFAULT_GOAL := up

up: force-build create-docker-network persistence wait15 create-buckets upload-data hive

create-docker-network:
	docker network create -d bridge hive-test || docker network ls | grep hive-test
# Enforce docker build with tag of last commit's hash in current branch
force-build:
	LAST_COMMIT_HASH=$(shell git rev-parse --verify HEAD) docker-compose build
down:
	docker-compose down
persistence:
	docker-compose up -d minio database
create-buckets:
	mc config host add myminio http://localhost:9000 minio minio123 || exit 2 && \
		mc mb myminio/hive || true && \
		mc mb myminio/default || true
wait15:
	sleep 15
upload-data:
	mc cp data/iris.csv myminio/hive/warehouse/iris/iris.csv || exit 1 \
		&& mc cp data/json.json myminio/hive/warehouse/json/json.json || exit 1 \
		&& mc cp data/json1.json myminio/hive/warehouse/json1/json1.json || exit 1 \
		&& mc cp data/json2.json myminio/hive/warehouse/json2/json2.json || exit 1
hive:
	docker-compose up -d hive-metastore hive-server

create-hive-tables:
	docker-compose exec hive-metastore beeline -u jdbc:hive2:// -f /tmp/query/create-iris.csv.hql
	docker-compose exec hive-metastore beeline -u jdbc:hive2:// -f /tmp/query/create-json.json.hql
	docker-compose exec hive-metastore beeline -u jdbc:hive2:// -f /tmp/query/create-json1.json.hql
	docker-compose exec hive-metastore beeline -u jdbc:hive2:// -f /tmp/query/create-json2.json.hql
