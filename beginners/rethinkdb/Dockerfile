FROM debian:jessie

MAINTAINER Daniel Alan Miller dalanmiller@rethinkdb.com

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys1614552E5765227AEC39EFCFA7E00EF33A8F2399 RUN echo "deb http://download.rethinkdb.com/apt jessie main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDBPACKAGEVERSION 2.0.4~0jessie

RUN apt-get update && apt-get install -y rethinkdb=$RETHINKDBPACKAGEVERSION && rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

EXPOSE 28015 29015 8080
