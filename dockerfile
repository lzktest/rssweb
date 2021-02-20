from golang:1.15
WORKDIR /go/src/app
arg GO111MODULE=on
arg GOPROXY='https://goproxy.cn'
copy . .
workdir /go/src/app/server
run CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build main.go 
run ls -al . 

from alpine:latest
workdir /root/
run ls -al /go/src/app/
copy --from=0 /go/src/app/server/config.yaml .
copy --from=0 /go/src/app/server/main .
run ls -al
run chmod +x main
#cmd ["./main"]
