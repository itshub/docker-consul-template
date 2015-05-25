FROM gliderlabs/alpine:3.1
MAINTAINER Ilja Bauer <kontakt@ilja-bauer.de>

RUN apk --update add wget

RUN wget -o /tmp/consul-template.tgz https://github.com/hashicorp/consul-template/releases/download/v0.9.0/consul-template_0.9.0_linux_amd64.tar.gz
RUN cd /bin && gzip -dc /tmp/consul-template.tgz | tar -xf - && rm /tmp/consul-template.tgz && mv /bin/consul-template_0.9.0_linux_amd64/consul-template /bin/consul-template && rmdir /bin/consul-template_0.9.0_linux_amd64

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /bin/docker
RUN chmod +x /bin/docker

ENV DOCKER_HOST unix:///tmp/docker.sock

ENTRYPOINT ["/bin/consul-template"]
