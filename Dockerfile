FROM centos:7

ENV AGENT_VERSION=0.34.0 \
    PLUGINS_VERSION=0.22.0 \
    DOCKER_VERSION=1.12.1

COPY repos/ /etc/yum.repos.d/

RUN yum -y install mackerel-agent-$AGENT_VERSION \
                   mackerel-agent-plugins-$PLUGINS_VERSION \
                   docker-engine-$DOCKER_VERSION && \
    yum clean all

COPY mackerel-agent/ /etc/mackerel-agent/
COPY startup.sh /startup.sh

ENV TZ=Asia/Tokyo \
    AUTO_RETIREMENT=1

CMD ["/startup.sh"]