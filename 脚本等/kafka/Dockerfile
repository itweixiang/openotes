FROM openjdk:11

WORKDIR /opt/kafka
RUN wget https://web/kafka_2.12-2.8.2.tgz \
	&& tar -xvf kafka_2.12-2.8.2.tgz \
    && mkdir -p /opt/kafka \
	&& mv kafka_2.12-2.8.2/* /opt/kafka/ \
	&& rm -rf kafka_2.12-2.8.2* \
    && chmod 777 -R /opt/kafka/bin

ENV PATH=$PATH:/opt/kafka/bin

CMD ["bash","/opt/kafka/bin/kafka-server-start.sh","/opt/kafka/config/server.properties"]