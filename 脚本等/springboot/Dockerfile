FROM openjdk:11 as builder
WORKDIR /opt/module_name
COPY module_name.jar module_name.jar
RUN java -Djarmode=layertools -jar module_name.jar extract

FROM openjdk:11
WORKDIR /opt/module_name
COPY  --from=builder /opt/module_name/dependencies ./
COPY  --from=builder /opt/module_name/snapshot-dependencies ./
COPY  --from=builder /opt/module_name/spring-boot-loader ./
COPY  --from=builder /opt/module_name/application ./

COPY entrypoint.sh entrypoint.sh

CMD ["exec"]
ENTRYPOINT ["bash","/opt/module_name/entrypoint.sh"]