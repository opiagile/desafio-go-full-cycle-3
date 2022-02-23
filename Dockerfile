FROM golang:1.16-buster AS builder

WORKDIR /app

COPY . .

RUN go mod init main && \
  go mod tidy && \
  go get -d -v ./... && \
  go install -v ./... && \
  go build -o main main.go

FROM scratch

COPY --from=builder /go/bin/main /go/bin/main

EXPOSE 8080

ENTRYPOINT ["/go/bin/main"]