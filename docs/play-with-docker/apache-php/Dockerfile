FROM ajeetraina/apache
MAINTAINER Ajeet Raina <ajeetraina@gmail.com>
 
RUN apt-get update && apt-get -y install php5 php5-mysql && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork
EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
