BINARY = kubryant.in
SERVER_DIR = server
CLIENT_DIR = client
GO_SOURCES = $(shell find $(SERVER_DIR) -type f -name '*.go')
JS_SOURCES = $(shell find $(CLIENT_DIR) -type f -name '*.js')

CONFIG = config.yml
STATIC_FILES = static
CLIENT_JS_FILES = static/client/js

BINDATA = bindata.go
BINDATA_FLAGS = -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/$(BINDATA) -debug
BINDATA_SOURCES = $(CONFIG) $(STATIC_FILES)/...

.DEFAULT_GOAL: $(BINARY)
.PHONY: server client kill clean

$(BINARY): kill clean client server run

server:
	@go-bindata $(BINDATA_FLAGS) $(BINDATA_SOURCES)
	@go build -o=$(BINARY) $(SERVER_DIR)/*.go

client:
	@./node_modules/webpack/bin/webpack.js --config ./conf/webpack.config.js

run:
	@./$(BINARY) &

kill:
	@killall -9 $(BINARY) 2>/dev/null || true

clean: kill
	@if [ -f $(BINARY) ]; then rm -rf $(BINARY); fi
	@if [ -f $(SERVER_DIR)/$(BINDATA) ]; then rm -rf $(SERVER_DIR)/$(BINDATA); fi
	@if [ -d $(CLIENT_JS_FILES) ]; then rm -rf $(CLIENT_JS_FILES); fi
	@if [ -f profile.cov ]; then rm profile.cov; fi
	@rm -rf *.log

install:
	@go get -u github.com/jteeuwen/go-bindata/...
	@go get -u github.com/yosssi/goat/...
	@glide install
	@npm install

reset: clean
	@if [ -d vendor ]; then rm -rf vendor; fi
	@if [ -d node_modules ]; then rm -rf node_modules; fi
