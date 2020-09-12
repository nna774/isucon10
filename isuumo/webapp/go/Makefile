SERVER_NUM:=2

SERVER_NAME=isucon-server$(SERVER_NUM)

all: isuumo

isuumo: *.go
	go build -o isuumo

deploy: isuumo
	ssh $(SERVER_NAME) sudo systemctl stop isuumo.go
	scp isuumo $(SERVER_NAME):/home/isucon/isuumo/webapp/go/isuumo
	ssh $(SERVER_NAME) sudo systemctl start isuumo.go

rotate:
	ssh $(SERVER_NAME) sudo rm /var/log/nginx/access.log
	ssh $(SERVER_NAME) sudo systemctl restart nginx

get-log:
	ssh $(SERVER_NAME) sudo chown isucon:isucon /var/log/nginx/access.log
	scp $(SERVER_NAME):/var/log/nginx/access.log 2.log
	make alp2

alp:
	alp ltsv -m "/api/chair/\d+","/api/estate/\d+","/api/recommended_estate/\d+","/api/estate/req_doc/\d+","/api/chair/buy/\d+" < 2.log
	wc -l 2.log

deploy-nginx:
	ssh $(SERVER_NAME) sudo chown isucon:isucon /etc/nginx/nginx.conf /etc/nginx/sites-enabled/isuumo.conf
	scp nginx/nginx.conf $(SERVER_NAME):/etc/nginx/nginx.conf
	scp nginx/isuumo.conf $(SERVER_NAME):/etc/nginx/sites-enabled/isuumo.conf
	ssh $(SERVER_NAME) sudo nginx -t
	ssh $(SERVER_NAME) sudo systemctl restart nginx
