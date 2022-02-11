export PATH := $(GOPATH)/bin:$(PATH)
export GO111MODULE=off
LDFLAGS := -s -w

all: build

build: nb 

nb:
	env CGO_ENABLED=0 go build -trimpath -ldflags "$(LDFLAGS)" -o bin/pingtunnel main.go

clean:
	rm -f ./bin/pingtunnel
