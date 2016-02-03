# ptcuops/build-base:1.0.2

# build image example:
#   docker build -t ptcuops/build-base .
# build versioned image example:
#   docker build -t ptcuops/build-base:1.0 .

FROM phusion/baseimage:latest
MAINTAINER PTC University Systems

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade &&\
    DEBIAN_FRONTEND=noninteractive apt-get -y install git openjdk-7-jdk maven nodejs npm wget nano --no-install-recommends

RUN mkdir -p /data/.m2
ADD settings.xml /data/.m2/
RUN chmod -R 777 /data/.m2

ADD entry.sh /

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
