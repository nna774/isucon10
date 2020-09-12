all: isuumo

isuumo: *.go
	go build -o isuumo

deploy2: isuumo
	ssh isucon-server2 sudo systemctl stop isuumo.go
	scp isuumo isucon-server2:/home/isucon/isuumo/webapp/go/isuumo
	ssh isucon-server2 sudo systemctl start isuumo.go

rotate2:
	ssh isucon-server2 sudo rm /var/log/nginx/access.log
	ssh isucon-server2 sudo systemctl restart nginx

get-log2:
	ssh isucon-server2 sudo chown isucon:isucon /var/log/nginx/access.log
	scp isucon-server2:/var/log/nginx/access.log 2.log
	make alp2

alp2:
	alp ltsv -m "/api/chair/\d+","/api/estate/\d+","/api/recommended_estate/\d+","/api/estate/req_doc/\d+","/api/chair/buy/\d+" < 2.log
	wc -l 2.log

deploy-nginx2:
	ssh isucon-server2 sudo chown isucon:isucon /etc/nginx/nginx.conf /etc/nginx/sites-enabled/isuumo.conf
	scp nginx/nginx.conf isucon-server2:/etc/nginx/nginx.conf
	scp nginx/isuumo.conf isucon-server2:/etc/nginx/sites-enabled/isuumo.conf
	ssh isucon-server2 sudo nginx -t
	ssh isucon-server2 sudo systemctl restart nginx
