FROM debian

RUN apt-get update 

RUN apt-get install sysbench -y

ENTRYPOINT [ "sysbench" ]
CMD [ "--help" ]