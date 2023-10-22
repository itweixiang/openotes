FROM openjdk:11

RUN useradd -m elasticsearch \
    && mkdir -p /opt/elasticsearch

WORKDIR /opt/elasticsearch
RUN wget https://web/elasticsearch-7.17.12-linux-x86_64.tar.gz \
	&& tar -xvf elasticsearch-7.17.12-linux-x86_64.tar.gz \
	&& mv elasticsearch-7.17.12/* /opt/elasticsearch/ \
	&& rm -rf elasticsearch-7.17.12* \
    && rm -rf /opt/elasticsearch/jdk \
    && chmod 777 -R /opt/elasticsearch/bin \
    && chown -R 1000:1000 /opt/elasticsearch

ENV PATH=$PATH:/opt/elasticsearch/bin
USER elasticsearch

CMD ["bash","/opt/elasticsearch/bin/elasticsearch"]
