FROM debian:latest

RUN apt-get update && \
    apt-get install -y sysbench && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["sysbench"]
CMD ["--help"]