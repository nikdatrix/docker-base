FROM ubuntu:14.04

MAINTAINER Felipe Restrepo, felipe.restrepo@allegorithmic.com

RUN echo "Minimal debian base"

# when services require special user
ENV UID allegorithmic
ENV GID allegorithmic
ENV LANG C.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN apt-get install --no-install-recommends -y -qq \
	vim-tiny mc software-properties-common

# Debian and Ubuntu do apt-get clen automatically.
RUN apt-get clean && \
	rm -rf /tmp/* /var/tmp/* && \
	rm -rf /var/lib/apt/lists/* && \
	rm -f /etc/ssh/ssh_host_*

# RUN locale-gen --purge en_US.UTF-8
RUN echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale

# Create the user for the service
RUN adduser --no-create-home --disabled-password --gecos '' --shell /bin/bash $UID

COPY bashrc /root/.bashrc

CMD ["/bin/bash"]
