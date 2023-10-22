FROM openjdk:11


RUN wget https://web/efak-web-3.0.1-bin.tar.gz \
    && mkdir -p /opt/kafka-eagle \
	&& tar -xvf efak-web-3.0.1-bin.tar.gz \
	&& mv efak-web-3.0.1/* /opt/kafka-eagle/ \
	&& rm -f efak-web-3.0.1-bin.tar.gz \
	&& rm -rf efak-web-3.0.1

RUN chmod 777 -R /opt/kafka-eagle/bin

ENV PATH=$PATH:/opt/kafka-eagle/bin
ENV KE_HOME=/opt/kafka-eagle

CMD /opt/kafka-eagle/bin/ke.sh start  ; sleep 3 ;tail -f /opt/kafka-eagle/logs/ke_console.out