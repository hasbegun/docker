# jetson-agx/opengl:jetpack-$BUILD_VERSION-bionic

ARG REPOSITORY
ARG TAG
FROM ${REPOSITORY}:${TAG}
LABEL maintainer "Inho C."

# args
ARG BUILD_VERSION
ARG USER
ARG UID

# setup environment variables
ENV container docker
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display

# set the locale
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# install packages
RUN apt-get update \
    && apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs) main restricted \n\
deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-updates main restricted \n\
deb-src http://us.archive.ubuntu.com/ubuntu/ $(lsb_release -cs)-backports main restricted universe multiverse \n\
deb-src http://security.ubuntu.com/ubuntu $(lsb_release -cs)-security main restricted" \
    > /etc/apt/sources.list.d/official-source-repositories.list

# install build tools
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TERM=linux apt-get install --no-install-recommends -q -y \
    apt-transport-https \
    apt-utils \
    bash-completion \
    build-essential \
    ca-certificates \
    clang \
    clang-format \
    cmake \
    cmake-curses-gui \
    curl \
    gconf2 \
    gconf-service \
    gdb \
    git-core \
    git-gui \
    gvfs-bin \
    inetutils-ping \
    llvm \
    llvm-dev \
    nano \
    net-tools \
    pkg-config \
    shared-mime-info \
    software-properties-common \
    sudo \
    tzdata \
    unzip \
    wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# download and install nvidia jetson xavier driver package
RUN if [ "$BUILD_VERSION" = "3.3" ]; then \
      echo "downloading jetpack-$BUILD_VERSION" ; \
      wget -qO- https://developer.nvidia.com/embedded/dlc/jetpack-l4t-3_3 | \
      tar -xvj -C /tmp/ ; \
      cd /tmp/Linux_for_Tegra ; \
    elif [ "$BUILD_VERSION" = "4.2.2" ]; then \
      echo "downloading jetpack-$BUILD_VERSION" ; \
      # wget -qO- https://developer.nvidia.com/embedded/r32-2-3_Release_v1.0/t186ref_release_aarch64/Tegra186_Linux_R32.2.3_aarch64.tbz2 | \
      wget -qO- https://developer.nvidia.com/embedded/dlc/Jetson_Linux_R32.2.1 | \
      tar -xvj -C /tmp/ ; \
      cd /tmp/Linux_for_Tegra ; \
      # fix error in tar command when extracting configuration files, by overwriting existing configuration files \
      # sed -i -e 's@tar xpfm ${LDK_NV_TEGRA_DIR}/config.tbz2@tar --overwrite -xpmf ${LDK_NV_TEGRA_DIR}/config.tbz2@g' apply_binaries.sh ; \
    else \
      echo "error: please specify jetpack version in build.sh" \
      exit 1 ;\
    fi \
    && echo "apply...." \
    && ./apply_binaries.sh -r / \
    # fix erroneous entry in /etc/ld.so.conf.d/nvidia-tegra.conf \
    && echo "/usr/lib/aarch64-linux-gnu/tegra" > /etc/ld.so.conf.d/nvidia-tegra.conf \
    # add missing /usr/lib/aarch64-linux-gnu/tegra/ld.so.conf \
    && echo "/usr/lib/aarch64-linux-gnu/tegra" > /usr/lib/aarch64-linux-gnu/tegra/ld.so.conf \
    && update-alternatives --install /etc/ld.so.conf.d/aarch64-linux-gnu_GL.conf aarch64-linux-gnu_gl_conf /usr/lib/aarch64-linux-gnu/tegra/ld.so.conf 1000 \
    # fix erroneous entry in /usr/lib/aarch64-linux-gnu/tegra-egl/ld.so.conf \
    && echo "/usr/lib/aarch64-linux-gnu/tegra-egl" > /usr/lib/aarch64-linux-gnu/tegra-egl/ld.so.conf \
    && update-alternatives --install /etc/ld.so.conf.d/aarch64-linux-gnu_EGL.conf aarch64-linux-gnu_egl_conf /usr/lib/aarch64-linux-gnu/tegra-egl/ld.so.conf 1000 \
    && rm -Rf /tmp/Linux_for_Tegra

# install packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TERM=linux apt-get install --no-install-recommends -q -y \
    mesa-utils \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# create user
ENV HOME /home/$USER
RUN adduser $USER --uid $UID --disabled-password --gecos "" \
    && usermod -aG audio,video $USER \
    && echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# switch to non-root user
USER $USER

# labels
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="jetson-agx/opengl:jetpack-$BUILD_VERSION-bionic"
LABEL org.label-schema.description="NVIDIA Jetson AGX JetPack-$BUILD_VERSION OpenGL - Ubuntu-18.04."
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.label-schema.docker.cmd="xhost +local:root \
docker run -it \
  --device /dev/nvhost-as-gpu \
  --device /dev/nvhost-ctrl \
  --device /dev/nvhost-ctrl-gpu \
  --device /dev/nvhost-ctxsw-gpu \
  --device /dev/nvhost-dbg-gpu \
  --device /dev/nvhost-gpu \
  --device /dev/nvhost-prof-gpu \
  --device /dev/nvhost-sched-gpu \
  --device /dev/nvhost-tsg-gpu \
  --device /dev/nvmap \
  --device /dev/snd \
  --net=host \
  -e DISPLAY \
  -e PULSE_SERVER=tcp:$HOST_IP:4713 \
  -e PULSE_COOKIE_DATA=`pax11publish -d | grep --color=never -Po '(?<=^Cookie: ).*'` \
  -e QT_GRAPHICSSYSTEM=native \
  -e QT_X11_NO_MITSHM=1 \
  -v /dev/shm:/dev/shm \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /usr/local/cuda/lib64:/usr/local/cuda/lib64 \
  -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket:ro \
  -v ${XDG_RUNTIME_DIR}/pulse/native:/run/user/1000/pulse/native \
  --rm \
  --name jetson-agx-opengl-jetpack-$BUILD_VERSION-bionic \
  jetson-agx/opengl:jetpack-$BUILD_VERSION-bionic \
xhost -local:root"

# set the working directory
WORKDIR $HOME

# update .bashrc
RUN echo \
'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/lib/aarch64-linux-gnu/tegra:/usr/lib/aarch64-linux-gnu/tegra-egl:/usr/lib/aarch64-linux-gnu:/usr/local/lib:$LD_LIBRARY_PATH\n\
export NO_AT_BRIDGE=1\n\
export PATH=/usr/local/cuda/bin:$PATH\n\
export PS1="${debian_chroot:+($debian_chroot)}\u:\W\$ "' \
    >> $HOME/.bashrc

CMD ["bash"]
