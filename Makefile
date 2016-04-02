APP_NAME = app
STATIC_FILES = static
SERVER_DIR = server
CONFIG = config.yaml

build:
	@go-bindata -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/bindata.go -debug $(STATIC_FILES)/... $(CONFIG)
	@go build -o=$(APP_NAME) $(SERVER_DIR)/*.go
	@./$(APP_NAME)

clean:
	@rm $(APP_NAME)
	@rm $(SERVER_DIR)/bindata.go
