down: 
	docker compose down -v

up: 
	docker compose up -d

dremio-ui: 
	cmd /c start http://localhost:9047/

minio-ui: 
	cmd /c start http://127.0.0.1:9001/

ui: minio-ui dremio-ui

run: down up 

