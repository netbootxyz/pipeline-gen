FROM netbootxyz/docker-builder:latest as builder

ENV DEBIAN_FRONTEND=noninteractive

# repo for build
COPY . /ansible

RUN pip3 install ansible

RUN \
 echo "**** running ansible ****" && \
 cd /ansible && \
 ansible-playbook -i inventory site.yml

# runtime stage
FROM alpine:latest

COPY --from=builder /opt/builders /mnt/
COPY docker-build-root/ /

ENTRYPOINT [ "/dumper.sh" ]
