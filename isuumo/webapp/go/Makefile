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
	-@ssh $(SERVER_NAME) sudo rm /var/log/mysql/mysql-slow.log
	ssh $(SERVER_NAME) sudo systemctl restart mysql

get-log:
	ssh $(SERVER_NAME) sudo chown isucon:isucon /var/log/nginx/access.log
	scp $(SERVER_NAME):/var/log/nginx/access.log 2.log
	make alp

alp:
	alp ltsv -m "/api/chair/\d+","/api/estate/\d+","/api/recommended_estate/\d+","/api/estate/req_doc/\d+","/api/chair/buy/\d+" < 2.log
	wc -l 2.log

deploy-nginx:
	ssh $(SERVER_NAME) sudo chown isucon:isucon /etc/nginx/nginx.conf /etc/nginx/sites-enabled/isuumo.conf
	scp nginx/nginx.conf $(SERVER_NAME):/etc/nginx/nginx.conf
	scp nginx/isuumo.conf $(SERVER_NAME):/etc/nginx/sites-enabled/isuumo.conf
	ssh $(SERVER_NAME) sudo nginx -t
	ssh $(SERVER_NAME) sudo systemctl restart nginx

deploy-mysql:
	scp mysql/0_NewSchema.sql $(SERVER_NAME):isuumo/webapp/mysql/db/0_NewSchema.sql
	scp mysql/1_NewDummyEstateData.sql $(SERVER_NAME):isuumo/webapp/mysql/db/1_NewDummyEstateData.sql
	scp mysql/2_DummyChairData.sql  $(SERVER_NAME):isuumo/webapp/mysql/db/2_DummyChairData.sql
	scp mysql/init.sh $(SERVER_NAME):isuumo/webapp/mysql/db/init.sh

deploy-zenbu: deploy deploy-nginx deploy-mysql

enable_slowquerylog:
	ssh $(SERVER_NAME) sudo chown isucon:isucon /etc/mysql/mysql.cnf
	scp mysql/mysql_enable_log.cnf /etc/mysql/mysql.cnf
	ssh $(SERVER_NAME) sudo systemctl restart mysql
	ssh $(SERVER_NAME) sudo systemctl restart isuumo.go

disable_slowquerylog:
	ssh $(SERVER_NAME) sudo chown isucon:isucon /etc/mysql/mysql.cnf
	scp mysql/mysql_disable_log.cnf /etc/mysql/mysql.cnf
	ssh $(SERVER_NAME) sudo systemctl restart mysql
	ssh $(SERVER_NAME) sudo systemctl restart isuumo.go

rotate-sql-log:
	now=`date +%Y%m%d-%H%M%S` 
	ssh $(SERVER_NAME) sudo mv /var/log/mysql/slow.log /var/log/mysql/slow.log.$now 
	ssh $(SERVER_NAME) sudo mysqladmin flush-logs
