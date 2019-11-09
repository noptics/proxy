FROM golang:1.12 as Builder

RUN mkdir -p /go/src/github.com/noptics/nats-proxy
ADD . /go/src/github.com/noptics/nats-proxy

WORKDIR /go/src/github.com/noptics/nats-proxy

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o nats-proxy

FROM alpine:3.9

RUN apk add --no-cache curl bash ca-certificates

COPY --from=builder /go/src/github.com/noptics/nats-proxy/nats-proxy /nats-proxy

CMD ["/nats-proxy"]