
# Nginx
#
# VERSION               0.0.1
# Applying LABEL

FROM      ubuntu
LABEL Description="This image is used to start the foobar executable" Vendor="Collabnix Products" Version="1.0"
RUN apt-get update && apt-get install -y inotify-tools nginx apache2 openssh-server
