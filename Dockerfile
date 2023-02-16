FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache ca-certificates

ARG version="1.0.20-r1"

RUN apk add sysbench=$version && rm -rf /var/cache/apk/*

ENTRYPOINT [ "sysbench" ]
CMD [ "--help" ]