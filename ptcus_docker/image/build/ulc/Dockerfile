# ptcuops/build-ulc:1.0.0

#build image example:
#   docker build -t ptcuops/build-ulc .
#build versioned image example:
#   docker build -t ptcuops/build-ulc:1.0 .


FROM ptcuops/build-base
MAINTAINER PTC University Systems

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install ruby
RUN gem install sass --no-rdoc --no-ri --quiet


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
