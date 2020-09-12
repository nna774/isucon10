all: isuumo

isuumo: *.go
	go build -o isuumo

deploy2: isuumo
	scp isuumo isucon-server2:/home/isucon/isuumo/webapp/go/isuumo
	ssh isucon-server2 sudo systemctl restart isuumo.go
