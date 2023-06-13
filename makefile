postgres:
	docker run --name postgres15 -p 5432:5432 -e POSTGRES_USER=atanda0x -e POSTGRES_PASSWORD=ethereumsolana -d postgres:15-alpine

mysql:
	docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=ethereumsolana -d mysql

createdb:
	docker exec -it postgres15 createdb --username=atanda0x --owner=atanda0x local_bank

dropdb:
	docker exec -it postgres15 dropdb -U atanda0x local_bank

migrateup:
	migrate -path db/migration  -database "postgresql://atanda0x:ethereumsolana@localhost:5432/local_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://atanda0x:ethereumsolana@localhost:5432/local_bank?sslmode=disable" -verbose down

sqlc: 
	docker run --rm -v "${CURDIR}:/src" -w /src kjconroy/sqlc generate

init:
	sqlc init

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc init test 

