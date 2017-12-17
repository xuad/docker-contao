FROM mariadb:latest

ARG MYSQL_USER_ID=999
ARG MYSQL_GROUP_ID=999

RUN usermod -u ${MYSQL_USER_ID} mysql && \
    groupmod -g ${MYSQL_GROUP_ID} mysql

CMD ["mysqld"]