postgres:
	docker run --name postgres13 -p 5432:5432 -e POSTGRES_USER=at0x -e POSTGRES_PASSWORD=ethereumsolana -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=at0x --owner=at0x local_bank

dropdb:
	docker exec -it postgres15 dropdb -U at0x local_bank

migrateup:
	migrate -path db/migration  -database postgres://at0x:ethereumsolana@localhost:5432/local_bank?sslmode=disable -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://at0x:ethereumsolana@localhost:5432/local_bank?sslmode=disable" -verbose down

sqlc: 
	docker run --rm -v "${CURDIR}:/src" -w /src kjconroy/sqlc generate

init:
	sqlc init

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc init test 

