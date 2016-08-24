FROM debian:jessie

ENV AGENT_VERSION=0.34.0-1 \
    PLUGINS_VERSION=0.22.0-1 \
    DOCKER_VERSION=1.12.1-0

RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsS "https://mackerel.io/assets/files/GPG-KEY-mackerel" | apt-key add - && \
    echo "deb http://apt.mackerel.io/debian/ mackerel contrib" > /etc/apt/sources.list.d/mackerel.list && \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb http://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y mackerel-agent=$AGENT_VERSION \
                       mackerel-agent-plugins=$PLUGINS_VERSION \
                       docker-engine=$DOCKER_VERSION~jessie && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY mackerel-agent.conf /etc/mackerel-agent/mackerel-agent.conf
COPY startup.sh /startup.sh

ENV AUTO_RETIREMENT=1

CMD ["/startup.sh"]