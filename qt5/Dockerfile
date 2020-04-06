FROM u18-ocv3:latest

#thanks https://github.com/lzane/Ubuntu-OpenCV3-docker/blob/master/Dockerfile

RUN echo 'deb http://security.ubuntu.com/ubuntu xenial-security main' >> /etc/apt/sources.list
# RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
RUN apt-get update --fix-missing && \
	apt-get install -qy \
	qt5-default qtbase5-dev \
	qtdeclarative5-dev \
	qtcreator

CMD ["/bin/bash"]
