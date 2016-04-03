APP_NAME = app
SERVER_DIR = server

CONFIG = config.yaml
STATIC_FILES = static
CLIENT_JS_FILES = static/client/js

dev: clean
	@webpack --watch &
	@go-bindata -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/bindata.go -debug $(CONFIG) $(STATIC_FILES)/...
	@go build -o=$(APP_NAME) $(SERVER_DIR)/*.go
	@./$(APP_NAME)

clean:
	@rm -rf $(APP_NAME)
	@rm -rf $(SERVER_DIR)/bindata.go
	@rm -rf $(CLIENT_JS_FILES)

install:
	@go get
	@go get -u github.com/jteeuwen/go-bindata/...
	@npm install
	@bower install

uninstall:
	@rm -rf bower_components
	@rm -rf node_modules
