FROM golang:1.16 as builder
ENV GO111MODULE=on \
    GOPROXY=https://goproxy.cn,direct
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o main main.go

FROM busybox:1.28.4
WORKDIR /app
COPY --from=builder /app/ .
EXPOSE 8080
CMD ["./main"]
