all: isuumo

isuumo: *.go
	go build -o isuumo

deploy2: isuumo
	ssh isucon-server2 sudo systemctl stop isuumo.go
	scp isuumo isucon-server2:/home/isucon/isuumo/webapp/go/isuumo
	ssh isucon-server2 sudo systemctl start isuumo.go
