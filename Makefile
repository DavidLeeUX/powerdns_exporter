VERSION = $(shell git describe --always --tags --dirty)
pkgs    = $(shell go list ./... | grep -v /vendor/)

.PHONY: container test build version

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi

version:
	@echo $(VERSION)

container: guard-IMAGE
	docker build -t $(IMAGE):$(VERSION) .

test:
	go test -v ./...

build:
	go build -v ./...

vet:
	go vet -v $(pkgs)