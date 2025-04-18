.PHONY: druid druid-forever druid-linux-amd64 druid-darwin-amd64 druid-windows-amd64 faucet fmt

druid: faucet
	@go run ./druid

druid-forever: faucet
	@go run ./druid --expose --persist

druid-linux-amd64: faucet
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o tmp/druid-linux-amd64 ./druid

druid-darwin-amd64: faucet
	@CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o tmp/druid-darwin-amd64 ./druid

druid-windows-amd64: faucet
	@CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o tmp/druid-windows-amd64 ./druid

build-druid: druid-linux-amd64 druid-darwin-amd64 druid-windows-amd64

faucet:
	@cd druid/faucet/web && \
	if [ ! -d "node_modules" ]; then \
		echo "node_modules not found, running npm install..."; \
		npm install; \
	fi && \
	npm run build

fmt:
	@gofmt -s -w $(shell find . -name "*.go")
