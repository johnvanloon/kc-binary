FROM jboss/base-jdk:8

ENV KEYCLOAK_VERSION 4.6.0.Final
ENV JDBC_POSTGRES_VERSION 42.2.2
ENV JDBC_MYSQL_VERSION 5.1.46
ENV JDBC_MARIADB_VERSION 2.2.3

ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false
ENV JBOSS_HOME /opt/jboss/keycloak
ENV LANG en_US.UTF-8

USER root

RUN yum install -y epel-release git && yum install -y jq openssl which && yum clean all

ADD tools /opt/jboss/tools
ADD keycloak /opt/jboss/keycloak
RUN /opt/jboss/tools/build-keycloak.sh

USER 1000

EXPOSE 8080

ENTRYPOINT [ "/opt/jboss/tools/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]