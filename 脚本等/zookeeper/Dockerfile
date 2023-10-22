FROM openjdk:11

WORKDIR /opt/zookeeper
RUN wget https://web/apache-zookeeper-3.5.10-bin.tar.gz \
	&& tar -xvf apache-zookeeper-3.5.10-bin.tar.gz \
    && mkdir -p /opt/zookeeper \
	&& mv apache-zookeeper-3.5.10-bin/* /opt/zookeeper/ \
	&& rm -rf apache-zookeeper-3.5.10* \
	&& chmod 777 -R /opt/zookeeper/bin

ENV PATH=$PATH:/opt/zookeeper/bin

CMD ["bash","/opt/zookeeper/bin/zkServer.sh","start-foreground"]