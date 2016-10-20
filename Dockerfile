FROM ubuntu:16.04

# https://github.com/carlossg/jenkins-swarm-slave-docker

USER root

ENV JENKINS_SWARM_VERSION 2.2
ENV HOME /var/jenkins_home

RUN useradd -c "Jenkins Slave user" -d $HOME -m jenkins

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils sudo \
 	build-essential \
 	curl \
	cmake \
	wget \
	netcat \
	vim \
	net-tools \
	ssh \
	apt-transport-https \
	ca-certificates \
	python \
	python3 \
	default-jdk

RUN apt-get install -y --no-install-recommends --fix-missing maven

# Install and setup nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs \
	&& npm version \
	&& npm config set cache $HOME/.npmcache --global

# Install docker
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list
RUN apt-get update \
 	&& apt-cache policy docker-engine \
	&& apt-get install -y docker-engine

# Install pip

RUN	wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
	&& python3 /tmp/get-pip.py "pip==8.1.2" \
	&& python /tmp/get-pip.py "pip==8.1.2" \
	&& rm /tmp/get-pip.py \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN gpasswd -a jenkins docker

RUN curl --create-dirs -sSLo /usr/share/jenkins_slave/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/${JENKINS_SWARM_VERSION}/swarm-client-${JENKINS_SWARM_VERSION}-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins_slave

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins

VOLUME /var/jenkins_home

WORKDIR /var/jenkins_home

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]