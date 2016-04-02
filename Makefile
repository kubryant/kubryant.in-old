APP_NAME = app
STATIC_FILES = static
SERVER_DIR = server

build:
	@go-bindata -pkg=main -prefix=$(STATIC_FILES) -o=$(SERVER_DIR)/bindata.go $(STATIC_FILES)/...
	@go build -o=$(APP_NAME) $(SERVER_DIR)/*.go
	@./$(APP_NAME)

clean:
	@rm $(APP_NAME)
	@rm $(SERVER_DIR)/bindata.go
