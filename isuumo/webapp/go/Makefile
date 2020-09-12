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
	alp ltsv -m "/api/chair/\d+","/api/estate/\d+","/api/recommended_estate/\d+","/api/estate/req_doc/\d+","/api/chair/buy/\d+" < 2.log
