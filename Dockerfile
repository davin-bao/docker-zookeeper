FROM java:8-jdk-alpine

COPY zookeeper-3.4.8 /usr/local/zookeeper-3.4.8
COPY entrypoint.sh /

ENV ZOO_CONF_DIR=/usr/local/zookeeper-3.4.8/conf \
    ZOO_DATA_DIR=/tmp/zookeeper \
    ZOO_DATA_LOG_DIR=/datalog \
    ZOO_PORT=2181 \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=10 \
    ZOO_SYNC_LIMIT=5 \
    ZOO_MAX_CLIENT_CNXNS=60 \
    PATH=$PATH:/usr/local/zookeeper-3.4.8/bin

RUN echo -e "https://mirrors.ustc.edu.cn/alpine/v3.4/main\nhttps://mirrors.ustc.edu.cn/alpine/v3.4/community\n" > /etc/apk/repositories \
&& apk add --no-cache bash vim tzdata \
&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& mkdir -p $ZOO_DATA_DIR \
&& mkdir -p $ZOO_DATA_LOG_DIR \
&& chmod 755 /entrypoint.sh \
&& chmod 755 /usr/local/zookeeper-3.4.8/bin/*.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["zkServer.sh", "start-foreground"]
