build:
	@go build -o bin/cash-pool-server cmd/server/main.go

test:
	@go test -v ./...

run: build
	@./bin/cash-pool-server

migrate:
	@migrate create -ext sql -dir db/migrations $(filter-out $@,$(MAKECMDGOALS))

migrate-up:
	@go run cmd/tools/migrations/main.go up

migrate-down:
	@go run cmd/tools/migrations/main.go down

docker-compose:
	@docker-compose -f deployments/docker-compose.yml -p cash-pool up -d
