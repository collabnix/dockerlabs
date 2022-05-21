FROM node
RUN npm install -g phantomjs
ADD . /app
WORKDIR /app
CMD ["/app/tests.sh"]
