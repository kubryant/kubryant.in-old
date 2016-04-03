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

$(BINARY): kill clean client server

server:
	@go-bindata $(BINDATA_FLAGS) $(BINDATA_SOURCES)
	@go build -o=$(BINARY) $(SERVER_DIR)/*.go
	@./$(BINARY) &

client:
	@webpack

kill:
	@killall -9 $(BINARY) 2>/dev/null || true

clean:
	@if [ -f $(BINARY) ]; then rm -rf $(BINARY); fi
	@if [ -f $(SERVER_DIR)/$(BINDATA) ]; then rm -rf $(SERVER_DIR)/$(BINDATA); fi
	@if [ -d $(CLIENT_JS_FILES) ]; then rm -rf $(CLIENT_JS_FILES); fi
