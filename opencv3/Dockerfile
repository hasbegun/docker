FROM ubuntu:18.04

RUN echo 'deb http://security.ubuntu.com/ubuntu xenial-security main' >> /etc/apt/sources.list
# RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
RUN apt-get update --fix-missing && apt-get install tzdata -qy &&\
	apt-get install -qy \
	cmake git wget xauth \
	python-numpy python-scipy python-pip python-setuptools \
	python3-numpy python3-scipy python3-pip python3-setuptools \
	libjpeg-dev libtiff5-dev libjasper1 libjasper-dev libpng-dev libavcodec-dev libavformat-dev \
	libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libgtk2.0-dev libatlas-base-dev \
	libv4l-0 libavcodec-dev libavformat-dev libavutil-dev ffmpeg \
	libswscale-dev libavresample-dev \
    libgstreamer1.0-dev openssh-server \
    vdpau-va-driver libvdpau-va-gl1 vdpauinfo \
    gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad\
    libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev \
    gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-tools libavcodec-dev \
	gfortran python2.7-dev python3-dev build-essential pkg-config sudo vim

WORKDIR /workspace
# Build OpenCV 3.4.9
# Either run this or copy
# Copy from local res dir. If error, run get_ocv3.sh.
# ADD res/opencv-3.4.9.tar.gz .
# ADD res/contrib-3.4.9.tar.gz .

# Download Opencv and Contrib.
RUN \
	wget https://github.com/opencv/opencv/archive/3.4.9.tar.gz -O opencv-3.4.9.tar.gz && \
	wget https://github.com/opencv/opencv_contrib/archive/3.4.9.tar.gz -O contrib-3.4.9.tar.gz

RUN \
	tar zxf opencv-3.4.9.tar.gz && rm -f opencv-3.4.9.tar.gz && \
	tar zxf contrib-3.4.9.tar.gz && rm -f contrib-3.4.9.tar.gz && \
	cd opencv-3.4.9 && mkdir build && cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D OPENCV_EXTRA_MODULES_PATH=/workspace/opencv_contrib-3.4.9/modules \
	-D BUILD_DOCS=OFF \
	-D BUILD_TESTS=OFF \
	-D BUILD_EXAMPLES=OFF \
	-D BUILD_opencv_python2=ON \
	-D BUILD_opencv_python3=ON \
	-D WITH_1394=OFF \
	-D WITH_MATLAB=OFF \
	-D WITH_OPENCL=OFF \
	-D WITH_OPENCLAMDBLAS=OFF \
	-D WITH_OPENCLAMDFFT=OFF \
	-D WITH_GSTREAMER=ON \
	-D WITH_FFMPEG=ON \
	-D CMAKE_CXX_FLAGS="-O3 -funsafe-math-optimizations" \
	-D CMAKE_C_FLAGS="-O3 -funsafe-math-optimizations" \
	.. && make -j $(nproc) && make install

# clean up
RUN	rm -rf /workspace/opencv-3.4.9 /workspace/opencv_contrib-3.4.9

# Remove temporary packages, but keep ones needed by opencv
# RUN apt-get install x11-apps vainfo git -qy &&\
# 	apt-get purge -qy \
# 	build-essential \
# 	libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev \
# 	libv4l-dev libxvidcore-dev libx264-dev libgtk2.0-dev libatlas-base-dev \
# 	gfortran pkg-config cmake && \
# 	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install pika streamlink setproctitle

# add user
RUN useradd -m developer && \
    usermod -aG sudo developer && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    cp /root/.bashrc /home/developer/ && \
    mkdir /home/developer/projects && \
    chown -R --from=root developer:developer /home/developer

CMD ["/bin/bash"]
