FROM ubuntu:16.04

MAINTAINER Inho Choi <hasbegun@gmail.com>

WORKDIR /projects
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
    build-essential cmake git sudo vim wget pkg-config \
    python-numpy python-dev libavcodec-dev libavformat-dev \
    libswscale-dev libjpeg-dev libpng-dev libtiff5-dev \
    libjasper-dev libopencv-dev checkinstall pkg-config \
    yasm libjpeg-dev libavcodec-dev \
    libavformat-dev libswscale-dev libdc1394-22-dev \
    libxine2 libgstreamer0.10-dev libv4l-dev \
    libgstreamer-plugins-base0.10-dev python-dev \
    python-numpy libtbb-dev libqt4-dev libgtk2.0-dev \
    libmp3lame-dev libopencore-amrnb-dev \
    libopencore-amrwb-dev libtheora-dev libvorbis-dev \
    libxvidcore-dev x264 v4l-utils

RUN wget https://github.com/opencv/opencv/archive/2.4.13.6.tar.gz -O opencv-2.4.13.6.tar.gz
RUN tar zxvf opencv-2.4.13.6.tar.gz && \
    cd opencv-2.4.13.6 && \
    mkdir release && \
    cd release && \
    cmake -G "Unix Makefiles" \
    -DCMAKE_CXX_COMPILER=/usr/bin/g++ CMAKE_C_COMPILER=/usr/bin/gcc \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DWITH_TBB=ON \
    -DBUILD_NEW_PYTHON_SUPPORT=ON \
    -DWITH_V4L=ON \
    -DINSTALL_C_EXAMPLES=OFF \
    -DINSTALL_PYTHON_EXAMPLES=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DWITH_QT=OFF \
    -DWITH_OPENGL=ON \
    -DBUILD_FAT_JAVA_LIB=OFF \
    -DINSTALL_TO_MANGLED_PATHS=ON \
    -DINSTALL_CREATE_DISTRIB=ON \
    -DINSTALL_TESTS=OFF \
    -DENABLE_FAST_MATH=ON \
    -DWITH_IMAGEIO=ON \
    -DBUILD_SHARED_LIBS=OFF \
    -DWITH_GSTREAMER=ON .. && \
    make all -j$(nproc) && \
    make install

# add user
RUN useradd -m developer && \
    usermod -aG sudo developer && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    cp /root/.bashrc /home/developer/ && \
    mkdir /home/developer/projects && \
    chown -R --from=root developer:developer /home/developer

# add basic files
ADD res/gitconfig /home/developer/.gitconfig
ADD res/commit_template.txt /home/developer/.commit_template.txt

# clean up
RUN rm -rf /projects/opencv-2.4.13.6 opencv-2.4.13.6.tar.gz

CMD [ "/bin/bash" ]
