FROM centos:7
COPY start.sh /start.sh
RUN chmod +x /start.sh \
    && mkdir /source /target
COPY dist.tar.gz /source
CMD /start.sh
