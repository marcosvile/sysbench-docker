FROM alpine:latest

RUN apk update && apk upgrade && apk add --no-cache ca-certificates

ARG version="1.0.20-r0"

RUN apk add mysql-client sysbench=$version && rm -rf /var/cache/apk/*

ENTRYPOINT [ "sysbench" ]
CMD [ "--help" ]