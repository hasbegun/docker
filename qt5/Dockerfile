FROM u18-ocv3:latest

#thanks https://github.com/lzane/Ubuntu-OpenCV3-docker/blob/master/Dockerfile

# apt-get python and build essentials

RUN echo 'deb http://security.ubuntu.com/ubuntu xenial-security main' >> /etc/apt/sources.list
# RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
RUN apt-get update --fix-missing && \
	apt-get install -qy \
	qt5-default qtbase5-dev \
	qtdeclarative5-dev \
	qtcreator

WORKDIR /workspace
# Build OpenCV 3.4.9

CMD ["/bin/bash"]
