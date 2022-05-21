
FROM wordpress:latest
MAINTAINER Ajeet S Raina
RUN apt-get update -y
RUN apt install -y wget unzip
RUN mkdir -p /var/www/html/wp-content
RUN wget  https://downloads.wordpress.org/theme/mywiki.3.0.1.zip && \
    unzip mywiki.3.0.1.zip -d /var/www/html/wp-content/
