FROM node:latest

# workaround problem
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

# dependencies
RUN apt-get update
RUN apt-get -y install libxext6 libxtst6 libfontconfig1 libxrender1 libxi6

USER root

ADD https://download.jetbrains.com/idea/ideaIU-2018.1.tar.gz /opt/idea.tar.gz
# COPY ideaIU-2018.1.tar.gz /opt/idea.tar.gz
RUN mkdir /opt/idea
RUN tar --extract --directory /opt/idea --file /opt/idea.tar.gz --strip-components=1
RUN rm -f /opt/idea.tar.gz

ADD http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz /opt/jdk.tar.gz
# COPY jdk-8u161-linux-x64.tar.gz /opt/jdk.tar.gz
RUN mkdir /opt/jdk
RUN tar --extract --directory /opt/jdk --file /opt/jdk.tar.gz --strip-components=1
RUN rm -f /opt/jdk.tar.gz

RUN mkdir ~/projects

ENV JAVA_HOME=/opt/jdk
ENV PATH=$PATH:/opt/jdk/bin

ENTRYPOINT ["/opt/idea/bin/idea.sh"]