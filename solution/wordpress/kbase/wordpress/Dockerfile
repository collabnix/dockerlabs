FROM wordpress:latest
MAINTAINER Ajeet S Raina
RUN apt-get update -y
RUN apt install -y unzip
RUN curl https://downloads.wordpress.org/theme/mywiki.3.0.1.zip \
    | unzip mywiki.3.0.1.zip \
    && cp mywiki.3.0.1 /var/www/html/wp-content/
