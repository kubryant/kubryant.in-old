BINARY = kubryant.in
SERVER_DIR = server
GO_SOURCES = $(shell find $(SERVER_DIR) -type f -name '*.go')

CONFIG = config.yml
STATIC_FILES = static
CLIENT_JS_FILES = static/client/js

BINDATA = bindata.go
BINDATA_FLAGS = -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/$(BINDATA) -debug
BINDATA_SOURCES = $(CONFIG) $(STATIC_FILES)/...

.DEFAULT_GOAL: $(BINARY)

$(BINARY): clean
	@go-bindata $(BINDATA_FLAGS) $(BINDATA_SOURCES)
	@go build -o=$(BINARY) $(SERVER_DIR)/*.go
	@./$(BINARY)

clean:
	@rm -rf $(BINARY)
	@rm -rf $(SERVER_DIR)/$(BINDATA)
	@rm -rf $(CLIENT_JS_FILES)

# dev: clean
# 	go-bindata -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/bindata.go -debug $(CONFIG) $(STATIC_FILES)/...
# 	go build -o=$(BINARY) $(SERVER_DIR)/*.go
# 	./$(BINARY)

# clean:
# 	@webpack --watch &
# 	@rm -rf $(APP_NAME)
# 	@rm -rf $(SERVER_DIR)/bindata.go
# 	@rm -rf $(CLIENT_JS_FILES)

# install:
# 	@go get
# 	@go get -u github.com/jteeuwen/go-bindata/...
# 	@npm install
# 	@bower install

# uninstall:
# 	@rm -rf bower_components
# 	@rm -rf node_modules
