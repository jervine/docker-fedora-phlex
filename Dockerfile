# Base on latest Fedora image
FROM fedora:latest

MAINTAINER “Jon Ervine” <jon.ervine@gmail.com>
ENV container docker

RUN dnf update -y
RUN dnf install -y php git supervisor php-xmlrpc php-xml
#RUN dnf clean all

RUN cd /var/www/html; git clone https://github.com/d8ahazard/Phlex
RUN chown -R apache:apache /var/www/html/Phlex

ADD supervisord.conf /etc/supervisord.conf
ADD httpd.ini /etc/supervisord.d/httpd.ini
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config

EXPOSE 9012
ENTRYPOINT ["/usr/sbin/start.sh"]
