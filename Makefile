APP_NAME = app
STATIC_FILES = static
SERVER_DIR = server
CONFIG = config.yaml

dev: clean
	@go-bindata -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/bindata.go -debug $(STATIC_FILES)/... $(CONFIG)
	@go build -o=$(APP_NAME) $(SERVER_DIR)/*.go
	@./$(APP_NAME)

clean:
	@rm -rf $(APP_NAME)
	@rm -rf $(SERVER_DIR)/bindata.go
	@rm -rf build

install:
	@go get
	@go get -u github.com/jteeuwen/go-bindata/...
	@npm install
	@bower install

uninstall:
	@rm -rf bower_components
	@rm -rf node_modules
