FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y wget \
  ssh \
  git \
  default-jre

WORKDIR /root

RUN wget https://www.gerritcodereview.com/download/gerrit-2.14.2.war
RUN mkdir gerrit
RUN java -jar gerrit*.war init --batch --dev -d ~/gerrit
RUN git config --file /root/gerrit/etc/gerrit.config httpd.listenUrl 'http://0.0.0.0:8080'

WORKDIR /root/gerrit
RUN bin/gerrit.sh stop

EXPOSE 8080 29418
CMD /root/gerrit/bin/gerrit.sh start && /bin/bash
