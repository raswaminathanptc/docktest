# ptcuops/build-lms:1.0.2

#build image example:
#   docker build -t ptcuops/build-lms .
#build versioned image example:
#   docker build -t ptcuops/build-lms:1.0 .


FROM ptcuops/build-base
MAINTAINER PTC University Systems

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update

RUN ln -s /usr/bin/nodejs /usr/bin/node \
    && npm install -g bower \
    && npm install -g phantomjs \
    && npm install -g grunt-cli



# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
