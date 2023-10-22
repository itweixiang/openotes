FROM centos:7

COPY openjdk-11+28_linux-x64_bin.tar.gz ./

RUN tar -xvf openjdk-11+28_linux-x64_bin.tar.gz \
	&& mkdir -p /opt/jdk/ \
	&& mv jdk-11/* /opt/jdk/ \
	&& rm -rf openjdk-11+28_linux-x64_bin.tar.gz jdk-11 

RUN chmod +x /opt/jdk/bin/* \
	&& echo "export PATH=$PATH:/opt/jdk/bin" >> /etc/bashrc \
	&& source /etc/bashrc

ENV PATH=$PATH:/opt/jdk/bin

CMD echo 'jdk-11+28'

