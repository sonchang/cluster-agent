FROM ibuildthecloud/ubuntu-core-base:14.04
ADD http://stedolan.github.io/jq/download/linux64/jq /usr/bin/
RUN chmod +x /usr/bin/jq
RUN apt-get update && apt-get install -y \
    busybox \
    curl \
    dnsmasq \
    iptables \
    monit \
    nodejs \
    psmisc \
    tcpdump \
    uuid-runtime \
    git-core \
    golang \
    ca-certificates \
    vim-tiny && \
    rm -rf /var/lib/apt/lists
RUN ln -s /usr/bin/nodejs /usr/bin/node
ENV GOPATH /root/go
RUN mkdir -p $GOPATH
RUN go get -u github.com/tools/godep
RUN mkdir $GOPATH/src/github.com/docker && git clone https://github.com/docker/swarm $GOPATH/src/github.com/docker/swarm
RUN cd $GOPATH/src/github.com/docker/swarm && $GOPATH/bin/godep restore && go install
ADD startup.sh /etc/init.d/agent-instance-startup
CMD ["/etc/init.d/agent-instance-startup", "init"]
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y racoon
