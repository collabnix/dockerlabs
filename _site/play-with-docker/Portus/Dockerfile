FROM library/ruby:2.3.1
MAINTAINER Flavio Castelli <fcastelli@suse.com>

ENV COMPOSE=1
EXPOSE 3000

WORKDIR /portus
COPY Gemfile* ./
RUN bundle install --retry=3 && bundle binstubs phantomjs
RUN apt-get update && \
    apt-get install -y --no-install-recommends nodejs

ADD . .
