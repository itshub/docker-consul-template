FROM gliderlabs/alpine:3.1
MAINTAINER Albert van t Hart <avthart@gmail.com>

ENV CONSUL_VERSION 0.9.0

RUN apk --update add wget

RUN wget -o /tmp/consul-template.tgz https://github.com/hashicorp/consul-template/releases/download/v$CONSUL_VERSION/consul-template_$CONSUL_VERSION_linux_amd64.tar.gz
RUN cd /bin && gzip -dc /tmp/consul-template.tgz | tar -xf - && rm /tmp/consul-template.tgz && mv /bin/consul-template_$CONSUL_VERSION_linux_amd64/consul-template /bin/consul-template && rmdir /bin/consul-template_$CONSUL_VERSION_linux_amd64

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /bin/docker
RUN chmod +x /bin/docker

ENV DOCKER_HOST unix:///tmp/docker.sock

ENTRYPOINT ["/bin/consul-template"]
